Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 2EC63B6ED0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Oct 2010 12:15:01 +1100 (EST)
Message-ID: <4CB5088D.4090201@windriver.com>
Date: Wed, 13 Oct 2010 09:17:01 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Questions on interrupt vector assignment on MPC8641D
References: <6e7b840fa55e4fba421e1b1cea2716ec.squirrel@localhost>	<1682399277683944B902B3657D2FCE21654570D791@CAREXCLUSTER03.ATL.CW.LOCAL>	<20100921170700.53a99e56@udp111988uds.am.freescale.net>	<fe4c3e4086132d746b79670f236302f1.squirrel@localhost>	<20101007152626.4e834d43@udp111988uds.am.freescale.net>	<8636b70ea34330679bebdaad187ccd68.squirrel@localhost>	<4CB2DEFB.90204@windriver.com>	<20101011121745.2e471fc0@udp111988uds.am.freescale.net>	<942ea2f3464025464521511c32355782.squirrel@localhost>
	<20101012162152.5246744a@udp111988uds.am.freescale.net>
In-Reply-To: <20101012162152.5246744a@udp111988uds.am.freescale.net>
Content-Type: text/plain; charset=UTF-8
Cc: david.hagood@gmail.com,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood wrote:
> On Tue, 12 Oct 2010 15:55:28 -0500
> <david.hagood@gmail.com> wrote:
> 
>> I wonder about the next lines:
>>
>>
>> 	mpic_assign_isu(mpic1, 0, res.start + 0x10000);
>>
>> 	/* 48 Internal Interrupts */
>> 	mpic_assign_isu(mpic1, 1, res.start + 0x10200);
>> 	mpic_assign_isu(mpic1, 2, res.start + 0x10400);
>> 	mpic_assign_isu(mpic1, 3, res.start + 0x10600);
>>
>> 	/* 16 External interrupts
>> 	 * Moving them from [0 - 15] to [64 - 79]
>> 	 */
>> 	mpic_assign_isu(mpic1, 4, res.start + 0x10000);
> 
> No mainline 86xx boards do that, even in 2.6.26.  I suspect you need to
> either get rid of the isu stuff altogether, or add a mapping for the
> MSI interrupts.
> 
>> Looking at the code, and where it appears to be faulting, it looks like
>> its in kernel/irq/chip.c:
>>
>>
>> int set_irq_type(unsigned int irq, unsigned int type)
>> {
>> 	struct irq_desc *desc;
>> 	unsigned long flags;
>> 	int ret = -ENXIO;
>>
>> 	if (irq >= NR_IRQS) {
>> 		printk(KERN_ERR "Trying to set irq type for IRQ%d\n", irq);
>> 		return -ENODEV;
>> 	}
>>
>> 	desc = irq_desc + irq;
>> ------------------------
>> 	if (desc->chip->set_type) {
>> 		spin_lock_irqsave(&desc->lock, flags);
>> 		ret = desc->chip->set_type(irq, type);
>> ------------------------
>>
>>
>> 		spin_unlock_irqrestore(&desc->lock, flags);
>> 	}
>> 	return ret;
>> }
>>
>> My conjecture is that desc->chip isn't set. Is mpic_assign_isu the
>> function that does that?
> 
> That happens in set_irq_chip_and_handler(), called from mpic_host_map()
> -- just a few lines before calling set_irq_type().
> 
> The crash is happening somewhere in mpic_set_irq_type():

Agreed. That is just where I pointed out on my email replied for OOPS. To enable
DBG to figure out 'src' and 'mpic->irq_count' from the file,
arch/powerpc/sysdev/mpic.c,    .
======
int mpic_set_irq_type(unsigned int virq, unsigned int flow_type)
{
	......
	if (src >= mpic->irq_count)
		return -EINVAL;
			^
			I think this OOPS may be from here.


Tiejun

>> NIP [c0016540] mpic_set_irq_type+0x188/0x1c4
> 
> -Scott
> 
> 
