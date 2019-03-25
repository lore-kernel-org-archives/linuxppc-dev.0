Return-Path: <SRS0=tR2X=R4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEBCC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 08:52:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF93E20863
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 08:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="RenvFtDM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF93E20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44SSgm3yJgzDqJP
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 19:52:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="RenvFtDM"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44SSdv5414zDq62
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 19:50:43 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44SSdl1kFQz9v0Yj;
 Mon, 25 Mar 2019 09:50:35 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=RenvFtDM; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id UP11EXQHm3pD; Mon, 25 Mar 2019 09:50:35 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44SSdl0ZqTz9v0Yh;
 Mon, 25 Mar 2019 09:50:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553503835; bh=eUXXTPKBtmZnBbOIuM1qXfH1lS7OM5bWpi2af9aCZ+o=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=RenvFtDMIPG6pchf+IpUNAZNIBqsGB5ACfu0dhHlVPQaRA8v4zIiMORkVKAexzJaA
 IgysjsZQL48GS63uYjy7uRkIw+3Dql4S2gnOZemdlfduFeITHOOovN/khGSK+DRroh
 Rb44kSG6TOiQ9vZG25+Pk+iLjJLm7qduBoCQKhYQ=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 93DBA8B89C;
 Mon, 25 Mar 2019 09:50:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id iHDVtVmwxPMH; Mon, 25 Mar 2019 09:50:39 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 3B90F8B74F;
 Mon, 25 Mar 2019 09:50:39 +0100 (CET)
Subject: Re: [PATCH v2] powerpc/8xx: fix possible object reference leak
To: Peng Hao <peng.hao2@zte.com.cn>, vitb@kernel.crashing.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1553533919-75527-1-git-send-email-peng.hao2@zte.com.cn>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <1846dc49-e691-cd24-2439-26d92f634036@c-s.fr>
Date: Mon, 25 Mar 2019 09:50:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <1553533919-75527-1-git-send-email-peng.hao2@zte.com.cn>
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
Cc: linuxppc-dev@lists.ozlabs.org, Wen Yang <wen.yang99@zte.com.cn>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 25/03/2019 à 18:11, Peng Hao a écrit :
> From: Wen Yang <wen.yang99@zte.com.cn>
> 
> The call to of_find_compatible_node returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
> irq_domain_add_linear also calls of_node_get to increase refcount,
> so irq_domain will not be affected when it is released.
> 
> Detected by coccinelle with the following warnings:
> ./arch/powerpc/platforms/8xx/pic.c:158:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 136, but without a corresponding object release within this function.
> 
> Fixes: a8db8cf0d894 ("irq_domain: Replace irq_alloc_host() with
> revmap-specific initializers")
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Peng Hao <peng.hao2@zte.com.cn>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> Cc: Vitaly Bordug <vitb@kernel.crashing.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   arch/powerpc/platforms/8xx/pic.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/8xx/pic.c b/arch/powerpc/platforms/8xx/pic.c
> index 8d5a25d..4453df6 100644
> --- a/arch/powerpc/platforms/8xx/pic.c
> +++ b/arch/powerpc/platforms/8xx/pic.c
> @@ -153,9 +153,7 @@ int mpc8xx_pic_init(void)
>   	if (mpc8xx_pic_host == NULL) {
>   		printk(KERN_ERR "MPC8xx PIC: failed to allocate irq host!\n");
>   		ret = -ENOMEM;
> -		goto out;
>   	}
> -	return 0;
>   
>   out:
>   	of_node_put(np);
> 
