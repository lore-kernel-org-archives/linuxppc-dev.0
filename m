Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f20.google.com (mail-gx0-f20.google.com
	[209.85.217.20]) by ozlabs.org (Postfix) with ESMTP id 54EE0DDFC2
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 17:04:00 +1100 (EST)
Received: by gxk13 with SMTP id 13so314162gxk.9
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 22:03:59 -0800 (PST)
Message-ID: <fa686aa40901132203u3074a2c1h3eeb5ae49b938090@mail.gmail.com>
Date: Tue, 13 Jan 2009 23:03:58 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Matt Sealey" <matt@genesi-usa.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Fwd: [PATCH] powerpc/mpc52xx: Properly update irq_desc when
	set_type() is called.
In-Reply-To: <fa686aa40901132203p71bbd6eem2b8173dc8a4e5fc8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20090107192505.26320.23112.stgit@localhost.localdomain>
	<fa686aa40901072053v7803c6afp206e0572a6c79eda@mail.gmail.com>
	<49661041.2010302@genesi-usa.com>
	<fa686aa40901091302y12fa13b4v25bd85079ee4e7ea@mail.gmail.com>
	<4968D8AF.8050402@genesi-usa.com>
	<fa686aa40901101425y5ff97f9fgabaa8aa6f0e974c7@mail.gmail.com>
	<496AB287.5050508@genesi-usa.com>
	<fa686aa40901112156i69611682icf9ef3a7702fd862@mail.gmail.com>
	<496C907B.2060609@genesi-usa.com>
	<fa686aa40901132203p71bbd6eem2b8173dc8a4e5fc8@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 13, 2009 at 6:00 AM, Matt Sealey <matt@genesi-usa.com> wrote:
> Grant Likely wrote:
>>
>>
>> Theoretically it could call IRQ handlers to be called too often.  It
>> might possibly be the cause of too many 'BAD' irqs being recorded....
>
> That might explain a few USB explosions, where high bandwidth transfers
> (restoring partimage disks) would make the host controller die (a freeze,
> then it comes back with 'nobody cared about irq 134' etc.) and perhaps a
> lockup we saw with openSUSE 11.0 installer..
>
>> Now that I think of it, I should probably also change all the internal
>> IRQs to be LEVEL instead of EDGE.
>
> And what does that really affect? I wouldn't think the internal stuff would
> make any difference what it senses on?

It took me most of the morning, but I traced through all the code and
figured out how it is supposed to work.  In this case the type field
in status is indeed cosmetic.  The only time I can see that it really
comes into play is when edge IRQs are enabled after being disabled for
replaying IRQs.  It might be the source of some of the BAD irq count
on the mpc5200, but it is unlikely.

The real logic behind handling an IRQ is defined by the handler
registered with set_irq_chip_and_handler() which the current mpc5200
PIC driver seems to be doing correctly.  However, for external IRQs,
the handler is not changed when the IRQ switches from the default edge
sensitivity to level sensitivity.  Using the wrong handler doesn't
seem to actively break things, but I'm still investigating to find out
if it affects performance or results in BAD irq counts.

Regardless, I'm looking at a number of cleanups to the PIC code and
I'll be posting a patch soon with the intent of getting it into .30.

Cheers,
g.

--
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
