Date: Fri, 6 Aug 2004 10:04:06 +0200
From: Harald Welte <laforge@gnumonks.org>
To: linuxppc-dev@lists.linuxppc.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] ugly hack to make therm_pm72 work on XServe G5
Message-ID: <20040806080406.GB11638@sunbeam2>
References: <20040805114348.GD7112@sunbeam2>
Mime-Version: 1.0
In-Reply-To: <20040805114348.GD7112@sunbeam2>
Content-Type: multipart/mixed; boundary="2/5bycvrmDh4d1IB"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7-bit

I actually forgot that small userspace program ;)

It is a total ripoff of the kernel driver and was implemented because
it's easier to play with i2c from userspace during development.

benh:  Any reason why you implemented your own byte+word read/write
routines?  Apparently the i2c_smbus routines work quite fine, even from
userspace...

--
- Harald Welte <laforge@gnumonks.org>               http://www.gnumonks.org/
============================================================================
Programming is like sex: One mistake and you have to support it your lifetime

--2/5bycvrmDh4d1IB
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="rackmac-fans.c"
Content-Transfer-Encoding: 7bit

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/stat.h>

#include <linux/i2c-dev.h>

static int fd;

#ifdef RAW_I2C
static int fan_read_reg(int reg, unsigned char *buf, int nb)
{
	int tries, nr, nw;

	buf[0] = reg;
	tries = 0;
	for (;;) {
		nw = write(fd, buf, 1);
		if (nw > 0 || (nw < 0 && nw != -EIO) || tries >= 100)
			break;
		usleep(10);
		++tries;
	}
	if (nw < 0) {
		fprintf(stderr, "Failure writing address to FCU: %d\n", nw);
		return -EIO;
	}
	tries = 0;
	for (;;) {
		nr = read(fd, buf, nb);
		if (nr > 0 || (nr < 0 && nr != ENODEV) || tries >= 100)
			break;
		usleep(10);
		++tries;
	}
	if (nr <= 0)
		fprintf(stderr, "Failure reading data from FCU: %d\n", nw);
	return nr;
}

static int fan_write_reg(int reg, const unsigned char *ptr, int nb)
{
	int tries, nw;
	unsigned char buf[16];

	buf[0] = reg;
	memcpy(buf+1, ptr, nb);
	++nb;
	tries = 0;

	for (;;) {
		nw = write(fd, buf, nb);
		if (nw > 0 || (nw < 0 && nw != EIO) || tries >= 100)
			break;
		usleep(1);
		++tries;
	}
	if (nw < 0)
		fprintf(stderr, "Failure writing to FCU: %d", nw);
	return nw;
}
#else
static int fan_read_reg(int reg, unsigned char *ptr, int nb)
{
	int ret;

	if (nb == 1) {
		ret = i2c_smbus_read_byte_data(fd, reg);
		if (ret < 0) {
			fprintf(stderr,"error during read_word_data\n");
			return ret;
		}
		*ptr = (unsigned char) ret;
		return nb;
	} else if (nb == 2) {
		ret = i2c_smbus_read_word_data(fd, reg);
		if (ret < 0) {
			fprintf(stderr,"error during read_word_data\n");
			return ret;
		}
		*ptr = (u_int16_t) ret;
		return nb;
	} else {
		fprintf(stderr, "%u bytes not inplemented\n", nb);
		return -EINVAL;
	}
}
static int fan_write_reg(int reg, const unsigned char *ptr, int nb)
{
	int ret;

	if (nb == 1) {
		ret = i2c_smbus_write_byte_data(fd, reg, *ptr);
		if (ret < 0) {
			fprintf(stderr, "error during write_byte_data\n");
			return ret;
		}
		return nb;
	} else if (nb == 2) {
		ret = i2c_smbus_write_word_data(fd, reg, *ptr);
		if (ret < 0) {
			fprintf(stderr, "error during write_word_data\n");
			return ret;
		}
		return nb;
	} else {
		fprintf(stderr, "%u bytes not implemented\n", nb);
		return -EINVAL;
	}
}
#endif

static int set_rpm_fan(int fan, int rpm)
{
	unsigned char buf[2];
	int rc;

	if (rpm < 300)
		rpm = 300;
	else if (rpm > 8191)
		rpm = 8191;
	buf[0] = rpm >> 5;
	buf[1] = rpm << 3;
	rc = fan_write_reg(0x10 + (fan *2), buf, 2);
	if (rc < 0)
		return -EIO;
	return 0;
}

static int get_rpm_fan(int fan, int programmed)
{
	unsigned char failure;
	unsigned char active;
	unsigned char buf[2];
	int rc, reg_base;

	rc = fan_read_reg(0xb, &failure, 1);
	if (rc != 1) {
		fprintf(stderr, "unable to reada 0xb register\n");
		return -EIO;
	}
	if ((failure & (1 << fan)) != 0)
		return -EFAULT;
	rc = fan_read_reg(0xd, &active, 1);
	if (rc != 1) {
		fprintf(stderr, "unable to read 0xd register\n");
		return -EIO;
	}
	if ((active & (1 << fan)) == 0)
		return -ENXIO;

	reg_base = programmed ? 0x10 : 0x11;
	rc = fan_read_reg(reg_base + (fan * 2), buf, 2);
	if (rc != 2) {
		fprintf(stderr, "unable to read fan register 0x%x\n",=20
			reg_base+(fan*2));
		return -EIO;
	}

	return (buf[0] << 5 | buf[1] >> 3);
}

static int set_pwm_fan(int fan, int pwm)
{
	unsigned char buf[2];
	int rc;

	if (pwm < 10)
		pwm = 10;
	else if (pwm > 100)
		pwm = 100;
	pwm = (pwm * 2559) / 1000;
	buf[0] = pwm;
	rc = fan_write_reg(0x30 + (fan*2), buf, 1);
	if (rc < 0)
		return rc;
	return 0;
}

static int get_pwm_fan(int fan)
{
	unsigned char failure;
	unsigned char active;
	unsigned char buf[2];
	int rc;

	rc = fan_read_reg(0x2b, &failure, 1);
	if (rc != 1)
		return -EIO;
	if ((failure & (1 << fan)) != 0)
		return -EFAULT;
	rc = fan_read_reg(0x2d, &active, 1);
	if (rc != 1)
		return -EIO;
	if ((active & (1 << fan)) == 0)
		return -ENXIO;
=09
	rc = fan_read_reg(0x30 + (fan *2), buf, 1);
	if (rc != 1)
		return -EIO;

	return (buf[0] * 1000) / 2559;
}


int main(int argc, char **argv)
{
	int ret;
	int fan_num;

	fd = open("/dev/i2c-2", O_RDWR);
	if (fd < 0)
		exit(1);

	ret = ioctl(fd, I2C_SLAVE_FORCE, 0x2f);
	if (ret < 0) {
		fprintf(stderr, "Unable to access device 0x2f\n");
		exit(1);
	}

	for (fan_num = 1; fan_num <= 6; fan_num++) {
		int rpm;

		set_rpm_fan(fan_num, 3000);

		rpm = get_rpm_fan(fan_num, 0);
		if (rpm < 0)
			printf("Fan %d: %s\n", fan_num, strerror(-rpm));
		else
			printf("Fan %d: %d rpm\n", fan_num, rpm);
	}
=09
	for (fan_num = 1; fan_num <= 2; fan_num++) {
		int pwm;

		set_pwm_fan(fan_num, 30);
		pwm = get_pwm_fan(fan_num);
		if (pwm < 0)
			printf("PWM-Fan %d: %s\n", fan_num, strerror(-pwm));
		else
			printf("PWM-Fan %d: %d\n", fan_num, pwm);
	}
}

--2/5bycvrmDh4d1IB--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
