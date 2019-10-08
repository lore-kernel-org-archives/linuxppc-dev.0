Return-Path: <SRS0=I7zA=YB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F0EC4360C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Oct 2019 06:23:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36EA92067B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Oct 2019 06:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="qFhczy1y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36EA92067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46nS3F4c9NzDqNm
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Oct 2019 17:23:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="qFhczy1y"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46nS155XvqzDqG6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2019 17:21:43 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 46nS0x5yQvz9tygv;
 Tue,  8 Oct 2019 08:21:37 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=qFhczy1y; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id Ss27VA1RuMln; Tue,  8 Oct 2019 08:21:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 46nS0x3zMjz9txbk;
 Tue,  8 Oct 2019 08:21:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1570515697; bh=oLw5ZQgF7cgLgeEYxJPWZZVTjqlHXjMvYkp1WLeDCVE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=qFhczy1yMiZI8LXPMyZoUJwp74CAsgHnhw6MoZ7kYkuHgwfx7LmH1TeFIUrMabXwe
 eK4AuzfgB2PqaCQeJGbW+h4y1XwBEiQjh5+krR/d/Mj89GYsZUHGZA1NylNFFZQbXg
 i0HRRUefiRj8RvB8LgA0IvAaOv+t84kpSv5NI+v8=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 480F68B826;
 Tue,  8 Oct 2019 08:21:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id RDN9vJtIXWXt; Tue,  8 Oct 2019 08:21:38 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A134D8B824;
 Tue,  8 Oct 2019 08:21:37 +0200 (CEST)
Subject: Re: [PATCH v3 3/4] powerpc/mm/ptdump: debugfs handler for W+X checks
 at runtime
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
References: <20191004075050.73327-1-ruscur@russell.cc>
 <20191004075050.73327-4-ruscur@russell.cc>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <665bacec-036f-f392-7e0f-95a57b0a7d22@c-s.fr>
Date: Tue, 8 Oct 2019 08:21:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191004075050.73327-4-ruscur@russell.cc>
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
Cc: ajd@linux.ibm.com, npiggin@gmail.com, joel@jms.id.au, rashmica.g@gmail.com,
 dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 04/10/2019 à 09:50, Russell Currey a écrit :
> Very rudimentary, just
> 
> 	echo 1 > [debugfs]/check_wx_pages
> 
> and check the kernel log.  Useful for testing strict module RWX.
> 
> Also fixed a typo.
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> ---
>   arch/powerpc/mm/ptdump/ptdump.c | 31 +++++++++++++++++++++++++------
>   1 file changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
> index 2f9ddc29c535..0547cd9f264e 100644
> --- a/arch/powerpc/mm/ptdump/ptdump.c
> +++ b/arch/powerpc/mm/ptdump/ptdump.c
> @@ -4,7 +4,7 @@
>    *
>    * This traverses the kernel pagetables and dumps the
>    * information about the used sections of memory to
> - * /sys/kernel/debug/kernel_pagetables.
> + * /sys/kernel/debug/kernel_page_tables.
>    *
>    * Derived from the arm64 implementation:
>    * Copyright (c) 2014, The Linux Foundation, Laura Abbott.
> @@ -409,16 +409,35 @@ void ptdump_check_wx(void)
>   	else
>   		pr_info("Checked W+X mappings: passed, no W+X pages found\n");
>   }
> +
> +static int check_wx_debugfs_set(void *data, u64 val)
> +{
> +	if (val != 1ULL)
> +		return -EINVAL;
> +
> +	ptdump_check_wx();
> +
> +	return 0;
> +}
> +
> +DEFINE_SIMPLE_ATTRIBUTE(check_wx_fops, NULL, check_wx_debugfs_set, "%llu\n");
>   #endif
>   
>   static int ptdump_init(void)
>   {
> -	struct dentry *debugfs_file;
> -
>   	populate_markers();
>   	build_pgtable_complete_mask();
> -	debugfs_file = debugfs_create_file("kernel_page_tables", 0400, NULL,
> -			NULL, &ptdump_fops);
> -	return debugfs_file ? 0 : -ENOMEM;
> +
> +	if (!debugfs_create_file("kernel_page_tables", 0400, NULL,
> +				 NULL, &ptdump_fops))
> +		return -ENOMEM;
> +
> +#ifdef CONFIG_PPC_DEBUG_WX
> +	if (!debugfs_create_file("check_wx_pages", 0200, NULL,
> +				 NULL, &check_wx_fops))
> +		return -ENOMEM;
> +#endif

The above seems to be completely independant from everything else in 
ptdump_init().

Could we avoid this #ifdef block inside ptdump_init() by creating a 
selfstanding device_initcall() for that through a function called 
ptdump_check_wx_init() defined inside the same #ifdef block as 
ptdump_check_wx() ?

Christophe

> +
> +	return 0;
>   }
>   device_initcall(ptdump_init);
> 
