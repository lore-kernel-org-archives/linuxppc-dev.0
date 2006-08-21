Return-Path: <kjoutwater@raytheon.com>
Received: from tus-mailout1.ext.ray.com (tus-mailout1.raytheon.com
	[199.46.245.198])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 05B4967C12
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Aug 2006 07:17:46 +1000 (EST)
Received: from dmoutt00.directory.ray.com (dmoutt00.directory.ray.com
	[147.25.154.125])
	by tus-mailout1.ext.ray.com (Switch-3.2.2/Switch-3.2.2) with ESMTP id
	k7LLHbOC026661
	for <linuxppc-embedded@ozlabs.org>; Mon, 21 Aug 2006 21:17:37 GMT
Received: from dmsmtpt00.directory.ray.com (dmsmtpt00.directory.ray.com
	[147.25.154.118])
	by dmoutt00.directory.ray.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id
	k7LLHbjI015045
	sender kjoutwater@raytheon.com for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Aug 2006 21:17:37 GMT
Received: from tu2-msg04.rsc.raytheon.com (tu2-msg04.RSC.RAYTHEON.COM
	[147.24.232.105])
	by dmsmtpt00.directory.ray.com (8.12.11/8.12.11) with ESMTP id
	k7LLGgG3001702
	sender kjoutwater@raytheon.com for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Aug 2006 21:16:42 GMT
In-Reply-To: <3C02138692C13C4BB675FE7EA240952918DE10@bluefin.Soneticom.local>
MIME-Version: 1.0
To: <linuxppc-embedded@ozlabs.org>
Subject: RE: Linux hanging on Xilinx SystemACE
From: Keith J Outwater <kjoutwater@raytheon.com>
Message-ID: <OFE0BDADDA.23EBA59D-ON072571D1.00733373-072571D1.0074DDC3@mck.us.ray.com>
Date: Mon, 21 Aug 2006 14:16:35 -0700
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> The adapter.c file fixed the problem, however running in polling I/O
> mode is far too slow. Since this is not an option for successful
> operation of our machine, do you know of a driver fix for this problem?
> Perhaps a newer version of the linux source tree is necessary. I'm using
> the Linuxppc_2_4_devel tree available from bkbits/mvista. Thanks for the
> help so far!
Sorry, I am not aware of any driver fix to make interrupt mode work.
Unfortunately, the use of the SystemACE under Linux for access to CF
file systems appears to be a niche application, so it does not receive
a lot of attention.

I recall someone on the net stating that they had observed the SystemAce
issuing more than one interrupt in response to sector transfers.  The
SystemACE is a strange beast (as you may have already observed!) and
perhaps it is being configured in hardware or software differently in your
design versus the Xilinx ML300 design.
For my particular application, I used the CF card to hold a root
filesystem image that was placed in RAM on boot, so I did not see a big
hit during operation.  Basically, the mediocre performance of the driver
in polled mode was good enough for me.  Maybe some day I'll return to that
problem, but right now other issues are more pressing.  As I stated
originally, the SystemACE driver appears to work fine in interrupt
mode for ML300 boards, but dies with Memec eval boards.  Perhaps you can
download the relevant designs for each board and compare them.  If you
do this, be sure to check the schematics as well as the configuration
of the SystemACE and the interrupt controller IP blocks in the Xilinx EDK
tool.  Maybe this will uncover something obvious.  Also, if MontaVista
supports their kernel on the Memec board, they may have seen this problem
and maybe even have fixed it.  I also used the mvista kernel and there is
support for a Memec board in there, although I don't know the exact part 
number.

Keith

> 
> Clint Thomas
> 
> -----Original Message-----
> From: linuxppc-embedded-bounces+cthomas=soneticom.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+cthomas=soneticom.com@ozlabs.org] On
> Behalf Of Keith J Outwater
> Sent: Wednesday, August 16, 2006 6:02 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: Re: Linux hanging on Xilinx SystemACE
> 
> Clint,
> 
> > Using the powerpc development tree of Linux 2.4, I am trying to boot 
> > my
> system from CompactFlash using Xilinx SystemACE. My compact flash card
> has two partitions, a 16MB FAT16 that holds the combination FPGA image /
> Linux Kernel ELF file, and an Ext2 partition that holds the root file
> system. 
> The system starts the boot process, uncompresses the Linux kernel and
> begins loading drivers. Part way into this process, it conducts a
> partition check of the drive being reported to it by SystemACE, however,
> it hangs at that point. No kernel panic, no error message, it simply
> hangs. Here is the output at that point...
> > 
> > Partition check:
> >  xsysacea:
> > 
> > what I am trying to find out is if this problem has been seen/fixed in
> the past? or did I format the CF card incorrectly?
> > 
> 
> I have a system that uses the SystemAce in a similar way.  I was also
> having lockups.  After a lot of digging, I found a patch by John Masters
> (e-mail unknown) to the MontaVista SystemAce driver in the 2.4 kernel
> that disables the use of interrupts and runs the SystemAce in a polled
> mode. 
> Performance is not that great, but at least it does not crash with the
> patch.  As I recall, the reason that the unpatched driver crashed is
> that the SystemAce is issuing more than one interrupt upon completion of
> a sector read or write.  Apparently, the Xilinx ML300 board works fine
> without this patch while other eval boards like the Memec DS-BD-2VPxx
> crash without the patch.
> 
> This still may not be your problem, but the patch may help later on.
> 
> I've attached the patched file.  The file is from
> ./drivers/block/xilinx_sysace/adapter.c in the 2.4.30 from MontaVista.
> 
> Keith
