Return-Path: <galak@kernel.crashing.org>
Subject: Re: [PATCH 4/4] powerpc/mpic: FSL MPIC error interrupt support.
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4F720FE3.7080101@freescale.com>
Date: Wed, 28 Mar 2012 09:35:13 -0500
Message-Id: <7376AC30-8A8F-4A3E-A025-C8F92AFE23E5@kernel.crashing.org>
References: <1332850633-23661-1-git-send-email-Varun.Sethi@freescale.com>
 <7F9EFF8D-82E4-414E-BB76-24BE84F2D8BC@kernel.crashing.org>
 <4F720FE3.7080101@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: Varun Sethi <Varun.Sethi@freescale.com>, Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 27, 2012, at 2:07 PM, Scott Wood wrote:

> On 03/27/2012 08:59 AM, Kumar Gala wrote:
>>=20
>> On Mar 27, 2012, at 7:17 AM, Varun Sethi wrote:
>>=20
>>> All SOC device error interrupts are muxed and delivered to the core =
as a single
>>> MPIC error interrupt. Currently all the device drivers requiring =
access to device
>>> errors have to register for the MPIC error interrupt as a shared =
interrupt.
>>>=20
>>> With this patch we add interrupt demuxing capability in the mpic =
driver, allowing
>>> device drivers to register for their individual error interrupts. =
This is achieved
>>> by handling error interrupts in a cascaded fashion.
>>>=20
>>> MPIC error interrupt is handled by the "error_int_handler", which =
subsequently demuxes
>>> it using the EISR and delivers it to the respective drivers.=20
>>>=20
>>> The error interrupt capability is dependent on the MPIC EIMR =
register, which was
>>> introduced in FSL MPIC version 4.1 (P4080 rev2). So, error interrupt =
demuxing capability
>>> is dependent on the MPIC version and can be used for versions >=3D =
4.1.
>>>=20
>>> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
>>> ---
>>=20
>> This isn't quite right.  Doing the 'request_irq' on behalf of the =
driver isn't treating the error interrupts as a real cascade, in =
addition to how you are hooking things up.
>=20
> Define "real cascade".  If you mean the chained handler stuff that's =
how
> Varun initially did it and I asked him to change it, because it gets a
> lot trickier to get things right, and I didn't see what it was buying =
us.
>=20
> The request_irq() isn't on behalf of the individual drivers, it's
> requesting the cascade itself (not a shared interrupt).

I missed the bit related to err_int_config_done, need to re-look at it.  =
Was thinking request_irq() was getting called for every error interrupt.

>> I think you need to add proper irq_domain_ops, etc.  Thus when we map =
the virq the proper thing can happen
>=20
> What proper thing is not happening?
>=20
> Maybe it would be cleaner from an interrupt number management
> perspective to keep things more separate, but do you have a functional
> issue in mind?
>=20
>> I'd also suggest maybe thinking about pulling this code into an =
mpic_fsl.c
>>=20
>>> arch/powerpc/include/asm/mpic.h |   18 +++++
>>> arch/powerpc/sysdev/mpic.c      |  155 =
++++++++++++++++++++++++++++++++++++++-
>>> 2 files changed, 171 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/arch/powerpc/include/asm/mpic.h =
b/arch/powerpc/include/asm/mpic.h
>>> index 3929b4b..db51015 100644
>>> --- a/arch/powerpc/include/asm/mpic.h
>>> +++ b/arch/powerpc/include/asm/mpic.h
>>> @@ -114,12 +114,21 @@
>>> #define MPIC_FSL_BRR1			0x00000
>>> #define 	MPIC_FSL_BRR1_VER			0x0000ffff
>>>=20
>>> +/*
>>> + * Error interrupt registers
>>> + */
>>> +
>>> +#define MPIC_ERR_INT_BASE	0x3900
>>> +#define MPIC_ERR_INT_EISR	0x0000
>>> +#define MPIC_ERR_INT_EIMR	0x0010
>>> +
>>> #define MPIC_MAX_IRQ_SOURCES	2048
>>> #define MPIC_MAX_CPUS		32
>>> #define MPIC_MAX_ISU		32
>>>=20
>>> #define MPIC_MAX_TIMER    8
>>> #define MPIC_MAX_IPI      4
>>> +#define MPIC_MAX_ERR      32
>>=20
>> Should probably be 64
>=20
> This patch supports MPIC 4.1 and EISR0.  When support is added for =
EISR1
> (didn't realize this was coming until your comment prompted me to
> check...), this should be updated, but this change alone would not =
make
> it work.

Would prefer we handle this now rather than later (T4240 is going to =
need EISR1 support).

>>> +static void mpic_mask_err(struct irq_data *d)
>>> +{
>>> +	u32 eimr;
>>> +	struct mpic *mpic =3D mpic_from_irq_data(d);
>>> +	unsigned int src =3D virq_to_hw(d->irq) - mpic->err_int_vecs[0];
>>> +	unsigned int err_reg_offset =3D MPIC_INFO(ERR_INT_EIMR);
>>> +
>>> +	eimr =3D mpic_err_read(err_reg_offset);
>>> +	eimr |=3D (0x80000000 >> src);
>>=20
>> This seems funny, add a comment about src # and bit # being opposite.
>=20
> People in PPC-land should be used to this craziness by now. :-P

:), as I said a comment would be helpful.

>> Maybe do:
>>=20
>> 	eimr |=3D (1 << (31 - src));
>=20
> I'm not sure it's really any clearer that way...
>=20
>>> +static irqreturn_t error_int_handler(int irq, void *data)
>>> +{
>>> +	struct mpic *mpic =3D (struct mpic *) data;
>>> +	unsigned int eisr_offset =3D MPIC_INFO(ERR_INT_EISR);
>>> +	unsigned int eimr_offset =3D MPIC_INFO(ERR_INT_EIMR);
>>> +	u32 eisr, eimr;
>>> +	int errint;
>>> +	unsigned int cascade_irq;
>>> +
>>> +	eisr =3D mpic_err_read(eisr_offset);
>>> +	eimr =3D mpic_err_read(eimr_offset);
>>> +
>>> +	if (!(eisr & ~eimr))
>>> +		return IRQ_NONE;
>>> +
>>> +	while (eisr) {
>>> +		errint =3D __ffs(eisr);
>>> +		cascade_irq =3D irq_linear_revmap(mpic->irqhost,
>>> +				 mpic->err_int_vecs[31 - errint]);
>>=20
>> Should 31, be replaced w/MPIC_MAX_ERR - 1 ?
>=20
> No, the 31 here is due to the backwards bit numbering within the
> register.  It'd be better to say "errint =3D 31 - __ffs(eisr)" -- or
> perhaps "errint =3D __builtin_clz(eisr)".

gotcha

- k=
