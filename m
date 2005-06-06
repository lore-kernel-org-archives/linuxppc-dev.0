Return-Path: <wd@denx.de>
Received: from mailout04.sul.t-online.com (mailout04.sul.t-online.com
	[194.25.134.18]) by ozlabs.org (Postfix) with ESMTP id 24F87679E2
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Jun 2005 18:27:28 +1000 (EST)
To: Tore Martin Hagen <THagen@oslo.westerngeco.slb.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_5053352060"
Date: Mon, 06 Jun 2005 10:27:03 +0200
Sender: wd@denx.de
Message-Id: <20050606082708.47638C1512@atlas.denx.de>
Cc: LinuxPPC Support <linuxppc-embedded@ozlabs.org>
Subject: Re: Reseting bootcount from linux 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multipart MIME message.

--==_Exmh_5053352060
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Mon, 06 Jun 2005 08:41:25 +0200."
	<42A3F015.5020203@oslo.westerngeco.slb.com>

Dear Tore,

in message <42A3F015.5020203@oslo.westerngeco.slb.com> you wrote:
> 
> I am using a MPC8266ADS-PCI board and u-boot with the
> CONFIG_BOOTCOUNT_LIMIT. If i stop u-boot before it starts Linux I can
> see that the bootcount variable increments nicely. But if i dump the 
> content from flash (dd if=/dev/mtd/1 of=a1out bs=1k) and check the 
> content it is always
> bootcount=1

The environment copy in flash gets  stored  only  when  you  run  the
"saveenv"  command,  but  "bootcount" gets updated automagically upon
each boot, so even if you would change the flash contents  this  does
ot matter.

> So how can I reset the bootcount if it is always 1, or rather where is
> the real bootcount stored?

See function bootcount_store() in "cpu/mpc8260/commproc.c"; see also
include/common.h for the definition of BOOTCOUNT_MAGIC and
include/asm-ppc/cpm_8260.h for CPM_BOOTCOUNT_ADDR.


Please find attached some code (courtesy of Steffen Rumler) that  can
be  used  to  reset  the  boot  counter  under  Linux using the /proc
interface.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"If that makes any sense to you, you have a big problem."
                                  -- C. Durance, Computer Science 234


--==_Exmh_5053352060
Content-Type: application/octet-stream ; name="ubootBootcountAccess.c"
Content-Description: ubootBootcountAccess.c
Content-Disposition: attachment; filename="ubootBootcountAccess.c"

/*
 *  SOURCE:         ubootBootcounterAccess.c 
 *  FIRST EDITION:  02.12.03 
 *  LAST UPDATE:    02.12.03
 *  AUTHOR(S):      Steffen Rumler  (Steffen.Rumler@siemens.com)
 *
 *  PURPOSE:	    Provide read/write access to the U-Boot bootcounter
 *                  via PROC FS 
 */

#include <linux/module.h>
#include <linux/version.h>
#include <linux/fs.h>
#include <linux/proc_fs.h>
#include <linux/types.h>
#include <linux/errno.h>
#include <linux/init.h>
#include <linux/proc_fs.h>
#include <asm/io.h>


#ifndef CONFIG_PROC_FS
#error "PROC FS support must be switched-on"
#endif


#ifdef CONFIG_8260
#define UBOOT_BOOTCOUNT_OFFSET        0x80f4	/* offset of bootcounter from IMMR */
#define UBOOT_BOOTCOUNT_MAGIC_OFFSET  0x80f8	/* offset of magic number from IMMR */
#define UBOOT_BOOTCOUNT_MAGIC         0xb001c041	/* magic number value */
#else
/*  add other platforms here
 */
#error "platform not yet supported"
#endif


#define UBOOT_BOOTCOUNT_PROC_ENTRY   "driver/bootcount"	/* PROC FS entry under '/proc' */


/*  This macro frees the machine specific function from bounds checking and
 *  this like that... 
 */
#define PRINT_PROC(fmt,args...) \
        do { \
                *len += sprintf( buffer+*len, fmt, ##args ); \
                if (*begin + *len > offset + size) \
                        return( 0 ); \
                if (*begin + *len < offset) { \
                        *begin += *len; \
                        *len = 0; \
                } \
        } while(0)


/*  read U-Boot bootcounter
 */
static int
read_bootcounter_info (char *buffer, int *len, off_t * begin, off_t offset,
		       int size)
{
	unsigned char *immr = (unsigned char *) IMAP_ADDR;
	unsigned long magic;
	unsigned long counter;


	magic = *((unsigned long *) (immr + UBOOT_BOOTCOUNT_MAGIC_OFFSET));
	counter = *((unsigned long *) (immr + UBOOT_BOOTCOUNT_OFFSET));

	if (magic == UBOOT_BOOTCOUNT_MAGIC) {
		PRINT_PROC ("%lu\n", counter);
	} else {
		PRINT_PROC ("bad magic: 0x%lx != 0x%lx\n", magic,
			    UBOOT_BOOTCOUNT_MAGIC);
	}

	return 1;
}


/*  read U-Boot bootcounter (wrapper)
 */
static int
read_bootcounter (char *buffer, char **start, off_t offset, int size,
		  int *eof, void *arg)
{
	int len = 0;
	off_t begin = 0;


	*eof = read_bootcounter_info (buffer, &len, &begin, offset, size);

	if (offset >= begin + len)
		return 0;

	*start = buffer + (offset - begin);
	return size < begin + len - offset ? size : begin + len - offset;
}


/*  write new value to U-Boot bootcounter
 */
static int
write_bootcounter (struct file *file, const char *buffer, unsigned long count,
		   void *data)
{
	unsigned char *immr = (unsigned char *) IMAP_ADDR;
	unsigned long magic;
	unsigned long *counter_ptr;


	magic = *((unsigned long *) (immr + UBOOT_BOOTCOUNT_MAGIC_OFFSET));
	counter_ptr = (unsigned long *) (immr + UBOOT_BOOTCOUNT_OFFSET);

	if (magic == UBOOT_BOOTCOUNT_MAGIC)
		*counter_ptr = simple_strtol (buffer, NULL, 10);
	else
		return -EINVAL;

	return count;
}


/*  init entry point
 */
static int __init uboot_bootcount_init (void)
{
	struct proc_dir_entry *bootcount;


	printk ("%s (%d) %s:  ", __FILE__, __LINE__, __FUNCTION__);

	if ((bootcount =
	     create_proc_entry (UBOOT_BOOTCOUNT_PROC_ENTRY, 0600,
				NULL)) == NULL) {

		printk (KERN_ERR "\n%s (%d): cannot create /proc/%s\n",
			__FILE__, __LINE__, UBOOT_BOOTCOUNT_PROC_ENTRY);
	} else {
		bootcount->read_proc = read_bootcounter;
		bootcount->write_proc = write_bootcounter;
		printk ("created \"/proc/%s\"\n", UBOOT_BOOTCOUNT_PROC_ENTRY);
	}

	return 0;		/* success */
}


static void __exit uboot_bootcount_cleanup (void)
{
	remove_proc_entry (UBOOT_BOOTCOUNT_PROC_ENTRY, NULL);
}


/*  for loading the module dynamically
 */
module_init (uboot_bootcount_init);
module_exit (uboot_bootcount_cleanup);

MODULE_LICENSE ("GPL");
MODULE_AUTHOR ("Steffen Rumler <steffen.rumler@siemens.com>");
MODULE_DESCRIPTION ("Provide (read/write) access to the U-Boot bootcounter via PROC FS");

--==_Exmh_5053352060--
