Return-Path: <phdm@macqel.be>
Received: from mail.macqel.be (mail.macqel.be [194.78.208.39])
	by ozlabs.org (Postfix) with ESMTP id 5FB55DDE2D
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 19:08:30 +1100 (EST)
Date: Tue, 4 Mar 2008 09:08:28 +0100
From: Philippe De Muyter <phdm@macqel.be>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: ARCH=ppc -> ARCH=powerpc : help needed for dts file
Message-ID: <20080304080828.GA18829@netgate.macqel>
References: <20080303144727.GA27949@ingate.macqel>
	<20080303170719.GC28951@ld0162-tx32.am.freescale.net>
	<20080303210532.GA20382@netgate.macqel>
	<47CC696C.4090103@freescale.com>
	<20080303212622.GB20382@netgate.macqel>
	<47CC73CE.4080801@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47CC73CE.4080801@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Scott,

On Mon, Mar 03, 2008 at 03:55:26PM -0600, Scott Wood wrote:
> Philippe De Muyter wrote:
>> The following seems important also :
>> /*
>>                 interrupts = <18 2>;
>> */
>>                 /* interrupts number are coded in hexa ! */
>>                 interrupts = <12 2 19 2 1a 2 1b 2 35 2 36 2 37 2>;
>> I have replaced the interrupts spec in comments by the longer interrupts 
>> spec
>> below,
>
> Why?

because of the error message regarding unhandled interrupt.  As I wrote I do
not know anything about dts files, just that it is needed to have one
for a non OF board if I want to use the ARCH=powerpc tree.

>
>> and it seems to have some positive effect,
>
> What kind of positive effect?  I'd think the extra interrupts would just be 
> ignored.  The interrupts property for the PCI node itself is generally for 
> error reporting.

My compact-flash device is discovered, but interrupts still do not work.
In the log, at the end of the boot,
this :

	rtc-m41t80 0-0068: hctosys: invalid date/time
	Waiting 3sec before mounting root device...
	VFS: Cannot open root device "hda1" or unknown-block(0,0)
	Please append a correct "root=" boot option; here are the
	available partitions:
	1f00       1920 mtdblock0 (driver?)
	1f01       1920 mtdblock1 (driver?)
	1f02       1920 mtdblock2 (driver?)
	1f03       1920 mtdblock3 (driver?)
	1f04        512 mtdblock4 (driver?)
	Kernel panic - not syncing: VFS: Unable to mount root fs on
	unknown-block(0,0)
	Rebooting in 180 seconds.. 

is replaced by that :

	hda: TRANSCEND, CFA DISK drive
	ide0 at 0x000-0x007,0x00e on irq 18
	hda: max request size: 128KiB
	hda: 8077104 sectors (4135 MB) w/1KiB Cache, CHS=8013/16/63
	 hda:<4>hda: lost interrupt
	[same message repeated]
	hda: lost interrupt
	 hda1
	ide-cs: hda: Vpp = 0.0
	rtc-m41t80 0-0068: hctosys: invalid date/time
	Waiting 3sec before mounting root device...
	hda: lost interrupt
	[same message repeated]
	EXT2-fs warning (device hda1): ext2_fill_super: mounting ext3 filesystem as ext2
	VFS: Mounted root (ext2 filesystem) readonly.
	Freeing unused kernel memory: 116k init
	hda: lost interrupt
	[same message repeated]
>
>> I know that 25, 26, 27, 53, 54 and 55 decimal i(hence 19, 1a etc...) are 
>> the
>> interrupts numbers that I had in the ARCH=ppc version.  I added 18 because
>> of the error message, but it did not help.
>
> What ARCH=ppc version?  There are no device trees for non-OF boards in 
> arch/ppc.

With ARCH=ppc, all those interrupt's info's are hardcoded in the .c files.
But I expected I could fill the dts file for ARCH=powerpc from info's I
could collect in /proc on a running ARCH=ppc linux without dts file
for the same board.

Philippe
