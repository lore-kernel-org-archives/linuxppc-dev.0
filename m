Message-ID: <3EA6D5D2.3080005@gmx.net>
Date: Wed, 23 Apr 2003 20:05:06 +0200
From: Oliver Amft <oam@gmx.net>
MIME-Version: 1.0
To: "Johnson, Stephen" <stevebj@artesyncp.com>
Cc: Wolfgang Denk <wd@denx.de>, linuxppc-embedded@lists.linuxppc.org,
	ebs@ebshome.net
Subject: RE: Opps...with ELDK-2.1.0 (ppc_4xx)
Content-Type: multipart/mixed;
 boundary="------------020008090205060808030104"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------020008090205060808030104
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Having missed some of the messages before, I am not sure if  i'm correct
but i think this is what you need ;-)
You will have to adapt the includes, e.g. i2c.h

Is there any official tree where this driver is included? (I havn't
found it in ELDK 2.0.2)

Cheers,
Oliver


>
> >[Wolfgang]
> > > >
> > > >This means you have a RTC on the I2C bus, right? Same here. It  works
> > > >fine on all baords except those with a I2C based RTC. Which is why we
> > > >detected the problem so late.
> > >
> >
> >[Eugene]
> > > It looks like a bug in m41t00_set_rtc_time.
> > >
> > > Generic I2C layer is very high-level subsystem and can not be
> > > used from the interrupt context.
> > >
> >
> >If the i2c layer cannot be used in the (e.g. timer) interrupt context,
> >wouldn't that preclude the use of the i2c layer to provide support (i.e.
> >clock updates) to an i2c-based rtc?
>
> Unfortunately, it looks so
>
> >Any suggestions on how to work around this?
>
> We can start kernel thread and call i2c from it (or maybe use one which is
> already available in the kernel?) .
> <foo>_set_rtc_time will notify this thread when it needs to update RTC
> from
> interrupt.
>
> If you worry about accuracy, we may also remember "jiffies" at the time of
> <foo>_set_rtc_time and adjust time accordingly when calling i2c (but I
> doubt it's worth it).
>
> Eugene
>
>
>

--------------020008090205060808030104
Content-Type: text/plain;
 name="m41t00.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="m41t00.c"

/*
 * /linux/drivers/i2c/m41t00.c - driver module
 *
 * Copyright (c) 2002 Christoph Suter fels@datacomm.ch
 * Copyright (c) 2002 ABB Switzerland Ltd.  All rights reserved.
 *
 * This code is free software; you can redistribute it and/or
 * modify it under the terms of the GNU *Library* General Public License
 * as published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This code is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * *Library* General Public License for more details.
 *
 * You should have received a copy of the GNU *Library* General Public
 * License along with this program (see file COPYING.LIB); if not,
 * write to the Free Software Foundation, Inc., 675 Mass Ave,
 * Cambridge, MA 02139, USA.
 *
 * $Id$
 *
*/

#include <linux/modversions.h>
#include <linux/config.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/types.h>
#include <linux/miscdevice.h>
#include <linux/fcntl.h>
#include <linux/fs.h>
#include <linux/init.h>
#include "../i2c/i2c-2.6.3/kernel/i2c.h"	//import our version of i2c.h. UGLY
#include <linux/rtc.h>
#include <linux/proc_fs.h>
#include <linux/devfs_fs_kernel.h>

#include <asm/machdep.h>	/* for ppc.md routines */
#include <asm/uaccess.h>	/* for copy to / from userspace */
#include <asm/hardirq.h>	/* for checking if in interupt (see function set_rtc_time_interrupt */

/* better include own definitions last... (multiple macro definitions) */
#include "m41t00.h"


/*
 * Function prototypes
 */

extern void to_tm(int tim, struct rtc_time *tm);


#define M41T00_NAME		"m41t00"
#define M41T00_VERSION		"1.00"



/*
 * Global variables
 */

devfs_handle_t m41t00_handle;


/* number of times /dev/rtc has been opened */
static int rtc_open = 0;

/* year corresponding to 0x00 (epoch).  */
static unsigned long epoch = 2000;
int globerr = 0;

	/* Number of Days per Month */
static const unsigned char days_in_mo[] =
    { 0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };

	/*don't ignore any addresses */
static unsigned short ignore[] = { I2C_CLIENT_END };

	/* the clock has always this address */
static unsigned short normal_addr[] = { 0xD0 / 2, I2C_CLIENT_END };



	/*Structures */

extern struct machdep_calls ppc_md;


struct clientdata {		/* Keep time from set_time call. */
	unsigned long time;
} jiq_data;



		/* task queue to write time outside the interrupt */
struct tq_struct jiq_task;

static struct i2c_client *this_client;

static struct i2c_client_address_data addr_data = {
	normal_i2c:normal_addr,
	normal_i2c_range:ignore,
	probe:ignore,
	probe_range:ignore,
	ignore:ignore,
	ignore_range:ignore,
	force:ignore,
};

static struct i2c_driver m41t00_driver = {
	name:"M41T00",
	id:I2C_DRIVERID_M41T00,
	flags:I2C_DF_NOTIFY,
	attach_adapter:m41t00_attach,
	detach_client:m41t00_detach,
	command:m41t00_command
};

static struct file_operations m41t00_fops = {	/* we only need iotl, open and release here */
	owner:THIS_MODULE,
	llseek:NULL,
	read:NULL,
	poll:NULL,
	ioctl:m41t00_ioctl,
	open:m41t00_open,
	release:m41t00_release,
	fasync:NULL,
};

		/* used for device-numbering */
static struct miscdevice m41t00_miscdev = {
	RTC_MINOR,
	"rtc",
	&m41t00_fops
};



/* End of Global Variables */



/* Global functions */


static int
m41t00_detect_client(struct i2c_adapter *adap, int addr,
		     unsigned short flags, int kind)
/* When probing for an adapter, i2c_probe calls back this function. To be sure
 * that a found device is really our rtc, we try to read the time once and do
 * some basic check of the returnvalue. We also check if the RTC is stopped.
 * If so, we turn it on.
 *
 * Reading from rtc is performed in two steps: write to rtc to set the
 * rtc's internal adresspointer,  2. read from rtc.
 */
{
	struct rtc_registers_cs rtc;
	unsigned char addrdata[2];
	int errsnd, errrcv = 0;


	PDEBUG("rtc.o: Examining address  %#02x...\n", 2 * addr);

	/* Allocate some memory for Client: */
	this_client = kmalloc(sizeof(*this_client), GFP_KERNEL);

	if (!this_client) {
		return -ENOMEM;	/*Memory Allocation failed */
	}

	strcpy(this_client->name, "M41T00");
	this_client->id = m41t00_driver.id;
	this_client->flags = 0;
	this_client->addr = addr;
	this_client->adapter = adap;
	this_client->driver = &m41t00_driver;
	this_client->data = NULL;	/* no driver specific data */

	PDEBUG("sending request to RTC...\n");

	/* Set the adress pointer in the clock */
	addrdata[0] = 0;	/*Read from adress 0 */
	errsnd = i2c_master_send(this_client, addrdata, 1);

	/* Read clock */
	errrcv = i2c_master_recv(this_client, (char *) &rtc, sizeof(rtc));

	if (errsnd + errrcv != sizeof(addrdata[0]) + sizeof(rtc))
		goto error;
	/* enable century enable bit and disable century bit in rtc:	*/
	addrdata[0] = 2;
	addrdata[1] = (rtc.hours | 0x80) & 0xBF;
	if (i2c_master_send(this_client, addrdata, sizeof(addrdata)) != sizeof(addrdata)) goto error;



	/* clock stopped? */
	if (rtc.secs & CTRL_STOP) {
		printk(KERN_INFO
		       "rtc.o: real-time-clock was stopped.\nNow starting...\n");
		addrdata[0] = 0;	/* store the following data at address 0 */
		addrdata[1] = rtc.secs & ~CTRL_STOP;
		if (i2c_master_send(	/* restart clock */
					   this_client, addrdata,
					   sizeof(addrdata)) !=
		    sizeof(addrdata))
			goto error;
	}

	i2c_attach_client(this_client);

	/* modules can be unloaded and our function pointer could point */
	/* to anywhere. Assumption: There is only one RTC on the bus... */
#  	if(defined CONFIG_PPC) && (defined M41T00_PATCH_KERNEL)
	if (ppc_md.set_rtc_time == NULL) {

		/* init structure for routine outside interrupt */
		jiq_task.sync = 0;
		jiq_task.routine = set_rtc_time_task;
		jiq_task.data = (void *) &jiq_data;

		/* register our function */
		ppc_md.set_rtc_time = set_rtc_time_interrupt;
		PDEBUG("RTC pointer in kernel modified!\n");
	} else {
		printk(KERN_WARNING
		       "rtc.o: RTC pointers in kernel already set!\n");
	}
#	endif(defined CONFIG_PPC) && (defined M41T00_PATCH_KERNEL)


	printk(KERN_INFO
	       "rtc.o: I2C based RTC detected at address %#02x.\n",
	       2 * addr);
	return 0;

      error:
	globerr = -1;		/* Set global error, so that we do not even try to register the device / attach the driver */
	PDEBUG("Summed bus transfer: %u. Should be: %u. \n",
	       errsnd + errrcv, 1 + sizeof(rtc));

	kfree(this_client);
	this_client = NULL;
	printk(KERN_ERR "rtc.o: I2C bus problem or another
	  device than RTC is responding at this address... \n ");
	return -EIO;
}




/*
 * Search for our RTC on the bus. Called by i2c_add_driver.
 *
 * Whenever a new adapter is inserted, or for all adapters if the driver is
 * being registered, the callback m41t00_attach is called. Now is the
 * time to determine what devices are present on the adapter, and to register
 * a client for each of them.
 *
 * The attach_adapter callback is really easy: we just call the generic
 * detection function. This function will scan the bus for us, using the
 * information as defined in the list addr_data. If a device is
 * detected at a specific address, another callback "m41t00_detect_client" is
 * called.
 *
 * Return value will be ignored...
 */
static int m41t00_attach(struct i2c_adapter *adap)
{
	int err;
	PDEBUG(KERN_INFO "rtc.o: searching for RTC...\n");
	err = i2c_probe(adap, &addr_data, m41t00_detect_client);
	if (err) {
		printk(KERN_ERR "rtc.o: error while scanning for RTC.\n");
		globerr = -1;	/* Set global error to one */
	}
	return err;
}




/*
 * Detach the RTC from the adapter
 */
static int m41t00_detach(struct i2c_client *client)
{
	int err = 0;
#if (defined CONFIG_PPC) && (defined M41T00_PATCH_KERNEL)
	ppc_md.set_rtc_time = NULL;	/* no rtc anymore.. */
#endif				/* (defined CONFIG_PPC) && (defined M41T00_PATCH_KERNEL) */
	err = i2c_detach_client(client);
	if (err) {
		printk(KERN_ERR
		       "rtc.o: Client deregistration failed, client not \
		  detached. \n");
	} else
		kfree(this_client);
	this_client = NULL;
	return 0;
}



/*
 * Misc commands exported over i2c driver
 */
static int
m41t00_command(struct i2c_client *client, unsigned int cmd, void *arg)
{
	switch (cmd) {
	case RTC_RD_TIME:
		return m41t00_get_datetime(client, arg);

	case RTC_SET_TIME:
		return m41t00_set_datetime(client, arg);

	default:		/* May not happen */
		return -EINVAL;
	}
}



/*
* Commands
*/
static inline int rtc_command(int cmd, void *data)
{
	int ret = -EIO;
	if (this_client) {
		ret = this_client->driver->command(this_client, cmd, data);
	}
	return ret;
}


/*
 *	ioctl-routine
*/
static int m41t00_ioctl(struct inode *inode,
			struct file *file,
			unsigned int cmd, unsigned long arg)
{
	struct rtc_time wtime;
	int err = 0;
	switch (cmd) {
	case RTC_RD_TIME:
		err = m41t00_get_datetime(this_client, &wtime);
		if (err) {
			PDEBUG("Error while getting time: %i \n", err);
			return err;
		}
		PDEBUG("Processing time...\n");
		/* copy from kernel address space to user address space */
		return copy_to_user((void *) arg, &wtime,
				    sizeof(wtime)) ? -EFAULT : 0;

	case RTC_SET_TIME:	/* Set the RTC */
		if (!capable(CAP_SYS_TIME))
			return -EACCES;
		/* copy from user address space to kernel address space */
		if (copy_from_user(&wtime, (struct rtc_time *) arg,
				   sizeof(struct rtc_time))) {
			return -EFAULT;
		}
		if (m41t00_set_datetime(this_client, &wtime)) {
			printk(KERN_WARNING
			       "Could not set time in rtc!\n");
			return -EFAULT;
		}
		return 0;


	default:		/* May not happen */
		PDEBUG("No valid flag given to ioctrl!!\n");
		return -EINVAL;
	}
}




/*
*	Read RTC
*/
static int
m41t00_get_datetime(struct i2c_client *client, struct rtc_time *dt)
{
	unsigned char addr[1] = { 0 };	/* read from address 0 */
	struct rtc_registers_cs rtc;
	int err, err1;
	err = i2c_master_send(client, addr, 1);	/* set adresspointer */
	err1 = i2c_master_recv(this_client, (char *) &rtc, sizeof(rtc));	/*read time */
	m41t00_print_info(&rtc);
	m41t00_rtc_to_tm(&rtc, dt);
	PDEBUG("Read: year-value: %u \n",dt->tm_year);
	/*
	 * Account for differences between how the RTC uses the values
	 * and how they are defined in a struct rtc_time;
	 */
	if (dt->tm_year >= 0 && dt->tm_year <= 37)
		dt->tm_year += 100;
	else if (dt->tm_year >=69 && dt->tm_year <=99)
		dt->tm_year += 0;
	else return -EIO;
	PDEBUG ("Year value now: %u\n",dt->tm_year);
	dt->tm_mon--;
	if ((err != 1) || (err1 != sizeof(rtc))) {
		printk(KERN_ERR
		       "rtc.o: I2C bus problem! (get datetime)\n");
		return -EIO;
	} else
		return 0;
}



/*
 * Set date & time
 *
 *
 * note: we must transfer the address and the time in one transaction
 * (no repeated slave address or start bit after we wrote the "word address")
 */
static int
m41t00_set_datetime(struct i2c_client *client, struct rtc_time *dt)
{
	int ret = 0;
	/* buf[0] is reserved for the adress to write to */
	u8 buf[1 + sizeof(struct rtc_registers_cs)];
	struct rtc_registers_cs *rtc;
	buf[0] = 0;		/* write to address 0 */
	rtc = (struct rtc_registers_cs *) &buf[1];
	PDEBUG("Year before checkdate: %u\n",dt->tm_year);
	/* check if date makes sense */
	/* Here we still need the "long" year, since leapyear checking is done here */
	if (checkdate(dt)) {
		PDEBUG("Date invalid!");
		return -EINVAL;
	}
	/* now reduce year to two places */
	if (dt->tm_year >99) {
		PDEBUG("Need to corect year. Year is now: %u\n",dt->tm_year);
		dt->tm_year = dt->tm_year % 100;
	}
	PDEBUG("Year after Checkdate: %u \n",dt->tm_year);

	dt->tm_mon++;		// month counting start with zero

	PDEBUG("Date ok.\n");

	/* convert date to BCD */
	m41t00_tm_to_rtc(dt, rtc);
	PDEBUG("Setting Date:\n");
	PDEBUG("rtc_time: %02d:%02d:%02d\n", dt->tm_hour,
	       dt->tm_min, dt->tm_sec);
	PDEBUG("rtc_date: %04d-%02d-%02d\n",
	       (dt->tm_year + (int) epoch), dt->tm_mon, dt->tm_mday);
	PDEBUG("rtc_epoch: %04lu\n", epoch);
#ifdef M41T00_DEBUG
	m41t00_print_content(rtc);
#endif
	/* set time & date */
	/*if (dt->tm_year > 2000) {
		PDEBUG("Subtracting 2000 from year!\n");
		dt->tm_year -=2000;
	}*/

	/* # of transfered bytes */
	if (i2c_master_send(client, buf, sizeof(buf)) != sizeof(buf)) {
		printk(KERN_ERR "rtc.o: I2C bus problem!\n");
		ret = -EIO;
	}
#ifdef M41T00_DEBUG
	m41t00_print_content(rtc);
#endif
	return ret;
}



/*
 * Check date, returns -1 if date & time makes no sense
 */

static int checkdate(struct rtc_time *dt)
{
	unsigned char leap_yr;
	/* Ntpd seems to call us with 2002 for the year-value... */
	/*if (dt->tm_year > 2000) {
		PDEBUG("Year was greater than 2000!\n");
		dt->tm_year -= 2000;
	}*/
	leap_yr = ((!(dt->tm_year % 4) && (dt->tm_year % 100))
		   || !(dt->tm_year % 400));

	if ((dt->tm_sec < 0) || (dt->tm_sec > 59)) {
		PDEBUG("Seconds out of range! Seconds: %u\n", dt->tm_sec);
		return (-1);
	}

	if ((dt->tm_min < 0) || (dt->tm_min > 59)) {
		PDEBUG("Minutes out of range! Minutes: %u\n", dt->tm_min);
		return (-1);
	}

	if ((dt->tm_hour < 0) || (dt->tm_hour > 23)) {
		PDEBUG("Hours out of range! Hours: %u\n", dt->tm_hour);
		return (0);
	}

	if ((dt->tm_mon < 1) || (dt->tm_mon > 12)) {
		PDEBUG("Months out of range! Months: %u\n", dt->tm_mon);
		return (0);
	}


	if (dt->tm_mday < 1) {
		PDEBUG("Days out of range! mday: %u\n", dt->tm_mday);
		return (-1);
	}

	if (dt->tm_mday > days_in_mo[dt->tm_mon]) {	/* we must have leap year and 29.2. */
		if (!leap_yr) {	/* no leapyear, wrong date */
			PDEBUG("Days out of range! mday: %u\n",
			       dt->tm_mday);
			return (-1);
		} else if (!(dt->tm_mon == 2) && (dt->tm_mday == 29)) {	/*leap year, must have 29.2 */
			PDEBUG("Days out of range! mday: %u\n",
			       dt->tm_mday);
			return (-1);
		}
	}

	if ((dt->tm_year < 0) || (dt->tm_year > 199)) {
		PDEBUG("Years out of range! Years: %u\n", dt->tm_year);
		return (-1);
	}

	/* No checking for weekdays done here, because we may not have
	   *       got a valid parameter for them */
	PDEBUG("Checkdate passed!\n");
	return 0;
}





/*
 * Open..
 */
static int m41t00_open(struct inode *minode, struct file *mfile)
{
	if (rtc_open) {		/* Allow only one opening at a time */
		printk(KERN_WARNING "Device already opened!\n");
		return -EBUSY;
	}
	rtc_open++;
	return 0;
}



/*
*	Release
*/

static int m41t00_release(struct inode *minode, struct file *mfile)
{
	rtc_open--;
	return 0;
}




/*
 *	Info exported via "/proc/rtc".
 */
static int m41t00_proc_output(char *buf)
{
	int len = 0, err, err1;
	struct rtc_time tm;
	unsigned char addr[1] = { 0 };	/* read from address 0 */
	struct rtc_registers_cs rtc;
	err = i2c_master_send(this_client, addr, 1);
	err1 = i2c_master_recv(this_client, (char *) &rtc, sizeof(rtc));
	if ((err == 1) && (err1 == sizeof(rtc))) {
		PDEBUG("Time successfully read!\n");
		len += sprintf(buf + len,
			       "Stop Bit\t\t: %d\n"
			       "Century Enable Bit\t: %d\n"
			       "Century Bit\t\t: %d\n"
			       "Output Level\t\t: %d\n"
			       "Frequency Test Bit\t: %d\n"
			       "Sign Bit\t\t: %d\n"
			       "Calibration\t\t: %d\n",
			       (rtc.secs & 0x80) ? 1 : 0,
			       (rtc.hours & 0x80) ? 1 : 0,
			       (rtc.hours & 0x40) ? 1 : 0,
			       (rtc.cs & 0x80) ? 1 : 0,
			       (rtc.cs & 0x40) ? 1 : 0,
			       (rtc.cs & 0x20) ? 1 : 0, (rtc.cs & 0x1f));
		/* convert date */
		m41t00_rtc_to_tm((struct rtc_registers_cs *) &rtc, &tm);
		/* Make  output deal with years the same way hwclock does: */
		if (tm.tm_year >= 0 && tm.tm_year <= 37)
		tm.tm_year += 2000;
		else if (tm.tm_year >=69 && tm.tm_year <=99)
		tm.tm_year += 1900;
		/*
		 * There is no way to tell if the user has the RTC set for local
		 * time or for Universal Standard Time (GMT). Probably local though.
		 */
		len += sprintf(buf + len,
			       "rtc_time\t\t: %02d:%02d:%02d\n"
			       "rtc_date\t\t: %04d-%02d-%02d\n"
			       "rtc_epoch\t\t: %04lu\n",
			       tm.tm_hour, tm.tm_min, tm.tm_sec,
			       tm.tm_year, tm.tm_mon,
			       tm.tm_mday, epoch);
	} else {
		len += sprintf(buf + len, "Error reading date!\n");
		printk(KERN_ERR "rtc.o: I2C bus problem!\n");
	}
	return len;
}



/**
 * helper function for proc output.
 *
 * page: buffer to print
 * start: start page (NULL)
 * off: offset
 * count: maximal length
 */
static int m41t00_read_proc(char *page, char **start,
			    off_t off, int count, int *eof, void *data)
{
	int len = m41t00_proc_output(page);	/* m41t00_proc_output may not */
	/*generate more than 1 page of data! */
	if (len <= off + count)
		*eof = 1;	/* 1 = this is last output */
	*start = page + off;
	len -= off;
	if (len > count)
		len = count;
	if (len < 0)
		len = 0;
	return len;
}



/**
 * Prints time during init() call
 */
static void m41t00_print_info(struct rtc_registers_cs *rtc)
{
	struct rtc_time tm;
	/* convert date */
	m41t00_rtc_to_tm((struct rtc_registers_cs *) rtc, &tm);
	/* Make  output deal with years the same way hwclock does: */
	if (tm.tm_year >= 0 && tm.tm_year <= 37)
		tm.tm_year += 2000;
	else if (tm.tm_year >=69 && tm.tm_year <=99)
		tm.tm_year += 1900;
	/*
	 * There is no way to tell if the user has the RTC set for local
	 * time or for Universal Standard Time (GMT). Probably local though.
	 */
	printk(KERN_INFO
	       "rtc.o: rtc_time: %02d:%02d:%02d\n"
	       "rtc.o: rtc_date: %04d-%02d-%02d\n"
	       "rtc.o: rtc_epoch: %04lu\n",
	       tm.tm_hour, tm.tm_min, tm.tm_sec,
	       tm.tm_year, tm.tm_mon, tm.tm_mday, epoch);
}


/*
 * prints rtc content via printk
 * used for debugging only
 */
#ifdef M41T00_DEBUG
static void m41t00_print_content(struct rtc_registers_cs
				 *rtc)
{
	struct rtc_time tm;
	printk(KERN_DEBUG "rtc content:\n");
	printk(KERN_DEBUG "Stop Bit\t\t: %d\n"
	       "Century Enable Bit\t: %d\n"
	       "Century Bit\t\t: %d\n" "Output Level\t\t: %d\n"
	       "Frequency Test Bit\t: %d\n" "Sign Bit\t\t: %d\n"
	       "Calibration\t\t: %d\n",
	       (rtc->secs & 0x80) ? 1 : 0,
	       (rtc->hours & 0x80) ? 1 : 0,
	       (rtc->hours & 0x40) ? 1 : 0,
	       (rtc->cs & 0x80) ? 1 : 0,
	       (rtc->cs & 0x40) ? 1 : 0,
	       (rtc->cs & 0x20) ? 1 : 0, (rtc->cs & 0x1f));
	/* convert date */
	m41t00_rtc_to_tm((struct rtc_registers_cs *) rtc, &tm);

	/* Make  output deal with years the same way hwclock does: */
	if (tm.tm_year >= 0 && tm.tm_year <= 37)
		tm.tm_year += 2000;
	else if (tm.tm_year >=69 && tm.tm_year <=99)
		tm.tm_year += 1900;
	/*
	 * There is no way to tell if the user has the RTC set for local
	 * time or for Universal Standard Time (GMT). Probably local though.
	 */
	printk(KERN_DEBUG
	       "rtc_time\t\t: %02d:%02d:%02d\n"
	       "rtc_date\t\t: %04d-%02d-%02d\n"
	       "rtc_epoch\t\t: %04lu\n",
	       tm.tm_hour, tm.tm_min, tm.tm_sec,
	       tm.tm_year, tm.tm_mon, tm.tm_mday, epoch);
}
#endif				/* M41T00_DEBUG */



/*
* Converts date and time from BCD to DEC
*/
static void m41t00_rtc_to_tm(struct rtc_registers_cs
			     *rtc, struct rtc_time *dt)
{
	dt->tm_sec = BCD_TO_BIN(rtc->secs & 0x7f);
	dt->tm_min = BCD_TO_BIN(rtc->mins & 0x7f);
	dt->tm_hour = BCD_TO_BIN(rtc->hours & 0x3f);
	dt->tm_wday = BCD_TO_BIN(rtc->wday & 0x07);
	dt->tm_mday = BCD_TO_BIN(rtc->mday & 0x3f);
	dt->tm_mon = BCD_TO_BIN(rtc->mon & 0x1f);
	dt->tm_year = BCD_TO_BIN(rtc->year & 0xff);
	dt->tm_year += (rtc->hours & 0x40) ? 100 : 0;
}



/*
*	Converts date and time from DEC to BCD
*/

static void m41t00_tm_to_rtc(struct rtc_time *dt,
			     struct rtc_registers_cs *rtc)
{
	PDEBUG("Year: %d (should be 0-200)\n", dt->tm_year);
	rtc->secs = BIN_TO_BCD(dt->tm_sec);
	rtc->mins = BIN_TO_BCD(dt->tm_min);
	rtc->hours = BIN_TO_BCD(dt->tm_hour);
	rtc->hours |= 0x80;	/* Set Century enable Bit */
	PDEBUG("tm_to_rtc: year: %u\n",dt->tm_year);
	rtc->year = BIN_TO_BCD(dt->tm_year);
	rtc->mday = BIN_TO_BCD(dt->tm_mday);
	rtc->mon = BIN_TO_BCD(dt->tm_mon);
	rtc->wday = BIN_TO_BCD(dt->tm_wday);
}



/*
 * Driver entry. Register our driver at the I2C-core driver.
 * If successful register at the kernel and install the proc read
 * routine.
 */
static int __init m41t00_init(void)
{
	int err;
	err = i2c_add_driver(&m41t00_driver);
	if (err || globerr) {
		printk(KERN_ERR
		       "rtc.o: Register I2C driver failed,  errno is % d \n ",
		       err);
		return err;
	}
	err = 0;
	m41t00_handle =		/* Register device for devfs, fails silently if devfs not supported */
	    devfs_register(NULL, "rtc", DEVFS_FL_AUTO_DEVNUM,
			   0, 0, S_IFCHR | S_IRUGO | S_IWGRP,
			   &m41t00_fops, NULL);
	if (m41t00_handle == NULL) {	/* we have no devfs, use dev */
		err = misc_register(&m41t00_miscdev);
		if (!err) {	/* registering /dev/rtc ok */
			printk(KERN_INFO
			       "/dev/rtc registered as chardevice major 10, min %u.\n",
			       RTC_MINOR);
		} else {	/* no devfs and /dev/rtc register failed: abort */
			printk(KERN_ERR
			       "rtc.o: Could not register device rtc, errno is %u(%d)\n",
			       err, err);
			err = i2c_del_driver(&m41t00_driver);
			if (err) {	/*unregistering driver failed */
				printk(KERN_ERR
				       "rtc.o: Unregister I2C driver failed, errno \
				  is % d \n ", err);
			}
			return err;

		}
	} else {		/*devfs ok , continue   */
		PDEBUG(KERN_INFO "Chardevice rtc successfully registered.\n");
	}

	if (!create_proc_read_entry("rtc", 0, NULL, m41t00_read_proc, NULL)) {	/* proc support */
		printk(KERN_ERR "rtc.o: can't create /proc/rtc\n");
	}
	/* we have no proc, but we still can access the rtc */

	printk(KERN_INFO
	       "rtc.o: I2C based RTC driver version %s initialized.\n",
	       M41T00_VERSION);
	return 0;
}



/*
*	Driver exit: unregister device and driver
*/

static void __exit m41t00_exit(void)
{
	remove_proc_entry("rtc", NULL);
	devfs_unregister(m41t00_handle);
	printk(KERN_INFO "rtc.o: Device unregistered.\n");
	if (misc_deregister(&m41t00_miscdev))
		printk(KERN_ERR
		       "rtc.o: Unregistering chardevice failed!\n");
	else
		printk(KERN_INFO "rtc.o: Chardevice unregistered.\n");
	if (i2c_del_driver(&m41t00_driver)) {
		printk(KERN_ERR "rtc.o: Unregister I2C driver failed, \
					  module not removed. \n ");
	} else {
		printk(KERN_INFO "RTC driver successfully unloaded!\n");
	}
}

EXPORT_NO_SYMBOLS;


/*
* If modules is NOT defined when this file is compiled, then the MODULE_*
* macros will resolve to nothing
*/
MODULE_AUTHOR("Christoph Suter <fels@datacomm.ch>");
MODULE_DESCRIPTION("M41T00 Real Time Clock Driver for I2C-Bus");
MODULE_SUPPORTED_DEVICE("rtc");
MODULE_LICENSE("GPL");
/*
* Description: Called when module is loaded or when kernel is intialized.
* If MODULES is defined when this file is compiled, then this function will
* resolve to init_module (the function called when insmod is invoked for a
* module).  Otherwise, this function is called early in the boot, when the
* kernel is intialized.  Check out /include/init.h to see how this works.
*/
module_init(m41t00_init);
/*
* Description: Resolves to module_cleanup when MODULES is defined.
*/
module_exit(m41t00_exit);
#if (defined CONFIG_PPC) && (defined M41T00_PATCH_KERNEL)
/*
 * Set the RTC time.
 *
 * A Pointer to this function will be set in the machine dependent code.
 *So, if we are synching our system time with an extrnal clock, the
 * kernel will call this routine every 11 minutes to sync the rtc to the systime
 *
 * Important: This routine is called in interrupt mode!
 * 			  Since the I2C driver also uses interrupts we *must*
 *			  set the RTC after the interrupt has been completed.
 *			  Otherwise we would wait for an interrupt to occur when
 *			  we are in another interrupt.
 */
static int set_rtc_time_interrupt(unsigned
				  long nowtime)
{
	jiq_data.time = nowtime;	// save time for delayed set
	if (!schedule_task(&jiq_task)) {	/* ready to run */
		printk(KERN_WARNING
		       "rtc.o: set_rtc_time calls to close!\n");
	}
	/* I'm not sure about this... */
	PDEBUG("really in interrupt: %s", in_interrupt()? "yes" : "no");
	return 0;
}

/*
 * Set the RTC time outside the interrupt.
 */
static void set_rtc_time_task(void
			      *p)
{
	struct rtc_time tm;
	struct clientdata *data = (struct clientdata *) p;
	PDEBUG("Task running\n");
	to_tm(data->time, &tm);
	tm.tm_mon--;	/* for compliance with hwclock */
	//tm.tm_hour++;	/* compensate kernel bug	*/
	if (tm.tm_year > 2000) {
		PDEBUG("Adjusting year!\n");
		tm.tm_year -= 2000;
	}
	rtc_command(RTC_SET_TIME, &tm);
}


#endif				/* (defined CONFIG_PPC) && (defined M41T00_PATCH_KERNEL) */

/*
 * Local variables:
 * c-indent-level: 4
 * c-basic-offset: 4
 * tab-width: 4
 * End:
 */

--------------020008090205060808030104
Content-Type: text/plain;
 name="m41t00.h"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="m41t00.h"

/*
 *  linux/include/linux/m41t00.h
 *
 *  Copyright (C) 2002 ABB
 *
 *  Author: Christoph Suter
 *			fels@datacomm.ch
 *
 *	Based on the work of
 *			Gérard Basler
 *          gbasler@ee.ethz.ch
 *
 *	Based on m41t11 driver by George Davis
 *
 *  Copyright (C) 2000 Russell King
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 */
#define EXPORT_SYMTAB
#define M41T00_DEBUG // turn debug messages on / off
#define M41T00_PATCH_KERNEL
#include <linux/devfs_fs_kernel.h>
#define M41T00_DEBUG

#undef PDEBUG
#if	defined M41T00_DEBUG
#	define	PDEBUG(fmt, args...)	printk(KERN_DEBUG "%s, %s [%d]: " fmt, __FILE__, __FUNCTION__ , __LINE__ , ## args)
#else
#	define	PDEBUG(fmt, args...)
#endif

/* internal definitions not for use in user space programs */
#ifdef __KERNEL__

/* undefined similar functions from other headers... */
#undef BCD_TO_BIN(val)
#define BCD_TO_BIN(val) (((val)&15) + ((val)>>4)*10)

#undef BIN_TO_BCD(val)
#define BIN_TO_BCD(val) ((((val)/10)<<4) + (val)%10)

#undef IS_LOWNIBBLE_BCD(x)
#define IS_LOWNIBBLE_BCD(x) ( (x & 0x0f) < 10 )

#undef IS_BCD(x)
#define IS_BCD(x) ( ( (x & 0x0f) < 10) && ( (x & 0xf0) <10) ) )


#undef DAT(x)
#define DAT(x) ((unsigned int)(x->data)) /* x: i2c_client->data */


#define M41T00_IOC_MAGIC 0xcc

#define CTRL_STOP	0x80

/* structure used for reading */
struct rtc_registers_cs {
	unsigned char 	secs	__attribute__ ((packed));
	unsigned char 	mins 	__attribute__ ((packed));
	unsigned char 	hours 	__attribute__ ((packed));
	unsigned char 	wday	__attribute__ ((packed));
	unsigned char 	mday 	__attribute__ ((packed));
	unsigned char 	mon 	__attribute__ ((packed));
	unsigned char 	year	__attribute__ ((packed));
	unsigned char 	cs		__attribute__ ((packed));
};


/*
 * Function prototypes
 */

static int __init m41t00_init(void);
static void __exit m41t00_exit(void);
static int m41t00_detect_client(struct i2c_adapter *adap, int addr, unsigned short flags, int kind);
static int m41t00_attach(struct i2c_adapter *adap);
static int m41t00_detach(struct i2c_client *client);
static int m41t00_get_datetime(struct i2c_client *client, struct rtc_time *dt);
static int m41t00_set_datetime(struct i2c_client *client, struct rtc_time *dt);
static int checkdate(struct rtc_time *dt);
static int m41t00_command(struct i2c_client *client, unsigned int cmd, void *arg);
static int m41t00_open(struct inode *minode, struct file *mfile);
static int m41t00_release(struct inode *minode, struct file *mfile);
static int m41t00_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg);
#ifdef CONFIG_PROC_FS
static int m41t00_proc_output (char *buf);
#endif // CONFIG_PROC_FS
static void m41t00_print_info(struct rtc_registers_cs *rtc);
#ifdef M41T00_DEBUG
static void m41t00_print_content(struct rtc_registers_cs *rtc);
#endif // M41T00_DEBUG
static int m41t00_read_proc(char *page, char **start, off_t off, int count, int *eof, void *data);

static void m41t00_rtc_to_tm(struct rtc_registers_cs *rtc, struct rtc_time *dt);
static void m41t00_tm_to_rtc(struct rtc_time *dt, struct rtc_registers_cs *rtc);

#if defined CONFIG_PPC
static int set_rtc_time_interrupt(unsigned long nowtime);
static void set_rtc_time_task(void *p);
#endif // CONFIG_PPC

#endif // __KERNEL__


--------------020008090205060808030104--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
