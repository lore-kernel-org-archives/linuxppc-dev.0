Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D960606A324
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 05:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=KVPQ8Da9;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=pP4kaxkf
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJ0RF3SVcz2yTQ;
	Mon, 02 Nov 2026 16:20:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=85.215.255.53 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793596857;
	cv=pass; b=InGQbcEt/K/GLN+BwD5JuKZjecEaNVCAuy256MVaL5BdhQFxrNF+Lv8CWoGJCY4ONY3HzOTOcKjXZqEJgRSOKEG+6/F/oCSAA6No91fSlXUFLHoCZOhRtGRvNTd52E0U3aCaxGwv8fxaiV4j6nTxTeMoEsRMwEiGKKlfE1XEmv0UYaLAEM79jueZtNnLQvrY+Ea0WoBJ/hIyCTRylNqmZZQTyIwQCB72drSsdRY4yQBV7j4x8u9etAmvssWBLMbCykMjSgSGdJvQU+0Z9CXIveWfiH4/Br09Ix4gbaRpb/bsR9m2soKPSEhTeBDaq4x07NVTQ1R3k11vWOlMgUwwDA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793596857; c=relaxed/relaxed;
	bh=GX/7Qy5oyjcT57M0CFfoxm0UI98pxhpQ+pqMh7EeW3Y=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nL0MdU/9l254dBmHzYQpmvP802h6xOwL7PGU5UU9ykV1pyNPBecI4cbQ0+8XQrJ3cGJu5YDCL/gaG0B/gU0L9O1Wo1V8jQw1BEZOdhSPMG07799aKV1fB90UYsez4lT+MuznLRjQelgebg3QixkhNBS0miiL4tV8V9Vmq7y7ybMHzxDBAXE1rYbmz42lUBBKqyco33wdV0FYasKowxLgqRXy3lbjschf8AdGihfH84RQUJaFnU0L9YEC23EO9cXeJ3zO514XImEVVFFmjGv2YfdHH5OdMWjn+FQpU3mqZTw4bc6xYOvv1nvVHpkfx+nkELLy3LVzxl2neJT2Q+mcKw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=KVPQ8Da9; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=pP4kaxkf; dkim-atps=neutral; spf=pass (client-ip=85.215.255.53; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p01-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=KVPQ8Da9;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=pP4kaxkf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p01-ob.smtp.rzone.de (client-ip=85.215.255.53; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJ0R62Blcz2xqh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 16:20:47 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793596824; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=sHjwFNN5AXwtIASS9Zh6wK8LhX40Zzb+N1UrnFTHbtWnfHMr8NfpsV6qAe8Hk+VELy
    hJpR+nyEymPugz0pX2rg48tciTf9VRX3IHFXrdIkkj57VJ/I8lTWCFTUvtQVeZfpulaf
    rpxwx+OXkSUQWz+JjVWYaKFvTSpldvJ033YeRftkSPZzFdE6noODbnSYinoTSJnU4BLP
    JPiLkTguCRH9HKkGRu08WD+xZQDvSNDeMsbozDeOwk5HIEMgDvzZKM119oX+crPyKSjL
    Kj7zLFYexuE69CZrxmr368uyDGQJk4ugo2oUyfus60aIfRsHOdPYPOsyBqVxf1JAE1+d
    Ixkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793596824;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=GX/7Qy5oyjcT57M0CFfoxm0UI98pxhpQ+pqMh7EeW3Y=;
    b=U4J82InD3ogW8wExiV59D0BvoupHY2fyugpHxYdMJ/lBPvSdUrYr1ZFy/LJ728D0bX
    4+TmeTQ53OkryeJN60tmu85Ifx9YPeJOuWdmaPPFAP8CmBImxUmvvpOtgIDWDw3geS8G
    UQMfe4Kksd5x6aeclzg4i0ZvWsYI+PDn/cMN2JG148t3kkv84y8YggeWq9R1FqbWkGTz
    B9RgaUiGQF2o+x7OuY1BSwCB9WKQNT8ZOr+BPbfogQR68gtkntAXLvXFHebwz3JdAlRx
    arb3qTbPaJHW6TVVYL5WToIx6H9gZ7B93vhsWHQd7PG5bvPRt7CwJreDLne9Bo0JBqcX
    MrGg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793596824;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=GX/7Qy5oyjcT57M0CFfoxm0UI98pxhpQ+pqMh7EeW3Y=;
    b=KVPQ8Da9re2V9w5r+srslIWwt+0063BF7TBK6INsDoeXM0+4tbn1Q1FH3V9P+JyCTt
    biyqpv60Q59vwMCeEyyuoOZkZeRs+WShynVQU2mMyQidr3IIz31gZ12RQ9UOpcVD0ssL
    VI5NiDAx+BU8TEcPE6iTd21OqWXEA//6njWzHeeNZfvTs0wXusnBPUfqmkFltldLAOJv
    mDvLRWaP8Jexbam2T/PuBHJpox+uo0BLKc0aBZNSyyQZXOy+6LHWvqseJVpf0Co2Yrzk
    nmphXEwjQjeKDwgI9IcLZsDsljd36Qn1ewxJCL9+em9EB9JZM+MQKAV+4Y2G5uMV5FHw
    pfbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793596824;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=GX/7Qy5oyjcT57M0CFfoxm0UI98pxhpQ+pqMh7EeW3Y=;
    b=pP4kaxkfDJOeo5xHE9ORcqg1jAnU1cLEBlO6YggjZCF2iDMH9ld3uTOtwhvRXUaj51
    TqjjpV3dSLESwxvf15AA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIy+g7Hc="
Received: from void-ppc.a-eon.tld
    by smtp.strato.de (RZmta 55.6.3 DYNA|AUTH)
    with ESMTPSA id e825d92A25KNAF6
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 2 Nov 2026 06:20:23 +0100 (CET)
Subject: Re: [PATCH] powerpc/pasemi: Defer Nemo IRQ initialization
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, maddy@linux.ibm.com,
 mpe@ellerman.id.au
Cc: npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
 Christian Zigotzky A-EON Open Source <info@xenosoft.de>,
 Darren Stevens <darren@stevens-zone.net>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Damien Stewart <hypexed@yahoo.com.au>, mad skateman <madskateman@gmail.com>
References: <20261024075519.18877-1-chzigotzky@xenosoft.de>
 <zevr6h46.ritesh.list@gmail.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Organization: A-EON Open Source
Message-ID: <1f7cd06f-9364-e5da-b65d-7282fc9af03e@xenosoft.de>
Date: Mon, 2 Nov 2026 06:20:23 +0100
X-Mailer: BrassMonkey/35.0.2
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
MIME-Version: 1.0
In-Reply-To: <zevr6h46.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/02/2026 04:34 AM, Ritesh Harjani (IBM) wrote:
> chzigotzky@xenosoft.de writes:
>
>> From: Christian Zigotzky A-EON Open Source <info@xenosoft.de>
>>
>> Since pas_pci_init() is now called later during boot, the i8259
>> initialization in pas_init_IRQ() happens too early and accesses
>> registers that are not yet mapped, preventing the board from booting.
>>
>> Move the Nemo-specific i8259 initialization to pas_add_bridge(),
>> after the ISA bridge has been discovered.
>
> That make sense to me. The patch looks good. However, shouldn't we also
> add Fixes tag and Cc: stable tag - so that this gets backported to older
> stable kernels.
>
>
> Fixes: c144bc719234 ("powerpc/pasemi: Move PHB discovery")
> Cc: stable@vger.kernel.org
>
> I think the fixes tag should be above - but feel free to correct that.
>
> Otherwise looks good to me. Feel free to add:
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>
Great! Just for info. I don't need this patch for the stable long-term 
kernel 5.10 but it is at least necessary for the stable long-term 
kernels 6.12 [1] and 6.18.

- Christian

[1] 
https://raw.githubusercontent.com/chzigotzky/kernels/refs/heads/6_12/patches/X1000/pas_pci_init_v6.patch
>> Suggested-by: Darren Stevens <darren@stevens-zone.net>
>> Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
>> Signed-off-by: Christian Zigotzky A-EON Open Source <info@xenosoft.de>
>> ---
>>   arch/powerpc/platforms/pasemi/pasemi.h |  6 ++++++
>>   arch/powerpc/platforms/pasemi/pci.c    |  5 +++++
>>   arch/powerpc/platforms/pasemi/setup.c  | 12 ++++--------
>>   3 files changed, 15 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/pasemi/pasemi.h b/arch/powerpc/platforms/pasemi/pasemi.h
>> index 6f6743b8e48d..01bcfa258625 100644
>> --- a/arch/powerpc/platforms/pasemi/pasemi.h
>> +++ b/arch/powerpc/platforms/pasemi/pasemi.h
>> @@ -7,6 +7,12 @@ extern void pas_pci_init(void);
>>   struct pci_dev;
>>   extern void pas_pci_dma_dev_setup(struct pci_dev *dev);
>>   
>> +#ifdef CONFIG_PPC_PASEMI_NEMO
>> +void __init nemo_init_IRQ(void);
>> +#else
>> +static inline void __init nemo_init_IRQ(void) { }
>> +#endif
>> +
>>   void __iomem *__init pasemi_pci_getcfgaddr(struct pci_dev *dev, int offset);
>>   
>>   extern void __init pasemi_map_registers(void);
>> diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
>> index 2df955274652..fb53782da7ec 100644
>> --- a/arch/powerpc/platforms/pasemi/pci.c
>> +++ b/arch/powerpc/platforms/pasemi/pci.c
>> @@ -265,6 +265,11 @@ static int __init pas_add_bridge(struct device_node *dev)
>>   	 */
>>   	isa_bridge_find_early(hose);
>>   
>> +	/*
>> +	 * ISA bridge is now active, add the i8259 cascade (if needed)
>> +	 */
>> +	nemo_init_IRQ();
>> +
>>   	return 0;
>>   }
>>   
>> diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
>> index 45792ecd5dfd..7a961f2a228f 100644
>> --- a/arch/powerpc/platforms/pasemi/setup.c
>> +++ b/arch/powerpc/platforms/pasemi/setup.c
>> @@ -216,10 +216,12 @@ static void sb600_8259_cascade(struct irq_desc *desc)
>>   	chip->irq_eoi(&desc->irq_data);
>>   }
>>   
>> -static void __init nemo_init_IRQ(struct mpic *mpic)
>> +void __init nemo_init_IRQ(void)
>>   {
>>   	struct device_node *np;
>>   	int gpio_virq;
>> +	struct mpic *mpic;
>> +
>>   	/* Connect the SB600's legacy i8259 controller */
>>   	np = of_find_node_by_path("/pxp@0,e0000000");
>>   	i8259_init(np, 0);
>> @@ -230,14 +232,10 @@ static void __init nemo_init_IRQ(struct mpic *mpic)
>>   	irq_set_chained_handler(gpio_virq, sb600_8259_cascade);
>>   	mpic_unmask_irq(irq_get_irq_data(gpio_virq));
>>   
>> +	mpic = irq_get_chip_data(gpio_virq);
>>   	irq_set_default_domain(mpic->irqhost);
>>   }
>>   
>> -#else
>> -
>> -static inline void nemo_init_IRQ(struct mpic *mpic)
>> -{
>> -}
>>   #endif
>>   
>>   static __init void pas_init_IRQ(void)
>> @@ -300,8 +298,6 @@ static __init void pas_init_IRQ(void)
>>   		mpic_unmask_irq(irq_get_irq_data(nmi_virq));
>>   	}
>>   
>> -	nemo_init_IRQ(mpic);
>> -
>>   	of_node_put(mpic_node);
>>   	of_node_put(root);
>>   }
>> -- 
>> 2.43.0


-- 
Sent with BrassMonkey 35.0.2 (https://github.com/chzigotzky/Web-Browsers-and-Suites-for-Linux-PPC/releases/tag/BrassMonkey_35.0.2)


