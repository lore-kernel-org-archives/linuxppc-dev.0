Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D907C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 13:42:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7874D20879
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 13:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7874D20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43b6cy6sFhzDqBs
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 00:42:42 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43b6Zh3RgRzDqgs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 00:40:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43b6Zh1ggPz8tQ2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 00:40:44 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43b6Zh0HW8z9sMp; Fri, 11 Jan 2019 00:40:44 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43b6Zg19bjz9sN8
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2019 00:40:42 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43b6ZZ3SVwz9v11t;
 Thu, 10 Jan 2019 14:40:38 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 370v5E7IE0PB; Thu, 10 Jan 2019 14:40:38 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43b6ZZ2wHFz9v11m;
 Thu, 10 Jan 2019 14:40:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C45D78B87D;
 Thu, 10 Jan 2019 14:40:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id e4DQonWdtiJq; Thu, 10 Jan 2019 14:40:39 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E66948B88F;
 Thu, 10 Jan 2019 14:40:37 +0100 (CET)
Subject: Re: [PATCH v2 1/3] powerpc: Stop using pr_cont() in __die()
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <20190110115737.30931-1-mpe@ellerman.id.au>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <996253a4-3deb-c320-f78a-15c8de261217@c-s.fr>
Date: Thu, 10 Jan 2019 14:40:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190110115737.30931-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 10/01/2019 à 12:57, Michael Ellerman a écrit :
> Using pr_cont() risks having our output interleaved with other output
> from other CPUs. Instead print everything in a single printk() call.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
>   arch/powerpc/kernel/traps.c | 26 ++++++++------------------
>   1 file changed, 8 insertions(+), 18 deletions(-)
> 
> v2: Use a single printk with (mostly) compile time checks rather than
> constructing the string with seq_buf.
> 
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 64936b60d521..164fc92895be 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -257,24 +257,14 @@ static int __die(const char *str, struct pt_regs *regs, long err)
>   {
>   	printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);

Maybe this printk() should also be merge with the following to further 
limit risks of interleaving ?

Christophe

>   
> -	if (IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN))
> -		printk("LE ");
> -	else
> -		printk("BE ");
> -
> -	if (IS_ENABLED(CONFIG_PREEMPT))
> -		pr_cont("PREEMPT ");
> -
> -	if (IS_ENABLED(CONFIG_SMP))
> -		pr_cont("SMP NR_CPUS=%d ", NR_CPUS);
> -
> -	if (debug_pagealloc_enabled())
> -		pr_cont("DEBUG_PAGEALLOC ");
> -
> -	if (IS_ENABLED(CONFIG_NUMA))
> -		pr_cont("NUMA ");
> -
> -	pr_cont("%s\n", ppc_md.name ? ppc_md.name : "");
> +	printk("%s %s%s%s%s%s %s\n",
> +	       IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN) ? "LE" : "BE",
> +	       IS_ENABLED(CONFIG_PREEMPT) ? " PREEMPT" : "",
> +	       IS_ENABLED(CONFIG_SMP) ? " SMP" : "",
> +	       IS_ENABLED(CONFIG_SMP) ? (" NR_CPUS=" __stringify(NR_CPUS)) : "",
> +	       debug_pagealloc_enabled() ? " DEBUG_PAGEALLOC" : "",
> +	       IS_ENABLED(CONFIG_NUMA) ? " NUMA" : "",
> +	       ppc_md.name ? ppc_md.name : "");
>   
>   	if (notify_die(DIE_OOPS, str, regs, err, 255, SIGSEGV) == NOTIFY_STOP)
>   		return 1;
> 
