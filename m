Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB498606A321
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 05:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Qj8GCYPq;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=uX3b8+8E
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNwTc4j7lz2yD8;
	Tue, 10 Nov 2026 16:40:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=81.169.146.166 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794289204;
	cv=pass; b=BmZhEKMPj3LL9n4Go/RDiv2Y6VR4DuD4OFV/PR2SKEaOohVfVuwNM7EVUUMyToWXfsq3eBgGihKUx1M9Ayp6239Y9+vNkGu8VCh10nK3pL5SGbwgnqzPKt2xDszsbzH1++VKg2VD0hp/sHtyFdCxrAhbUwLsKSPzCBx9H9P1bNeCA2IyIFVpXnfuR08GPl7VdgXSt+oCgfSiHYFJixaEHifENHWr4cSv0JUbRRLLVSJv9uhCytg79a3K+XyHuOTBnNQ6nRBFxatNTvz5GKfoAGGtnhR/7caAuH/EdLTtLt71TOuGFFkRchEilkuWFMRhtZX7G0SZkYVgxSQrAjPhjA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794289204; c=relaxed/relaxed;
	bh=S8ohD8TTon6CSuE8BFoK8vlZxKMe26OgleUkaVwDF1w=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=J5sIbBfB7XGIHXklSxq9F7AYoOmNgKupw0qwt+2YhJd/cRTPIItBu2EDsBcXFitCHJ5QbRzs2xUpRDGR75Q1srt148mzYvhEKgBQp3nez3e0thY/DekYyS5RH2+7BdkcPIHuFPLXcqxrm03TGfXqYDeit4HfojK+FmdhiqbVqpIk2yf/0yzOKUJg6mWFevePncZprDDz906Hc5Gdi9PJ+2SsD1RT/iVLYaoIwOSCMHmXpFQtuELCcKrzAa6cmHLSrOg+VQlE0I7Z2j/kwS1NKtX5C4t/1+5VuxXM9pHAz51abeQn2sw8wK+E3NwzTRvSbg5EBGNHGGIzs8WHQNM71A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Qj8GCYPq; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=uX3b8+8E; dkim-atps=neutral; spf=pass (client-ip=81.169.146.166; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p01-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Qj8GCYPq;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=uX3b8+8E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p01-ob.smtp.rzone.de (client-ip=81.169.146.166; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNwTW3BJGz2xf8
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 16:39:56 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; t=1794289190; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ZdhaAyO0gC+JhwlOsEDPbJme4hpbYmRiz4Ri0GROCwGrRYafkgpdu78ttz92RLyLvM
    BxOj1s+6mY5Ncp+MxigH8l7sWW/dy5onwUmpmHDZ+8PVoOUgScgh5GPi8Zl1EYLK4pPF
    n2IZj4Jvol1GYemx2gRBS+gGd+4BgY0HKyEJ6T86cpssA0wC6UQ6P0WNghk+JA8Xh9Fr
    g3iEbNTiQpcYq24sRYK917cWEqYxm2Y0bZv1EjeDFC5RUiXlwxs2r4YeRdqUuF1yHb4h
    MhVvo8KzJ6t1430mTd3tfuTE+UU/kmSaz9/gO0G0GOnV4MwO4Bsjj6YFjCNi1slo1rSU
    GKPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794289190;
    s=strato-dkim-0002; d=strato.com;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=S8ohD8TTon6CSuE8BFoK8vlZxKMe26OgleUkaVwDF1w=;
    b=WBx3jm1tMkB98Y6mnXz23ubg8dlENR8mIwWpO7avqVs33ikzkCccR0JKl45ApL6tUX
    NdsLROvSvO8sL+3Mc7r/aPddZdbUNBBIHto9NDTM6i/akC4bTYN5MXQE18HOQxQbFvw3
    Mw7e7XBqZ+dUiPCcqgCC6QdNIX9Yna/gEiZxSQQv2stVDx2GCQhoJnAgLj2bzsxlurz0
    CEWMDAvMqOxQscIC35TMzjd8l9kogs75tfUc41VmSLWRd5WmqrwwB0Z1deRqRriV9uCI
    7xMbHAwbhEggt5Q7lkUhFk9I/bQ/9mFJBZVQeqPpXqryhcJi7V7Ai7zUFQMWHyTXEId3
    ntkQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794289190;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=S8ohD8TTon6CSuE8BFoK8vlZxKMe26OgleUkaVwDF1w=;
    b=Qj8GCYPql97W7egzPwd+WiMkD4QnR14nXd/LizIT8UGDJAD3ZHHDTx7mES5A/ahID2
    JHNcDi4zgSMyJ6vRFO58S4Vjp+iwAWcm8qZ+Mk0nu7+04VA9/xiXYU7NBO/eyRCAVBLN
    GwK2sJlllLloFQ1HKgYbLDAE++bJhMtU3zf7kChGyrK2Yc0gGwwkk9DBxox95QB9B9nR
    /q6r5U1wahn/Ui2+v+U8yf+vp5EOL6UGor+Ziy4Htsn/edpvyMySScqQcGakIHpgzq1t
    9xdNYM0IBQsGMX49dlmIE946O+ek6fhEvHqu5aoL/8SbA6AX7M5dJ+6zCDNErBNn3VZC
    iLnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794289190;
    s=strato-dkim-0003; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=S8ohD8TTon6CSuE8BFoK8vlZxKMe26OgleUkaVwDF1w=;
    b=uX3b8+8E4yIjeDJIN1zmGsRs3Yj3i3Mx3M2gzEr/kXIq80elfPIkAKQdl0hB1G3WOe
    OKkrBv9tipQvCC6BjfCA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7X5jmsynCW3ulH0C0frstyBygmu/G3vm9T9+/NnU="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id e825d92AA5dneIS
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 10 Nov 2026 06:39:49 +0100 (CET)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Christian Zigotzky <chzigotzky@xenosoft.de>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] powerpc/pasemi: Defer Nemo IRQ initialization
Date: Tue, 10 Nov 2026 06:39:38 +0100
Message-Id: <E1BAC41D-33BA-4A27-8549-6A885489A59E@xenosoft.de>
References: <zevr6h46.ritesh.list@gmail.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
 info@xenosoft.de, Darren Stevens <darren@stevens-zone.net>,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, Damien Stewart <hypexed@yahoo.com.au>
In-Reply-To: <zevr6h46.ritesh.list@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
X-Mailer: iPhone Mail (24B119)
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNWANTED_DEVICE_2 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> On 02 November 2026 at 04:39 am, Ritesh Harjani <ritesh.list@gmail.com> wr=
ote:
>=20
> =EF=BB=BFchzigotzky@xenosoft.de writes:
>=20
>> From: Christian Zigotzky A-EON Open Source <info@xenosoft.de>
>>=20
>> Since pas_pci_init() is now called later during boot, the i8259
>> initialization in pas_init_IRQ() happens too early and accesses
>> registers that are not yet mapped, preventing the board from booting.
>>=20
>> Move the Nemo-specific i8259 initialization to pas_add_bridge(),
>> after the ISA bridge has been discovered.
>=20
>=20
> That make sense to me. The patch looks good. However, shouldn't we also
> add Fixes tag and Cc: stable tag - so that this gets backported to older
> stable kernels.
>=20
>=20
> Fixes: c144bc719234 ("powerpc/pasemi: Move PHB discovery")
> Cc: stable@vger.kernel.org
>=20
> I think the fixes tag should be above - but feel free to correct that.
>=20
> Otherwise looks good to me. Feel free to add:
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>=20
>=20
>>=20
>> Suggested-by: Darren Stevens <darren@stevens-zone.net>
>> Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
>> Signed-off-by: Christian Zigotzky A-EON Open Source <info@xenosoft.de>
>> ---
>> arch/powerpc/platforms/pasemi/pasemi.h |  6 ++++++
>> arch/powerpc/platforms/pasemi/pci.c    |  5 +++++
>> arch/powerpc/platforms/pasemi/setup.c  | 12 ++++--------
>> 3 files changed, 15 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/arch/powerpc/platforms/pasemi/pasemi.h b/arch/powerpc/platfo=
rms/pasemi/pasemi.h
>> index 6f6743b8e48d..01bcfa258625 100644
>> --- a/arch/powerpc/platforms/pasemi/pasemi.h
>> +++ b/arch/powerpc/platforms/pasemi/pasemi.h
>> @@ -7,6 +7,12 @@ extern void pas_pci_init(void);
>> struct pci_dev;
>> extern void pas_pci_dma_dev_setup(struct pci_dev *dev);
>>=20
>> +#ifdef CONFIG_PPC_PASEMI_NEMO
>> +void __init nemo_init_IRQ(void);
>> +#else
>> +static inline void __init nemo_init_IRQ(void) { }
>> +#endif
>> +
>> void __iomem *__init pasemi_pci_getcfgaddr(struct pci_dev *dev, int offse=
t);
>>=20
>> extern void __init pasemi_map_registers(void);
>> diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms=
/pasemi/pci.c
>> index 2df955274652..fb53782da7ec 100644
>> --- a/arch/powerpc/platforms/pasemi/pci.c
>> +++ b/arch/powerpc/platforms/pasemi/pci.c
>> @@ -265,6 +265,11 @@ static int __init pas_add_bridge(struct device_node *=
dev)
>>     */
>>    isa_bridge_find_early(hose);
>>=20
>> +    /*
>> +     * ISA bridge is now active, add the i8259 cascade (if needed)
>> +     */
>> +    nemo_init_IRQ();
>> +
>>    return 0;
>> }
>>=20
>> diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platfor=
ms/pasemi/setup.c
>> index 45792ecd5dfd..7a961f2a228f 100644
>> --- a/arch/powerpc/platforms/pasemi/setup.c
>> +++ b/arch/powerpc/platforms/pasemi/setup.c
>> @@ -216,10 +216,12 @@ static void sb600_8259_cascade(struct irq_desc *des=
c)
>>    chip->irq_eoi(&desc->irq_data);
>> }
>>=20
>> -static void __init nemo_init_IRQ(struct mpic *mpic)
>> +void __init nemo_init_IRQ(void)
>> {
>>    struct device_node *np;
>>    int gpio_virq;
>> +    struct mpic *mpic;
>> +
>>    /* Connect the SB600's legacy i8259 controller */
>>    np =3D of_find_node_by_path("/pxp@0,e0000000");
>>    i8259_init(np, 0);
>> @@ -230,14 +232,10 @@ static void __init nemo_init_IRQ(struct mpic *mpic)=

>>    irq_set_chained_handler(gpio_virq, sb600_8259_cascade);
>>    mpic_unmask_irq(irq_get_irq_data(gpio_virq));
>>=20
>> +    mpic =3D irq_get_chip_data(gpio_virq);
>>    irq_set_default_domain(mpic->irqhost);
>> }
>>=20
>> -#else
>> -
>> -static inline void nemo_init_IRQ(struct mpic *mpic)
>> -{
>> -}
>> #endif
>>=20
>> static __init void pas_init_IRQ(void)
>> @@ -300,8 +298,6 @@ static __init void pas_init_IRQ(void)
>>        mpic_unmask_irq(irq_get_irq_data(nmi_virq));
>>    }
>>=20
>> -    nemo_init_IRQ(mpic);
>> -
>>    of_node_put(mpic_node);
>>    of_node_put(root);
>> }
>> --
>> 2.43.0

Hi Michael,

I would like to ask about the status of my patch.
The patch received a positive review from Ritesh Harjani.
This fix is important for our Nemo boards, otherwise fails to boot with rece=
nt kernels.

Thanks,
Christian=


