Subject: Re: MPC5200Lite PCI & IRQ
From: David Woodhouse <dwmw2@infradead.org>
To: Bertrand Baudet <bbaudet@lacie.com>
Cc: linuxppc-embedded@lists.linuxppc.org, jgarzik@redhat.com,
	B.Zolnierkiewicz@elka.pw.edu.pl
In-Reply-To: <5A96167EBCEA8440A48790B5419953AE13C443@gr-lafayette.lacie.com>
References: <5A96167EBCEA8440A48790B5419953AE13C443@gr-lafayette.lacie.com>
Content-Type: text/plain
Message-Id: <1087550915.19489.3137.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Fri, 18 Jun 2004 10:28:35 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2004-06-04 at 15:00 +0200, Bertrand Baudet wrote:
> Hi,
>
> I'm trying to plug a sata card in the PCI slot of the MPC5200Lite.
...
> By default the IRQ line of the sata card is 0,
...
> From the source code, it looks like a value 0 for the IRQ means the IRQ
> is disabled.
>
> From "drivers/ide/ide-probe.c", in the 'hwif_init' function:
> ...
> if (!hwif->irq) {
>    if (!(hwif->irq = ide_default_irq(hwif->io_ports[IDE_DATA_OFFSET])))
>    {
>       printk("%s: DISABLED, NO IRQ\n", hwif->name);
>       return (hwif->present = 0);
>    }
> }
> ...
>
> Commenting out the above code allow the PCI card to run properly.

This is a bug in the IDE driver. Zero is a perfectly valid IRQ number --
I have boxes where PCI slots get IRQ #0 too. Please fix the IDE driver
and send the patch to the IDE maintainer.

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
