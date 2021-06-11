Return-Path: <SRS0=pFgb=LF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81455C4743D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jun 2021 07:36:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDAFB61364
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jun 2021 07:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDAFB61364
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G1Xhc6Qy6z3c3k
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jun 2021 17:36:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G1XhD3yv7z3034
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jun 2021 17:35:56 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4G1Xh80Qz8zBCKr;
 Fri, 11 Jun 2021 09:35:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u9a0Peq1v63h; Fri, 11 Jun 2021 09:35:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4G1Xh76dGszBCGX;
 Fri, 11 Jun 2021 09:35:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C8BDA8B82C;
 Fri, 11 Jun 2021 09:35:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id gK3cbO8PtkHc; Fri, 11 Jun 2021 09:35:51 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 55EF18B765;
 Fri, 11 Jun 2021 09:35:51 +0200 (CEST)
Subject: Re: [PATCH 2/2] powerpc/tm: Avoid SPR flush if TM is disabled
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
References: <1538423270-17527-1-git-send-email-leitao@debian.org>
 <1538423270-17527-2-git-send-email-leitao@debian.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <72d2aedc-7604-3f46-c5c7-34f11455e8aa@csgroup.eu>
Date: Fri, 11 Jun 2021 09:35:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1538423270-17527-2-git-send-email-leitao@debian.org>
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
Cc: mikey@neuling.org, gromero@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 01/10/2018 à 21:47, Breno Leitao a écrit :
> There is a bug in the flush_tmregs_to_thread() function, where it forces
> TM SPRs to be saved to the thread even if the TM facility is disabled.
> 
> This bug could be reproduced using a simple test case:
> 
>    mtspr(SPRN_TEXASR, XX);
>    sleep until load_tm == 0
>    cause a coredump
>    read SPRN_TEXASR in the coredump
> 
> In this case, the coredump may contain an invalid SPR, because the
> current code is flushing live SPRs (Used by the last thread with TM
> active) into the current thread, overwriting the latest SPRs (which were
> valid).
> 
> This patch checks if TM is enabled for current task before
> saving the SPRs, otherwise, the TM is lazily disabled and the thread
> value is already up-to-date and could be used directly, and saving is
> not required.

If this patch is still applicable, it has to be rebased.


> 
> Fixes: cd63f3cf1d5 ("powerpc/tm: Fix saving of TM SPRs in core dump")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>   arch/powerpc/kernel/ptrace.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> index 9667666eb18e..e0a2ee865032 100644
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c
> @@ -138,7 +138,12 @@ static void flush_tmregs_to_thread(struct task_struct *tsk)
>   
>   	if (MSR_TM_SUSPENDED(mfmsr())) {
>   		tm_reclaim_current(TM_CAUSE_SIGNAL);
> -	} else {
> +	} else if (tm_enabled(tsk)) {
> +		/*
> +		 * Only flush TM SPRs to the thread if TM was enabled,
> +		 * otherwise (TM lazily disabled), the thread already
> +		 * contains the latest SPR value
> +		 */
>   		tm_enable();
>   		tm_save_sprs(&(tsk->thread));
>   	}
> 
