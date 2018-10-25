Return-Path: <SRS0=ruO2=NF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CE1C46475
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 22:09:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76DE6207DD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 22:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="Xhk7xyV+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76DE6207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42h1Wg0sgZzF2Ds
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 09:09:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; secure) header.d=jms.id.au header.i=@jms.id.au header.b="Xhk7xyV+";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::841; helo=mail-qt1-x841.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=jms.id.au header.i=@jms.id.au header.b="Xhk7xyV+"; 
 dkim-atps=neutral
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42h1St1TNwzF2Ds
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Oct 2018 09:07:26 +1100 (AEDT)
Received: by mail-qt1-x841.google.com with SMTP id l41-v6so11826861qtl.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 15:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TUBidomvoH/Apxm80HzLvAN3a3t8ShLP0h0KAo04q48=;
 b=Xhk7xyV+jTV7bw2mkVFCZ8q7zeoJc05L1JFO3z01gaRp0Iq/X6Wh1nKOvh4fhyeLAm
 lF4M6/xb6U5fIOCxQYzR4OCp5p/rpiYX2xR4xHAkn0kVgHclw36nevbuu4s9TEuZCF9D
 v6VSokwSnxxl0Bhbmab3WU9eWsS6D4YLG/QlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TUBidomvoH/Apxm80HzLvAN3a3t8ShLP0h0KAo04q48=;
 b=VI+sG5DbrnHxSGsCjC0uiuZ3xFMswBJ5RSJS7KjbAXZu0WdgFjd3AyE7iwJ8i6I9+T
 ePWeNaB7TvtTZ/LkdlhDdnVY+WliIdZIy/eI9zuzsoULCY9Bxxy4QAA2KQ0ZT/Yvfyj9
 UzdRZHkSA56xQI631KimiDNQ7p6hqs/GACPZxTY9yT17fmtoNRjJZPlQ9PNaPPvr219x
 Q8M9HQo1gsA8qDnpxPW89T+72KoJ4M/gaPYTpVpoLM8lLncNIbesUaUYf1+wiGeLHpQO
 QybIRsuOPWrhtxwbefLSRJtNYUaDj/SdY8Qprc9s4JF2LwXHXZd5Dj2c3cfCGdpJB9wW
 HjTw==
X-Gm-Message-State: AGRZ1gLgwRKEFkjOpMfmzXberXmn/YtJXNtHT+VQMe/spVDxiSfNTLcC
 T5fna7rDHavod1DojieordUzicl8WPeoYD7p39A=
X-Google-Smtp-Source: AJdET5dzkQhzFFP7LE4xRvx8AQVGqP8HTP+zXdScggcFZ+xJEAfe4K1G0sTthmUNzOCqlfL64+9qB1goOOM37j6EBcU=
X-Received: by 2002:ac8:7445:: with SMTP id
 h5-v6mr1004681qtr.284.1540505243862; 
 Thu, 25 Oct 2018 15:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <20181023080456.2558-1-naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <20181023080456.2558-1-naveen.n.rao@linux.vnet.ibm.com>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 26 Oct 2018 08:37:11 +1030
Message-ID: <CACPK8XfK-uQdkh0mb55bs8LnN-e3CgWJh2guRDfjx0NqTSTbPg@mail.gmail.com>
Subject: Re: [PATCH] selftests/powerpc: Relax L1d miss targets for rfi_flush
 test
To: naveen.n.rao@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 23 Oct 2018 at 18:35, Naveen N. Rao
<naveen.n.rao@linux.vnet.ibm.com> wrote:
>
> When running the rfi_flush test, if the system is loaded, we see two
> issues:
> 1. The L1d misses when rfi_flush is disabled increase significantly due
> to other workloads interfering with the cache.
> 2. The L1d misses when rfi_flush is enabled sometimes goes slightly
> below the expected number of misses.
>
> To address these, let's relax the expected number of L1d misses:
> 1. When rfi_flush is disabled, we allow upto half the expected number of
> the misses for when rfi_flush is enabled.
> 2. When rfi_flush is enabled, we allow ~1% lower number of cache misses.
>
> Reported-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Thanks, this now passes 10/10 runs on my Romulus machine. A log is
attached below.

Tested-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel

---

for i in `seq 1 10`; do sudo ./rfi_flush; done
test: rfi_flush_test
tags: git_version:next-20181018-67-g61f7abf00719
PASS (L1D misses with rfi_flush=0: 5013939 < 95000000) [10/10 pass]
PASS (L1D misses with rfi_flush=1: 195054696 > 190000000) [10/10 pass]
success: rfi_flush_test
test: rfi_flush_test
tags: git_version:next-20181018-67-g61f7abf00719
PASS (L1D misses with rfi_flush=0: 11015957 < 95000000) [10/10 pass]
PASS (L1D misses with rfi_flush=1: 195053292 > 190000000) [10/10 pass]
success: rfi_flush_test
test: rfi_flush_test
tags: git_version:next-20181018-67-g61f7abf00719
PASS (L1D misses with rfi_flush=0: 8017248 < 95000000) [10/10 pass]
PASS (L1D misses with rfi_flush=1: 195145579 > 190000000) [10/10 pass]
success: rfi_flush_test
test: rfi_flush_test
tags: git_version:next-20181018-67-g61f7abf00719
PASS (L1D misses with rfi_flush=0: 11015308 < 95000000) [10/10 pass]
PASS (L1D misses with rfi_flush=1: 195042376 > 190000000) [10/10 pass]
success: rfi_flush_test
test: rfi_flush_test
tags: git_version:next-20181018-67-g61f7abf00719
PASS (L1D misses with rfi_flush=0: 1021356 < 95000000) [10/10 pass]
PASS (L1D misses with rfi_flush=1: 195031624 > 190000000) [10/10 pass]
success: rfi_flush_test
test: rfi_flush_test
tags: git_version:next-20181018-67-g61f7abf00719
PASS (L1D misses with rfi_flush=0: 6015342 < 95000000) [10/10 pass]
PASS (L1D misses with rfi_flush=1: 195037322 > 190000000) [10/10 pass]
success: rfi_flush_test
test: rfi_flush_test
tags: git_version:next-20181018-67-g61f7abf00719
PASS (L1D misses with rfi_flush=0: 16635 < 95000000) [10/10 pass]
PASS (L1D misses with rfi_flush=1: 195032476 > 190000000) [10/10 pass]
success: rfi_flush_test
test: rfi_flush_test
tags: git_version:next-20181018-67-g61f7abf00719
PASS (L1D misses with rfi_flush=0: 6013599 < 95000000) [10/10 pass]
PASS (L1D misses with rfi_flush=1: 195060037 > 190000000) [10/10 pass]
success: rfi_flush_test
test: rfi_flush_test
tags: git_version:next-20181018-67-g61f7abf00719
PASS (L1D misses with rfi_flush=0: 25236 < 95000000) [10/10 pass]
PASS (L1D misses with rfi_flush=1: 195052859 > 190000000) [10/10 pass]
success: rfi_flush_test
test: rfi_flush_test
tags: git_version:next-20181018-67-g61f7abf00719
PASS (L1D misses with rfi_flush=0: 18120 < 95000000) [10/10 pass]
PASS (L1D misses with rfi_flush=1: 195014212 > 190000000) [10/10 pass]
success: rfi_flush_test
