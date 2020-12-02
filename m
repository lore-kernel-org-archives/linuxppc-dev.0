Return-Path: <SRS0=PqhP=FG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19A6C64E7B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Dec 2020 13:07:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D54912222C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Dec 2020 13:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54912222C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CmK5543DWzDqKW
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Dec 2020 00:07:37 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CmJwK3DfDzDr3m
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Dec 2020 00:00:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=ozECxdJL; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4CmJwJ6mw3z9sTL;
 Thu,  3 Dec 2020 00:00:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1606914001;
 bh=il+wpPBmVvm9r7smyT4j5MqUTkLNm2LQ7yE8BD7sboE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=ozECxdJLj/5kK42PP1HJK/3kvDl4Oqt12XnZmdjhEIi54iSTRlZfABpdZTTY8JIcs
 fMgFhaQwqzrVQl3LDwMAUk6B6RovGugeKA/kaHwJQmMwkpJSr16SZk43qlDrmzpEP8
 VU9/Xf9spcp6hXX3kkDFjFrHED3RIFg4iei6W7KLxvHQRhXjjD0vxLv/k9icFvGkPo
 NEN9zyNI1v0X/toH/il+39rT3CbfRfxKMghKpgdbTTNqvG05oRIRaOoaH3hCECSzF7
 Sj67G8l+1ddeoORzK+HgbW20JlRvzf/Fsem4mwPe89THj4kpMzx4Tc2TfqJn8+l9ke
 of2IC1O+z0FjA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 5/8] powerpc/64s/powernv: ratelimit harmless HMI error
 printing
In-Reply-To: <20201128070728.825934-6-npiggin@gmail.com>
References: <20201128070728.825934-1-npiggin@gmail.com>
 <20201128070728.825934-6-npiggin@gmail.com>
Date: Thu, 03 Dec 2020 00:00:00 +1100
Message-ID: <87zh2wuzvz.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Nicholas Piggin <npiggin@gmail.com>, kvm-ppc@vger.kernel.org,
 Mahesh Salgaonkar <mahesh@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nicholas Piggin <npiggin@gmail.com> writes:
> Harmless HMI errors can be triggered by guests in some cases, and don't
> contain much useful information anyway. Ratelimit these to avoid
> flooding the console/logs.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/platforms/powernv/opal-hmi.c | 27 +++++++++++++----------
>  1 file changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/opal-hmi.c b/arch/powerpc/platforms/powernv/opal-hmi.c
> index 3e1f064a18db..959da6df0227 100644
> --- a/arch/powerpc/platforms/powernv/opal-hmi.c
> +++ b/arch/powerpc/platforms/powernv/opal-hmi.c
> @@ -240,19 +240,22 @@ static void print_hmi_event_info(struct OpalHMIEvent *hmi_evt)
>  		break;
>  	}
>  
> -	printk("%s%s Hypervisor Maintenance interrupt [%s]\n",
> -		level, sevstr,
> -		hmi_evt->disposition == OpalHMI_DISPOSITION_RECOVERED ?
> -		"Recovered" : "Not recovered");
> -	error_info = hmi_evt->type < ARRAY_SIZE(hmi_error_types) ?
> -			hmi_error_types[hmi_evt->type]
> -			: "Unknown";
> -	printk("%s Error detail: %s\n", level, error_info);
> -	printk("%s	HMER: %016llx\n", level, be64_to_cpu(hmi_evt->hmer));
> -	if ((hmi_evt->type == OpalHMI_ERROR_TFAC) ||
> -		(hmi_evt->type == OpalHMI_ERROR_TFMR_PARITY))
> -		printk("%s	TFMR: %016llx\n", level,
> +	if (hmi_evt->severity != OpalHMI_SEV_NO_ERROR || printk_ratelimit()) {
> +		printk("%s%s Hypervisor Maintenance interrupt [%s]\n",
> +			level, sevstr,
> +			hmi_evt->disposition == OpalHMI_DISPOSITION_RECOVERED ?
> +			"Recovered" : "Not recovered");
> +		error_info = hmi_evt->type < ARRAY_SIZE(hmi_error_types) ?
> +				hmi_error_types[hmi_evt->type]
> +				: "Unknown";
> +		printk("%s Error detail: %s\n", level, error_info);
> +		printk("%s	HMER: %016llx\n", level,
> +					be64_to_cpu(hmi_evt->hmer));
> +		if ((hmi_evt->type == OpalHMI_ERROR_TFAC) ||
> +			(hmi_evt->type == OpalHMI_ERROR_TFMR_PARITY))
> +			printk("%s	TFMR: %016llx\n", level,
>  						be64_to_cpu(hmi_evt->tfmr));
> +	}

Same comment RE printk_ratelimit(), I folded this in:

diff --git a/arch/powerpc/platforms/powernv/opal-hmi.c b/arch/powerpc/platforms/powernv/opal-hmi.c
index 959da6df0227..f0c1830deb51 100644
--- a/arch/powerpc/platforms/powernv/opal-hmi.c
+++ b/arch/powerpc/platforms/powernv/opal-hmi.c
@@ -213,6 +213,8 @@ static void print_hmi_event_info(struct OpalHMIEvent *hmi_evt)
 		"A hypervisor resource error occurred",
 		"CAPP recovery process is in progress",
 	};
+	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
+				      DEFAULT_RATELIMIT_BURST);
 
 	/* Print things out */
 	if (hmi_evt->version < OpalHMIEvt_V1) {
@@ -240,7 +242,7 @@ static void print_hmi_event_info(struct OpalHMIEvent *hmi_evt)
 		break;
 	}
 
-	if (hmi_evt->severity != OpalHMI_SEV_NO_ERROR || printk_ratelimit()) {
+	if (hmi_evt->severity != OpalHMI_SEV_NO_ERROR || __ratelimit(&rs)) {
 		printk("%s%s Hypervisor Maintenance interrupt [%s]\n",
 			level, sevstr,
 			hmi_evt->disposition == OpalHMI_DISPOSITION_RECOVERED ?

cheers
