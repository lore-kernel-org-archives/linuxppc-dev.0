Return-Path: <SRS0=EQUS=5X=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51989C2BA80
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2020 05:58:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0685720730
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2020 05:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="pQgLUSKA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0685720730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48xGtl0HY8zDql2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2020 15:58:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.a=rsa-sha256
 header.s=mail header.b=pQgLUSKA; dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48xGWw4mbpzDqwp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Apr 2020 15:42:36 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 48xGWr3ZXtz9tyl2;
 Tue,  7 Apr 2020 07:42:32 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=pQgLUSKA; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id ViWYKlAmZhnS; Tue,  7 Apr 2020 07:42:32 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 48xGWr2VSCz9tyl0;
 Tue,  7 Apr 2020 07:42:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1586238152; bh=0tLxDoUi5al3tDWWu+k+JPbwXxGPx6Hf8CUYJFZNx5I=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=pQgLUSKAlDUwli8li9Yb6OIPeMgEgC8shFOiYtShlM+kwmTtKtZA20grnWdKNjNuP
 1JExGxh0UeM011UY9g+y+Ruc/o3DLIq5Da1lLbn/aAZncadEkPKdAFOGL97s5oaPZP
 UI3zX8d4UbazrUKXf/ls/YLUw90qCRZPVNNmxFG8=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2345B8B76E;
 Tue,  7 Apr 2020 07:42:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id dWDzlx8rZ4Xx; Tue,  7 Apr 2020 07:42:33 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 042988B75E;
 Tue,  7 Apr 2020 07:42:31 +0200 (CEST)
Subject: Re: [PATCH v3 05/15] powerpc/pseries/ras: avoid calling rtas_token in
 NMI paths
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20200407051636.648369-1-npiggin@gmail.com>
 <20200407051636.648369-6-npiggin@gmail.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <6071fb96-c5e0-0173-fb9c-0eebb63ab224@c-s.fr>
Date: Tue, 7 Apr 2020 07:42:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200407051636.648369-6-npiggin@gmail.com>
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
 Ganesh Goudar <ganeshgr@linux.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 07/04/2020 à 07:16, Nicholas Piggin a écrit :
> In the interest of reducing code and possible failures in the
> machine check and system reset paths, grab the "ibm,nmi-interlock"
> token at init time.
> 
> Reviewed-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
>   arch/powerpc/include/asm/firmware.h    |  1 +
>   arch/powerpc/platforms/pseries/ras.c   |  2 +-
>   arch/powerpc/platforms/pseries/setup.c | 14 ++++++++++----
>   3 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
> index ca33f4ef6cb4..6003c2e533a0 100644
> --- a/arch/powerpc/include/asm/firmware.h
> +++ b/arch/powerpc/include/asm/firmware.h
> @@ -128,6 +128,7 @@ extern void machine_check_fwnmi(void);
>   
>   /* This is true if we are using the firmware NMI handler (typically LPAR) */
>   extern int fwnmi_active;
> +extern int ibm_nmi_interlock_token;
>   
>   extern unsigned int __start___fw_ftr_fixup, __stop___fw_ftr_fixup;
>   
> diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
> index aa6208c8d4f0..972b95ebc867 100644
> --- a/arch/powerpc/platforms/pseries/ras.c
> +++ b/arch/powerpc/platforms/pseries/ras.c
> @@ -458,7 +458,7 @@ static struct rtas_error_log *fwnmi_get_errinfo(struct pt_regs *regs)
>    */
>   static void fwnmi_release_errinfo(void)
>   {
> -	int ret = rtas_call(rtas_token("ibm,nmi-interlock"), 0, 1, NULL);
> +	int ret = rtas_call(ibm_nmi_interlock_token, 0, 1, NULL);
>   	if (ret != 0)
>   		printk(KERN_ERR "FWNMI: nmi-interlock failed: %d\n", ret);
>   }
> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
> index 0c8421dd01ab..dd234095ae4f 100644
> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -83,6 +83,7 @@ unsigned long CMO_PageSize = (ASM_CONST(1) << IOMMU_PAGE_SHIFT_4K);
>   EXPORT_SYMBOL(CMO_PageSize);
>   
>   int fwnmi_active;  /* TRUE if an FWNMI handler is present */
> +int ibm_nmi_interlock_token;
>   
>   static void pSeries_show_cpuinfo(struct seq_file *m)
>   {
> @@ -113,9 +114,14 @@ static void __init fwnmi_init(void)
>   	struct slb_entry *slb_ptr;
>   	size_t size;
>   #endif
> +	int ibm_nmi_register_token;
>   
> -	int ibm_nmi_register = rtas_token("ibm,nmi-register");
> -	if (ibm_nmi_register == RTAS_UNKNOWN_SERVICE)
> +	ibm_nmi_register_token = rtas_token("ibm,nmi-register");
> +	if (ibm_nmi_register_token == RTAS_UNKNOWN_SERVICE)
> +		return;
> +
> +	ibm_nmi_interlock_token = rtas_token("ibm,nmi-interlock");
> +	if (WARN_ON(ibm_nmi_interlock_token == RTAS_UNKNOWN_SERVICE))
>   		return;
>   
>   	/* If the kernel's not linked at zero we point the firmware at low
> @@ -123,8 +129,8 @@ static void __init fwnmi_init(void)
>   	system_reset_addr  = __pa(system_reset_fwnmi) - PHYSICAL_START;
>   	machine_check_addr = __pa(machine_check_fwnmi) - PHYSICAL_START;
>   
> -	if (0 == rtas_call(ibm_nmi_register, 2, 1, NULL, system_reset_addr,
> -				machine_check_addr))
> +	if (0 == rtas_call(ibm_nmi_register_token, 2, 1, NULL,
> +			   system_reset_addr, machine_check_addr))
>   		fwnmi_active = 1;
>   
>   	/*
> 
