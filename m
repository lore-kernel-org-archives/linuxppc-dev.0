Return-Path: <SRS0=D1of=QG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AA1C282D4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 08:10:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E353921873
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 08:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="sYKzP3rw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E353921873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qGJD5JfqzDqTN
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 19:10:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="sYKzP3rw"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qGGH0s1KzDqQH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 19:08:39 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43qGG83L6vz9v0wX;
 Wed, 30 Jan 2019 09:08:32 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=sYKzP3rw; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id QG24T4PNc8TU; Wed, 30 Jan 2019 09:08:32 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43qGG82G3Vz9v0wS;
 Wed, 30 Jan 2019 09:08:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548835712; bh=9vW9OR0z4S58IqvSQCrbKbsZWtlNhKwNlQ9D3jbIex4=;
 h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
 b=sYKzP3rwYPZCGGi4Q6vyE1KvBlBGPwVwckOTPW7Kx89Lj92jYTiOn5NEne+AL37Qx
 HqFO+TfvvPvd/yruWo5s8Sdx2ynVSEg+Gapx5pZLtu1Qvx8hgC1nkQWHHqz7RJ5IKY
 ez6UsJhppEcCEZd7RsYBlQgTQm0oAh8JqCV/P4B4=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 446A78B7EB;
 Wed, 30 Jan 2019 09:08:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id j1GNqgnD3Ty5; Wed, 30 Jan 2019 09:08:33 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1EDA18B755;
 Wed, 30 Jan 2019 09:08:33 +0100 (CET)
Subject: Re: [PATCH v14 01/12] powerpc/32: Fix
 CONFIG_VIRT_CPU_ACCOUNTING_NATIVE for 40x/booke
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Mike Rapoport <rppt@linux.ibm.com>
References: <cover.1548346225.git.christophe.leroy@c-s.fr>
 <90ef676a0fba977259221d95dd8ffd1117f963f3.1548346225.git.christophe.leroy@c-s.fr>
Message-ID: <9d1db23c-4a5b-6dcb-7cfe-f743a5f053db@c-s.fr>
Date: Wed, 30 Jan 2019 09:08:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <90ef676a0fba977259221d95dd8ffd1117f963f3.1548346225.git.christophe.leroy@c-s.fr>
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
Cc: Mark Rutland <mark.rutland@arm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 24/01/2019 à 17:19, Christophe Leroy a écrit :
> 40x/booke have another path to reach 3f from transfer_to_handler,
> so ACCOUNT_CPU_USER_ENTRY() have to be moved there.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Now ACCOUNT_CPU_USER_ENTRY() is also in the non-user entry path.

This change is crazy, please ignore it :-S

Christophe

> ---
>   arch/powerpc/kernel/entry_32.S | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
> index 0768dfd8a64e..0165edd03b38 100644
> --- a/arch/powerpc/kernel/entry_32.S
> +++ b/arch/powerpc/kernel/entry_32.S
> @@ -185,12 +185,6 @@ transfer_to_handler:
>   	addi	r12,r12,-1
>   	stw	r12,4(r11)
>   #endif
> -#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
> -	CURRENT_THREAD_INFO(r9, r1)
> -	tophys(r9, r9)
> -	ACCOUNT_CPU_USER_ENTRY(r9, r11, r12)
> -#endif
> -
>   	b	3f
>   
>   2:	/* if from kernel, check interrupted DOZE/NAP mode and
> @@ -208,9 +202,14 @@ transfer_to_handler:
>   	bt-	31-TLF_NAPPING,4f
>   	bt-	31-TLF_SLEEPING,7f
>   #endif /* CONFIG_PPC_BOOK3S_32 || CONFIG_E500 */
> +3:
> +#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
> +	CURRENT_THREAD_INFO(r9, r1)
> +	tophys(r9, r9)
> +	ACCOUNT_CPU_USER_ENTRY(r9, r11, r12)
> +#endif
>   	.globl transfer_to_handler_cont
>   transfer_to_handler_cont:
> -3:
>   	mflr	r9
>   	lwz	r11,0(r9)		/* virtual address of handler */
>   	lwz	r9,4(r9)		/* where to go when done */
> 
