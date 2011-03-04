Return-Path: <henk.stegeman@gmail.com>
Received: from mail-qy0-f177.google.com (mail-qy0-f177.google.com
	[209.85.216.177]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E807EB70E5
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Mar 2011 09:40:36 +1100 (EST)
Received: by qyl38 with SMTP id 38so2414754qyl.15
	for <linuxppc-dev@ozlabs.org>; Fri, 04 Mar 2011 14:40:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AANLkTim8W6np1A1d=SKFNS5ze8FmrbUekoZaY8_a=46A@mail.gmail.com>
References: <fa686aa41003181102i2a702c61h8ecfe05568c2a42e@mail.gmail.com>
	<1295054884-18540-1-git-send-email-henk.stegeman@gmail.com>
	<1297033514.14982.6.camel@pasglop>
	<AANLkTikfKnLG1pBQuWLOcvuu7Za2cB9McyR=Z=h0nBpd@mail.gmail.com>
	<AANLkTim8W6np1A1d=SKFNS5ze8FmrbUekoZaY8_a=46A@mail.gmail.com>
Date: Fri, 4 Mar 2011 23:40:32 +0100
Message-ID: <AANLkTi=Wq_uF14TXWQ3ooOpbkroJfM_DOWZXJfCWDHcX@mail.gmail.com>
Subject: Re: [PATCH] Fix masking of interrupts for 52xx GPT IRQ.
From: Henk Stegeman <henk.stegeman@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

What if the unmask/mask functions are dropped and only interrupt
enable/disable functions are provided?
I.e: rename the old unmask/mask functions to enable/disable and
register them as enable/disable? I did try that, and it works too, no
spurious IRQ's and no missing IRQ's.


Cheers,

Henk.

On Wed, Mar 2, 2011 at 10:30 PM, Grant Likely <grant.likely@secretlab.ca> w=
rote:
> [fixed top-posted reply]
>
> On Wed, Feb 9, 2011 at 3:16 AM, Henk Stegeman <henk.stegeman@gmail.com> w=
rote:
>> On Mon, Feb 7, 2011 at 12:05 AM, Benjamin Herrenschmidt
>> <benh@kernel.crashing.org> wrote:
>>> On Sat, 2011-01-15 at 02:28 +0100, Henk Stegeman wrote:
>>>> When using the GPT as interrupt controller interupts were missing.
>>>> It turned out the IrqEn bit of the GPT is not a mask bit, but it also
>>>> disables interrupt generation. This modification masks interrupt one
>>>> level down the cascade. Note that masking one level down the cascade
>>>> is only valid here because the GPT as interrupt ontroller only serves
>>>> one IRQ.
>>>
>>> I'm not too sure here... You shouldn't implemen t both mask/unmask and
>>> enable/disable on the same irq_chip and certainly not cal
>>> enable_irq/disable_irq from a mask or an unmask callback...
>>>
>>> Now, I'm not familiar with the HW here, can you tell me more about what
>>> exactly is happening, how things are layed out and what you are trying
>>> to fix ?
>>>
> [...]
>> Because the old code in the unmask/mask function did enable/disable
>> and I didn't want to just drop that code, I provided it via the
>> enable/disable function.
>> What is wrong by implementing & registering both mask/unmask and
>> enable/disable for the same irq_chip?
>> If it is wrong it would be nice to let the kernel print a big fat
>> warning when this is registered.
>
> After some digging, yes Ben is right. =A0It doesn't make much sense to
> provide an enable/disable function along with the mask/unmask. =A0I
> think you can safely drop the old enable/disable code. =A0I'm going to
> drop this patch from my tree and you can respin and retest.
>
> g.
>
>>
>> Cheers,
>>
>> Henk
>>
>
>>>
>>>> Signed-off-by: Henk Stegeman <henk.stegeman@gmail.com>
>>>> ---
>>>> =A0arch/powerpc/platforms/52xx/mpc52xx_gpt.c | =A0 25 ++++++++++++++++=
++++++---
>>>> =A01 files changed, 22 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/=
platforms/52xx/mpc52xx_gpt.c
>>>> index 6f8ebe1..9ae2045 100644
>>>> --- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
>>>> +++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
>>>> @@ -91,7 +91,7 @@ struct mpc52xx_gpt_priv {
>>>> =A0 =A0 =A0 struct irq_host *irqhost;
>>>> =A0 =A0 =A0 u32 ipb_freq;
>>>> =A0 =A0 =A0 u8 wdt_mode;
>>>> -
>>>> + =A0 =A0 int cascade_virq;
>>>> =A0#if defined(CONFIG_GPIOLIB)
>>>> =A0 =A0 =A0 struct of_gpio_chip of_gc;
>>>> =A0#endif
>>>> @@ -136,18 +136,35 @@ DEFINE_MUTEX(mpc52xx_gpt_list_mutex);
>>>> =A0static void mpc52xx_gpt_irq_unmask(unsigned int virq)
>>>> =A0{
>>>> =A0 =A0 =A0 struct mpc52xx_gpt_priv *gpt =3D get_irq_chip_data(virq);
>>>> +
>>>> + =A0 =A0 enable_irq(gpt->cascade_virq);
>>>> +
>>>> +}
>>>> +
>>>> +static void mpc52xx_gpt_irq_mask(unsigned int virq)
>>>> +{
>>>> + =A0 =A0 struct mpc52xx_gpt_priv *gpt =3D get_irq_chip_data(virq);
>>>> +
>>>> + =A0 =A0 disable_irq(gpt->cascade_virq);
>>>> +}
>>>> +
>>>> +static void mpc52xx_gpt_irq_enable(unsigned int virq)
>>>> +{
>>>> + =A0 =A0 struct mpc52xx_gpt_priv *gpt =3D get_irq_chip_data(virq);
>>>> =A0 =A0 =A0 unsigned long flags;
>>>>
>>>> + =A0 =A0 dev_dbg(gpt->dev, "%s %d\n", __func__, virq);
>>>> =A0 =A0 =A0 spin_lock_irqsave(&gpt->lock, flags);
>>>> =A0 =A0 =A0 setbits32(&gpt->regs->mode, MPC52xx_GPT_MODE_IRQ_EN);
>>>> =A0 =A0 =A0 spin_unlock_irqrestore(&gpt->lock, flags);
>>>> =A0}
>>>>
>>>> -static void mpc52xx_gpt_irq_mask(unsigned int virq)
>>>> +static void mpc52xx_gpt_irq_disable(unsigned int virq)
>>>> =A0{
>>>> =A0 =A0 =A0 struct mpc52xx_gpt_priv *gpt =3D get_irq_chip_data(virq);
>>>> =A0 =A0 =A0 unsigned long flags;
>>>>
>>>> + =A0 =A0 dev_dbg(gpt->dev, "%s %d\n", __func__, virq);
>>>> =A0 =A0 =A0 spin_lock_irqsave(&gpt->lock, flags);
>>>> =A0 =A0 =A0 clrbits32(&gpt->regs->mode, MPC52xx_GPT_MODE_IRQ_EN);
>>>> =A0 =A0 =A0 spin_unlock_irqrestore(&gpt->lock, flags);
>>>> @@ -184,6 +201,8 @@ static struct irq_chip mpc52xx_gpt_irq_chip =3D {
>>>> =A0 =A0 =A0 .name =3D "MPC52xx GPT",
>>>> =A0 =A0 =A0 .unmask =3D mpc52xx_gpt_irq_unmask,
>>>> =A0 =A0 =A0 .mask =3D mpc52xx_gpt_irq_mask,
>>>> + =A0 =A0 .enable =3D mpc52xx_gpt_irq_enable,
>>>> + =A0 =A0 .disable =3D mpc52xx_gpt_irq_disable,
>>>> =A0 =A0 =A0 .ack =3D mpc52xx_gpt_irq_ack,
>>>> =A0 =A0 =A0 .set_type =3D mpc52xx_gpt_irq_set_type,
>>>> =A0};
>>>> @@ -268,7 +287,7 @@ mpc52xx_gpt_irq_setup(struct mpc52xx_gpt_priv *gpt=
, struct device_node *node)
>>>> =A0 =A0 =A0 if ((mode & MPC52xx_GPT_MODE_MS_MASK) =3D=3D 0)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&gpt->regs->mode, mode | MPC52xx_=
GPT_MODE_MS_IC);
>>>> =A0 =A0 =A0 spin_unlock_irqrestore(&gpt->lock, flags);
>>>> -
>>>> + =A0 =A0 gpt->cascade_virq =3D cascade_virq;
>>>> =A0 =A0 =A0 dev_dbg(gpt->dev, "%s() complete. virq=3D%i\n", __func__, =
cascade_virq);
>>>> =A0}
>>>>
>>>
>>>
>>>
>>
>
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>
