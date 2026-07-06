Return-Path: <linuxppc-dev+bounces-23594-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9499EC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 08:57:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtysY20Hjz2xpn;
	Mon, 06 Jul 2026 18:57:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783328225;
	cv=none; b=H1QPni+6pGY65yLjAeNokG0iu0s8Zy/10ENTwXEPiqcpItUNhyVynwvN8pLyy9HX8yHC87QzcRLWtFuek3CuRtlqzdnpkbfsg2oqd/ifN9oVgBbBa0kcn20+wM6dX1oFZ2yNyg3CQChpOOlOI2Hz0g7uOFLXclpTJ2FUwIrG0Kv6LxIPbk1GE7NMfQFRhcxfDvzwR6B7t1z89qj/iTdIl8sq2195gcWHcayfzpgZa3zMriXJHcAacGjLljhfNHz7ODGlw1RhhvlJztii0xP+X3Npr7Ng3XBtPgK8C29Fe/1ha1sSR8aKcWp4iQU8KkRicncaHSqR6jNaMLieLM9HbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783328225; c=relaxed/relaxed;
	bh=kfFPiegXNTBdwL7ERGkc+qHbAJDd2t8DcXD4UdKo670=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=m3xIVHaMioXOUPMIUJLyF2vyx9vg+x+XGy3kqGmmKaLRFlcr69jmIp+Xx4hRcs32bwR8JUcNKFd45HjBoQ06mEbpE/wEUsXgxY2ftIwTjOl+ea9QoIV3JF39OZjJz4JrJso484wbOjUMqEvc9hGj3FrHz1DK1lcLgut50tTpdVd+6TtgsrKCs+nhJJHdUUc2R+5AR9reG1i7q65rHbA1aTxvPvVupHX9ezlm4Gk3srVCNhqhdhYdqUZGlT+vWaeMNlqkzTbAl9zt7ayMC+Oo38ZIutegcKi+i56tpOz9JZiNExC/1nSjvlacNzqGcVpOA32LTt9WVpr1ri9rYhtx9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=226LxmgD; dkim-atps=neutral; spf=pass (client-ip=185.171.202.116; helo=smtpout-04.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=226LxmgD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.171.202.116; helo=smtpout-04.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gtysX08ZQz2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 18:57:02 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 3C7D6C8EC62;
	Mon,  6 Jul 2026 08:57:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2C3F2601A2;
	Mon,  6 Jul 2026 08:56:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6433611BB9BF5;
	Mon,  6 Jul 2026 10:56:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783328218; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kfFPiegXNTBdwL7ERGkc+qHbAJDd2t8DcXD4UdKo670=;
	b=226LxmgDjx9k9eSuB9lzIsww26Zz8Ic9NQLh0i4uMKUs5Gns2LhFiuf3n4DK4rypNVQe6A
	/TpEfY4XWaVCUItIlaFrreQ60DyDdR4yrIhQ7Ifkk9ediqJJ2qtvj5eNbgG2rYPxTMINl5
	QsFHXtk2CV2yU84tHFQIqppoEDMmr6XdW0fhgucdghDZOnx/TxPtMEEUhG8myLxd0CUBa4
	+nmESPjYRIUYipXI5FEiL+Dc7T2FY2aE/d1SC9wXNZJQ2ZpqDc3Rmj96g4Bxos7X2yrQfw
	MoilbPUhQ3q+DMaGgK9IdAQ/+MinohXiBRAcDgWPzwvaqv3OMIbAC9w90W8ARg==
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 10:56:54 +0200
Message-Id: <DJRD3C0919EP.CTZYPXDY93HI@bootlin.com>
Cc: <linuxppc-dev@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 08/12] soc: fsl: qe: Convert to generic IRQ chip
From: "Paul Louvel" <paul.louvel@bootlin.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Paul Louvel"
 <paul.louvel@bootlin.com>, "Qiang Zhao" <qiang.zhao@nxp.com>, "Thomas
 Gleixner" <tglx@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Linus Walleij" <linusw@kernel.org>, "Bartosz Golaszewski"
 <brgl@kernel.org>, "Madhavan Srinivasan" <maddy@linux.ibm.com>, "Michael
 Ellerman" <mpe@ellerman.id.au>, "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260703-qe-pic-gpios-v1-0-6c3e706e27dc@bootlin.com>
 <20260703-qe-pic-gpios-v1-8-6c3e706e27dc@bootlin.com>
 <34946670-2a76-47fa-af82-3d70cdc9d8f0@kernel.org>
In-Reply-To: <34946670-2a76-47fa-af82-3d70cdc9d8f0@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Mon Jul 6, 2026 at 9:29 AM CEST, Christophe Leroy (CS GROUP) wrote:
> Hi Paul,
>
> Le 03/07/2026 =C3=A0 15:30, Paul Louvel a =C3=A9crit=C2=A0:
>> The generic IRQ chip framework is available to handle IRQ chips. Using
>> this framework for the QE interrupt controller allows to simplify the
>> driver. Indeed, the framework internally handles operations coded
>> directly in the driver.
>>=20
>> Add a select dependency to GENERIC_IRQ_CHIP in the PPC platform Kconfig.
>>=20
>> Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
>> ---
>>   arch/powerpc/platforms/Kconfig   |   1 +
>>   drivers/soc/fsl/qe/qe_ports_ic.c | 103 ++++++++++++++++++++++++++-----=
--------
>>   2 files changed, 70 insertions(+), 34 deletions(-)
>>=20
>> diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kco=
nfig
>> index c4e61843d9d9..b0b3a80f8cde 100644
>> --- a/arch/powerpc/platforms/Kconfig
>> +++ b/arch/powerpc/platforms/Kconfig
>> @@ -232,6 +232,7 @@ config QE_GPIO
>>   	bool "QE GPIO support"
>>   	depends on QUICC_ENGINE
>>   	select GPIOLIB
>> +	select GENERIC_IRQ_CHIP
>>   	help
>>   	  Say Y here if you're going to use hardware that connects to the
>>   	  QE GPIOs.
>> diff --git a/drivers/soc/fsl/qe/qe_ports_ic.c b/drivers/soc/fsl/qe/qe_po=
rts_ic.c
>> index c8b73b0aa233..d022aa224f6d 100644
>> --- a/drivers/soc/fsl/qe/qe_ports_ic.c
>> +++ b/drivers/soc/fsl/qe/qe_ports_ic.c
>> @@ -20,63 +20,65 @@ struct qepic_data {
>>   	void __iomem *reg;
>>   	struct irq_domain *host;
>>   	int irq;
>> +	struct irq_chip_generic *gc;
>>   };
>>  =20
>>   static void qepic_mask(struct irq_data *d)
>>   {
>> -	struct qepic_data *data =3D irq_data_get_irq_chip_data(d);
>> +	struct irq_chip_generic *gc =3D irq_data_get_irq_chip_data(d);
>> +	struct irq_chip_type *ct =3D irq_data_get_chip_type(d);
>>  =20
>> -	clrbits32(data->reg + CEPIMR, 1 << (31 - irqd_to_hwirq(d)));
>> +	clrbits32(gc->reg_base + ct->regs.mask, d->mask);
>
> Is there a real added value with this change ?
>
> Previously we had:
>
> 00000000 <qepic_mask>:
>     0:	81 03 00 18 	lwz     r8,24(r3)
>     4:	81 28 00 00 	lwz     r9,0(r8)
>     8:	7c 00 04 ac 	hwsync
>     c:	81 29 00 10 	lwz     r9,16(r9)
>    10:	0c 09 00 00 	twi     0,r9,0
>    14:	4c 00 01 2c 	isync
>    18:	80 e3 00 08 	lwz     r7,8(r3)
>    1c:	3d 40 80 00 	lis     r10,-32768
>    20:	81 08 00 00 	lwz     r8,0(r8)
>    24:	7d 4a 3c 30 	srw     r10,r10,r7
>    28:	7d 29 50 78 	andc    r9,r9,r10
>    2c:	7c 00 04 ac 	hwsync
>    30:	91 28 00 10 	stw     r9,16(r8)
>    34:	4e 80 00 20 	blr
>
> Now we have:
>
> 00000000 <qepic_mask>:
>     0:	80 e3 00 18 	lwz     r7,24(r3)
>     4:	81 03 00 10 	lwz     r8,16(r3)
>     8:	81 27 00 00 	lwz     r9,0(r7)
>     c:	81 48 00 94 	lwz     r10,148(r8)
>    10:	7d 29 52 14 	add     r9,r9,r10
>    14:	7c 00 04 ac 	hwsync
>    18:	81 49 00 00 	lwz     r10,0(r9)
>    1c:	0c 0a 00 00 	twi     0,r10,0
>    20:	4c 00 01 2c 	isync
>    24:	80 c3 00 00 	lwz     r6,0(r3)
>    28:	81 27 00 00 	lwz     r9,0(r7)
>    2c:	81 08 00 94 	lwz     r8,148(r8)
>    30:	7d 4a 30 78 	andc    r10,r10,r6
>    34:	7d 29 42 14 	add     r9,r9,r8
>    38:	7c 00 04 ac 	hwsync
>    3c:	91 49 00 00 	stw     r10,0(r9)
>    40:	4e 80 00 20 	blr
>
> We now have three more indirect loads (8x lwz instead of 5x), for=20
> loading some value which is already known at compile time.
>
>
>>   }
>>  =20
>>   static void qepic_unmask(struct irq_data *d)
>>   {
>> -	struct qepic_data *data =3D irq_data_get_irq_chip_data(d);
>> +	struct irq_chip_generic *gc =3D irq_data_get_irq_chip_data(d);
>> +	struct irq_chip_type *ct =3D irq_data_get_chip_type(d);
>>  =20
>> -	setbits32(data->reg + CEPIMR, 1 << (31 - irqd_to_hwirq(d)));
>> +	setbits32(gc->reg_base + ct->regs.mask, d->mask);
>>   }
>>  =20
>>   static void qepic_end(struct irq_data *d)
>>   {
>> -	struct qepic_data *data =3D irq_data_get_irq_chip_data(d);
>> +	struct irq_chip_generic *gc =3D irq_data_get_irq_chip_data(d);
>> +	struct irq_chip_type *ct =3D irq_data_get_chip_type(d);
>>  =20
>> -	out_be32(data->reg + CEPIER, 1 << (31 - irqd_to_hwirq(d)));
>> +	out_be32(gc->reg_base + ct->regs.eoi, d->mask);
>> +}
>> +
>> +static void qepic_calc_mask(struct irq_data *d)
>> +{
>> +	d->mask =3D 1 << (31 - irqd_to_hwirq(d));
>>   }
>>  =20
>>   static int qepic_set_type(struct irq_data *d, unsigned int flow_type)
>>   {
>> -	struct qepic_data *data =3D irq_data_get_irq_chip_data(d);
>> -	unsigned int vec =3D (unsigned int)irqd_to_hwirq(d);
>> +	struct irq_chip_generic *gc =3D irq_data_get_irq_chip_data(d);
>> +	struct irq_chip_type *ct =3D irq_data_get_chip_type(d);
>>  =20
>>   	switch (flow_type & IRQ_TYPE_SENSE_MASK) {
>>   	case IRQ_TYPE_EDGE_FALLING:
>> -		setbits32(data->reg + CEPICR, 1 << (31 - vec));
>> +		setbits32(gc->reg_base + ct->regs.type, d->mask);
>>   		return 0;
>>   	case IRQ_TYPE_EDGE_BOTH:
>>   	case IRQ_TYPE_NONE:
>> -		clrbits32(data->reg + CEPICR, 1 << (31 - vec));
>> +		clrbits32(gc->reg_base + ct->regs.type, d->mask);
>>   		return 0;
>>   	}
>>   	return -EINVAL;
>>   }
>>  =20
>> -static struct irq_chip qepic =3D {
>> -	.name =3D "QEPIC",
>> -	.irq_mask =3D qepic_mask,
>> -	.irq_unmask =3D qepic_unmask,
>> -	.irq_eoi =3D qepic_end,
>> -	.irq_set_type =3D qepic_set_type,
>> -};
>> -
>>   static void qepic_cascade(struct irq_desc *desc)
>>   {
>>   	struct qepic_data *data =3D irq_desc_get_handler_data(desc);
>> +	struct irq_chip_type *ct =3D data->gc->chip_types;
>>   	struct irq_chip *chip =3D irq_desc_get_chip(desc);
>>   	unsigned long event, bit;
>>  =20
>>   	chained_irq_enter(chip, desc);
>>  =20
>> -	event =3D in_be32(data->reg + CEPIER);
>> +	event =3D in_be32(data->gc->reg_base + ct->regs.eoi);
>>   	if (!event) {
>>   		handle_bad_irq(desc);
>>   		goto out;
>> @@ -89,33 +91,64 @@ static void qepic_cascade(struct irq_desc *desc)
>>   	chained_irq_exit(chip, desc);
>>   }
>>  =20
>> -static int qepic_host_map(struct irq_domain *h, unsigned int virq, irq_=
hw_number_t hw)
>> +static int qepic_chip_init(struct irq_chip_generic *gc)
>>   {
>> -	irq_set_chip_data(virq, h->host_data);
>> -	irq_set_chip_and_handler(virq, &qepic, handle_fasteoi_irq);
>> +	struct irq_chip_type *ct =3D gc->chip_types;
>> +
>> +	ct->regs.mask =3D CEPIMR;
>> +	ct->chip.irq_mask =3D qepic_mask;
>> +	ct->chip.irq_unmask =3D qepic_unmask;
>> +	ct->regs.eoi =3D CEPIER;
>> +	ct->chip.irq_eoi =3D qepic_end;
>> +	ct->regs.type =3D CEPICR;
>> +	ct->chip.irq_set_type =3D qepic_set_type;
>> +	ct->chip.irq_calc_mask =3D qepic_calc_mask;
>
> Are ct->regs.mask, ct->regs.eoi and ct->regs.type used anywhere else=20
> than locally in qepic_{mask/unmask/end/set_type} ?

No they are not.
The main purpose of these registers is that they are used in the generic ir=
q
chip framework functions like irq_gc_mask_set_bit(), which we dropped earli=
er in
favor of using our own hooks.
At this stage, if you consider that the instructions overhead of the functi=
ons
above is already too much, it is better to get rid of the framework complet=
ly
then.

>
> Christophe
>
>> +
>>   	return 0;
>>   }
>>  =20
>> -static const struct irq_domain_ops qepic_host_ops =3D {
>> -	.map =3D qepic_host_map,
>> -};
>> +static int qepic_domain_init(struct irq_domain *d)
>> +{
>> +	struct qepic_data *data =3D d->host_data;
>>  =20
>> -static void qepic_remove(void *res)
>> +	irq_set_chained_handler_and_data(data->irq, qepic_cascade, data);
>> +
>> +	return 0;
>> +}
>> +
>> +static void qepic_domain_exit(struct irq_domain *d)
>>   {
>> -	struct qepic_data *data =3D res;
>> +	struct qepic_data *data =3D d->host_data;
>>  =20
>>   	irq_set_chained_handler_and_data(data->irq, NULL, NULL);
>> -	irq_domain_remove(data->host);
>>   }
>>  =20
>>   static int qepic_probe(struct platform_device *pdev)
>>   {
>> +	struct irq_domain_chip_generic_info dgc_info =3D {
>> +		.name		=3D "QEPIC",
>> +		.handler	=3D handle_fasteoi_irq,
>> +		.irqs_per_chip	=3D 32,
>> +		.num_ct		=3D 1,
>> +		.init		=3D qepic_chip_init,
>> +	};
>> +	struct irq_domain_info d_info =3D {
>> +		.fwnode		=3D of_fwnode_handle(pdev->dev.of_node),
>> +		.domain_flags	=3D IRQ_DOMAIN_FLAG_DESTROY_GC,
>> +		.size		=3D 32,
>> +		.hwirq_max	=3D 32,
>> +		.ops		=3D &irq_generic_chip_ops,
>> +		.dgc_info	=3D &dgc_info,
>> +		.init		=3D qepic_domain_init,
>> +		.exit		=3D qepic_domain_exit,
>> +	};
>>   	struct device *dev =3D &pdev->dev;
>>   	struct qepic_data *data;
>>  =20
>>   	data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>>   	if (!data)
>>   		return -ENOMEM;
>> +	d_info.host_data =3D data;
>>  =20
>>   	data->reg =3D devm_platform_ioremap_resource(pdev, 0);
>>   	if (IS_ERR(data->reg))
>> @@ -125,14 +158,16 @@ static int qepic_probe(struct platform_device *pde=
v)
>>   	if (data->irq < 0)
>>   		return data->irq;
>>  =20
>> -	data->host =3D irq_domain_create_linear(dev_fwnode(dev), 32, &qepic_ho=
st_ops, data);
>> -	if (!data->host)
>> -		return -ENODEV;
>> +	data->host =3D devm_irq_domain_instantiate(dev, &d_info);
>> +	if (IS_ERR(data->host))
>> +		return PTR_ERR(data->host);
>>  =20
>> -	irq_set_chained_handler_and_data(data->irq, qepic_cascade, data);
>> -
>> -	return devm_add_action_or_reset(dev, qepic_remove, data);
>> +	data->gc =3D irq_get_domain_generic_chip(data->host, 0);
>> +	if (!data->gc)
>> +		return -ENODEV;
>> +	data->gc->reg_base =3D data->reg;
>>  =20
>> +	return 0;
>>   }
>>  =20
>>   static const struct of_device_id qepic_match[] =3D {
>>=20

Thanks,
Paul.



--=20
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


