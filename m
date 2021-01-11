Return-Path: <SRS0=L4S4=GO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2951EC433DB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Jan 2021 16:45:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A2C52242A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Jan 2021 16:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2C52242A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DF02J6bMfzDqs3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Jan 2021 03:45:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DDzzs0MdXzDqR0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2021 03:43:30 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4DDzzV71Z3z9tySH;
 Mon, 11 Jan 2021 17:43:18 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 4TE2AUabVSHM; Mon, 11 Jan 2021 17:43:18 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4DDzzV67CGz9tySG;
 Mon, 11 Jan 2021 17:43:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A1E1F8B79D;
 Mon, 11 Jan 2021 17:43:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id zAXdc398vnxx; Mon, 11 Jan 2021 17:43:24 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1E32C8B79C;
 Mon, 11 Jan 2021 17:43:24 +0100 (CET)
Subject: Re: [PATCH] powerpc/vdso: fix clock_gettime_fallback for vdso32
To: Andreas Schwab <schwab@linux-m68k.org>, linuxppc-dev@lists.ozlabs.org
References: <87eeirsdr8.fsf@igel.home>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <a703eaa2-178f-02b3-8206-b200b6bf1f35@csgroup.eu>
Date: Mon, 11 Jan 2021 17:43:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87eeirsdr8.fsf@igel.home>
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
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 11/01/2021 à 16:18, Andreas Schwab a écrit :
> The second argument of __kernel_clock_gettime64 points to a struct
> __kernel_timespec, with 64-bit time_t, so use the clock_gettime64 syscall
> in the fallback function for the 32-bit vdso.  Similarily,
> clock_getres_fallback should use the clock_getres_time64 syscall, though
> it isn't yet called from the 32-bit vdso.
> 
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>

Fixes: d0e3fc69d00d ("powerpc/vdso: Provide __kernel_clock_gettime64() on vdso32")

> ---
>   arch/powerpc/include/asm/vdso/gettimeofday.h | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/vdso/gettimeofday.h b/arch/powerpc/include/asm/vdso/gettimeofday.h
> index 81671aa365b3..a26c12df2c9a 100644
> --- a/arch/powerpc/include/asm/vdso/gettimeofday.h
> +++ b/arch/powerpc/include/asm/vdso/gettimeofday.h
> @@ -106,13 +106,21 @@ int gettimeofday_fallback(struct __kernel_old_timeval *_tv, struct timezone *_tz
>   static __always_inline
>   int clock_gettime_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
>   {
> +#ifndef __powerpc64__

I think we should do like x86, create a second version of clock_gettime_fallback() inside the #ifdef 
CONFIG_VDSO32, and move that one in a matching (non existing yet) #else

> +	return do_syscall_2(__NR_clock_gettime64, _clkid, (unsigned long)_ts);
> +#else
>   	return do_syscall_2(__NR_clock_gettime, _clkid, (unsigned long)_ts);
> +#endif
>   }
>   
>   static __always_inline
>   int clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
>   {
> +#ifndef __powerpc64__

Same.

> +	return do_syscall_2(__NR_clock_getres_time64, _clkid, (unsigned long)_ts);
> +#else
>   	return do_syscall_2(__NR_clock_getres, _clkid, (unsigned long)_ts);
> +#endif
>   }
>   
>   #ifdef CONFIG_VDSO32
> 

Christophe
