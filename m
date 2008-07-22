Return-Path: <duykynguyen@hotmail.com>
Received: from bay0-omc3-s9.bay0.hotmail.com (bay0-omc3-s9.bay0.hotmail.com
	[65.54.246.209]) by ozlabs.org (Postfix) with ESMTP id BB74ADDE20
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Jul 2008 10:00:02 +1000 (EST)
Message-ID: <BLU119-DAV66E265C25A41567A6B842BB850@phx.gbl>
From: "Duy-Ky Nguyen" <duykynguyen@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
References: <mailman.401.1216756203.2828.linuxppc-embedded@ozlabs.org>
Subject: Re: Linuxppc-embedded Digest, Vol 47, Issue 39
Date: Tue, 22 Jul 2008 16:59:28 -0700
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Scott,

We have One_Second_IRR() using PPS (Pulse Per Second) as external interrupt 
implemented on all our comapny products.
I used GPIO interrupt in 1 product using MPC8272 (arch/ppc) and it works 
fine.

Now I'm trying to use the same way with MPC8313 (arch/powerpc) but failed.

I fixed my mistake by include a device node "gpio" in the DTS file 
arch/powerpc/boot/dts/mpc8313erdb.dts

  gpio@c00 {
   linux,phandle = <c00>;
   device_type = "gpio";
   compatible = "fsl-gpio";
   reg = <c00 100>;
   interrupts = <4a 8>; /* IRQ ID 74, edge trigger */
   interrupt-parent = <700>;
  };

Using DTC to compile DTS for DTB and check DTB in binary format and found 
the new node really there. I set the size 0x3000 so the original and new DTS 
have the same file size of 12 KB

dtc -b 0 -V 17 -p 0x3000 -I dts -O dtb -f ${1}.dts > ${1}.dtb

I then have the code segment below to access the node and request interrupt

## Start of code
 struct device_node *np = NULL;

 np = of_find_node_by_type(np, "gpio");    // is it correct ???
 if (np != NULL) {
  printk("Got device node from device tree\n");
 }

 virq = irq_of_parse_and_map(np, 0);    // unsigned return, so return of 0 
must be error ?

// int return for request_irq() so return negative number must be error
 result = request_irq (virq,  //
      ppc_ISR,  // ISR
      IRQF_SHARED,
      DEVICE_NAME,   // LCS_dev name
      NULL);   // LCS_dev ID

## End of code

I have screen capture for error in the code above at the end of this email

I'm not sure if I have the right way in finding the node and in mapping the 
"virq" ?

Your help is very much appreciated, Scott

Best Regards,

^^Duy-Ky


## Start of screen capture for error in requesting interrupt

Unable to handle kernel paging request for data at address 0x00000014
Faulting instruction address: 0xc000d1e8
Oops: Kernel access of bad area, sig: 11 [#1]

Modules linked in: ppc_drv
NIP: C000D1E8 LR: C000D274 CTR: C0006088
REGS: c783dd20 TRAP: 0300   Not tainted  (2.6.20)
MSR: 00009032 <EE,ME,IR,DR>  CR: 22000442  XER: 00000000
DAR: 00000014, DSISR: 20000000
TASK = c03bdbd0[765] 'rrgg' THREAD: c783c000
GPR00: C000D274 C783DDD0 C03BDBD0 00000000 C0282BA8 C783DE08 C786EA60 
00000000
GPR08: C034F280 00000000 C0282E31 C0006088 22000442 10018D00 07FFD000 
28000422
GPR16: 10090000 100B0000 100B7318 00000000 00000000 00000000 100BDBA8 
100BDBE8
GPR24: 100BDAE8 00000000 00000000 C786EA60 FFFFFFEA C783DE08 C0282BA8 
00000000
Call Trace:
[C783DDD0] [C7FD5468]  (unreliable)
[C783DDF0] [C000D274]
[C783DE00] [C0009FC8]
[C783DE30] [C000609C]
[C783DE60] [C9072054]
[C783DE70] [C0063E5C]
[C783DEA0] [C005FFAC]
[C783DEC0] [C0060244]
[C783DF20] [C00602B8]
[C783DF40] [C000F540]
--- Exception: c01Instruction dump:
409effc8 80030024 900b0020 4e800020 7d800026 9421ffe0 7c0802a6 bfa10014
7c9e2378 7cbd2b78 91810010 90010024 <83e30014> 2f9f0000 419e0028 2e050000
 Segmentation fault

## End of capture

----- Original Message ----- 
From: <linuxppc-embedded-request@ozlabs.org>
To: <linuxppc-embedded@ozlabs.org>
Sent: Tuesday, July 22, 2008 12:50 PM
Subject: Linuxppc-embedded Digest, Vol 47, Issue 39


> Send Linuxppc-embedded mailing list submissions to
> linuxppc-embedded@ozlabs.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> or, via email, send a message with subject or body 'help' to
> linuxppc-embedded-request@ozlabs.org
>
> You can reach the person managing the list at
> linuxppc-embedded-owner@ozlabs.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Linuxppc-embedded digest..."
>
>
> Today's Topics:
>
>   1. Re: how to allocate 9MB of memory in kernel ? (Arnd Bergmann)
>   2. Re: Help: Kernel BUG with U-boot 1.1.4 and kernel 2.6.23
>      scanning PCIe on a MPC8641D board (Jon Loeliger)
>   3. Re: Failure of request_irq()  for MPC8313 using arch=powerpc
>      (Scott Wood)
>   4. Re: Problem with cuImage Linux entry from old U-boot (Scott Wood)
>   5. RE: Problem with cuImage Linux entry from old U-boot
>      (Mike Timmons)
>   6. Re: Problem with cuImage Linux entry from old U-boot (Scott Wood)
>   7. [OT] write flash on MPC5200 board via jtag (Albrecht Dre?)
>   8. RE: Problem with cuImage Linux entry from old U-boot
>      (Stephen Horton)
>   9. Re: [PATCH] Add AMCC Arches 460GT eval board support to
>      platforms/44x (Victor Gallardo)
>  10. Re: How to create custom ramdisk  (Ron Sass)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Tue, 22 Jul 2008 17:12:51 +0200
> From: Arnd Bergmann <arnd@arndb.de>
> Subject: Re: how to allocate 9MB of memory in kernel ?
> To: linuxppc-embedded@ozlabs.org
> Cc: Misbah khan <misbah_khan@engineer.com>
> Message-ID: <200807221712.52030.arnd@arndb.de>
> Content-Type: text/plain;  charset="iso-8859-1"
>
> On Tuesday 22 July 2008, Misbah khan wrote:
>> First of all let me thank you for your valuable suggessions ...
>>
>> 1. I wanted to allocate 9MB in kernel and wanted that memory to be mapped 
>> to
>> the physically continews SDRAM memory. but till now i could not found a 
>> way
>> to do so ???
>>
>> 2. So i thought to use ioremap to map SDRAM and make it accessible to 
>> user
>> using mmap technique but there is only one doubt and that is will it be
>> secure and stable and whether it is a right way of doing ???
>
> As I have told you a few times now, you *either* allocate the memory *or*
> ioremap it, NOT BOTH!!!
>
> If you SDRAM is you main memory, you need vmalloc and remap_vmalloc_range.
> If the SDRAM is not your main memory but some I/O attached buffer, you 
> need
> ioremap/of_iomap and remap_pfn_range.
>
> Arnd <><
>
>
> ------------------------------
>
> Message: 2
> Date: Tue, 22 Jul 2008 11:57:05 -0500
> From: Jon Loeliger <jdl@freescale.com>
> Subject: Re: Help: Kernel BUG with U-boot 1.1.4 and kernel 2.6.23
> scanning PCIe on a MPC8641D board
> To: joachim.bader@diehl-aerospace.de
> Cc: linuxppc-embedded@ozlabs.org
> Message-ID: <48861161.8050707@freescale.com>
> Content-Type: text/plain; charset=UTF-8; format=flowed
>
> joachim.bader@diehl-aerospace.de wrote:
>>
>> Hello folks,
>>
>> we run a proprietary board with Freescale MPC8641D using U-boot 1.1.4
>> and Linux kernel 2.6.23
>>
>
>> I read in the logs some messages that 2.6.23 does contain some bugs
>> related to PCIe
>
> Correct.
>
>> and it would be a good choice to upgrade to 2.6.25. Is
>> this one of that cases?
>
> Almost certainly.  You should pick up top of tree if you can.
>
>> Currently we would like to prevent switching the kernel version.
>
> You could back-port the PCIe bug fixes and rewrite if you wanted.
> My guess is that a _trial_ run of the current top of tree,
> or at least 2.6.26 might Just Work and fix your issues.
>
> It would be less work to try it than do discover-n-back-port...
>
> jdl
>
>
> ------------------------------
>
> Message: 3
> Date: Tue, 22 Jul 2008 12:55:08 -0500
> From: Scott Wood <scottwood@freescale.com>
> Subject: Re: Failure of request_irq()  for MPC8313 using arch=powerpc
> To: Duy-Ky Nguyen <duykynguyen@hotmail.com>
> Cc: Liu Dave <DaveLiu@freescale.com>, linuxppc-embedded@ozlabs.org
> Message-ID: <20080722175508.GA13940@loki.buserror.net>
> Content-Type: text/plain; charset=us-ascii
>
> On Tue, Jul 15, 2008 at 08:43:59PM -0700, Duy-Ky Nguyen wrote:
>> Hi Dave,
>>
>> I've just tried it and it failed.
>
> Could you elaborate on exactly what you tried?  Did you pass the GPIO 
> device
> tree node?
>
>> Before I had tried using the function
>> int virq = of_irq_to_resource(GPIO_IRQ, 0, NULL);
>> and it failed the same way
>
> The first argument of of_irq_to_resource is a device node pointer, not an
> IRQ number.  Surely the compiler warned you about this.
>
> -Scott
>
>
> ------------------------------
>
> Message: 4
> Date: Tue, 22 Jul 2008 13:05:06 -0500
> From: Scott Wood <scottwood@freescale.com>
> Subject: Re: Problem with cuImage Linux entry from old U-boot
> To: Stephen Horton <SHorton@kodiaknetworks.com>
> Cc: linuxppc-embedded@ozlabs.org
> Message-ID: <20080722180506.GB13940@loki.buserror.net>
> Content-Type: text/plain; charset=us-ascii
>
> On Mon, Jul 21, 2008 at 03:39:55PM -0500, Stephen Horton wrote:
>> I have made great strides with help from this mailing list and its
>> archives. I now have a compiled cuImage ready to boot from my older
>> working u-boot 1.1.2. I now seem to be stuck at the kernel entry point.
>> I'm not sure if I'm trying to jump into the kernel at the wrong address,
>> or if I have a serial console issue that prevents me from seeing anymore
>> progress.
>
> Most likely the latter, or some other issue that prevents the kernel from
> booting to the point where the serial console functions.
>
>> Linux/PowerPC load: ip=bootp root=/dev/nfs rw nfsroot=/opt/gentoo
>> console=ttyMM0,9600n8
>> Finalizing device tree... flat tree at 0x7423a0
>>
>>
>>
>> ------
>>
>>
>>
>> If I run 'nm' on my elf image, I expect to find some entry point address
>> that corresponds to 0x7423a0, but this is not the case.
>
> Why would you expect that?  It's a dynamically allocated chunk of memory
> that holds the device tree that is passed to the kernel.  It's not an 
> entry
> point; the entry point to the kernel is zero.
>
> -Scott
>
>
> ------------------------------
>
> Message: 5
> Date: Tue, 22 Jul 2008 11:13:09 -0700
> From: "Mike Timmons" <mike_timmons@trimble.com>
> Subject: RE: Problem with cuImage Linux entry from old U-boot
> To: "Scott Wood" <scottwood@freescale.com>, "Stephen Horton"
> <SHorton@kodiaknetworks.com>
> Cc: linuxppc-embedded@ozlabs.org
> Message-ID:
> <161B3BAD77161449A144FF054231C3D60249D825@uss-am-xch-01.am.trimblecorp.net>
>
> Content-Type: text/plain; charset="us-ascii"
>
> Related question: I'm using a newer U-boot and managing the load of the
> kernel and the device tree from separate partitions of my boot media.
>
> Having the two partitions and managing the kernel and the tree
> separately is a bit cumbersome, or maybe I'm just lazy. Regardless, can
> I just use that "static" file name option when I build the kernel, load
> the cuImage, and just invoke
>
> bootm <cuImageLoadAddress> ?
>
> Will it work to just leave off the - <device tree Ram address>
>
> I think I had it set-p right yesterday and I gave it a try, but no joy.
>
> Can it be this simple to statically link the device tree with the kernel
> build? For my application I don't see a benefit in keeping them separate
> (the kernel and the tree).
>
> Thanks,
> Mike
>
>
> -----Original Message-----
> From: linuxppc-embedded-bounces+mike_timmons=trimble.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+mike_timmons=trimble.com@ozlabs.org]
> On Behalf Of Scott Wood
> Sent: Tuesday, July 22, 2008 1:05 PM
> To: Stephen Horton
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: Problem with cuImage Linux entry from old U-boot
>
> On Mon, Jul 21, 2008 at 03:39:55PM -0500, Stephen Horton wrote:
>> I have made great strides with help from this mailing list and its
>> archives. I now have a compiled cuImage ready to boot from my older
>> working u-boot 1.1.2. I now seem to be stuck at the kernel entry
> point.
>> I'm not sure if I'm trying to jump into the kernel at the wrong
> address,
>> or if I have a serial console issue that prevents me from seeing
> anymore
>> progress.
>
> Most likely the latter, or some other issue that prevents the kernel
> from
> booting to the point where the serial console functions.
>
>> Linux/PowerPC load: ip=bootp root=/dev/nfs rw nfsroot=/opt/gentoo
>> console=ttyMM0,9600n8
>> Finalizing device tree... flat tree at 0x7423a0
>>
>>
>>
>> ------
>>
>>
>>
>> If I run 'nm' on my elf image, I expect to find some entry point
> address
>> that corresponds to 0x7423a0, but this is not the case.
>
> Why would you expect that?  It's a dynamically allocated chunk of memory
> that holds the device tree that is passed to the kernel.  It's not an
> entry
> point; the entry point to the kernel is zero.
>
> -Scott
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
> ------------------------------
>
> Message: 6
> Date: Tue, 22 Jul 2008 13:20:30 -0500
> From: Scott Wood <scottwood@freescale.com>
> Subject: Re: Problem with cuImage Linux entry from old U-boot
> To: Mike Timmons <mike_timmons@trimble.com>
> Cc: Stephen Horton <SHorton@kodiaknetworks.com>,
> linuxppc-embedded@ozlabs.org
> Message-ID: <488624EE.9040502@freescale.com>
> Content-Type: text/plain; charset=UTF-8; format=flowed
>
> Mike Timmons wrote:
>> Related question: I'm using a newer U-boot and managing the load of the
>> kernel and the device tree from separate partitions of my boot media.
>>
>> Having the two partitions and managing the kernel and the tree
>> separately is a bit cumbersome, or maybe I'm just lazy. Regardless, can
>> I just use that "static" file name option when I build the kernel, load
>> the cuImage, and just invoke
>>
>> bootm <cuImageLoadAddress> ?
>>
>> Will it work to just leave off the - <device tree Ram address>
>>
>> I think I had it set-p right yesterday and I gave it a try, but no joy.
>>
>> Can it be this simple to statically link the device tree with the kernel
>> build? For my application I don't see a benefit in keeping them separate
>> (the kernel and the tree).
>
> Yes, you can use cuImage to bundle the device tree with the kernel (note
> that the type of image you use *must* match the type of bootm command
> you use), though it's not recommended if you have a u-boot that can
> properly pass a device tree.  cuImage relies on the bd_t to get
> information from u-boot, and this is a very fragile structure, and
> contains less information than the device tree.
>
> -Scott
>
>
> ------------------------------
>
> Message: 7
> Date: Tue, 22 Jul 2008 20:56:43 +0200
> From: Albrecht Dre? <albrecht.dress@arcor.de>
> Subject: [OT] write flash on MPC5200 board via jtag
> To: LinuxPPC Embedded <linuxppc-embedded@ozlabs.org>
> Message-ID: <1216753011l.5683l.0l@antares>
> Content-Type: text/plain; charset="us-ascii"; Format="Flowed";
> DelSp="Yes"
>
> Hi,
>
> sorry for a somewhat off-topic question...
>
> I want to design a mpc5200b board which is roughly derived from
> Freescale's 5200B Lite demo.  Obviously, I have the problem to
> initially write u-boot into the boot nor flash.  I believe this would
> be possible using the jtag/bsm interface (is that true?).
>
> Can you recommend any good hardware and software solution for that, if
> possible running on linux (OSS?)?  I don't need a "real" debugger
> (maybe an interface to gdb), just something to write the flash, so
> u-boot comes up.
>
> Thanks for any help,
> Albrecht.
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: not available
> Type: application/pgp-signature
> Size: 189 bytes
> Desc: not available
> URL: 
> <http://ozlabs.org/pipermail/linuxppc-embedded/attachments/20080722/8a637400/attachment-0001.pgp>
>
> ------------------------------
>
> Message: 8
> Date: Tue, 22 Jul 2008 14:23:39 -0500
> From: "Stephen Horton" <SHorton@kodiaknetworks.com>
> Subject: RE: Problem with cuImage Linux entry from old U-boot
> To: "Scott Wood" <scottwood@freescale.com>
> Cc: linuxppc-embedded@ozlabs.org
> Message-ID:
> <295C5089A56CE143B316E5F67CA99CB001D0637A@cowboy.inovate.inovate.com>
> Content-Type: text/plain; charset="us-ascii"
>
> Thanks Scott for the tip. I'll redouble my efforts to compare the code
> in my older 1.1.2 U-boot source (that the board boots from) with my new
> .dts and cuboot source.
>
> -----Original Message-----
> From: Scott Wood [mailto:scottwood@freescale.com]
> Sent: Tuesday, July 22, 2008 1:05 PM
> To: Stephen Horton
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: Problem with cuImage Linux entry from old U-boot
>
> On Mon, Jul 21, 2008 at 03:39:55PM -0500, Stephen Horton wrote:
>> I have made great strides with help from this mailing list and its
>> archives. I now have a compiled cuImage ready to boot from my older
>> working u-boot 1.1.2. I now seem to be stuck at the kernel entry
> point.
>> I'm not sure if I'm trying to jump into the kernel at the wrong
> address,
>> or if I have a serial console issue that prevents me from seeing
> anymore
>> progress.
>
> Most likely the latter, or some other issue that prevents the kernel
> from
> booting to the point where the serial console functions.
>
>> Linux/PowerPC load: ip=bootp root=/dev/nfs rw nfsroot=/opt/gentoo
>> console=ttyMM0,9600n8
>> Finalizing device tree... flat tree at 0x7423a0
>>
>>
>>
>> ------
>>
>>
>>
>> If I run 'nm' on my elf image, I expect to find some entry point
> address
>> that corresponds to 0x7423a0, but this is not the case.
>
> Why would you expect that?  It's a dynamically allocated chunk of memory
> that holds the device tree that is passed to the kernel.  It's not an
> entry
> point; the entry point to the kernel is zero.
>
> -Scott
>
>
>
> ------------------------------
>
> Message: 9
> Date: Tue, 22 Jul 2008 12:35:51 -0700 (PDT)
> From: Victor Gallardo <vgallardo@amcc.com>
> Subject: Re: [PATCH] Add AMCC Arches 460GT eval board support to
> platforms/44x
> To: linuxppc-embedded@ozlabs.org
> Message-ID: <18597016.post@talk.nabble.com>
> Content-Type: text/plain; charset=us-ascii
>
>
>>As you might have noticed, this has generated quite a bit of discussion
>>on whether this is the right approach or not.  If you can wait for a
>>week, we plan on talking it over at OLS.  Then I can give you a better
>>idea as to whether we're going to stick with this or use a different
>>approach.
>>
>>Overall your patches are fairly clean, so you've done a good job so
>>far.  Have a little patience with us as we figure out the right way to
>>go :).
>>
>>josh
>
> OK. I watch the mailing list for updates.
>
> Thanks,
>
> Victor Gallardo
> -- 
> View this message in context: 
> http://www.nabble.com/-PATCH--Add-AMCC-Arches-460GT-eval-board-support-to-platforms-44x-tp18480745p18597016.html
> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
>
>
>
> ------------------------------
>
> Message: 10
> Date: Tue, 22 Jul 2008 15:49:47 -0400
> From: Ron Sass <rsass@uncc.edu>
> Subject: Re: How to create custom ramdisk
> To: Neeraj Garg <neerajg@cdac.in>
> Cc: linuxppc-embedded@ozlabs.org
> Message-ID: <200807221949.m6MJnll7016697@rsass-homer.uncc.edu>
>
>
> Under my home page, I have links to the courses I teach.
>
> http://rcs.uncc.edu/~rsass/
>
> Follow the links to "Fundamentals of Reconfigurable
> Computing"  specifically,
>
> http://rcs.uncc.edu/~rsass/courses/2008-Fall/6890/
>
> There are labs and tutorials there.  Under Labs, (Lab 3 in
> particular) we build Linux-based systems.  Lab 3 is has a tutorial
> based on Secret Lab's git repository and some in-house scripts.
> The students use RHEL5 machines but in our research lab we Fedora
> Core and CentOS4 machines.
>
> Also we have a wiki with other tutorials.  Sorry, it's not very
> organized (or up to date...)
>
> http://www.rcs.uncc.edu/wiki/index.php/Main_Page
>
> Ron
>
>
>>
>> Hi,
>>
>> I want to create a custom ramdisk (initrd which can be placed in
>> arch/ppc/boot/images). Can anybody guide me steps to built the same. My
>> host have RHEL-4.
>>
>> -- 
>>
>> -------------------------------------------------------------------
>> Neeraj Garg
>>
>>
>>
>> --------------080207080004080602090709
>> Content-Type: text/html; charset=ISO-8859-1
>> Content-Transfer-Encoding: 7bit
>>
>> <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
>> <html>
>> <head>
>>   <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
>>   <title></title>
>> </head>
>> <body bgcolor="#ffffff" text="#000000">
>> Hi,<br>
>> <br>
>> I want to create a custom ramdisk (initrd which can be placed in
>> arch/ppc/boot/images). Can anybody guide me steps to built
>> the same. My host have RHEL-4.<br>
>> <br>
>> <div class="moz-signature">-- <br>
>> <pre><!-- img src="file:///E:/htdg.jpg" border="0" 
>> alt="C-DAC"-->------------
>> -------------------------------------------------------
>> Neeraj Garg
>>
>> </pre>
>> </div>
>> </body>
>> </html>
>>
>> --------------080207080004080602090709--
>>
>>
>> --===============0773240910==
>> Content-Type: text/plain; charset="us-ascii"
>> MIME-Version: 1.0
>> Content-Transfer-Encoding: 7bit
>> Content-Disposition: inline
>>
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>> --===============0773240910==--
>>
>
>
> ------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
> End of Linuxppc-embedded Digest, Vol 47, Issue 39
> *************************************************
> 
