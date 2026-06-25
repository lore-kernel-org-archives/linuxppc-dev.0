Return-Path: <linuxppc-dev+bounces-22980-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9F1CDE000
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2026 14:04:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmLBr73Pmz2ySW;
	Fri, 26 Jun 2026 00:04:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782396244;
	cv=none; b=E8ITEkFtz+UUPsR7VCQ76pG4YYmzOaZ72raeDQjEOCdEEQsRzkTvJso8BtlSmhtdhBft3NEgpL+aZ1u8gRsN3dAhwgSwJx7V7nnwQWe5Xaxvdw1akVtalG1Nx/nOI5gZjAPdAtITY/3eFdrO9eOHai3ALn29Lt4nVyXgm+dp53UK0AatDqxtwoXLkUXmb8j64sPswieZSENRhwzzHwPlpJlHk+WvtZiqZucMBwGgxhwJQzCWJBO1gWLjSvrmnn/8/TlUNYNXfNW2aTDhYWYpTXsNOsCQiMhnnqQwu6rz2rX+ZKSLvfR5p7N144JsnEjuekYLJF65i+XQAckS356sig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782396244; c=relaxed/relaxed;
	bh=FXePbhpqmqUIpWXHZ6AhrPzihy8SICwPudmPEVZUNGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxYk93rgn8LPLruSvbc3SlIxyN5SzEY+LV6ql3RsCTKQ2PbCVPviJN3dBjPNtcmbT6zPICmywSwItro1c2Ol63hcBxFjg4Dw55AfRwfsP6C/ni+2RmGyGHwbA7PgRlacEga1Dy4SR2rnMOOL908OgujhKmIwdsOq/f19Nf0C5R8NdgeBwMduuonxLQjVtErFMQiYHllBOm7E8KBoS6esbbU57WEDiHPHBsxq/W+JIvu+1CaZvLhbfeM1Gz56Mo0d2wnoEsOlvo4kGxlUPD4LY1TcjVv2CpwHIQXRcKplNAmREgzk7aBPahmvo81emBRwblKU32H8ASJ/dbU2vf9MoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=D3+MXZ9G; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com; envelope-from=pmladek@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=D3+MXZ9G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com; envelope-from=pmladek@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmLBp16tCz2y8p
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2026 00:04:01 +1000 (AEST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-46cdcec58c2so527951f8f.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2026 07:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782396233; x=1783001033; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FXePbhpqmqUIpWXHZ6AhrPzihy8SICwPudmPEVZUNGU=;
        b=D3+MXZ9Gy7fG2fdAbXPaGdvo5+ikXh67DEICyN/VkBXnz3oqaQl8Ajl8AsDL79Byvu
         Cf7xhrgJw+ztWuNwCae8XhYc5IBqtH0oKf+eUC/hYgtQx6+LK5l6qDn0wMlqwqwBd6N6
         27xJ81jSpYhCS8Fc9owdWW3kxMBKnSAmoFPTSlq9ddzby4LTwkRvhOLQxBnArmgG6L3S
         +7Mtq9El35ln27OmAGUWDqNh1pkIGCn0j8bH614QR+NYL9UcKc5jnZnTAS88WL6H5/Wf
         do4XG1P4eyrDjhC0dIM2ts1WTs1dTyZTFf3fMrrHLhH3Gf5th5HieA9vC3nPnQVkyiBz
         f/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782396233; x=1783001033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXePbhpqmqUIpWXHZ6AhrPzihy8SICwPudmPEVZUNGU=;
        b=nw+Ba+LIISphwCdYVNLr0QmTOv4iCQ+kFjgFC6IQ3uTvYW2GulS9L1JEDSKHMN1Twb
         I6eLvnmqqoCr63sILjtMF/DXoh0n/22LIaqaxzZepdR6iSpbVoDqEQZz+Js5+Xc2EJ/N
         rQ2XIfAMCQJSHgQfggs1yX8AvczBdIdRcOaEy9hay8marBjRqLXLXLRTlxgxAYN5M4Q2
         tr0S8Zv1dX+Qg+VKXs83dU7hT9l8RrE+x3huevX+HyJTZE1LgXZdA3Ztn0MpPgJc/0AF
         KLygGe+MNFWHFS3/3DryVNU45TBlLIJH0pTgRXgw9BubfPNVE2uS1aveqfRXIkuksZ1r
         1OOg==
X-Forwarded-Encrypted: i=1; AHgh+RpiicRTLFQnHcKQuu1tT7KL+SIt3V+8yF25GOLXrsEuf3hKGslCQwixSWyItjFcC82x/azqVBgxhjK1IY0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwHJgsXqORD5MRt2S3twr9PPSpoFIbDTjajzPo0jW6n9VrVCb27
	hJOGb15/14Chm4PQVoP6pFzVjWj8s2qolfBYQFJUaIVtCS/t9KxIfdYSTsM5kgOOMJg=
X-Gm-Gg: AfdE7cncEWyaDgN442cFSohwREitfei/gWV5iXk9sdKURnl83HIUBFGnlP6BBEF0Esd
	Il19mAI7ymbsWtxqZgzOmJdEK/bKKsJTHPBEFRQIlH0E2+LgvMXrRzLC1XrQnjzRS+D30Hgns4/
	fEkBV1kmpgnS0kVTVoa08s9BLWsXkFgvloAlJwnjxs8m0c3pz0rjXwqqsVCvHRILzlLFjlIFOEe
	OHdmgwXuRFFqrJ4PfQmjLXIg2fSiJvS4cdp4/ia+LReahIvIjioVmFQ7VdGTzhzvdwoplRV6lsn
	sSph9mpYI6mp2ld2QFCceZpZ5QqHTs6A5oU5/0yfR4ZRG56Ga2zXxJV28tXYjQiqNvQ6oIXZfS1
	J+/rKQtos8dgBUs3ArU8BrtqpJG+u+a6E9GQPeh4jYoT830UT4JtP+2JXQnaYcHSmDzBzShWzMx
	g3
X-Received: by 2002:a5d:5f4d:0:b0:460:395c:7404 with SMTP id ffacd0b85a97d-46da9aceb40mr4346600f8f.20.1782396232681;
        Thu, 25 Jun 2026 07:03:52 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46d86960983sm7584574f8f.4.2026.06.25.07.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 07:03:51 -0700 (PDT)
Date: Thu, 25 Jun 2026 16:03:48 +0200
From: Petr Mladek <pmladek@suse.com>
To: Bradley Morgan <include@grrlz.net>
Cc: Feng Tang <feng.tang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Kees Cook <kees@kernel.org>, Rio <rioo.tsukatsukii@gmail.com>,
	Joel Granados <joel.granados@kernel.org>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Mayank Rungta <mrungta@google.com>, Tejun Heo <tj@kernel.org>,
	Zhenguo Yao <yaozhenguo1@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] sys_info: add helper for callers that handle
 all_bt
Message-ID: <aj01RHgagZm83dFq@pathway.suse.cz>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>

On Tue 2026-06-23 15:34:58, Bradley Morgan wrote:
> Some callers handle SYS_INFO_ALL_BT themselves before calling sys_info().
> Add a helper that strips that bit without turning an all_bt only mask into
> a kernel_sys_info fallback.
> 
> Signed-off-by: Bradley Morgan <include@grrlz.net>
> ---
> Changes since v1:
> - New patch for the shared helper suggested by Petr.
> 
>  include/linux/sys_info.h |  1 +
>  lib/sys_info.c           | 15 +++++++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/include/linux/sys_info.h b/include/linux/sys_info.h
> index a5bc3ea3d44b..87a841ec7b6a 100644
> --- a/include/linux/sys_info.h
> +++ b/include/linux/sys_info.h
> @@ -18,6 +18,7 @@
>  #define SYS_INFO_BLOCKED_TASKS		0x00000080
>  
>  void sys_info(unsigned long si_mask);
> +void sys_info_without_all_bt(unsigned long si_mask);
>  unsigned long sys_info_parse_param(char *str);
>  
>  #ifdef CONFIG_SYSCTL
> diff --git a/lib/sys_info.c b/lib/sys_info.c
> index f32a06ec9ed4..6afd4c697633 100644
> --- a/lib/sys_info.c
> +++ b/lib/sys_info.c
> @@ -164,3 +164,18 @@ void sys_info(unsigned long si_mask)
>  {
>  	__sys_info(si_mask ? : kernel_si_mask);
>  }
> +
> +void sys_info_without_all_bt(unsigned long si_mask)
> +{
> +	unsigned long dump_mask = si_mask & ~SYS_INFO_ALL_BT;
> +
> +	/*
> +	 * Do not call sys_info() when the caller context required only
> +	 * backtraces from all CPUs. Otherwise sys_info() would fall back
> +	 * to the generic kernel_si_mask.
> +	 */
> +	if (si_mask && !dump_mask)
> +		return;
> +
> +	sys_info(dump_mask);
> +}

Sashiko AI pointed out that this function still migth trigger printing
duplicate backtraces when (si_mask == 0). It calls sys_info(0)
which falls back to kernel_si_mask which might have SYS_INFO_ALL_BT
bit set, see https://sashiko.dev/#/patchset/9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include%40grrlz.net

=> we need to eventually disable the SYS_INFO_ALL_BT bit also
   in kernel_si_mask.

I think about creating a generic API which would allow to apply
a filter mask, something like:

From 02fc810a801adc0fc4d1fd14318415719bdfc656 Mon Sep 17 00:00:00 2001
From: Bradley Morgan <include@grrlz.net>
Date: Tue, 23 Jun 2026 15:34:58 +0000
Subject: [PATCH 1/4] sys_info: add helper for callers that print some
sys_info on their own

Some callers print some sys_info on their own before calling sys_info().
Add a helper which would allow to prevent a duplicated output.

It is a bit tricky because kernel_si_mask should be used only
when the call-specific si_mask is empty. But the duplicated
output must be prevented there as well.

Signed-off-by: Bradley Morgan <include@grrlz.net>
Fixes: a9af76a78760 ("watchdog: add sys_info sysctls to dump sys info on system lockup") ?
Fixes: a9af76a78760 ("watchdog: add sys_info sysctls to dump sys info on system lockup")
---
 include/linux/sys_info.h |  1 +
 lib/sys_info.c           | 20 ++++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/linux/sys_info.h b/include/linux/sys_info.h
index a5bc3ea3d44b..f1c2552ca3d1 100644
--- a/include/linux/sys_info.h
+++ b/include/linux/sys_info.h
@@ -18,6 +18,7 @@
 #define SYS_INFO_BLOCKED_TASKS		0x00000080
 
 void sys_info(unsigned long si_mask);
+void sys_info_with_filter(unsigned long si_mask, unsigned long si_ignore_mask);
 unsigned long sys_info_parse_param(char *str);
 
 #ifdef CONFIG_SYSCTL
diff --git a/lib/sys_info.c b/lib/sys_info.c
index f32a06ec9ed4..d411fee10415 100644
--- a/lib/sys_info.c
+++ b/lib/sys_info.c
@@ -136,8 +136,10 @@ static int __init sys_info_sysctl_init(void)
 subsys_initcall(sys_info_sysctl_init);
 #endif
 
-static void __sys_info(unsigned long si_mask)
+static void __sys_info(unsigned long si_mask, unsigned long si_ignore_mask)
 {
+	si_mask &= ~si_ignore_mask;
+
 	if (si_mask & SYS_INFO_TASKS)
 		show_state();
 
@@ -160,7 +162,21 @@ static void __sys_info(unsigned long si_mask)
 		show_state_filter(TASK_UNINTERRUPTIBLE);
 }
 
+void sys_info_with_filter(unsigned long si_mask, unsigned long si_ignore_mask)
+{
+	unsigned long dump_mask = si_mask & ~si_ignore_mask;
+
+	/*
+	 * Do not fall back to kernel_si_mask when the caller context
+	 * required only the ignored information.
+	 */
+	if (si_mask && !dump_mask)
+		return;
+
+	__sys_info(dump_mask ? : kernel_si_mask, si_ignore_mask);
+}
+
 void sys_info(unsigned long si_mask)
 {
-	__sys_info(si_mask ? : kernel_si_mask);
+	sys_info_with_filter(si_mask, 0);
 }

The next patches might use sys_info_with_filter(si_mask,
SYS_INFO_ALL_BT) instead of sys_info_without_all_bt(si_mask).

Feel free to bike shed about the function name. Also I am not
sure whether to pass the filter as bits to filter or already
the complement (~mask).

Best Regards,
Petr


