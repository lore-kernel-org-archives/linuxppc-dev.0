Return-Path: <r58472@freescale.com>
Received: from DB3EHSOBE006.bigfish.com (db3ehsobe006.messaging.microsoft.com
 [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id A0105B6F7E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2011 21:32:36 +1100 (EST)
Received: from mail15-db3 (localhost.localdomain [127.0.0.1])	by
 mail15-db3-R.bigfish.com (Postfix) with ESMTP id 99B83C50416	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2011 10:32:16 +0000 (UTC)
Received: from DB3EHSMHS019.bigfish.com (unknown [10.3.81.247])	by
 mail15-db3.bigfish.com (Postfix) with ESMTP id 628711A1004B	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2011 10:32:16 +0000 (UTC)
From: Li Yang-R58472 <r58472@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, Zhao Chenhui-B35336
 <B35336@freescale.com>
Subject: RE: [PATCH 3/7] powerpc/85xx: add sleep and deep sleep support
Date: Tue, 8 Nov 2011 10:32:22 +0000
Message-ID: <3F607A5180246847A760FD34122A1E052BC91C@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1320410014-14453-1-git-send-email-chenhui.zhao@freescale.com>
 <4EB432C1.1000601@freescale.com>
In-Reply-To: <4EB432C1.1000601@freescale.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>Subject: Re: [PATCH 3/7] powerpc/85xx: add sleep and deep sleep support
>
>On 11/04/2011 07:33 AM, Zhao Chenhui wrote:
>> +/* Cast the ccsrbar to 64-bit parameter so that the assembly
>> + * code can be compatible with both 32-bit & 36-bit */
>> +extern void mpc85xx_enter_deep_sleep(u64 ccsrbar, u32 powmgtreq);
>
>/*
> * Please use proper
> * Linux multi-line comment format.
> */
>
>>  static int pmc_suspend_enter(suspend_state_t state)
>>  {
>>  	int ret;
>> +	u32 powmgtreq =3D 0x00500000;
>
>Where does this 0x00500000 come from?  Please symbolically define
>individual bits.
>
>The comment in the asm code says it should be 0x00100000, BTW.

I think we should get rid of the powmgtreq argument, as we don't support mu=
ltiple modes for mpc85xx_enter_deep_sleep() now.

>
>> +
>> +	switch (state) {
>> +	case PM_SUSPEND_MEM:
>> +#ifdef CONFIG_SPE
>> +		enable_kernel_spe();
>> +#endif
>
>Should comment that currently only e500v2 hardware supports deep sleep
>-- else we'd need to save normal FP here.
>
>> +		pr_debug("Entering deep sleep\n");
>> +
>> +		local_irq_disable();
>> +		mpc85xx_enter_deep_sleep(get_immrbase(),
>> +				powmgtreq);
>> +		pr_debug("Resumed from deep sleep\n");
>> +
>> +		return 0;
>> +
>> +	/* else fall-through */
>> +	case PM_SUSPEND_STANDBY:
>
>What fall-through?  You just returned.
>
>> +	}
>>
>> -	/* Upon resume, wait for SLP bit to be clear. */
>> -	ret =3D spin_event_timeout((in_be32(&pmc_regs->pmcsr) & PMCSR_SLP) =3D=
=3D
>0,
>> -				 10000, 10) ? 0 : -ETIMEDOUT;
>> -	if (ret)
>> -		dev_err(pmc_dev, "tired waiting for SLP bit to clear\n");
>> -	return ret;
>>  }
>
>Remove that blank line as well.
>
>> @@ -58,13 +101,23 @@ static const struct platform_suspend_ops
>pmc_suspend_ops =3D {
>>  	.enter =3D pmc_suspend_enter,
>>  };
>>
>> -static int pmc_probe(struct platform_device *ofdev)
>> +static int pmc_probe(struct platform_device *pdev)
>>  {
>> -	pmc_regs =3D of_iomap(ofdev->dev.of_node, 0);
>> +	struct device_node *np =3D pdev->dev.of_node;
>> +
>> +	pmc_regs =3D of_iomap(pdev->dev.of_node, 0);
>>  	if (!pmc_regs)
>>  		return -ENOMEM;
>>
>> -	pmc_dev =3D &ofdev->dev;
>> +	has_deep_sleep =3D 0;
>> +	if (of_device_is_compatible(np, "fsl,mpc8536-pmc"))
>> +		has_deep_sleep =3D 1;
>> +
>> +	has_lossless =3D 0;
>> +	if (of_device_is_compatible(np, "fsl,p1022-pmc"))
>> +		has_lossless =3D 1;
>> +
>
>You never use has_lossless.

It will be used in the later patch in the series.

- Leo
