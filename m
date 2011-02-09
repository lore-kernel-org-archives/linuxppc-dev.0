Return-Path: <henk.stegeman@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
	[209.85.215.170]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AAF7DB70DE
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Feb 2011 21:16:57 +1100 (EST)
Received: by eyf5 with SMTP id 5so4578667eyf.15
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Feb 2011 02:16:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1297033514.14982.6.camel@pasglop>
References: <fa686aa41003181102i2a702c61h8ecfe05568c2a42e@mail.gmail.com>
	<1295054884-18540-1-git-send-email-henk.stegeman@gmail.com>
	<1297033514.14982.6.camel@pasglop>
Date: Wed, 9 Feb 2011 11:16:43 +0100
Message-ID: <AANLkTikfKnLG1pBQuWLOcvuu7Za2cB9McyR=Z=h0nBpd@mail.gmail.com>
Subject: Re: [PATCH] Fix masking of interrupts for 52xx GPT IRQ.
From: Henk Stegeman <henk.stegeman@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

What I'm trying to achieve is to have an interrupt service routine
called for every rising edge on pin E2 of the MPC5200B.
The only CPU register setup (AFAIK) to let the CPU generate this
interrupt is to use the GPT (general purpose timer) function pin E2 is
attached to.

This function is supported by mpc52xx_gpt.c.

Excerpt from mpc52xx_gpt.c:
 * To use the IRQ controller function, the following two properties must
 * be added to the device tree node for the gpt device:
 *      interrupt-controller;
 *      #interrupt-cells =3D < 1 >;
 * The IRQ controller binding only uses one cell to specify the interrupt,
 * and the IRQ flags are encoded in the cell.  A cell is not used to encode
 * the IRQ number because the GPT only has a single IRQ source.  For flags,
 * a value of '1' means rising edge sensitive and '2' means falling edge.

In my dts it's setup like so:

               gpt6: timer@660 {       // General Purpose Timer GPT6
in GPIO mode for
SMC4000IO sample irq.
                       compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
                       reg =3D <0x660 0x10>;
                       interrupts =3D <1 15 0>;
                       interrupt-controller;
                       #interrupt-cells =3D <1>;
               };

When I put a 512Hz signal on pin E2, I was not getting 512 interrupt
calls per second.

I then found that the GPT's "Interrupt Enable" bit is touched via the
mask/unmask functions.
However when 0, the "Interrupt Enable" bit stops generation of
interrupts by the GPT, so while 0, any edge on pin E2 is lost.
If the GPT had it's own mask bit I would probably have changed the
mask/unmask to use this bit instead.
Now the bit that actually would mask/unmask the interrupt is in the
mask register of the MPC5200B's interrupt controller.

This bit (Bit 15 of the interrupts controller's main_mask register) is
controlled by mpc52xx_main_mask / mpc52xx_main_unmask in
mpc52xx_pic.c.
It does feel odd to have it masked/unmask a level down the cascade, if
the GPT provided more interrupt sources they'd be disabled too, but
that's not the case here, only one interrupt is provided by the GPT.
So that's why I did it anyways. It works, and even if it is sane, it's
confusing and I'd sure like to know of a better way to do this.

Because the old code in the unmask/mask function did enable/disable
and I didn't want to just drop that code, I provided it via the
enable/disable function.
What is wrong by implementing & registering both mask/unmask and
enable/disable for the same irq_chip?
If it is wrong it would be nice to let the kernel print a big fat
warning when this is registered.

Cheers,

Henk

On Mon, Feb 7, 2011 at 12:05 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Sat, 2011-01-15 at 02:28 +0100, Henk Stegeman wrote:
>> When using the GPT as interrupt controller interupts were missing.
>> It turned out the IrqEn bit of the GPT is not a mask bit, but it also
>> disables interrupt generation. This modification masks interrupt one
>> level down the cascade. Note that masking one level down the cascade
>> is only valid here because the GPT as interrupt ontroller only serves
>> one IRQ.
>
> I'm not too sure here... You shouldn't implemen t both mask/unmask and
> enable/disable on the same irq_chip and certainly not cal
> enable_irq/disable_irq from a mask or an unmask callback...
>
> Now, I'm not familiar with the HW here, can you tell me more about what
> exactly is happening, how things are layed out and what you are trying
> to fix ?
>
> Cheers,
> Ben.
>
>> Signed-off-by: Henk Stegeman <henk.stegeman@gmail.com>
>> ---
>> =A0arch/powerpc/platforms/52xx/mpc52xx_gpt.c | =A0 25 ++++++++++++++++++=
++++---
>> =A01 files changed, 22 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/pl=
atforms/52xx/mpc52xx_gpt.c
>> index 6f8ebe1..9ae2045 100644
>> --- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
>> +++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
>> @@ -91,7 +91,7 @@ struct mpc52xx_gpt_priv {
>> =A0 =A0 =A0 struct irq_host *irqhost;
>> =A0 =A0 =A0 u32 ipb_freq;
>> =A0 =A0 =A0 u8 wdt_mode;
>> -
>> + =A0 =A0 int cascade_virq;
>> =A0#if defined(CONFIG_GPIOLIB)
>> =A0 =A0 =A0 struct of_gpio_chip of_gc;
>> =A0#endif
>> @@ -136,18 +136,35 @@ DEFINE_MUTEX(mpc52xx_gpt_list_mutex);
>> =A0static void mpc52xx_gpt_irq_unmask(unsigned int virq)
>> =A0{
>> =A0 =A0 =A0 struct mpc52xx_gpt_priv *gpt =3D get_irq_chip_data(virq);
>> +
>> + =A0 =A0 enable_irq(gpt->cascade_virq);
>> +
>> +}
>> +
>> +static void mpc52xx_gpt_irq_mask(unsigned int virq)
>> +{
>> + =A0 =A0 struct mpc52xx_gpt_priv *gpt =3D get_irq_chip_data(virq);
>> +
>> + =A0 =A0 disable_irq(gpt->cascade_virq);
>> +}
>> +
>> +static void mpc52xx_gpt_irq_enable(unsigned int virq)
>> +{
>> + =A0 =A0 struct mpc52xx_gpt_priv *gpt =3D get_irq_chip_data(virq);
>> =A0 =A0 =A0 unsigned long flags;
>>
>> + =A0 =A0 dev_dbg(gpt->dev, "%s %d\n", __func__, virq);
>> =A0 =A0 =A0 spin_lock_irqsave(&gpt->lock, flags);
>> =A0 =A0 =A0 setbits32(&gpt->regs->mode, MPC52xx_GPT_MODE_IRQ_EN);
>> =A0 =A0 =A0 spin_unlock_irqrestore(&gpt->lock, flags);
>> =A0}
>>
>> -static void mpc52xx_gpt_irq_mask(unsigned int virq)
>> +static void mpc52xx_gpt_irq_disable(unsigned int virq)
>> =A0{
>> =A0 =A0 =A0 struct mpc52xx_gpt_priv *gpt =3D get_irq_chip_data(virq);
>> =A0 =A0 =A0 unsigned long flags;
>>
>> + =A0 =A0 dev_dbg(gpt->dev, "%s %d\n", __func__, virq);
>> =A0 =A0 =A0 spin_lock_irqsave(&gpt->lock, flags);
>> =A0 =A0 =A0 clrbits32(&gpt->regs->mode, MPC52xx_GPT_MODE_IRQ_EN);
>> =A0 =A0 =A0 spin_unlock_irqrestore(&gpt->lock, flags);
>> @@ -184,6 +201,8 @@ static struct irq_chip mpc52xx_gpt_irq_chip =3D {
>> =A0 =A0 =A0 .name =3D "MPC52xx GPT",
>> =A0 =A0 =A0 .unmask =3D mpc52xx_gpt_irq_unmask,
>> =A0 =A0 =A0 .mask =3D mpc52xx_gpt_irq_mask,
>> + =A0 =A0 .enable =3D mpc52xx_gpt_irq_enable,
>> + =A0 =A0 .disable =3D mpc52xx_gpt_irq_disable,
>> =A0 =A0 =A0 .ack =3D mpc52xx_gpt_irq_ack,
>> =A0 =A0 =A0 .set_type =3D mpc52xx_gpt_irq_set_type,
>> =A0};
>> @@ -268,7 +287,7 @@ mpc52xx_gpt_irq_setup(struct mpc52xx_gpt_priv *gpt, =
struct device_node *node)
>> =A0 =A0 =A0 if ((mode & MPC52xx_GPT_MODE_MS_MASK) =3D=3D 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&gpt->regs->mode, mode | MPC52xx_GP=
T_MODE_MS_IC);
>> =A0 =A0 =A0 spin_unlock_irqrestore(&gpt->lock, flags);
>> -
>> + =A0 =A0 gpt->cascade_virq =3D cascade_virq;
>> =A0 =A0 =A0 dev_dbg(gpt->dev, "%s() complete. virq=3D%i\n", __func__, ca=
scade_virq);
>> =A0}
>>
>
>
>
