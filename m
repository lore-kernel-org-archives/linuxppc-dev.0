Return-Path: <SRS0=JA7W=R5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E6BC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 06:14:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8146C20828
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 06:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="XsOGXmaK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8146C20828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44T17g3L7FzDqG6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 17:14:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="XsOGXmaK"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44T15q5P3gzDqHY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 17:13:19 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44T15l3pJKz9v25V;
 Tue, 26 Mar 2019 07:13:15 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=XsOGXmaK; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id x5ZNmpGQxrMq; Tue, 26 Mar 2019 07:13:15 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44T15l2ZP5z9v25T;
 Tue, 26 Mar 2019 07:13:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553580795; bh=aUmAi91vtAFaIZb6qUCanpVzBvXxG3iUFfovfKRIkhM=;
 h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
 b=XsOGXmaKtMZKvQ8nV9wX1fvebo41wrMeoJcnXtrbtQ3HaEkS2GHO/Bmkb0sbIE9fQ
 50iJBPcd5OcUTPYQyAAvxJNkZbLlepPSsfoV51d9B60MJZ3D4tYXmLuSOtc+5EjYKS
 GJKIJQ0KVVFm1WNfwWMo2+/zEHkKdyotmgWWokRo=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2A51B8B77C;
 Tue, 26 Mar 2019 07:13:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id zrunFgtvlB3M; Tue, 26 Mar 2019 07:13:16 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B3BF18B74C;
 Tue, 26 Mar 2019 07:13:15 +0100 (CET)
Subject: Re: [PATCH 3/7] powerpc/setup: define cpu_pvr at all time
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <a2ac33258063682558fe0cac8eedcbd28aa4a141.1553242059.git.christophe.leroy@c-s.fr>
 <a3188807e85a5e0f8952d3470d9da7504bfd3e14.1553242059.git.christophe.leroy@c-s.fr>
Message-ID: <10494441-fcc3-a01b-4f95-ce39dc1e2dd3@c-s.fr>
Date: Tue, 26 Mar 2019 07:13:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <a3188807e85a5e0f8952d3470d9da7504bfd3e14.1553242059.git.christophe.leroy@c-s.fr>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 22/03/2019 à 09:08, Christophe Leroy a écrit :
> To avoid ifdefs, define cpu_pvr at all time.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

This patch introduces a sparse warning.

I guess we can skip it for now and rework more deeply the use of cpu_pvr 
versus SPRN_PVR which is re-read in many places in the code.

Christophe

> ---
>   arch/powerpc/kernel/setup-common.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index a90e8367ccde..a4ed9301e815 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -190,9 +190,7 @@ void machine_halt(void)
>   	machine_hang();
>   }
>   
> -#ifdef CONFIG_SMP
>   DEFINE_PER_CPU(unsigned int, cpu_pvr);
> -#endif
>   
>   static void show_cpuinfo_summary(struct seq_file *m)
>   {
> @@ -234,11 +232,11 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>   	unsigned short maj;
>   	unsigned short min;
>   
> -#ifdef CONFIG_SMP
> -	pvr = per_cpu(cpu_pvr, cpu_id);
> -#else
> -	pvr = mfspr(SPRN_PVR);
> -#endif
> +	if (IS_ENABLED(CONFIG_SMP))
> +		pvr = per_cpu(cpu_pvr, cpu_id);
> +	else
> +		pvr = mfspr(SPRN_PVR);
> +
>   	maj = (pvr >> 8) & 0xFF;
>   	min = pvr & 0xFF;
>   
> 
