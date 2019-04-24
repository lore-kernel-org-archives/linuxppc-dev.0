Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABBEC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 06:05:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2380420685
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 06:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="EnD590RN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2380420685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pqYh5VVnzDqTv
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 16:05:44 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pqWq5SjSzDqTY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 16:04:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="EnD590RN"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44pqWp6tyWz8tPk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 16:04:06 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 44pqWp5mSnz9s5c; Wed, 24 Apr 2019 16:04:06 +1000 (AEST)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="EnD590RN"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44pqWm0tfDz9s4Y
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Apr 2019 16:04:01 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44pqWb75CJz9v0R3;
 Wed, 24 Apr 2019 08:03:55 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=EnD590RN; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id BI1H-BKWZJL0; Wed, 24 Apr 2019 08:03:55 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44pqWb5Bgrz9v0R1;
 Wed, 24 Apr 2019 08:03:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556085835; bh=sC44C7uZQruPIW4pbCGJqEkDOd9PgMX0qBcc2uFzHSw=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=EnD590RNYTanFTLod+VkYz75oZw58Aa6rXFRPAQ0zo1cpsAmnEnIo1SOCAInUfPwd
 oTLTcAXAdktDGXMF8vZ7+2zDjCE6MAmGQw2+0So96ygoapLEhM/U1ICJahVK5IBZXw
 jzt2cJWbBxLJnA0U58FHNBxmpaaLvwUklayARppk=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9B7468B7A6;
 Wed, 24 Apr 2019 08:03:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id DZNu6jJEvNuu; Wed, 24 Apr 2019 08:03:56 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.6])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 86DB08B79D;
 Wed, 24 Apr 2019 08:03:56 +0200 (CEST)
Subject: Re: [PATCH v6 06/10] powerpc/64: Setup KUP on secondary CPUs
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <20190418065125.2687-1-mpe@ellerman.id.au>
 <20190418065125.2687-6-mpe@ellerman.id.au>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <78310ea2-35ba-6ee6-45e0-cf1937f0c714@c-s.fr>
Date: Wed, 24 Apr 2019 08:03:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418065125.2687-6-mpe@ellerman.id.au>
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



Le 18/04/2019 à 08:51, Michael Ellerman a écrit :
> From: Russell Currey <ruscur@russell.cc>
> 
> Some platforms (i.e. Radix MMU) need per-CPU initialisation for KUP.
> 
> Any platforms that only want to do KUP initialisation once
> globally can just check to see if they're running on the boot CPU, or
> check if whatever setup they need has already been performed.
> 
> Note that this is only for 64-bit.
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
> 
> v6: setup_kup() can't be __init anymore.

As reported by the kbuild robot, then setup_kuap() and setup_kuep() 
can't be __init anymore in that case on the 8xx allthough the 8xx is not 
SMP. That is rather pitty since they are only used at init.

Why can't we keep setup_kup() __init ? Are secondary CPUs started after 
init section has been freed ?

Christophe

> ---
>   arch/powerpc/kernel/setup_64.c | 3 +++
>   arch/powerpc/mm/init-common.c  | 2 +-
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index 6179c4200339..684e34493bf5 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -390,6 +390,9 @@ void early_setup_secondary(void)
>   	/* Initialize the hash table or TLB handling */
>   	early_init_mmu_secondary();
>   
> +	/* Perform any KUP setup that is per-cpu */
> +	setup_kup();
> +
>   	/*
>   	 * At this point, we can let interrupts switch to virtual mode
>   	 * (the MMU has been setup), so adjust the MSR in the PACA to
> diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
> index ecaedfff9992..6ea5607fc564 100644
> --- a/arch/powerpc/mm/init-common.c
> +++ b/arch/powerpc/mm/init-common.c
> @@ -45,7 +45,7 @@ static int __init parse_nosmap(char *p)
>   }
>   early_param("nosmap", parse_nosmap);
>   
> -void __init setup_kup(void)
> +void setup_kup(void)
>   {
>   	setup_kuep(disable_kuep);
>   	setup_kuap(disable_kuap);
> 
