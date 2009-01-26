Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 13E1DDE089
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jan 2009 19:31:33 +1100 (EST)
Message-ID: <497D74E1.6070507@grandegger.com>
Date: Mon, 26 Jan 2009 09:31:29 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 7/8] powerpc/5200: Refactor mpc5200 interrupt controller
	driver
References: <20090121205506.31232.27908.stgit@localhost.localdomain>	
	<20090121205540.31232.77034.stgit@localhost.localdomain>	
	<497CC632.2000402@grandegger.com>
	<fa686aa40901251622j542b6029u83c510f5b4e2f92@mail.gmail.com>
In-Reply-To: <fa686aa40901251622j542b6029u83c510f5b4e2f92@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Sun, Jan 25, 2009 at 1:06 PM, Wolfgang Grandegger <wg@grandegger.com> wrote:
>> Grant Likely wrote:
>>> From: Grant Likely <grant.likely@secretlab.ca>
>>>
>>> Rework the mpc5200-pic driver to simplify it and fix up the setting
>>> of desc->status when set_type is called for internal IRQs (so they
>>> are reported as level, not edge).  The simplification is due to
>>> splitting off the handling of external IRQs into a separate block
>>> so they don't need to be handled as exceptions in the normal
>>> CRIT, MAIN and PERP paths.
>>>
>>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>>> CC: Wolfram Sang <w.sang@pengutronix.de>
>>> ---
>>>
>>>  arch/powerpc/platforms/52xx/mpc52xx_pic.c |  145 ++++++++++++-----------------
>>>  1 files changed, 58 insertions(+), 87 deletions(-)
>>>
>>>
>>> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
>>> index c0a9559..277c9c5 100644
>>> --- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
>>> +++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
>>> @@ -190,10 +190,10 @@ static void mpc52xx_extirq_ack(unsigned int virq)
>>>
>>>  static int mpc52xx_extirq_set_type(unsigned int virq, unsigned int flow_type)
>>>  {
>>> -     struct irq_desc *desc = get_irq_desc(virq);
>>>       u32 ctrl_reg, type;
>>>       int irq;
>>>       int l2irq;
>>> +     void *handler = handle_level_irq;
>>>
>>>       irq = irq_map[virq].hwirq;
>>>       l2irq = irq & MPC52xx_IRQ_L2_MASK;
>>> @@ -201,32 +201,21 @@ static int mpc52xx_extirq_set_type(unsigned int virq, unsigned int flow_type)
>>>       pr_debug("%s: irq=%x. l2=%d flow_type=%d\n", __func__, irq, l2irq, flow_type);
>>>
>>>       switch (flow_type) {
>>> -     case IRQF_TRIGGER_HIGH:
>>> -             type = 0;
>>> -             break;
>>> -     case IRQF_TRIGGER_RISING:
>>> -             type = 1;
>>> -             break;
>>> -     case IRQF_TRIGGER_FALLING:
>>> -             type = 2;
>>> -             break;
>>> -     case IRQF_TRIGGER_LOW:
>>> -             type = 3;
>>> -             break;
>>> +     case IRQF_TRIGGER_HIGH: type = 0; break;
>>> +     case IRQF_TRIGGER_RISING: type = 1; handler = handle_edge_irq; break;
>>> +     case IRQF_TRIGGER_FALLING: type = 2; handler = handle_edge_irq; break;
>>> +     case IRQF_TRIGGER_LOW: type = 3; break;
>> The Linux coding style tells us not to do that:
>>
>> http://lxr.linux.no/linux+v2.6.28.2/Documentation/CodingStyle#L60
> 
> In principle I agree and follow that rule most of the time, but I have
> good reason for not choosing to do so here.
> 
> The whole point of coding style is to promote
> readability/manageability.  ie. the 80 column rule is a very strong
> guideline, but there are places where breaking that rule makes for
> more readable code than breaking things up and it is left to the
> discretion of the coder and the maintainer.
> 
> In this case I looked at the block of code and saw that a large number
> of lines (11) were needed to do a set of nearly identical operations.
> I chose to line them up because in my opinion it is easier to follow
> the pattern with them written in horizontal columns instead of in
> vertical blocks.  In other words, in this case it is harder to hide
> something in the code written this way because it wouldn't match the
> pattern of the other lines.  For the same reason you'll also notice
> that I did *not* put all the statements on the same line for the
> default case because it doesn't match the pattern of the specific
> cases.

Well, I don't want to debate coding style rules. I also sometimes just
shake my head. But this rules I actually find useful because it allows
the GDB to point to the line == expression, apart from readability. If
you don't stick to the coding style rules, you have to explain to the
maintainer why you broke it ... good luck ;-).

Wolfgang.
