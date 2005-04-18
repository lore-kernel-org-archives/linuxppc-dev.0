Return-Path: <pstudencki@yahoo.com>
Received: from web51310.mail.yahoo.com (web51310.mail.yahoo.com
	[206.190.38.176]) by ozlabs.org (Postfix) with SMTP id A85D867A67
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Apr 2005 07:24:06 +1000 (EST)
Message-ID: <20050418212401.33270.qmail@web51310.mail.yahoo.com>
Date: Mon, 18 Apr 2005 14:24:01 -0700 (PDT)
From: Pawel Studencki <pstudencki@yahoo.com>
To: Eugene Surovegin <ebs@ebshome.net>
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: using initramfs with ppc
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hello,

It can be wrong kernel parameter or problem with mtd
or cramfs support. But if I see my kernel messages,
everything seems to be OK for me. I've attached kernel
logging, so let me know, if I'm wrong.

Do I need initramfs if I want to mount root filesystem
on CRAMFS? If so, with special devices?

I found some problems here:
static int __init do_mount_root(char *name, char *fs,
int flags, void *data)
{
	int err = sys_mount(name, "/root", fs, flags, data);
	if (err)
		return err;
[...]
}
return -2.

Directory "/root" hasn't been found! Does this funtion
look for on initramfs???

best regards
Pawel
------------------------------------
Kernel command line: console=ttyCPM0, 57600
root=/dev/mtdblock1 
rootfstype=cramfs ro
PID hash table entries: 128 (order: 7, 2048 bytes)
Decrementer Frequency = 187500000/60
m8xx_wdt: wdt disabled (SYPCR: 0xFFFFFF88)
Console: colour dummy device 80x25
Dentry cache hash table entries: 4096 (order: 2, 16384
ytes)
Inode-cache hash table entries: 2048 (order: 1, 8192
ytes)
Memory: 14772k available (976k kernel code, 368k data,
60k init, 0k 
highmem)
Mount-cache hash table entries: 512 (order: 0, 4096
bytes)
NET: Registered protocol family 16
JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
Serial: CPM driver $Revision: 0.01 $
ttyCPM0 at MMIO 0xff000a60 (irq = 43) is a CPM UART
io scheduler noop registered
loop: loaded (max 8 devices)
physmap flash device: 400000 at ffc00000
phys_mapped_flash: Found 1 x16 devices at 0x0 in
16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due
to code 
brokenness.
Creating 5 MTD partitions on "phys_mapped_flash":
0x00000000-0x000d0000 : "Kernel"
mtd: Giving out device 0 to Kernel
0x000d0000-0x001d0000 : "RootFS"
mtd: Giving out device 1 to RootFS
0x001d0000-0x00300000 : "ApplFS1"
mtd: Giving out device 2 to ApplFS1
0x00300000-0x00330000 : "U-Boot"
mtd: Giving out device 3 to U-Boot
0x00330000-0x00400000 : "ApplFS2"
mtd: Giving out device 4 to ApplFS2
VFS: Cannot open root device "mtdblock1" or
unknown-block(31,1)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root
fs on 
unknown-block(31,1)



--- Eugene Surovegin <ebs@ebshome.net> wrote:
> On Mon, Apr 18, 2005 at 08:34:42AM -0700, Pawel
> Studencki wrote:
> > Hello,
> >  
> > I use a custom board with 8xx and kernel 2.6.11
> and
> > try to mount root fs
> > based on cramfs. I still have problems with
> mounting
> > VFS:
> > 
> > VFS: Cannot open root device "mtdblock1" or
> > unknown-block(31,1)
> > Please append a correct "root=" boot option
> > Kernel panic - not syncing: VFS: Unable to mount
> root
> > fs on
> > unknown-block(31,1)
> > 
> > I found, that perhaps the reason is initramfs.
> 
> Unlikely.
> 
> Please, check that you have mtdblock device enabled
> in config, also 
> that you have configured your flash support, and
> mtdblock1 partition 
> actually exists.
> 
> -- 
> Eugene
> 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
