Message-Id: <5.1.0.14.2.20030513234918.035106b8@mail.ebshome.net>
Date: Tue, 13 May 2003 23:56:56 -0700
To: Xupei Liang <tliang@yahoo.com>
From: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: IDE driver support in PPC440
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20030514051548.90794.qmail@web11008.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 10:15 PM 5/13/2003, Xupei Liang wrote:


>I am working on a PPC440 board that supports
>a PCI-IDE device, and I am experiencing an
>interrupt handling problem.
>
>The PCI-IDE controller uses External Interrupt 7 and
>the controller interrupt line is wired to the
>processor directly. When the IDE device is
>being initialized, I can see that the interrupt
>goes off. But the code is stuck in the
>ISR and can not get out. Here are the screen
>debug messages:
>
><Linux booting up>
>ide1: CMD649 Bus-Master DMA disabled (BIOS)
>disabling irq 50 defensively
>ppc405_uic_disable - irq 50 word 1 bit 0x12
>hda: SanDisk SDCFB-128, ATA DISK drive
>ppc405_uic_enable - irq 50 word 1 bit 0x12
>ppc405_uic_enable - irq 50 word 1 bit 0x12
>ide0 at 0x2000-0x2007,0x3002 on irq 50
>hda: 250880 sectors (128 MB) w/1KiB Cache,
>CHS=980/8/32
>Partition check:
>  hda:ppc405_pic_get_irq - irq 50 bit 0x2000
>ppc405_uic_disable_and_ack - irq 50 word 1 bit 0x12
>ppc405_pic_get_irq - irq 64 bit 0x0
>ppc405_pic_get_irq - irq 64 bit 0x0
>-------------

Well, "irq 64" bothers me.
You shouldn't see this message. Real external interrupts are in the range 0-63

Please, check that you are using latest code from 2.4 devel tree
(in particular file arch/ppc/kernel/ppc4xx_pic.c)

BTW, how did you setup trigger and polarity settings for IRQ7 ?

Eugene.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
