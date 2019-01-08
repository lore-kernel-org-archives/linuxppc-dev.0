Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5CBC43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 12:20:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E147C206B7
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 12:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E147C206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Yrv76XNRzDqV7
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 23:20:35 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43YrrL4kgfzDqRp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 23:18:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43YrrL3L88z8tRJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 23:18:10 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43YrrL2yqGz9sMM; Tue,  8 Jan 2019 23:18:10 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43YrrK6FjNz9sBQ
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2019 23:18:09 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43YrrF5Lx3z9v0L4;
 Tue,  8 Jan 2019 13:18:05 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id z4u8MhO1ofuF; Tue,  8 Jan 2019 13:18:05 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43YrrF4mrxz9v0L3;
 Tue,  8 Jan 2019 13:18:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D4D948B7E1;
 Tue,  8 Jan 2019 13:18:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id LU23fYc-yFox; Tue,  8 Jan 2019 13:18:06 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id ED6BB8B7DF;
 Tue,  8 Jan 2019 13:18:05 +0100 (CET)
Subject: Re: [PATCH 1/2] powerpc: Use seq_buf to avoid pr_cont() in __die()
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <20190108120500.2547-1-mpe@ellerman.id.au>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <53b82835-630a-beb9-8a4e-5badc07960c9@c-s.fr>
Date: Tue, 8 Jan 2019 13:18:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190108120500.2547-1-mpe@ellerman.id.au>
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



Le 08/01/2019 à 13:04, Michael Ellerman a écrit :
> Using pr_cont() risks having our output interleaved with other output
> from other CPUs. Instead use a seq_buf to construct the line and then
> print it as a whole.

Why not simply doing a single printk() or similar on the same model as 
X86 for instance ? 
(https://elixir.bootlin.com/linux/v5.0-rc1/source/arch/x86/kernel/dumpstack.c#L368)

Christophe

> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>   arch/powerpc/kernel/traps.c | 23 ++++++++++++++++-------
>   1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 64936b60d521..431a86d3f772 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -38,6 +38,7 @@
>   #include <linux/kdebug.h>
>   #include <linux/ratelimit.h>
>   #include <linux/context_tracking.h>
> +#include <linux/seq_buf.h>
>   #include <linux/smp.h>
>   #include <linux/console.h>
>   #include <linux/kmsg_dump.h>
> @@ -255,26 +256,34 @@ NOKPROBE_SYMBOL(oops_end);
>   
>   static int __die(const char *str, struct pt_regs *regs, long err)
>   {
> +	char buf[128]; /* enough for all flags and a long platform name */
> +	struct seq_buf s;
> +
> +	seq_buf_init(&s, buf, sizeof(buf));
> +
>   	printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
>   
>   	if (IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN))
> -		printk("LE ");
> +		seq_buf_puts(&s, "LE ");
>   	else
> -		printk("BE ");
> +		seq_buf_puts(&s, "BE ");
>   
>   	if (IS_ENABLED(CONFIG_PREEMPT))
> -		pr_cont("PREEMPT ");
> +		seq_buf_puts(&s, "PREEMPT ");
>   
>   	if (IS_ENABLED(CONFIG_SMP))
> -		pr_cont("SMP NR_CPUS=%d ", NR_CPUS);
> +		seq_buf_printf(&s, "SMP NR_CPUS=%d ", NR_CPUS);
>   
>   	if (debug_pagealloc_enabled())
> -		pr_cont("DEBUG_PAGEALLOC ");
> +		seq_buf_puts(&s, "DEBUG_PAGEALLOC ");
>   
>   	if (IS_ENABLED(CONFIG_NUMA))
> -		pr_cont("NUMA ");
> +		seq_buf_puts(&s, "NUMA ");
> +
> +	if (ppc_md.name)
> +		seq_buf_puts(&s, ppc_md.name);
>   
> -	pr_cont("%s\n", ppc_md.name ? ppc_md.name : "");
> +	printk("%s\n", buf);
>   
>   	if (notify_die(DIE_OOPS, str, regs, err, 255, SIGSEGV) == NOTIFY_STOP)
>   		return 1;
> 
