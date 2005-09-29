Return-Path: <listmember@orkun.us>
Received: from www65.dixiesys.com (ns65a.dixiesys.com [65.254.42.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A17EF680F7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Sep 2005 04:59:40 +1000 (EST)
Message-ID: <433C398E.30408@orkun.us>
Date: Thu, 29 Sep 2005 13:59:26 -0500
From: Tolunay Orkun <listmember@orkun.us>
MIME-Version: 1.0
To: Sam Song <samlinuxppc@yahoo.com.cn>
References: <20050929123535.66570.qmail@web15803.mail.cnb.yahoo.com>
In-Reply-To: <20050929123535.66570.qmail@web15803.mail.cnb.yahoo.com>
Content-Type: multipart/mixed; boundary="------------020603060800000103030108"
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Available user-level tool for I2C device?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020603060800000103030108
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 7bit

Sam,

Sam Song wrote:
> Hi all,
> 
> I'd like to ask whether there is user-level utility
> for I2C device registers access like lspci/setpci for
> PCI device?
> 
> I have a RTC chip DS1337 on a 8248 target. It can
> work right in u-boot and linux. If no similar utility,
> I will switch to change hwclock.c in busybox to make
> it. Any idea?
> 
> Thanks in advance,
> 
> Sam

I've a hwclock.c implementation for DS1307/DS1338. I do not know how
close DS1337 was but it should not be too difficult to adapt.

Best regards,
Tolunay

--------------020603060800000103030108
Content-Type: text/x-csrc;
 name="hwclock_ds1307.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hwclock_ds1307.c"

/*
 * Mini hwclock implementation suitable for DS1307/DS1338 RTC chips
 *
 * Copyright (C) 2004 NextIO Inc. - Tolunay Orkun <torkun@nextio.com>
 *
 * Based on GPL licensed code from Busybox and U-boot projects
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 *
*/

#include <sys/ioctl.h>
#include <sys/time.h>
#include <time.h>
#include <unistd.h>
#include <getopt.h>
#include <fcntl.h>
#include <stdio.h>
#include <libgen.h>
#include <stdlib.h>
#include <linux/i2c.h>
#include <linux/i2c-dev.h>

#define DS1307_ADDR	0x68

struct i2c_ioctl_rdwr_data {
	struct i2c_msg *msgs;
	int nmsgs;
};

int i2c_xfer(int addr, char *wbuf, int wcount, char *rbuf, int rcount)
{
	int fd, i;
	int val, nmsgs;
	struct i2c_msg msg[2];
	struct i2c_ioctl_rdwr_data ioctl_rdwr_data;

	memset(msg, 0, sizeof(msg));
	memset(&ioctl_rdwr_data, 0, sizeof(ioctl_rdwr_data));

	nmsgs = 0;
	if (wcount > 0) {
		msg[nmsgs].addr  = addr;
		msg[nmsgs].flags = 0;
		msg[nmsgs].len   = wcount;
		msg[nmsgs].buf   = wbuf;
		nmsgs++;
	}

	if (rcount > 0) {
		msg[nmsgs].addr  = addr;
		msg[nmsgs].flags = I2C_M_RD;
		msg[nmsgs].len   = rcount;
		msg[nmsgs].buf   = rbuf;
		nmsgs++;
	}

	ioctl_rdwr_data.msgs = msg;
	ioctl_rdwr_data.nmsgs = nmsgs;

#ifdef DEBUG
	if (wcount > 0) {
		printf("Writing i2c...\n");
		printf("Addr : %3d (0x%02x)\n", addr, addr);
		printf("Count: %3d (0x%02x)\n", wcount, wcount);
		printf("Data :\n");
		for (i = 0; i < wcount; i++) {
			val = wbuf[i];
			printf("%3d (0x%02x) = %3d (0x%02x)\n", i, i, val, val);
		}
		printf("\n");
	}

	if (rcount > 0) {
		printf("Reading i2c...\n");
		printf("Addr : %3d (0x%02x)\n", addr, addr);
		printf("Count: %3d (0x%02x)\n", rcount, rcount);
	}
#endif

	fd = open("/dev/i2c0", O_RDWR);
	if (fd < 0) {
		fd = open("/dev/i2c/0", O_RDWR);
		if (fd < 0) {
			printf("Can't open i2c\n");
			return 1;
		}
	}

	if (ioctl(fd, I2C_RDWR, &ioctl_rdwr_data) < 0) {
		printf("I2C I/O Error\n");
		close(fd);
		return 2;
	}

#ifdef DEBUG
	if (rcount > 0) {
		printf("Data :\n");
		for (i = 0; i < rcount; i++) {
			val = rbuf[i];
			printf("%3d (0x%02x) = %3d (0x%02x)\n", i, i, val, val);
		}
		printf("\n");
	}
#endif
	
	close(fd);
	return 0;
}

unsigned int bcd2bin(unsigned char n)
{
	return ((((n >> 4) & 0x0f) * 10) + (n & 0x0f));
}

unsigned char bin2bcd(unsigned int n)
{
	return (((n / 10) << 4) | (n % 10));
}

time_t read_rtc(int utc)
{
	char reg = 0; /* register start address for transfer */
	char buf[8];
	struct tm tm;
	char *oldtz = NULL;
	time_t t = 0;

	if (i2c_xfer(DS1307_ADDR, &reg, sizeof(reg), buf, sizeof(buf)) != 0)
		return -1;

	memset(&tm, 0, sizeof(struct tm));
	tm.tm_sec  = bcd2bin(buf[0] & 0x7f);
	tm.tm_min  = bcd2bin(buf[1] & 0x7f);
	tm.tm_hour = bcd2bin(buf[2] & 0x3f);
	tm.tm_wday = bcd2bin(buf[3] & 0x07) - 1;
	tm.tm_mday = bcd2bin(buf[4] & 0x3f);
	tm.tm_mon  = bcd2bin(buf[5] & 0x1f) - 1;
	tm.tm_year = bcd2bin(buf[6]) + 100;
	tm.tm_isdst = -1; /* unknown */

	if (utc) {
		oldtz = getenv("TZ");
		setenv("TZ", "UTC 0", 1);
		tzset();
	}

	t = mktime(&tm);

	if (utc) {
		if (oldtz)
			setenv("TZ", oldtz, 1);
		else
			unsetenv("TZ");
		tzset();
	}

	return t;
}

int write_rtc(time_t t, int utc)
{
	char buf[8];
	struct tm tm;

	tm = *(utc ? gmtime(&t) : localtime(&t));

	buf[0] = 0; /* register start address for transfer */
	buf[1] = bin2bcd(tm.tm_sec);
	buf[2] = bin2bcd(tm.tm_min);
	buf[3] = bin2bcd(tm.tm_hour);
	buf[4] = bin2bcd(tm.tm_wday + 1);
	buf[5] = bin2bcd(tm.tm_mday);
	buf[6] = bin2bcd(tm.tm_mon + 1);
	buf[7] = bin2bcd(tm.tm_year - 100);

	if (i2c_xfer(DS1307_ADDR, buf, sizeof(buf), NULL, 0) != 0)
		return -1;

	return 0;
}

int show_clock(int utc)
{
	time_t t;
	char   buffer[64];
	char   *p;
	int    len;

	buffer[0] = '\0';
	t = read_rtc(utc);
	p = ctime(&t);
	if (p) {
		len = strlen(p) - 1; /* strip newline */
		if (len >= sizeof(buffer))
			len = sizeof(buffer) - 1;
		memcpy(buffer, p, len);
		buffer[len] = '\0';
	}

	printf("%s 0.000000 seconds\n", buffer);
	return 0;
}

int to_sys_clock(int utc)
{
	struct timeval tv;

	memset(&tv, 0, sizeof(tv));
	tv.tv_sec = read_rtc(utc);
	return settimeofday(&tv, NULL);
}

int from_sys_clock(int utc)
{
	struct timeval tv;

	memset(&tv, 0, sizeof(tv));
	gettimeofday(&tv, NULL);
	return write_rtc(tv.tv_sec, utc); 
}

void show_usage(char *progname)
{
	char buf[64];

	strncpy(buf, progname, sizeof(buf));
	buf[sizeof(buf) - 1] = '\0';
	basename(buf);

	printf("%s - query and set the hardware clock (DS1307/1338 RTC)\n\n", buf);
	printf("Usage: %s [options...]\n\n", buf);
	printf("Options:\n");
	printf("\t-r, --show\tread hardware clock and print result\n");
	printf("\t-s, --hctosys\tset the system time from the hardware clock\n");
	printf("\t-w, --systohc\tset the hardware clock to the current system time\n\n");
	printf("\t-u, --utc\tthe hardware clock is kept in universal time\n");
	printf("\t-l, --localtime\tthe hardware clock is kept in local time\n\n");
	exit(-1);
}

int main(int argc, char *argv[])
{
	int  opt_help = 0;
	int  opt_localtime = 0;
	int  opt_utc = 0;
	int  func_show = 0;
	int  func_hctosys = 0;
	int  func_systohc = 0;
	int  func_count;
	int  utc;
	int  c;

	static struct option long_options[] = {
		{ "show",	0, 0, 'r' },
		{ "hctosys",	0, 0, 's' },
		{ "systohc",	0, 0, 'w' },
		{ "localtime",	0, 0, 'l' },
		{ "utc",	0, 0, 'u' },
		{ "help",	0, 0, '?' },
		{ 0,		0, 0, 0   }
	};
	int opt_idx = 0;

	while (1) {
		c = getopt_long(argc, argv, "rswlu?h", long_options, &opt_idx);	
		if (c == -1)
			break;

		switch (c) {
			case 'r':
				func_show = 1;
				break;
			case 's':
				func_hctosys = 1;
				break;
			case 'w':
				func_systohc = 1;
				break;
			case 'l':
				opt_localtime = 1;
				break;
			case 'u':
				opt_utc = 1;
				break;
			default:
				opt_help = 1;
				break;
		}
	}

	func_count = func_show + func_hctosys + func_systohc;
	if (func_count > 1)
		show_usage(argv[0]);
	
	if (opt_localtime && opt_utc)
		show_usage(argv[0]);

	if (opt_help)
		show_usage(argv[0]);

	if (func_hctosys)
		return to_sys_clock(opt_utc);
	else if (func_systohc)
		return from_sys_clock(opt_utc);
	else
		return show_clock(opt_utc);
	
	return 0;
}

/* ex: set sw=4 ts=4: */

--------------020603060800000103030108--
