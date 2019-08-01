Return-Path: <SRS0=4G4N=V5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BE1C19759
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Aug 2019 11:00:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C5DD206A2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Aug 2019 11:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C5DD206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45znQH3dPLzDqsx
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Aug 2019 21:00:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=178.33.251.175; helo=3.mo179.mail-out.ovh.net;
 envelope-from=groug@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 4198 seconds by postgrey-1.36 at bilbo;
 Thu, 01 Aug 2019 20:58:56 AEST
Received: from 3.mo179.mail-out.ovh.net (3.mo179.mail-out.ovh.net
 [178.33.251.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45znNJ4FnWzDqrC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Aug 2019 20:58:55 +1000 (AEST)
Received: from player778.ha.ovh.net (unknown [10.108.54.74])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 4C0E413D42F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Aug 2019 11:41:43 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player778.ha.ovh.net (Postfix) with ESMTPSA id 5D8AE873BBDD;
 Thu,  1 Aug 2019 09:41:33 +0000 (UTC)
Date: Thu, 1 Aug 2019 11:41:32 +0200
From: Greg Kurz <groug@kaod.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 2/2] powerpc/xive: Add a check for memory allocation
 failure
Message-ID: <20190801114132.4c1db5be@bahia.lan>
In-Reply-To: <cc53462734dfeaf15b6bad0e626b483de18656b4.1564647619.git.christophe.jaillet@wanadoo.fr>
References: <cover.1564647619.git.christophe.jaillet@wanadoo.fr>
 <cc53462734dfeaf15b6bad0e626b483de18656b4.1564647619.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 12958826454390118683
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrleejgddukecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 paulus@samba.org, clg@kaod.org, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, allison@lohutok.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu,  1 Aug 2019 10:32:42 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> The result of this kzalloc is not checked. Add a check and corresponding
> error handling code.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

> Note that 'xive_irq_bitmap_add()' failures are not handled in
> 'xive_spapr_init()'
> I guess that it is not really an issue. This function is _init, so if a
> memory allocation occures here, it is likely that the system will
> already be in bad shape.

Hmm not sure... The allocation could also fail if the "ibm,xive-lisn-ranges"
property contains an insanely big range, eg. count == 1 << 31. The system isn't
necessarily in bad shape in this case, but XIVE is definitely unusable and
we should let a chance to the kernel to switch to XICS in this case.

I guess it is worth adding proper error handling in xive_spapr_init() as well.

> Anyway, the check added here would at least keep the data linked in
> 'xive_irq_bitmaps' usable.
> ---
>  arch/powerpc/sysdev/xive/spapr.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
> index b4f5eb9e0f82..52198131c75e 100644
> --- a/arch/powerpc/sysdev/xive/spapr.c
> +++ b/arch/powerpc/sysdev/xive/spapr.c
> @@ -53,6 +53,10 @@ static int xive_irq_bitmap_add(int base, int count)
>  	xibm->base = base;
>  	xibm->count = count;
>  	xibm->bitmap = kzalloc(xibm->count, GFP_KERNEL);
> +	if (!xibm->bitmap) {
> +		kfree(xibm);
> +		return -ENOMEM;
> +	}
>  	list_add(&xibm->list, &xive_irq_bitmaps);
>  
>  	pr_info("Using IRQ range [%x-%x]", xibm->base,

