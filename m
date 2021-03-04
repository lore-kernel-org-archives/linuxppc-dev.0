Return-Path: <SRS0=6LlZ=IC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3476C433DB
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Mar 2021 07:10:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02C2864EE4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Mar 2021 07:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C2864EE4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DrhpQ3YCDz3d4x
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Mar 2021 18:10:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Drhny4mD9z30Ld
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Mar 2021 18:09:57 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4Drhnr3xRRz9v1Mj;
 Thu,  4 Mar 2021 08:09:52 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id O2PkTkGHV1vi; Thu,  4 Mar 2021 08:09:52 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4Drhnr1f4vz9v1Mh;
 Thu,  4 Mar 2021 08:09:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9307E8B7F7;
 Thu,  4 Mar 2021 08:09:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id Lxx4YMro9UFv; Thu,  4 Mar 2021 08:09:53 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 771458B773;
 Thu,  4 Mar 2021 08:09:52 +0100 (CET)
Subject: Re: [PATCH 2/5] CMDLINE: drivers: of: ifdef out cmdline section
To: Daniel Walker <danielwa@cisco.com>, Will Deacon <will@kernel.org>,
 ob Herring <robh@kernel.org>,
 Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
 Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>
References: <20210304044803.812204-2-danielwa@cisco.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <2b0081aa-52af-a4ab-7481-6e125bd103d6@csgroup.eu>
Date: Thu, 4 Mar 2021 08:09:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210304044803.812204-2-danielwa@cisco.com>
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
Cc: devicetree@vger.kernel.org, Ruslan Ruslichenko <rruslich@cisco.com>,
 linux-kernel@vger.kernel.org, xe-linux-external@cisco.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 04/03/2021 à 05:47, Daniel Walker a écrit :
> It looks like there's some seepage of cmdline stuff into
> the generic device tree code. This conflicts with the
> generic cmdline implementation so I remove it in the case
> when that's enabled.
> 
> Cc: xe-linux-external@cisco.com
> Signed-off-by: Ruslan Ruslichenko <rruslich@cisco.com>
> Signed-off-by: Daniel Walker <danielwa@cisco.com>
> ---
>   drivers/of/fdt.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index feb0f2d67fc5..cfe4f8d3c9f5 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -25,6 +25,7 @@
>   #include <linux/serial_core.h>
>   #include <linux/sysfs.h>
>   #include <linux/random.h>
> +#include <linux/cmdline.h>
>   
>   #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
>   #include <asm/page.h>
> @@ -1048,8 +1049,18 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
>   
>   	early_init_dt_check_for_initrd(node);
>   
> +#ifdef CONFIG_GENERIC_CMDLINE
>   	/* Retrieve command line */
>   	p = of_get_flat_dt_prop(node, "bootargs", &l);
> +
> +	/*
> +	 * The builtin command line will be added here, or it can override
> +	 * with the DT bootargs.
> +	 */
> +	cmdline_add_builtin(data,
> +			    ((p != NULL && l > 0) ? p : NULL), /* This is sanity checking */

Can we do more simple ? If p is NULL, p is already NULL, so (l > 0 ? p : NULL) should be enough.

> +			    COMMAND_LINE_SIZE);
> +#else

What does p contains now that "p = of_get_flat_dt_prop(node, "bootargs", &l);" is only called when 
CONFIG_GENERIC_CMDLINE is defined ?

>   	if (p != NULL && l > 0)
>   		strlcpy(data, p, min(l, COMMAND_LINE_SIZE));
>   
> @@ -1070,6 +1081,7 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
>   		strlcpy(data, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
>   #endif
>   #endif /* CONFIG_CMDLINE */
> +#endif /* CONFIG_GENERIC_CMDLINE */
>   
>   	pr_debug("Command line is: %s\n", (char *)data);
>   
> 
