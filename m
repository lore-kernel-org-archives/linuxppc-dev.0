Message-ID: <3B574C53.4050008@mvista.com>
Date: Thu, 19 Jul 2001 14:08:35 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: Grant Erickson <erick205@umn.edu>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCI-to-PCMCIA/CardBus, Hardhat Linux 2.4.2, and the 405GP
References: <Pine.SOL.4.20.0107182123580.21428-100000@garnet.tc.umn.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Grant Erickson wrote:

> I am attempting to get a SanDisk or IBM MicroDrive CardFlash interface
> device working with a Walnut (IBM 405GP Rev. D) platforms and am using
> MontaVista's 2.4.2-mvista_010329 Linux kernel to do so. The PCI-to-CardBus
> adapter is a TI1420.

>
> Are there any tricks or pitfalls to get this working? I haven't been too
> wildly successful yet using either compiled in or module-based drivers.


I am not familiar with all the cache coherency issues with PCI in that
kernel.  It is best to upgrade to the latest 405 kernel from Montavista.

>
> Also, the PCMCIA-HOWTO seems fairly explicit that a PCMCIA IDE/ATA drive
> such as the IBM MicroDrive or SanDisk cannot be used as a boot device (but
> can be used as a root device w/ initrd). Has anyone out there done
> otherwise (i.e. built-in drivers, no initrd, w/ a simple root=/dev/hda)?


Yes with a minor hack to the kernel pcmcia ide-cs driver I believe you
can get it to work.  The problem is the ide-cs waits for the Cardmgr
daemon to start before it will recognize the card.

>
> ANY insight would be greatly appreciated.
>


I believe there are problems with kernel PCMCIA in hhl-2.4.2.  We
actually only support the pcmcia-cs package.  Its probably best to start
w/ the pcmcia-cs package and get that to work.  If it doesn't work, you
probably are running into the cache issues. The pcmcia-cs package, the
Microdrive, and that TI controller all work on other PPC platforms.

If you are a Montavista customer, send the exact error messages you are
getting to your support contact.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
