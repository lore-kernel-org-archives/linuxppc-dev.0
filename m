Message-ID: <20031021160024.27655.qmail@web41507.mail.yahoo.com>
Date: Tue, 21 Oct 2003 09:00:24 -0700 (PDT)
From: bhupinder sahran <bhup_sah@yahoo.com>
Subject: Re: PCI on MPC8265
To: Tamas Bara <tba@mixed-mode.de>,
	"Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <3F95161F.1080206@mixed-mode.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I think problen is with the idselect on pci back
plane.
Looks like same card is connected to more than one
ideselect, so when kernel is doing enumertaion for
different idselect, same card is responding and kernel
thinks that you have multiple card sitting on pci back
plane. In place of changing the kernel, you shall fix
your hardware....that is a better solution...

Bhupi

Linux +Hypertransport --> Silicon
www.gdatech.com




--- Tamas Bara <tba@mixed-mode.de> wrote:
>
> Hi,
>
> I´m running Linux 2.4.4 on a TQM8260 board with
> an MPC8265 on it and an Ethernet controller on
> the PCI Bus.
>
> When Linux scans the PCI Bus it detects the
> controller multiple times. I could change the for
> loop to devfn < 9 since I only got the internal
> host bridge and the controller on the bus:
>
> /* Go find them, Rover! */
> for (devfn = 0; devfn < 0x100; devfn += 8) {
> 	dev0.devfn = devfn;
> 	pci_scan_slot(&dev0);
> }
>
> This works, but I don´t want to change the kernel.
> So I´m looking for a different solution.
>
> How does the kernel know that it already detected
> a device before?
>
> Thanks
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
