Return-Path: <SRS0=Xeze=HO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BF3C433DB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Feb 2021 17:36:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F60F64D9C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Feb 2021 17:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F60F64D9C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DcgdV1RlDzDwvk
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Feb 2021 04:35:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kaod.org (client-ip=188.165.45.220; helo=5.mo52.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
X-Greylist: delayed 417 seconds by postgrey-1.36 at bilbo;
 Sat, 13 Feb 2021 04:34:16 AEDT
Received: from 5.mo52.mail-out.ovh.net (5.mo52.mail-out.ovh.net
 [188.165.45.220])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DcgbX55l9zDwrx
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Feb 2021 04:34:14 +1100 (AEDT)
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.2])
 by mo52.mail-out.ovh.net (Postfix) with ESMTPS id 88BEB2417B3;
 Fri, 12 Feb 2021 18:27:10 +0100 (CET)
Received: from kaod.org (37.59.142.99) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 12 Feb
 2021 18:27:09 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G003458b0af4-a908-4155-a8a5-638fe7ab923e,
 924A9ABFE736D7433D2D31E3EEE0F14BF3EF610E) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 90.55.29.191
Subject: Re: [PATCH] powerpc/pseries: Don't enforce MSI affinity with kdump
To: Greg Kurz <groug@kaod.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <20210212164132.821332-1-groug@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <cc65e3ba-312a-65df-2b95-c870fe47866e@kaod.org>
Date: Fri, 12 Feb 2021 18:27:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210212164132.821332-1-groug@kaod.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.99]
X-ClientProxiedBy: DAG7EX2.mxp5.local (172.16.2.62) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: b152fbe0-3c72-4360-bb9e-8bb5cbdf721d
X-Ovh-Tracer-Id: 13433674741941046054
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledriedugddutdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefuvfhfhffkffgfgggjtgfgihesthekredttdefheenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeeglefgjeevheeifeffudeuhedvveeftdeliedukeejgeeviefgieefhfdtffeftdenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehgrhhouhhgsehkrghougdrohhrgh
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: lvivier@redhat.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2/12/21 5:41 PM, Greg Kurz wrote:
> Depending on the number of online CPUs in the original kernel, it is
> likely for CPU #0 to be offline in a kdump kernel. The associated IRQs
> in the affinity mappings provided by irq_create_affinity_masks() are
> thus not started by irq_startup(), as per-design with managed IRQs.
> 
> This can be a problem with multi-queue block devices driven by blk-mq :
> such a non-started IRQ is very likely paired with the single queue
> enforced by blk-mq during kdump (see blk_mq_alloc_tag_set()). This
> causes the device to remain silent and likely hangs the guest at
> some point.
> 
> This is a regression caused by commit 9ea69a55b3b9 ("powerpc/pseries:
> Pass MSI affinity to irq_create_mapping()"). Note that this only happens
> with the XIVE interrupt controller because XICS has a workaround to bypass
> affinity, which is activated during kdump with the "noirqdistrib" kernel
> parameter.
> 
> The issue comes from a combination of factors:
> - discrepancy between the number of queues detected by the multi-queue
>   block driver, that was used to create the MSI vectors, and the single
>   queue mode enforced later on by blk-mq because of kdump (i.e. keeping
>   all queues fixes the issue)
> - CPU#0 offline (i.e. kdump always succeed with CPU#0)
> 
> Given that I couldn't reproduce on x86, which seems to always have CPU#0
> online even during kdump, I'm not sure where this should be fixed. Hence
> going for another approach : fine-grained affinity is for performance
> and we don't really care about that during kdump. Simply revert to the
> previous working behavior of ignoring affinity masks in this case only.
> 
> Fixes: 9ea69a55b3b9 ("powerpc/pseries: Pass MSI affinity to irq_create_mapping()")
> Cc: lvivier@redhat.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Greg Kurz <groug@kaod.org>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks for tracking this issue. 

This layer needs a rework. Patches adding a MSI domain should be ready 
in a couple of releases. Hopefully. 

C. 

> ---
>  arch/powerpc/platforms/pseries/msi.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
> index b3ac2455faad..29d04b83288d 100644
> --- a/arch/powerpc/platforms/pseries/msi.c
> +++ b/arch/powerpc/platforms/pseries/msi.c
> @@ -458,8 +458,28 @@ static int rtas_setup_msi_irqs(struct pci_dev *pdev, int nvec_in, int type)
>  			return hwirq;
>  		}
>  
> -		virq = irq_create_mapping_affinity(NULL, hwirq,
> -						   entry->affinity);
> +		/*
> +		 * Depending on the number of online CPUs in the original
> +		 * kernel, it is likely for CPU #0 to be offline in a kdump
> +		 * kernel. The associated IRQs in the affinity mappings
> +		 * provided by irq_create_affinity_masks() are thus not
> +		 * started by irq_startup(), as per-design for managed IRQs.
> +		 * This can be a problem with multi-queue block devices driven
> +		 * by blk-mq : such a non-started IRQ is very likely paired
> +		 * with the single queue enforced by blk-mq during kdump (see
> +		 * blk_mq_alloc_tag_set()). This causes the device to remain
> +		 * silent and likely hangs the guest at some point.
> +		 *
> +		 * We don't really care for fine-grained affinity when doing
> +		 * kdump actually : simply ignore the pre-computed affinity
> +		 * masks in this case and let the default mask with all CPUs
> +		 * be used when creating the IRQ mappings.
> +		 */
> +		if (is_kdump_kernel())
> +			virq = irq_create_mapping(NULL, hwirq);
> +		else
> +			virq = irq_create_mapping_affinity(NULL, hwirq,
> +							   entry->affinity);
>  
>  		if (!virq) {
>  			pr_debug("rtas_msi: Failed mapping hwirq %d\n", hwirq);
> 

