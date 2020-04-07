Return-Path: <SRS0=EQUS=5X=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21323C2BA16
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2020 06:01:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFF3E2051A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2020 06:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="f4HWt7Or"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF3E2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48xGxL6KGyzDqN7
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2020 16:01:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.a=rsa-sha256
 header.s=mail header.b=f4HWt7Or; dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48xGb83QKbzDr3h
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Apr 2020 15:45:24 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 48xGb44KkWz9tyl1;
 Tue,  7 Apr 2020 07:45:20 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=f4HWt7Or; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id aOlQcO2TMTV4; Tue,  7 Apr 2020 07:45:20 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 48xGb42vgyz9tyl0;
 Tue,  7 Apr 2020 07:45:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1586238320; bh=/FbVZl2qNswYiJjAQeF9V7X9sWcfutdPc4E6CnADDl8=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=f4HWt7OrSa6KjKTRQGRZJLqGSfIscMXlCZMSh79ELCD64qNDpp/uLTwZauZCudYL2
 GQnB23ddAULDTTJrSiLMRhiWrzw/slNeXwWT6DclL/4WcfMOSRSypGnXE0zOs13N7G
 BO5mRaksYRxKTCK1vTpliEy+OXLwFJ6xpWzz9Nho=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 16E008B76E;
 Tue,  7 Apr 2020 07:45:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id qrgIT9dyeboy; Tue,  7 Apr 2020 07:45:21 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 197868B75E;
 Tue,  7 Apr 2020 07:45:20 +0200 (CEST)
Subject: Re: [PATCH v3 12/15] powerpc: ftrace_enabled helper
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20200407051636.648369-1-npiggin@gmail.com>
 <20200407051636.648369-13-npiggin@gmail.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <71b09f76-2cba-4aa5-34d7-e10bdd681f57@c-s.fr>
Date: Tue, 7 Apr 2020 07:45:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200407051636.648369-13-npiggin@gmail.com>
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
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 07/04/2020 à 07:16, Nicholas Piggin a écrit :
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>


> ---
>   arch/powerpc/include/asm/ftrace.h | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
> index f54a08a2cd70..bc76970b6ee5 100644
> --- a/arch/powerpc/include/asm/ftrace.h
> +++ b/arch/powerpc/include/asm/ftrace.h
> @@ -108,9 +108,23 @@ static inline void this_cpu_enable_ftrace(void)
>   {
>   	get_paca()->ftrace_enabled = 1;
>   }
> +
> +/* Disable ftrace on this CPU if possible (may not be implemented) */
> +static inline void this_cpu_set_ftrace_enabled(u8 ftrace_enabled)
> +{
> +	get_paca()->ftrace_enabled = ftrace_enabled;
> +}
> +
> +static inline u8 this_cpu_get_ftrace_enabled(void)
> +{
> +	return get_paca()->ftrace_enabled;
> +}
> +
>   #else /* CONFIG_PPC64 */
>   static inline void this_cpu_disable_ftrace(void) { }
>   static inline void this_cpu_enable_ftrace(void) { }
> +static inline void this_cpu_set_ftrace_enabled(u8 ftrace_enabled) { }
> +static inline u8 this_cpu_get_ftrace_enabled(void) { return 1; }
>   #endif /* CONFIG_PPC64 */
>   #endif /* !__ASSEMBLY__ */
>   
> 
