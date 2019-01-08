Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047F4C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 12:23:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FB97206BB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 12:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB97206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43YryB5d2gzDqS7
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 23:23:14 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Yrw946trzDqRq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 23:21:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43Yrw932NDz8sX0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 23:21:29 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43Yrw92J4Jz9sMQ; Tue,  8 Jan 2019 23:21:29 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43Yrw85hk8z9sBQ
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2019 23:21:28 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43Yrw44rQlz9v0Nk;
 Tue,  8 Jan 2019 13:21:24 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id RGNil0h2eiW4; Tue,  8 Jan 2019 13:21:24 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43Yrw44HVfz9v0DS;
 Tue,  8 Jan 2019 13:21:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id CB7CD8B7E2;
 Tue,  8 Jan 2019 13:21:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id ixUsLJ9xgnsS; Tue,  8 Jan 2019 13:21:25 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 036118B7DF;
 Tue,  8 Jan 2019 13:21:24 +0100 (CET)
Subject: Re: [PATCH 2/2] powerpc: Show PAGE_SIZE in __die() output
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <20190108120500.2547-1-mpe@ellerman.id.au>
 <20190108120500.2547-2-mpe@ellerman.id.au>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <324827d2-b736-5726-76d7-3ece152a30cd@c-s.fr>
Date: Tue, 8 Jan 2019 13:21:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190108120500.2547-2-mpe@ellerman.id.au>
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



Le 08/01/2019 à 13:05, Michael Ellerman a écrit :
> The page size the kernel is built with is useful info when debugging a
> crash, so add it to the output in __die().
> 
> Result looks like eg:
> 
>    kernel BUG at drivers/misc/lkdtm/bugs.c:63!
>    Oops: Exception in kernel mode, sig: 5 [#1]
>    LE PAGE_SIZE=64K SMP NR_CPUS=2048 NUMA pSeries
>    Modules linked in: vmx_crypto kvm binfmt_misc ip_tables
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>   arch/powerpc/kernel/traps.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 431a86d3f772..fc972e4eee5f 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -268,6 +268,18 @@ static int __die(const char *str, struct pt_regs *regs, long err)
>   	else
>   		seq_buf_puts(&s, "BE ");
>   
> +	seq_buf_puts(&s, "PAGE_SIZE=");
> +	if (IS_ENABLED(CONFIG_PPC_4K_PAGES))
> +		seq_buf_puts(&s, "4K ");
> +	else if (IS_ENABLED(CONFIG_PPC_16K_PAGES))
> +		seq_buf_puts(&s, "16K ");
> +	else if (IS_ENABLED(CONFIG_PPC_64K_PAGES))
> +		seq_buf_puts(&s, "64K ");
> +	else if (IS_ENABLED(CONFIG_PPC_256K_PAGES))
> +		seq_buf_puts(&s, "256K ");

Can't we build all the above at once using PAGE_SHIFT ?

Something like (untested):

"%dK ", 1 << (PAGE_SHIFT - 10)

Christophe

> +	else
> +		BUILD_BUG_ON(1);
> +
>   	if (IS_ENABLED(CONFIG_PREEMPT))
>   		seq_buf_puts(&s, "PREEMPT ");
>   
> 
