Message-ID: <20030514152011.2631.qmail@web11004.mail.yahoo.com>
Date: Wed, 14 May 2003 08:20:11 -0700 (PDT)
From: Xupei Liang <tliang@yahoo.com>
Subject: Re: IDE driver support in PPC440
To: Eugene Surovegin <ebs@ebshome.net>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <5.1.0.14.2.20030513234918.035106b8@mail.ebshome.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, Eugene,

The IRQ7 is setup as level trigger and active low.

I think what happened is that when the ISR is
serving the first interrupt, which is external
interrupt 7 (number 50), it is interrupted again.
This time, ppc405_pic_get_irq() returns irq 64 because
the routine knows that all interrupts have been
disabled (I have looked at UIC_ER0 and UIC_ER1
and verified that is the case). So the question is,
if all interrupts are disabled, why the code is stuck
inside the ISR?

I am using the lastest 2.4.19 code.

Thank you for your help again.

Regards,

Terry L.


--- Eugene Surovegin <ebs@ebshome.net> wrote:
>
> At 10:15 PM 5/13/2003, Xupei Liang wrote:
>
>
> >I am working on a PPC440 board that supports
> >a PCI-IDE device, and I am experiencing an
> >interrupt handling problem.
> >
> >The PCI-IDE controller uses External Interrupt 7
> and
> >the controller interrupt line is wired to the
> >processor directly. When the IDE device is
> >being initialized, I can see that the interrupt
> >goes off. But the code is stuck in the
> >ISR and can not get out. Here are the screen
> >debug messages:
> >
> ><Linux booting up>
> >ide1: CMD649 Bus-Master DMA disabled (BIOS)
> >disabling irq 50 defensively
> >ppc405_uic_disable - irq 50 word 1 bit 0x12
> >hda: SanDisk SDCFB-128, ATA DISK drive
> >ppc405_uic_enable - irq 50 word 1 bit 0x12
> >ppc405_uic_enable - irq 50 word 1 bit 0x12
> >ide0 at 0x2000-0x2007,0x3002 on irq 50
> >hda: 250880 sectors (128 MB) w/1KiB Cache,
> >CHS=980/8/32
> >Partition check:
> >  hda:ppc405_pic_get_irq - irq 50 bit 0x2000
> >ppc405_uic_disable_and_ack - irq 50 word 1 bit 0x12
> >ppc405_pic_get_irq - irq 64 bit 0x0
> >ppc405_pic_get_irq - irq 64 bit 0x0
> >-------------
>
> Well, "irq 64" bothers me.
> You shouldn't see this message. Real external
> interrupts are in the range 0-63
>
> Please, check that you are using latest code from
> 2.4 devel tree
> (in particular file arch/ppc/kernel/ppc4xx_pic.c)
>
> BTW, how did you setup trigger and polarity settings
> for IRQ7 ?
>
> Eugene.
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
