Return-Path: <david.hagood@gmail.com>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179]) by ozlabs.org (Postfix) with ESMTP id 49598B6F10
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Oct 2010 07:55:52 +1100 (EST)
Received: by gyg10 with SMTP id 10so1218303gyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Oct 2010 13:55:46 -0700 (PDT)
Message-ID: <942ea2f3464025464521511c32355782.squirrel@localhost>
In-Reply-To: <20101011121745.2e471fc0@udp111988uds.am.freescale.net>
References: <6e7b840fa55e4fba421e1b1cea2716ec.squirrel@localhost>
	<1682399277683944B902B3657D2FCE21654570D791@CAREXCLUSTER03.ATL.CW.LOCAL>
	<20100921170700.53a99e56@udp111988uds.am.freescale.net>
	<fe4c3e4086132d746b79670f236302f1.squirrel@localhost>
	<20101007152626.4e834d43@udp111988uds.am.freescale.net>
	<8636b70ea34330679bebdaad187ccd68.squirrel@localhost>
	<4CB2DEFB.90204@windriver.com>
	<20101011121745.2e471fc0@udp111988uds.am.freescale.net>
Date: Tue, 12 Oct 2010 15:55:28 -0500
Subject: Re: Questions on interrupt vector assignment on MPC8641D
From: david.hagood@gmail.com
To: "Scott Wood" <scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: "tiejun.chen" <tiejun.chen@windriver.com>, david.hagood@gmail.com,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> There's mpic stuff in the call trace, so the NULL host was OK.
>
> Look in arch/powerpc/platforms/86xx/pic.c.  What is the second-to-last
> parameter of mpc86xx_init_irq() in your kernel tree?  It's 256 in
> current upstream -- this is the number of IRQ sources the MPIC driver
> will handle.
>

One, thanks for your help - I do appreciate it.

In the tree I am working from, the call to mpc86xx_init_irq() function is
in a BSP file (ep8641a.c), and the line was

 mpic1 = mpic_alloc(np, res.start,
			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
			16, NR_IRQS-4,
			" MPIC     ");

I tried changing that to
mpic1 = mpic_alloc(np, res.start,
			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
			16, 256,
			" MPIC     ");

With no meaningful changes.

I wonder about the next lines:


	mpic_assign_isu(mpic1, 0, res.start + 0x10000);

	/* 48 Internal Interrupts */
	mpic_assign_isu(mpic1, 1, res.start + 0x10200);
	mpic_assign_isu(mpic1, 2, res.start + 0x10400);
	mpic_assign_isu(mpic1, 3, res.start + 0x10600);

	/* 16 External interrupts
	 * Moving them from [0 - 15] to [64 - 79]
	 */
	mpic_assign_isu(mpic1, 4, res.start + 0x10000);


Looking at the code, and where it appears to be faulting, it looks like
its in kernel/irq/chip.c:


int set_irq_type(unsigned int irq, unsigned int type)
{
	struct irq_desc *desc;
	unsigned long flags;
	int ret = -ENXIO;

	if (irq >= NR_IRQS) {
		printk(KERN_ERR "Trying to set irq type for IRQ%d\n", irq);
		return -ENODEV;
	}

	desc = irq_desc + irq;
------------------------
	if (desc->chip->set_type) {
		spin_lock_irqsave(&desc->lock, flags);
		ret = desc->chip->set_type(irq, type);
------------------------


		spin_unlock_irqrestore(&desc->lock, flags);
	}
	return ret;
}

My conjecture is that desc->chip isn't set. Is mpic_assign_isu the
function that does that?

(yes, I know - update your kernel. I am 2 weeks from a delivery, I have to
merge driver changes to sRIO in along with all of this....)
