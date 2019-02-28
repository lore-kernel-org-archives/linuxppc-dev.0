Return-Path: <SRS0=68wk=RD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2476C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 13:04:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9D612171F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 13:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="dyUWiOD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D612171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449CSj2bxczDqJ5
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 00:04:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="dyUWiOD6"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449CN36PY5zDqMl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2019 00:00:50 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 449CMw0WKFz9tyYj;
 Thu, 28 Feb 2019 14:00:44 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=dyUWiOD6; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id sePUGDFcg7i5; Thu, 28 Feb 2019 14:00:44 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 449CMv6Xljz9tyYZ;
 Thu, 28 Feb 2019 14:00:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1551358843; bh=6pFTjxAQJAxN1w/c378t7W+IbxT6JN6QnYihXyettS0=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=dyUWiOD609JGvwYstrcSvgFJ4kFAQ7jhFodHTVfGug+191nn2pg4uF7766sO7LX3V
 mGBBtFrcGG8j0ru6jxb/amQ6WkfTOfb5GCilN1L6LT+L6ANZTmr6RYNRPk9u7W5KbX
 h2uB5cTrqYFYhR7s4Zq4uL2U+V02d1dd0FvpPeUU=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 3F7E18BB46;
 Thu, 28 Feb 2019 14:00:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id JHAOofqrNoX4; Thu, 28 Feb 2019 14:00:45 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 885738BB1A;
 Thu, 28 Feb 2019 14:00:44 +0100 (CET)
Subject: Re: [PATCH] powerpc: remove dead code in head_fsl_booke.S
To: Jason Yan <yanaijie@huawei.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, diana.craciun@nxp.com,
 linuxppc-dev@lists.ozlabs.org
References: <20190228083121.30598-1-yanaijie@huawei.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <cc1c7fdc-33b8-bebd-f5df-4c9b814e099e@c-s.fr>
Date: Thu, 28 Feb 2019 14:00:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190228083121.30598-1-yanaijie@huawei.com>
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



Le 28/02/2019 à 09:31, Jason Yan a écrit :
> This code is dead. Just remove it.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

This review was easy :)

Christophe

> ---
>   arch/powerpc/kernel/head_fsl_booke.S | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
> index 2386ce2a9c6e..b8450f017d85 100644
> --- a/arch/powerpc/kernel/head_fsl_booke.S
> +++ b/arch/powerpc/kernel/head_fsl_booke.S
> @@ -194,13 +194,6 @@ set_ivor:
>   #endif
>   	mtspr	SPRN_MAS4, r2
>   
> -#if 0
> -	/* Enable DOZE */
> -	mfspr	r2,SPRN_HID0
> -	oris	r2,r2,HID0_DOZE@h
> -	mtspr	SPRN_HID0, r2
> -#endif
> -
>   #if !defined(CONFIG_BDI_SWITCH)
>   	/*
>   	 * The Abatron BDI JTAG debugger does not tolerate others
> 
