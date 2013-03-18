Return-Path: <B11780@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 31ADD2C0085
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2013 01:44:17 +1100 (EST)
From: Gala Kumar-B11780 <B11780@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] powerpc/mpic: add irq_set_wake support
Date: Mon, 18 Mar 2013 14:44:07 +0000
Message-ID: <CF1EE7AED478CD48A05574C8E2DA142D7611FE@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1362728327-21013-1-git-send-email-dongsheng.wang@freescale.com>
 <ABB05CD9C9F68C46A5CEDC7F15439259EB6434@039-SN2MPN1-022.039d.mgd.msft.net>
 <1363617693.15862.1.camel@pasglop>
In-Reply-To: <1363617693.15862.1.camel@pasglop>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Gala Kumar-B11780 <B11780@freescale.com>,
 Wang Dongsheng-B40534 <B40534@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 18, 2013, at 9:41 AM, Benjamin Herrenschmidt wrote:

> On Mon, 2013-03-18 at 09:28 +0000, Wang Dongsheng-B40534 wrote:
>> Hi Benjamin & Kumar,
>>=20
>> I am not sure who can apply these patches...
>>=20
>> Could you apply these patches?
>=20
> I can but I need somebody to review them, I don't have the bandwidth nor
> am I familiar with the FSL changes to the MPIC.
>=20
> Cheers,
> Ben.

I'd ask for Scott's ack/signoff on these patches for ben or I to accept the=
m.

- k

>=20
>> Thanks.
>>=20
>> [1/3] powerpc/mpic: add irq_set_wake support
>> http://patchwork.ozlabs.org/patch/226034/
>>=20
>> [2/3] powerpc/mpic: add global timer support
>> http://patchwork.ozlabs.org/patch/226035/
>>=20
>> [3/3] powerpc/fsl: add MPIC timer wakeup support
>> http://patchwork.ozlabs.org/patch/226036/
>>=20
>>> -----Original Message-----
>>> From: Wang Dongsheng-B40534
>>> Sent: Friday, March 08, 2013 3:39 PM
>>> To: Wood Scott-B07421; Gala Kumar-B11780
>>> Cc: linuxppc-dev@lists.ozlabs.org; Wang Dongsheng-B40534
>>> Subject: [PATCH 1/3] powerpc/mpic: add irq_set_wake support
>>>=20
>>> Add irq_set_wake support. Just add IRQF_NO_SUSPEND to desc->action->fla=
g.
>>> So the wake up interrupt will not be disable in suspend_device_irqs.
>>>=20
>>> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
>>> ---
>>> arch/powerpc/sysdev/mpic.c |   15 +++++++++++++++
>>> 1 files changed, 15 insertions(+), 0 deletions(-)
>>>=20
>>> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
>>> index 3b2efd4..10e474e 100644
>>> --- a/arch/powerpc/sysdev/mpic.c
>>> +++ b/arch/powerpc/sysdev/mpic.c
>>> @@ -920,6 +920,18 @@ int mpic_set_irq_type(struct irq_data *d, unsigned
>>> int flow_type)
>>> 	return IRQ_SET_MASK_OK_NOCOPY;
>>> }
>>>=20
>>> +static int mpic_irq_set_wake(struct irq_data *d, unsigned int on) {
>>> +	struct irq_desc *desc =3D container_of(d, struct irq_desc, irq_data);
>>> +
>>> +	if (on)
>>> +		desc->action->flags |=3D IRQF_NO_SUSPEND;
>>> +	else
>>> +		desc->action->flags &=3D ~IRQF_NO_SUSPEND;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> void mpic_set_vector(unsigned int virq, unsigned int vector)  {
>>> 	struct mpic *mpic =3D mpic_from_irq(virq); @@ -957,6 +969,7 @@ static
>>> struct irq_chip mpic_irq_chip =3D {
>>> 	.irq_unmask	=3D mpic_unmask_irq,
>>> 	.irq_eoi	=3D mpic_end_irq,
>>> 	.irq_set_type	=3D mpic_set_irq_type,
>>> +	.irq_set_wake	=3D mpic_irq_set_wake,
>>> };
>>>=20
>>> #ifdef CONFIG_SMP
>>> @@ -971,6 +984,7 @@ static struct irq_chip mpic_tm_chip =3D {
>>> 	.irq_mask	=3D mpic_mask_tm,
>>> 	.irq_unmask	=3D mpic_unmask_tm,
>>> 	.irq_eoi	=3D mpic_end_irq,
>>> +	.irq_set_wake	=3D mpic_irq_set_wake,
>>> };
>>>=20
>>> #ifdef CONFIG_MPIC_U3_HT_IRQS
>>> @@ -981,6 +995,7 @@ static struct irq_chip mpic_irq_ht_chip =3D {
>>> 	.irq_unmask	=3D mpic_unmask_ht_irq,
>>> 	.irq_eoi	=3D mpic_end_ht_irq,
>>> 	.irq_set_type	=3D mpic_set_irq_type,
>>> +	.irq_set_wake	=3D mpic_irq_set_wake,
>>> };
>>> #endif /* CONFIG_MPIC_U3_HT_IRQS */
>>>=20
>>> --
>>> 1.7.5.1
>>=20
>=20
>=20
>=20
