Return-Path: <SRS0=8MIQ=RP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D633EC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 21:08:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DCF6214AE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 21:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="J0hH/exY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DCF6214AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44JndF409dzDqG6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 08:08:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="J0hH/exY"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44JnbT7013zDq9L
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 08:07:01 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44JnbQ3ftMz9tyk6;
 Tue, 12 Mar 2019 22:06:58 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=J0hH/exY; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id z67DVygoNA5z; Tue, 12 Mar 2019 22:06:58 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44JnbQ2NJ4z9tyk5;
 Tue, 12 Mar 2019 22:06:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1552424818; bh=zBYhOEYLXrz7PJI1Po72HlbOH12xnUkoCduJPKrRJmQ=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=J0hH/exY/s5vF5+d4+F/msn0zj+YTfieD1SSNtio+35WR1mqo7TowrF4hIsPrT9b+
 6Zx6yW+c31cwN2b/3eD4lql/ZXZLqkBh5DaTJIEF7ZKq02VWkis6OXpysbR9VXu1Tk
 /iBxzr5ww9MCYJtWvlmD4SQot6lZnqkGTeOEeoFs=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 633118B8B1;
 Tue, 12 Mar 2019 22:06:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id hwek6NOpjogc; Tue, 12 Mar 2019 22:06:58 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 00E548B8A7;
 Tue, 12 Mar 2019 22:06:57 +0100 (CET)
Subject: Re: [PATCH] powerpc/64s: Mark 'dummy_copy_buffer' as used
To: Mathieu Malaterre <malat@debian.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <20190312202921.31331-1-malat@debian.org>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <38359442-e219-18ad-926b-42a6e5ab4e7d@c-s.fr>
Date: Tue, 12 Mar 2019 21:06:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190312202921.31331-1-malat@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 03/12/2019 08:29 PM, Mathieu Malaterre wrote:
> In commit 07d2a628bc00 ("powerpc/64s: Avoid cpabort in context switch
> when possible") a buffer 'dummy_copy_buffer' was introduced. gcc does
> not see this buffer being used in the inline assembly within function
> '__switch_to', explicitly marked this variable as being used.
> 
> Prefer using '__aligned' to get passed line over 80 characters warning
> in checkpatch.

Powerpc accepts 90 characters, use arch/powerpc/tools/checkpatch.sh

> 
> This remove the following warning:
> 
>    arch/powerpc/kernel/process.c:1156:17: error: 'dummy_copy_buffer' defined but not used [-Werror=unused-const-variable=]

commit 2bf1071a8d50 ("powerpc/64s: Remove POWER9 DD1 support") has 
removed the fonction using 'dummy_copy_buffer' so you should remove it 
completely.

Christophe


> 
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>   arch/powerpc/kernel/process.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 77e44275d025..5acf63d45802 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1153,7 +1153,7 @@ static inline void restore_sprs(struct thread_struct *old_thread,
>   
>   #ifdef CONFIG_PPC_BOOK3S_64
>   #define CP_SIZE 128
> -static const u8 dummy_copy_buffer[CP_SIZE] __attribute__((aligned(CP_SIZE)));
> +static const u8 dummy_copy_buffer[CP_SIZE] __aligned(CP_SIZE) __used;
>   #endif
>   
>   struct task_struct *__switch_to(struct task_struct *prev,
> 
