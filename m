Return-Path: <SRS0=wNeI=O2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE747C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 12:30:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EC2B206A2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 12:30:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC2B206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43JL8x4xTBzDqMP
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 23:30:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43JL6L5mpzzDqHx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Dec 2018 23:28:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43JL6L30wlz9s4s;
 Mon, 17 Dec 2018 23:28:26 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2] powerpc/mm: make NULL pointer deferences explicit on
 bad page faults.
In-Reply-To: <46e2533084dc3255a1d67553b682bd4b9642b176.1544800765.git.christophe.leroy@c-s.fr>
References: <46e2533084dc3255a1d67553b682bd4b9642b176.1544800765.git.christophe.leroy@c-s.fr>
Date: Mon, 17 Dec 2018 23:28:19 +1100
Message-ID: <87mup4tk0s.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 01b9bcc7fa85..3398291f4785 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -636,21 +636,24 @@ void bad_page_fault(struct pt_regs *regs, unsigned long address, int sig)
>  	switch (TRAP(regs)) {
>  	case 0x300:
>  	case 0x380:
> -		printk(KERN_ALERT "Unable to handle kernel paging request for "
> -			"data at address 0x%08lx\n", regs->dar);
> +		if (regs->dar < PAGE_SIZE)
> +			pr_alert("BUG: Kernel NULL pointer dereference");
> +		else
> +			pr_alert("BUG: Unable to handle kernel data access");
> +		pr_cont(" at 0x%08lx\n", regs->dar);

It's best to avoid pr_cont() as it can lead to interleaving, so I
rewrote this as:

		pr_alert("BUG: %s at 0x%08lx\n",
			 regs->dar < PAGE_SIZE ? "Kernel NULL pointer dereference" :
			 "Unable to handle kernel data access", regs->dar);


>  		break;
>  	case 0x400:
>  	case 0x480:
> -		printk(KERN_ALERT "Unable to handle kernel paging request for "
> -			"instruction fetch\n");
> +		pr_alert("BUG: Unable to handle kernel instruction fetch%s",
> +			 regs->nip < PAGE_SIZE ? " (NULL pointer ?)\n" : "\n");
                                       I dropped the space here ^


cheers
