Message-ID: <377E3715.94BEF931@tiac.net>
Date: Sat, 03 Jul 1999 12:15:15 -0400
From: Timothy Wall <twall@tiac.net>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
CC: "Adkins, Dave" <dadkins@gtcocalcomp.com>
Subject: ADB tablet driver
Content-Type: multipart/mixed;
 boundary="------------9B909B301426C500DE790A67"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------9B909B301426C500DE790A67
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Content-Transfer-Encoding: 7bit

Here's a rudimentary driver which provides basic tablet info to the read
(on /dev/adbtablet) and /proc/adbtablet interfaces.  It's installable as
a module, but don't try to remove it, or the ADB subsys will hang
(there's not yet a method for unregistering ADB handlers).  This was
built for 2.2.X kernels, but will probably run under older ones with
only minor mods.

This can easily be expanded to accomodate other ADB tablets, given the
appropriate data formats.

An added bonus is that it tells you all the default information for any
other ADB devices on your system (dev ID, handler ID, etc).  Useful for
getting the handler ID for non-apple mice.

When I get some time I'll integrate this into the X server...

Tim Wall



--------------9B909B301426C500DE790A67
Content-Type: image/x-xbitmap; x-mac-type="3F3F3F3F"; x-mac-creator="3F3F3F3F";
 name="adbtablet.c"
Content-Disposition: inline;
 filename="adbtablet.c"
Content-Transfer-Encoding: 7bit

/*
 * Macintosh ADB tablet driver for Linux
 * Ultraslate implementation
 *
 * 3 July 1999 Timothy Wall (twall@kagi.com)
 *
 * Expects /dev/adbtablet, character device major 10 minor 11
 * Thanks to Dave Adkins of Calcomp for precious information
 * Code template taken from adbmouse.c
 */

#include <linux/module.h>

#include <linux/sched.h>
#include <linux/errno.h>
#include <linux/miscdevice.h>
#include <linux/mm.h>
#include <linux/random.h>
#include <linux/poll.h>
#include <linux/init.h>
#include <linux/proc_fs.h>

#include <asm/uaccess.h>
#ifdef __powerpc__
#include <asm/processor.h>
#endif
#ifdef __mc68000__
#include <asm/setup.h>
#endif

#include <asm/adb.h>
#include "adbtablet.h"

static inline unsigned long timer_get (void)
{
        struct timeval now;
        do_gettimeofday (&now);
        return ((unsigned long)now.tv_sec & 0xFFF)*1000000 + now.tv_usec;
}

/* for now, only one at a time */
static struct tablet_status tablet;
static struct adb_ids tablet_ids;   // this should be global

static int
tablet_read_procmem (char *buf, char **start, off_t offset,
                     int len, int unused)
{
#define LIMIT (PAGE_SIZE-80);
        char *p = buf;
        /* should prefer snprintf, but i don't think kernal has it */
        p += sprintf (p,
                      "buttons      : 0x%08lx\n"
                      "location     : (%ld,%ld)\n"
                      "tilt         : (%ld,%ld)\n"
                      "pressure     : %ld\n"
                      "height       : %ld\n"
                      "in proximity : %s\n",
                      tablet.state.buttons,
                      tablet.state.loc.x, tablet.state.loc.y,
                      tablet.state.tilt.x, tablet.state.tilt.y,
                      tablet.state.pressure,
                      tablet.state.height,
                      tablet.state.in_proximity ? "yes" : "no");

        return p - buf;
}

struct proc_dir_entry tablet_proc_entry = {
        0,                          // low_ino: the inode (dynamic)
        9,"adbtablet",              // name len and name
        S_IFREG | S_IRUGO,          // mode
        1, 0, 0,                    // nlinks, owner, group
        0,                          // size (unused)
        NULL,                       // operations (use default)
        &tablet_read_procmem,       // function used to read data
};

static void tablet_input(unsigned char *data, int nb, 
                         struct pt_regs *regs, int autopoll)
{
/*
  Calcomp UltraSlate ADB tablet info

  The tablet indicates default address 3 and responds to handler 2 (extended
  mouse protocol).  it still responds at address 4.
  If driver had initialized tablet, only ID 4 shows.
  
  AppleVision display is handler 0xC0. (device ID varies)

  Calcomp ADB (default mode)

  BITS      COMMENTS
  data[0] = dddd 1100 ADB command: talk, register 0, for device dddd
  data[1] = Pyyy yyyy Proximity (1=out), Y-axis
  data[2] = yyyy yyyy Y-axis location 
  data[3] = xxxx xxxx X-axis location (high bits)
  data[4] = xxxx xxxx
  data[5] = CCDb bbbp data type code, D=all buttons, buttons(1), pressure 

  Based on CC,
  data[6] = pppp pppp Pressure (CC=10)
  data[6] = Xttt tttt X=0->X tilt, X=1->Y tilt (CC=00)
  data[6] = hhhh hhhh height (CC=01)
  data[6] = ssss tttt special data(2)/type(3) (CC=11)

  If enabled (same data as mouse for these two bytes, i.e. delta at 100 lpi)
  data[7] = tyyy yyyy tip, Y delta
  data[9] = 1xxx xxxx X delta
    
  (1) Pen or mouse 4 button cursor use one bit per button.
  (2) special
  0000 0000 pen
  0000 0001 reserved
  0000 0010 4 button cursor
  0000 0011 16-button cursor
  0000 0100 unknown
  0000 0101 click tip pen
  0000 0110 4-button cursor square buttons IBM style
  0000 0111 5-button mouse
  0000 1XXX reserved
  0001 0000 reread size information on ADB/RS232 box
  (3) type
  000 pressure pen
  001 mouse 
  011 16-button cursor
  100 unknown
*/
        int type = DATA_TYPE(data[5]);

        tablet.state.loc.x = (short)((unsigned)data[3]<<8)|data[4];
        tablet.state.loc.y = (short)((unsigned)data[1]<<9)|(data[2]<<1)/2;
        tablet.state.buttons = (data[5]&0x3F)>>1;
        tablet.state.in_proximity = (data[1]&0x80) != 0;
        
        switch (type){
        case DATA_TILT:
                if (data[6]&0x80)
                        tablet.state.tilt.y = (int)
                                ((signed char)((data[6] & 0x7F)<<1))>>1;
                else
                        tablet.state.tilt.x = (int)
                                ((signed char)((data[6] & 0x7F)<<1))>>1;
                break;
        case DATA_HEIGHT:
                tablet.state.height = (int)data[6];
                break;
        case DATA_PRESSURE:
                tablet.state.pressure = (int)
                        (data[6]|((unsigned)(data[5]&0x1)<<8));
                break;
        case DATA_SPECIAL:
        default:
//                printk(" special: 0x%x/0x%x\n", (data[6]>>4), (data[6]&0xF));
                break;
        }
 
        tablet.ready = 1;
        wake_up_interruptible(&tablet.wait);
        if (tablet.fasyncptr)
                kill_fasync(tablet.fasyncptr, SIGIO);
}

static int fasync_tablet(int fd, struct file *filp, int on)
{
        int retval;

        retval = fasync_helper(fd, filp, on, &tablet.fasyncptr);
        if (retval < 0)
                return retval;
        return 0;
}

static int release_tablet(struct inode *inode, struct file *file)
{
        fasync_tablet(-1, file, 0);
        if (--tablet.active)
                return 0;

        MOD_DEC_USE_COUNT;
        return 0;
}

static int open_tablet(struct inode *inode, struct file *file)
{
        if (tablet.active++)
                return 0;
	
        tablet.ready = 0;

        MOD_INC_USE_COUNT;

        return 0;
}

static ssize_t write_tablet(struct file *file, const char *buffer,
                            size_t count, loff_t *ppos)
{
        return -EINVAL;
}

static ssize_t read_tablet(struct file *file, char *buffer, size_t count,
                           loff_t *ppos)
{
        if (!tablet.ready)
                return -EAGAIN;
        /* only allow reads of the tablet state/caps structs */
        if (count != sizeof(tablet_state) && count != sizeof(tablet_caps))
                return -EINVAL;

        if (count == sizeof(tablet_state)){
                copy_to_user (buffer, &tablet.state, count);
        }
        else if (count == sizeof(tablet_caps)){
                copy_to_user (buffer, &tablet.caps, count);
        }
        else
                return -EINVAL;

        return count;
}

static unsigned int tablet_poll(struct file *file, poll_table *wait)
{
//	poll_wait(file, (void *)&tablet.wait, wait);
        if (tablet.ready)
                return POLLIN | POLLRDNORM;
        return 0;
}

struct file_operations adb_tablet_fops = {
        NULL,		/* tablet_seek */
        read_tablet,
        write_tablet,
        NULL,		/* tablet_readdir */
        tablet_poll,
        NULL,		/* tablet_ioctl */
        NULL,		/* tablet_mmap */
        open_tablet,
        NULL,		/* flush */
        release_tablet,
        NULL,
        fasync_tablet,
};

#define ADB_TABLET_MINOR	11

static struct miscdevice adb_tablet = {
        ADB_TABLET_MINOR, "adbtablet", &adb_tablet_fops
};

__initfunc(int adb_tablet_init(void))
{
        int tablet_found = 0;
        struct adb_request req;
        int i;
        int devid = ADB_TABLET;

        /* FIXME -- check for existence (i.e. proper HID) of the device we're
           about to support */

        tablet.active = 0;
        tablet.ready = 0;
        tablet.wait = NULL;

#if 0
#ifdef __powerpc__
        if ( (_machine != _MACH_chrp) && (_machine != _MACH_Pmac) )
                return -ENODEV;
#endif
#ifdef __mc68000__
        if (!MACH_IS_MAC)
                return -ENODEV;
#endif
#endif
        // As an added bonus, see what's on the bus and show the default 
        // handler IDs and addresses
        for (devid=0;devid<16;devid++){
                adb_request(&req,NULL,ADBREQ_SYNC,1,ADB_READREG(devid,3));
                if(req.reply_len){
                        int hid = (int)req.reply[2];
                        int addr = req.reply[1]&0xF;
                        printk(KERN_INFO "ADB device@%d, HID 0x%02x, "
                               "default addr %d ", devid, hid, addr);
                        if ((req.reply[1] & 0x4) == 0){
                                printk("EXC");
                                if (req.reply[1]&0x2)
                                        printk("|SRQ");
                        }
                        else if (req.reply[1]&0x2){
                                printk("SRQ");
                        }
                        printk("\n");
                        if (devid == ADB_TABLET && hid == ULTRASLATE_HID)
                                tablet_found = 1;
                }
        }
        if (!tablet_found)
                return -ENODEV;

        /* load Ultraslate capabilities */
        tablet.caps.flags = (TF_HAS_HEIGHT|
                             TF_HAS_TILT|
                             TF_HAS_PRESSURE|
                             TF_HAS_PROXIMITY);
        tablet.caps.res.x = 5000; /* unknown, exactly */
        tablet.caps.res.y = 7800; /* unknown, exactly (y resolution higher?) */
        tablet.caps.tiltres.x = 0x3F; /* 6 bits, -64 < X < 63 */
        tablet.caps.tiltres.y = 0x3F; /* 6 bits, -64 < Y < 63 */
        tablet.caps.pressure_res = 0xFF; /* 8 bits */
        tablet.caps.tangential_res = 0; /* not supported */
        tablet.caps.buttons = 0x7; /* 0x10 is any button */

        printk(KERN_INFO "\nLoading Macintosh ADB tablet driver\n");

        adb_register(ADB_TABLET, ULTRASLATE_HID, &tablet_ids, tablet_input);
        printk(KERN_INFO "ADB tablet(s) registered on ");
        for (i=0;i<tablet_ids.nids;i++)
                printk("%d ", tablet_ids.id[i]);
        printk("\n");

        misc_register(&adb_tablet);
        proc_register (&proc_root, &tablet_proc_entry);

        return 0;
}

#ifdef MODULE
//#include <asm/setup.h>

int init_module(void)
{
        return adb_tablet_init();
}

void cleanup_module(void)
{
        printk(KERN_INFO "\nUnloading Macintosh ADB tablet driver\n");
        misc_deregister(&adb_tablet);
}
#endif

/*
 * Local variables:
 *  compile-command: "gcc -DMODULE -D__KERNEL__ -Wall -Wstrict-prototypes -c adbtablet.c `[ -f /usr/include/linux/modversions.h ] && echo -DMODVERSIONS`"
 *  c-indent-level: 4
 *  c-basic-offset: 4
 *  tab-width: 4
 * End:
 */

--------------9B909B301426C500DE790A67
Content-Type: image/x-xbitmap; x-mac-type="3F3F3F3F"; x-mac-creator="3F3F3F3F";
 name="adbtablet.h"
Content-Disposition: inline;
 filename="adbtablet.h"
Content-Transfer-Encoding: 7bit

#ifndef _LINUX_ADB_TABLET_H
#define _LINUX_ADB_TABLET_H

/* various handler IDs */
#define POWERKEY_HID            0x22
#define ULTRASLATE_HID          0x40
/*
 * linux/include/asm/adbtablet.h
 * header file for Macintosh ADB Calcomp UltraSlate driver
 * 990522 Timothy Wall
 */

#define DATA_TYPE(X)    ((X)>>6)
#define   DATA_TILT          0
#define   DATA_HEIGHT        1
#define   DATA_PRESSURE      2
#define   DATA_SPECIAL       3

typedef struct tablet_state {
        unsigned long       buttons;    /* up to 32 buttons */
        struct { long x,y;} loc;
        struct { long x,y;} tilt;
        unsigned long       pressure;
        unsigned long       tangential;
        unsigned long       height;
        unsigned char       in_proximity;  
} tablet_state;

typedef struct tablet_caps {
        unsigned long flags;        /* capabilities mask */
#define TF_HAS_HEIGHT      (1<<0)
#define TF_HAS_TANGENTIAL  (1<<1)
#define TF_HAS_TILT        (1<<2)
#define TF_HAS_PRESSURE    (1<<3)        
#define TF_METRIC          (1<<4)
#define TF_HAS_PROXIMITY   (1<<5)
        struct { long x,y;} dim;    /* tablet dimensions, in lpi or lpmm */
        struct { long x,y;} res;    /* tablet resolution */
        struct { long x,y;} tiltres;/* tilt resolution */
        unsigned long pressure_res; /* pressure range */
        unsigned long tangential_res;/* tangential pressure range */
        unsigned long buttons;      /* mask for existing buttons */
} tablet_caps;

typedef struct tablet_status {
        tablet_state    state;
        tablet_caps     caps; 
        int		ready;
        int		active;
        struct wait_queue *wait;
        struct fasync_struct *fasyncptr;
} tablet_status;

#endif

--------------9B909B301426C500DE790A67--

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
