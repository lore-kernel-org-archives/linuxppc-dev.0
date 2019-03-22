Return-Path: <SRS0=ildu=RZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CEEC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 07:11:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95DA521900
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 07:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Ql4ROuJL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95DA521900
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44QZb614fvzDqV5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 18:11:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="Ql4ROuJL"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44QZY82ZBgzDqRy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 18:10:03 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44QZY06cSsz9ttgC;
 Fri, 22 Mar 2019 08:09:56 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=Ql4ROuJL; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 5zZVGQFDRQBd; Fri, 22 Mar 2019 08:09:56 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44QZY05F2Zz9ttgB;
 Fri, 22 Mar 2019 08:09:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553238596; bh=Sw2tSGEbTLCzOtGXCUs6+Rh8fSKxp3YF2aekA8N6VOA=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Ql4ROuJLM1HyWZpohTbpMdhgx6BkCXtoNRD4ER8FHkfkMz2kzWr314lvJ/Qa6CZLr
 bN1dLT3Uq7v5DTDK2tb1SjAJQhWHA6DhMPiqrxRf+6Ri1/ljd7X2C8gjHLJPhxmpSF
 ExyfwQVI22PQYfbTuuxQ+7Qp3AoIq43/cJE/yTa0=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 96A038B83A;
 Fri, 22 Mar 2019 08:09:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id r29En-u5Hj1J; Fri, 22 Mar 2019 08:09:57 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 57F818B803;
 Fri, 22 Mar 2019 08:09:57 +0100 (CET)
Subject: Re: [PATCH 5/5] powerpc/8xx: fix possible object reference leak
To: Wen Yang <wen.yang99@zte.com.cn>, linux-kernel@vger.kernel.org
References: <1553223955-7350-1-git-send-email-wen.yang99@zte.com.cn>
 <1553223955-7350-5-git-send-email-wen.yang99@zte.com.cn>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <d948696e-ecf8-eadd-0db5-b1c436bd1490@c-s.fr>
Date: Fri, 22 Mar 2019 07:09:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1553223955-7350-5-git-send-email-wen.yang99@zte.com.cn>
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
Cc: wang.yi59@zte.com.cn, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 03/22/2019 03:05 AM, Wen Yang wrote:
> The call to of_find_compatible_node returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
> irq_domain_add_linear also calls of_node_get to increase refcount,
> so irq_domain will not be affected when it is released.


Should you have a:

Fixes: a8db8cf0d894 ("irq_domain: Replace irq_alloc_host() with 
revmap-specific initializers")

If not, it means your change is in contradiction with commit 
b1725c9319aa ("[POWERPC] arch/powerpc/sysdev: Add missing of_node_put")

> 
> Detected by coccinelle with the following warnings:
> ./arch/powerpc/platforms/8xx/pic.c:158:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 136, but without a corresponding object release within this function.
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: Vitaly Bordug <vitb@kernel.crashing.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   arch/powerpc/platforms/8xx/pic.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/platforms/8xx/pic.c b/arch/powerpc/platforms/8xx/pic.c
> index 8d5a25d..13d880b 100644
> --- a/arch/powerpc/platforms/8xx/pic.c
> +++ b/arch/powerpc/platforms/8xx/pic.c
> @@ -155,6 +155,7 @@ int mpc8xx_pic_init(void)
>   		ret = -ENOMEM;
>   		goto out;
>   	}
> +	of_node_put(np);
>   	return 0;
>   
>   out:
> 

I guess it would be better as follows:

--- a/arch/powerpc/platforms/8xx/pic.c
+++ b/arch/powerpc/platforms/8xx/pic.c
@@ -153,9 +153,7 @@ int mpc8xx_pic_init(void)
         if (mpc8xx_pic_host == NULL) {
                 printk(KERN_ERR "MPC8xx PIC: failed to allocate irq 
host!\n");
                 ret = -ENOMEM;
-               goto out;
         }
-       return 0;

  out:
         of_node_put(np);



Christophe
