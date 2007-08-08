Return-Path: <antonkowalski@gmail.com>
Received: from ik-out-1112.google.com (ik-out-1112.google.com [66.249.90.177])
	by ozlabs.org (Postfix) with ESMTP id F1BCCDDEE0
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Aug 2007 05:42:46 +1000 (EST)
Received: by ik-out-1112.google.com with SMTP id b35so126087ika
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 08 Aug 2007 12:42:44 -0700 (PDT)
Message-ID: <e835b80a0708081242k2a9bfd34jdd1328081644ebf7@mail.gmail.com>
Date: Wed, 8 Aug 2007 15:42:42 -0400
From: "Anton Kowalski" <antonkowalski@gmail.com>
To: "Benedict, Michael" <MBenedict@twacs.com>
Subject: Re: no output to serial console from /init process on ml405
In-Reply-To: <CF7E46FCFF66AD478BB72724345289EC2797CE@twx-exch01.twacs.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e835b80a0708080428q59378732x52ee40f9702f5692@mail.gmail.com>
	<CF7E46FCFF66AD478BB72724345289EC2797CE@twx-exch01.twacs.local>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Indeed I hadn't set up the compulsary links correctly. In reading
through the devices.txt document I realized that I don't have /proc
mounted either. So the following links might not make much sense until
/proc is up.

    slink /dev/fd /proc/self/fd 777 0 0
    slink /dev/stdin /proc/self/fd/0 777 0 0
    slink /dev/stdout /proc/self/fd/1 777 0 0
    slink /dev/stderr /proc/self/fd/2 777 0 0

Thanks for your help.
Anton


On 8/8/07, Benedict, Michael <MBenedict@twacs.com> wrote:
> Just a guess, but do you have stdout and friends defined as recommended
> in the Compulsory links section of Documentation/devices.txt?
>         -Michael
>
> > -----Original Message-----
> > From:
> > linuxppc-embedded-bounces+mbenedict=twacs.com@ozlabs.org
> > [mailto:linuxppc-embedded-bounces+mbenedict=twacs.com@ozlabs.o
> rg] On Behalf Of Anton Kowalski
> > Sent: Wednesday, August 08, 2007 6:28 AM
> > To: linuxppc-embedded@ozlabs.org
> > Subject: no output to serial console from /init process on ml405
> >
> > Hi All:
> >
> > I'm trying to bring up linux 2.6.21.1 on an ml405 board. The kernel
> > boots fine but the init process does not produce any output. The /init
> > program resides in an initramfs file system and I believe the /dev
> > device files have been set up correctly. Here's an excerpt from my
> > initramfs specification:
> >
> >     dir /dev 755 0 0
> >     nod /dev/console 644 0 0 c 5 1
> >     nod /dev/ttyS0 644 0 0 c 4 64
> >
> > (I am able to open these files from the init program. I tested this by
> > sleeping for a specified time on success.)
> >
> > Also, printk continues to function after /init terminates and before
> > the kernel panics.
> >
> > Here are the last few lines of the console output:
> >
> > [    0.507478] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports,
> > IRQ sharing disabled
> > [    0.513862] serial8250.0: ttyS0 at MMIO 0x80201003 (irq =
> > 3) is a 16550A
> > [    2.927509] RAMDISK driver initialized: 1 RAM disks of 8192K size
> > 1024 blocksize
> > [    3.018391] tun: Universal TUN/TAP device driver, 1.6
> > [    3.079115] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
> > [    3.154919] mice: PS/2 mouse device common for all mice
> > [    3.218021] TCP cubic registered
> > [    3.257034] NET: Registered protocol family 1
> > [    3.309405] NET: Registered protocol family 17
> > [    3.363462] Freeing unused kernel memory: 300k init
> > [   23.488277] Kernel panic - not syncing: Attempted to kill init!
> > [   23.559517] Rebooting in 180 seconds..<NULL>
> >
> > I'm using the plb uart and the 8250.c driver. (The obp uartlite driver
> > didn't work so I switched.) The kernel and the init program were
> > compiled with eldk.
> >
> > Any insights into resolving this problem are greatly appreciated.
> >
> >
> > Anton
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
> >
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
