Return-Path: <SRS0=pFgb=LF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2535C4743D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jun 2021 06:04:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B19560E08
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jun 2021 06:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B19560E08
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G1VfF6ZJkz3c2c
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jun 2021 16:04:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G1Vdt69Rcz303H
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jun 2021 16:03:46 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4G1Vdp5s2fzBDn9;
 Fri, 11 Jun 2021 08:03:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O073bCl2e0pq; Fri, 11 Jun 2021 08:03:42 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4G1Vdp4wD0z9xF5;
 Fri, 11 Jun 2021 08:03:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 98D458B82C;
 Fri, 11 Jun 2021 08:03:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id ax2RHWfUqtTH; Fri, 11 Jun 2021 08:03:42 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 395E58B765;
 Fri, 11 Jun 2021 08:03:42 +0200 (CEST)
Subject: Re: [PATCH] powerpc/tau: Remove redundant parameter in
 alloc_workqueue() call
To: Finn Thain <fthain@linux-m68k.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
References: <4af6a7138fbd400e458352f6b384115f4adc4301.1623380367.git.fthain@linux-m68k.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <c3824489-2f36-7b4c-e306-0c91b52e9c26@csgroup.eu>
Date: Fri, 11 Jun 2021 08:03:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <4af6a7138fbd400e458352f6b384115f4adc4301.1623380367.git.fthain@linux-m68k.org>
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

Redundant with what ?

Do you mean superfluous ?

Le 11/06/2021 à 04:59, Finn Thain a écrit :
> This avoids an (optional) compiler warning:
> 
> arch/powerpc/kernel/tau_6xx.c: In function 'TAU_init':
> arch/powerpc/kernel/tau_6xx.c:204:30: error: too many arguments for format [-Werror=format-extra-args]
>    tau_workq = alloc_workqueue("tau", WQ_UNBOUND, 1, 0);
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Fixes: b1c6a0a10bfa ("powerpc/tau: Convert from timer to workqueue")
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>   arch/powerpc/kernel/tau_6xx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/tau_6xx.c b/arch/powerpc/kernel/tau_6xx.c
> index 6c31af7f4fa8..b9a047d92ec0 100644
> --- a/arch/powerpc/kernel/tau_6xx.c
> +++ b/arch/powerpc/kernel/tau_6xx.c
> @@ -201,7 +201,7 @@ static int __init TAU_init(void)
>   	tau_int_enable = IS_ENABLED(CONFIG_TAU_INT) &&
>   			 !strcmp(cur_cpu_spec->platform, "ppc750");
>   
> -	tau_workq = alloc_workqueue("tau", WQ_UNBOUND, 1, 0);
> +	tau_workq = alloc_workqueue("tau", WQ_UNBOUND, 1);
>   	if (!tau_workq)
>   		return -ENOMEM;
>   
> 
