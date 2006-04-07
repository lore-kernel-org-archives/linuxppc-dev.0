Return-Path: <Claus.Gindhart@kontron.com>
Received: from kom-exchfe.kontron-modular.com (mail.kontron-modular.com
	[62.159.155.200]) by ozlabs.org (Postfix) with ESMTP id 11AAB67B57
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Apr 2006 19:07:21 +1000 (EST)
From: Claus Gindhart <claus.gindhart@kontron-modular.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: RTC/I2C on 82xx with Linux 2.6.x
Date: Fri, 7 Apr 2006 10:57:25 +0200
References: <003401c65a1b$915dac90$5201a8c0@GEG2400>
In-Reply-To: <003401c65a1b$915dac90$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_2liNERSBtEOPM/r"
Message-Id: <200604071057.26265.claus.gindhart@kontron-modular.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Boundary-00=_2liNERSBtEOPM/r
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Laurent,

attached you find a rtc-driver for 2.6.13.
I ported it from 2.4 myself, because i didnt find any 2.6-port out in the 
world.
the ppc_md-structure entries are initialized within the driver itself. This is 
propably not 100% consistent with the coding conventions, but it works fro 
me.
This i2c-layer can still be used with this driver; i have a LM75 and an EEPROM 
on the same bus, which i operate via LM-Sensors and the i2c-dev driver.

-- 
Mit freundlichen Gruessen / Best regards

Claus Gindhart
SW R&D 
Kontron Modular Computers
phone :++49 (0)8341-803-374
mailto:claus.gindhart@kontron-modular.com 
http://www.kontron.com

-----BEGIN GEEK CODE BLOCK-----
  Version: 3.1
  GU d- s++:>++:+ a+ C++$ !U !P L++>$ E-- W+(-) N- o? 
  K? w !O !M V !PS PE- Y+ PGP+ t 5? X R* tv- b+ DI+++ 
  D-- G e++> h--- !r x+++
------END GEEK CODE BLOCK------



Am Friday 07 April 2006 10:16 schrieb Laurent Lagrange:
Hello,

I use a Linux 2.6.x on a custom 8270 board with a RTC on the I2C bus
(rtc8564).
I want to use it as the system date :
	- Is it possible ?
	- Do I need to initialize the "ppc_md" structure in the "platform_init"
function with my own RTC functions ?
	- In that case, can I use the kernel I2C layer ?

Thanks all
Laurent


_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded


--Boundary-00=_2liNERSBtEOPM/r
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="rtc8564.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rtc8564.c"

/*
 *  linux/drivers/i2c/chips/rtc8564.c
 *
 *  Copyright (C) 2002-2004 Stefan Eletzhofer
 *
 *	based on linux/drivers/acron/char/pcf8583.c
 *  Copyright (C) 2000 Russell King
 *
 * 2006.03.14 Claus Gindhart <claus.gindhart@kontron-modular.com>
 * Added missing support for PowerPC and fix up for RTC update 
 * in interrupt mode (11 minute mode support)
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 asr
 * published by the Free Software Foundation.
 *
 * Driver for system3's EPSON RTC 8564 chip
 */
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/i2c.h>
#include <linux/slab.h>
#include <linux/string.h>
#include <linux/rtc.h>		/* get the user-level API */
#include <linux/init.h>
#ifdef CONFIG_PPC
	#include <asm/machdep.h>
#endif

#include "rtc8564.h"

/* prints out the time to be set, if activated */
#undef EXT_DEBUG


#ifdef DEBUG
# define _DBG(x, fmt, args...) do{ if (debug>=x) printk("%s: " fmt "\n", __FUNCTION__, ##args); } while(0);
#else
# define _DBG(x, fmt, args...) do { } while(0);
#endif

#define _DBGRTCTM(x, rtctm) if (debug>=x) printk(KERN_DEBUG"%s: secs=%d, mins=%d, hours=%d, mday=%d, " \
			"mon=%d, year=%d, wday=%d VL=%d\n", __FUNCTION__, \
			(rtctm).secs, (rtctm).mins, (rtctm).hours, (rtctm).mday, \
			(rtctm).mon, (rtctm).year, (rtctm).wday, (rtctm).vl);

struct rtc8564_data {
	struct i2c_client client;
	u16 ctrl;
};

static inline u8 _rtc8564_ctrl1(struct i2c_client *client)
{
	struct rtc8564_data *data = i2c_get_clientdata(client);
	return data->ctrl & 0xff;
}
static inline u8 _rtc8564_ctrl2(struct i2c_client *client)
{
	struct rtc8564_data *data = i2c_get_clientdata(client);
	return (data->ctrl & 0xff00) >> 8;
}

#define CTRL1(c) _rtc8564_ctrl1(c)
#define CTRL2(c) _rtc8564_ctrl2(c)

#define BCD_TO_BIN(val) (((val)&15) + ((val)>>4)*10)
#define BIN_TO_BCD(val) ((((val)/10)<<4) + (val)%10)

static int debug;
module_param(debug, int, S_IRUGO | S_IWUSR);

DECLARE_MUTEX(rtc8564_sem);

static struct i2c_driver rtc8564_driver;
struct i2c_client *this_client;

static unsigned short ignore[] = { I2C_CLIENT_END };
static unsigned short normal_addr[] = { 0x51, I2C_CLIENT_END };

static struct i2c_client_address_data addr_data = {
	.normal_i2c		= normal_addr,
	.probe			= ignore,
	.ignore			= ignore,
	.force			= ignore,
};

static int rtc8564_read_mem(struct i2c_client *client, struct mem *mem);
static int rtc8564_write_mem(struct i2c_client *client, struct mem *mem);

static int rtc8564_recv(struct i2c_client *client, 
			unsigned char *buf, unsigned char addrs, unsigned char count)
{
	int ret = -EIO;

	unsigned char addr[1] = { addrs };
	struct i2c_msg msgs[2] = {
		{client->addr, 0, 1, addr},
		{client->addr, I2C_M_RD, count, buf}
	};

	_DBG(1, "client=%p, addrs=%d, buf=%p, count=%d", client, addrs, buf, count);

	if (!buf) {
		ret = -EINVAL;
		goto done;
	}

	ret = i2c_transfer(client->adapter, msgs, 2);
	if (ret == 2) {
		ret = 0;
	}

done:
	return ret;
}

static int rtc8564_write(struct i2c_client *client, unsigned char adr,
			 unsigned char *data, unsigned char len)
{
	int ret = 0;
	unsigned char _data[16];
	struct i2c_msg wr;
	int i;

	if (!data || len > 15) {
		ret = -EINVAL;
		goto done;
	}

	_DBG(1, "client=%p, adr=%d, buf=%p, len=%d", client, adr, data, len);

	_data[0] = adr;
	for (i = 0; i < len; i++) {
		_data[i + 1] = data[i];
		_DBG(5, "data[%d] = 0x%02x (%d)", i, data[i], data[i]);
	}

	wr.addr = client->addr;
	wr.flags = 0;
	wr.len = len + 1;
	wr.buf = _data;

	ret = i2c_transfer(client->adapter, &wr, 1);
	if (ret == 1) {
		ret = 0;
	}

done:
	return ret;
}


static int rtc8564_get_datetime(struct i2c_client *client, struct rtc_tm *dt)
{
	int ret = -EIO;
	unsigned char buf[15];

	_DBG(1, "client=%p, dt=%p", client, dt);

	if (!dt)
		return -EINVAL;

	memset(buf, 0, sizeof(buf));

	ret = rtc8564_recv(client, buf, 0, 15);
	if (ret)
		return ret;

	/* century stored in minute alarm reg */
	dt->year = BCD_TO_BIN(buf[RTC8564_REG_YEAR]);
	dt->year += 100 * BCD_TO_BIN(buf[RTC8564_REG_AL_MIN] & 0x3f);
	dt->mday = BCD_TO_BIN(buf[RTC8564_REG_DAY] & 0x3f);
	dt->wday = BCD_TO_BIN(buf[RTC8564_REG_WDAY] & 7);
	dt->mon = BCD_TO_BIN(buf[RTC8564_REG_MON_CENT] & 0x1f);

	dt->secs = BCD_TO_BIN(buf[RTC8564_REG_SEC] & 0x7f);
	dt->vl = (buf[RTC8564_REG_SEC] & 0x80) == 0x80;
	dt->mins = BCD_TO_BIN(buf[RTC8564_REG_MIN] & 0x7f);
	dt->hours = BCD_TO_BIN(buf[RTC8564_REG_HR] & 0x3f);

	_DBGRTCTM(2, *dt);

	return 0;
}

unsigned long ppc_rtc8564_get_time( void )
{
	struct rtc_tm time;
	int rc;

	/* The only way to tell the user that rtc time is not reliable (?) */
	if(!this_client)
		return -1 /*RTC_24H | RTC_BATT_BAD */;


	down(&rtc8564_sem);
	rc = rtc8564_get_datetime(this_client,&time);
	up(&rtc8564_sem);
	if (rc)
	{
		return -1 /* RTC_24H | RTC_BATT_BAD */;
	}

	return mktime(time.year, time.mon, time.mday, 
				time.hours, time.mins, time.secs);
}



static int
rtc8564_set_datetime(struct i2c_client *client, struct rtc_tm *dt, int datetoo)
{
	int ret, len = 5;
	unsigned char buf[15];

	_DBG(1, "client=%p, dt=%p", client, dt);
#ifdef EXT_DEBUG
	printk("rtc8564_set_datetime %d\\%d\\%d %d:%d:%d, wday=%d\n",
		dt->year,dt->mon,dt->mday,
		dt->hours,dt->mins,dt->secs,dt->wday);
#endif

	if (!dt)
		return -EINVAL;

	_DBGRTCTM(2, *dt);

	buf[RTC8564_REG_CTRL1] = CTRL1(client) | RTC8564_CTRL1_STOP;
	buf[RTC8564_REG_CTRL2] = CTRL2(client);
	buf[RTC8564_REG_SEC] = BIN_TO_BCD(dt->secs);
	buf[RTC8564_REG_MIN] = BIN_TO_BCD(dt->mins);
	buf[RTC8564_REG_HR] = BIN_TO_BCD(dt->hours);

	if (datetoo) {
		len += 5;
		buf[RTC8564_REG_DAY] = BIN_TO_BCD(dt->mday);
		buf[RTC8564_REG_WDAY] = BIN_TO_BCD(dt->wday);
		buf[RTC8564_REG_MON_CENT] = BIN_TO_BCD(dt->mon) & 0x1f;
		/* century stored in minute alarm reg */
		buf[RTC8564_REG_YEAR] = BIN_TO_BCD(dt->year % 100);
		buf[RTC8564_REG_AL_MIN] = BIN_TO_BCD(dt->year / 100);
	}

	ret = rtc8564_write(client, 0, buf, len);
	if (ret) {
		_DBG(1, "error writing data! %d", ret);
	}

	buf[RTC8564_REG_CTRL1] = CTRL1(client);
	ret = rtc8564_write(client, 0, buf, 1);
	if (ret) {
		_DBG(1, "error writing data! %d", ret);
	}

	return ret;
}


int rtc8564_set_time(struct rtc_time *time)
{
	int rc;
	struct rtc_tm dt;

#ifdef EXT_DEBUG
	printk("rtc8564_set_time to %d\\%d\\%d %d:%d:%d\n",
		time->tm_year,time->tm_mon,time->tm_mday,
		time->tm_hour,time->tm_min,time->tm_sec);
#endif

	down(&rtc8564_sem);

	dt.secs = time->tm_sec;
	dt.mins = time->tm_min;
	dt.hours = time->tm_hour;
	dt.wday = time->tm_wday;
	dt.mday = time->tm_mday;
	dt.mon = time->tm_mon;
	dt.year = time->tm_year;

	rc = rtc8564_set_datetime(this_client,&dt,1);

	up(&rtc8564_sem);

	return rc;
}

static void deferred_set_rtc(void *thistime)
{
	struct rtc_time wtime;
	unsigned long nowtime = (unsigned long) thistime;
	to_tm(nowtime, &wtime);
	rtc8564_set_time(&wtime);
	return;
}


int ppc_rtc8564_set_time(unsigned long nowtime)
{
	struct rtc_time wtime;
	static DECLARE_WORK(set_rtc_work, deferred_set_rtc, NULL);

	if (unlikely(in_interrupt())) {
		/* because RTC works on interrupts (I2C access) 
		 * we can't set time while we are during interrupt
		 * processing, so set must be done later.
		 */
		/* if previous setting is not done - cancel it 
		 */
		cancel_delayed_work(&set_rtc_work);
		set_rtc_work.data = (void *)nowtime;
		schedule_work(&set_rtc_work);
		/* unfortunatelly, we can't wait till work_queue
		 * will be executed - lets assume it will return 0
		 */
		return 0;
	}
	to_tm(nowtime, &wtime);
	/* wtime probably needs some fiddling here (year -= 1900 etc.) */
	/* Be aware that adjtime uses /dev/port for rtc access: x86 only! */
	return rtc8564_set_time(&wtime);
}

static int rtc_8564_probe(struct i2c_adapter *adap, int addr, int kind)
{
	int ret;
	struct i2c_client *new_client;
	struct rtc8564_data *d;
	unsigned char data[10];
	unsigned char ad[1] = { 0 };
	struct i2c_msg ctrl_wr[1] = {
		{addr, 0, 2, data}
	};
	struct i2c_msg ctrl_rd[2] = {
		{addr, 0, 1, ad},
		{addr, I2C_M_RD, 2, data}
	};

	d = kmalloc(sizeof(struct rtc8564_data), GFP_KERNEL);
	if (!d) {
		ret = -ENOMEM;
		goto done;
	}
	memset(d, 0, sizeof(struct rtc8564_data));
	new_client = &d->client;

	strlcpy(new_client->name, "RTC8564", I2C_NAME_SIZE);
	i2c_set_clientdata(new_client, d);
	new_client->flags = I2C_CLIENT_ALLOW_USE | I2C_DF_NOTIFY;
	new_client->addr = addr;
	new_client->adapter = adap;
	new_client->driver = &rtc8564_driver;

	_DBG(1, "client=%p", new_client);

	/* init ctrl1 reg */
	data[0] = 0;
	data[1] = 0;
	ret = i2c_transfer(new_client->adapter, ctrl_wr, 1);
	if (ret != 1) {
		printk(KERN_ERR "rtc8564: cant init ctrl1\n");
		ret = -ENODEV;
		goto done;
	}

	/* read back ctrl1 and ctrl2 */
	ret = i2c_transfer(new_client->adapter, ctrl_rd, 2);
	if (ret != 2) {
		printk(KERN_ERR "rtc8564: cant read ctrl\n");
		ret = -ENODEV;
		goto done;
	}

	d->ctrl = data[0] | (data[1] << 8);

	_DBG(1, "RTC8564_REG_CTRL1=%02x, RTC8564_REG_CTRL2=%02x",
	     data[0], data[1]);

	ret = i2c_attach_client(new_client);
done:
	if (ret) {
		kfree(d);
	}

	this_client = new_client;

#ifdef CONFIG_PPC
        /* Hook up the wrapper to machdep for 11-minute mode support */
        ppc_md.set_rtc_time = ppc_rtc8564_set_time;
        ppc_md.get_rtc_time = ppc_rtc8564_get_time;
#endif


	return ret;
}

static int rtc_8564_attach(struct i2c_adapter *adap)
{
	return i2c_probe(adap, &addr_data, rtc_8564_probe);
}

static int rtc8564_detach(struct i2c_client *client)
{
	i2c_detach_client(client);
	kfree(i2c_get_clientdata(client));
	return 0;
}


static int rtc8564_get_ctrl(struct i2c_client *client, unsigned int *ctrl)
{
	struct rtc8564_data *data = i2c_get_clientdata(client);

	if (!ctrl)
		return -1;

	*ctrl = data->ctrl;
	return 0;
}

static int rtc8564_set_ctrl(struct i2c_client *client, unsigned int *ctrl)
{
	struct rtc8564_data *data = i2c_get_clientdata(client);
	unsigned char buf[2];

	if (!ctrl)
		return -1;

	buf[0] = *ctrl & 0xff;
	buf[1] = (*ctrl & 0xff00) >> 8;
	data->ctrl = *ctrl;

	return rtc8564_write(client, 0, buf, 2);
}

static int rtc8564_read_mem(struct i2c_client *client, struct mem *mem)
{

	if (!mem)
		return -EINVAL;

	return rtc8564_recv(client, mem->data, mem->loc, mem->nr);
}

static int rtc8564_write_mem(struct i2c_client *client, struct mem *mem)
{

	if (!mem)
		return -EINVAL;

	return rtc8564_write(client, mem->loc, mem->data, mem->nr);
}

static int
rtc8564_command(struct i2c_client *client, unsigned int cmd, void *arg)
{
	int rc;
	_DBG(1, "cmd=%d", cmd);

	down(&rtc8564_sem);
	switch (cmd) {
	case RTC_GETDATETIME:
		rc = rtc8564_get_datetime(client, arg);
		break;

	case RTC_SETTIME:
		rc = rtc8564_set_datetime(client, arg, 0);
		break;

	case RTC_SETDATETIME:
		rc = rtc8564_set_datetime(client, arg, 1);
		break;

	case RTC_GETCTRL:
		rc = rtc8564_get_ctrl(client, arg);
		break;

	case RTC_SETCTRL:
		rc = rtc8564_set_ctrl(client, arg);
		break;

	case MEM_READ:
		rc = rtc8564_read_mem(client, arg);
		break;

	case MEM_WRITE:
		rc = rtc8564_write_mem(client, arg);
		break;

	default:
		rc = -EINVAL;
		break;
	}

	up(&rtc8564_sem);
	return rc;
}

static struct i2c_driver rtc8564_driver = {
	.owner		= THIS_MODULE,
	.name		= "RTC8564",
	.id		= I2C_DRIVERID_RTC8564,
	.flags		= I2C_DF_NOTIFY,
	.attach_adapter = rtc_8564_attach,
	.detach_client	= rtc8564_detach,
	.command	= rtc8564_command
};

static __init int rtc8564_init(void)
{
	return i2c_add_driver(&rtc8564_driver);
}

static __exit void rtc8564_exit(void)
{
	i2c_del_driver(&rtc8564_driver);
}

MODULE_AUTHOR("Stefan Eletzhofer <Stefan.Eletzhofer@eletztrick.de>");
MODULE_DESCRIPTION("EPSON RTC8564 Driver");
MODULE_LICENSE("GPL");

module_init(rtc8564_init);
module_exit(rtc8564_exit);

--Boundary-00=_2liNERSBtEOPM/r
Content-Type: text/x-chdr;
  charset="iso-8859-1";
  name="rtc8564.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rtc8564.h"

/*
 *  linux/drivers/i2c/chips/rtc8564.h
 *
 *  Copyright (C) 2002-2004 Stefan Eletzhofer
 *
 *	based on linux/drivers/acron/char/pcf8583.h
 *  Copyright (C) 2000 Russell King
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 */
struct rtc_tm {
	unsigned char	secs;
	unsigned char	mins;
	unsigned char	hours;
	unsigned char	mday;
	unsigned char	mon;
	unsigned short	year; /* xxxx 4 digits :) */
	unsigned char	wday;
	unsigned char	vl;
};

struct mem {
	unsigned int	loc;
	unsigned int	nr;
	unsigned char	*data;
};

#define RTC_GETDATETIME	0
#define RTC_SETTIME	1
#define RTC_SETDATETIME	2
#define RTC_GETCTRL	3
#define RTC_SETCTRL	4
#define MEM_READ	5
#define MEM_WRITE	6

#define RTC8564_REG_CTRL1		0x0 /* T  0 S 0 | T 0 0 0 */
#define RTC8564_REG_CTRL2		0x1 /* 0  0 0 TI/TP | AF TF AIE TIE */
#define RTC8564_REG_SEC			0x2 /* VL 4 2 1 | 8 4 2 1 */
#define RTC8564_REG_MIN			0x3 /* x  4 2 1 | 8 4 2 1 */
#define RTC8564_REG_HR			0x4 /* x  x 2 1 | 8 4 2 1 */
#define RTC8564_REG_DAY			0x5 /* x  x 2 1 | 8 4 2 1 */
#define RTC8564_REG_WDAY		0x6 /* x  x x x | x 4 2 1 */
#define RTC8564_REG_MON_CENT	0x7 /* C  x x 1 | 8 4 2 1 */
#define RTC8564_REG_YEAR		0x8 /* 8  4 2 1 | 8 4 2 1 */
#define RTC8564_REG_AL_MIN		0x9 /* AE 4 2 1 | 8 4 2 1 */
#define RTC8564_REG_AL_HR		0xa /* AE 4 2 1 | 8 4 2 1 */
#define RTC8564_REG_AL_DAY		0xb /* AE x 2 1 | 8 4 2 1 */
#define RTC8564_REG_AL_WDAY		0xc /* AE x x x | x 4 2 1 */
#define RTC8564_REG_CLKOUT		0xd /* FE x x x | x x FD1 FD0 */
#define RTC8564_REG_TCTL		0xe /* TE x x x | x x FD1 FD0 */
#define RTC8564_REG_TIMER		0xf /* 8 bit binary */

/* Control reg */
#define RTC8564_CTRL1_TEST1		(1<<3)
#define RTC8564_CTRL1_STOP		(1<<5)
#define RTC8564_CTRL1_TEST2		(1<<7)

#define RTC8564_CTRL2_TIE		(1<<0)
#define RTC8564_CTRL2_AIE		(1<<1)
#define RTC8564_CTRL2_TF		(1<<2)
#define RTC8564_CTRL2_AF		(1<<3)
#define RTC8564_CTRL2_TI_TP		(1<<4)

/* CLKOUT frequencies */
#define RTC8564_FD_32768HZ		(0x0)
#define RTC8564_FD_1024HZ		(0x1)
#define RTC8564_FD_32			(0x2)
#define RTC8564_FD_1HZ			(0x3)

/* Timer CTRL */
#define RTC8564_TD_4096HZ		(0x0)
#define RTC8564_TD_64HZ			(0x1)
#define RTC8564_TD_1HZ			(0x2)
#define RTC8564_TD_1_60HZ		(0x3)

#define I2C_DRIVERID_RTC8564 0xf000

--Boundary-00=_2liNERSBtEOPM/r--
