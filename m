Return-Path: <SRS0=nZGU=SK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B71C10F13
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 20:25:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFED721841
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 20:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="XzoQ5uk9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFED721841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dMNs2dGMzDqK6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 06:25:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com;
 envelope-from=hughd@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="XzoQ5uk9"; 
 dkim-atps=neutral
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dMM00KxdzDqK9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 06:23:33 +1000 (AEST)
Received: by mail-pf1-x431.google.com with SMTP id 188so8270685pfd.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Apr 2019 13:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:user-agent:mime-version;
 bh=2/plURz0O/kvp62nzrIaAO156gML2Ck7ZIjU/iprOVA=;
 b=XzoQ5uk96KHSveBdJCs6H+S8Cp4n1TIcFB5ojCBkIQ1v9BNXA5eT3zkNLe0uWMF6W1
 DYCXkfW2stKlrr1nIsb+DwUu+/CDdtKGSYQWnIany7ygqybu2TLsonSy1Ib+KMUhrQ4O
 EO+0JXVG5sM6dgep35nMvk5t5JmUwd5XauEWRdzYGUz/LnluiizJp/WqUqra/l4M5RcD
 qzjPg07l2rgfRJnUflE89o5B3pSTRtoITW1tWecsNFs7ijiDVwPoEjWcdEcqUvR7DL4C
 VZAjmoBNZTk/cMre1XjEaOESlW+ShUtXIa6Dnk8IqNUh1as6da/kapBHTvufPxnepD1Y
 /aQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
 :mime-version;
 bh=2/plURz0O/kvp62nzrIaAO156gML2Ck7ZIjU/iprOVA=;
 b=KjPaZIB/G6Jku9vl65/mf5C8yZT7eC7Mqg1l0OAlI8HUPRd3AgvyZjqWfUMcBgGrLG
 f7A6sTGWFDeUncKUDavQaLHNimTBmkZO1L3qwHq6RCJkiyouueilg/lpGlF6aJEEoupJ
 2GNE1FggFu+Kri4COwfCDvuDjDR1v19gpocnFX0ms0pZqVGdKtSwBGQw3lBRLZCe2wI3
 niaaS4vTYCiV+TXTqTW11Qwr5F0mus0Uhv50lOQYCq8bMcaqi9LN8pyHyTe6PBe+iiwa
 Qg0Imm8jv0pRgoIV/F9yrrkYjPrni5wqRYtZg9CFUBWniPrkpPPBmfqDXj6gaagZKhBx
 NufQ==
X-Gm-Message-State: APjAAAUtb5mqh+UW5A6ZFTOWJY5XlAolnn4MF9TkqB87QSmsauRik2l4
 BP0akknd3Ejf1fsMm0Cq9qCJlg==
X-Google-Smtp-Source: APXvYqwMUipIgX4gLd9oCEzoY3Q+Rqc4f36bfR714GeDU8O5vxj7ObU5MMNI+5jZITZgYokSvXIeSg==
X-Received: by 2002:a63:2b0d:: with SMTP id r13mr30002742pgr.400.1554755009311; 
 Mon, 08 Apr 2019 13:23:29 -0700 (PDT)
Received: from [100.112.89.103] ([104.133.8.103])
 by smtp.gmail.com with ESMTPSA id 4sm49396590pgx.68.2019.04.08.13.23.27
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 08 Apr 2019 13:23:28 -0700 (PDT)
Date: Mon, 8 Apr 2019 13:23:10 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To: Ben Hutchings <ben@decadent.org.uk>
Subject: ppc64 4kB: MAX_PHYSMEM_BITS undefined
Message-ID: <alpine.LSU.2.11.1904081305030.1656@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Cc: Hugh Dickins <hughd@google.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Ben,

5.1-rc's 8bc086899816 ("powerpc/mm: Only define MAX_PHYSMEM_BITS in
SPARSEMEM configurations") has sadly broken the build for my config
on the G5, which has (amongst a few other options):

CONFIG_PPC_BOOK3S_64=y
CONFIG_PPC_BOOK3S=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_PPC_4K_PAGES=y
# CONFIG_PPC_64K_PAGES is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y

Easily enough worked around for me by...

--- 5.1-rc4/arch/powerpc/include/asm/mmu.h	2019-03-24 15:40:26.833378215 -0700
+++ linux/arch/powerpc/include/asm/mmu.h	2019-04-07 19:51:11.419295089 -0700
@@ -352,7 +352,7 @@ static inline bool strict_kernel_rwx_ena
 #if defined(CONFIG_SPARSEMEM_VMEMMAP) && defined(CONFIG_SPARSEMEM_EXTREME) &&	\
 	defined (CONFIG_PPC_64K_PAGES)
 #define MAX_PHYSMEM_BITS        51
-#elif defined(CONFIG_SPARSEMEM)
+#else
 #define MAX_PHYSMEM_BITS        46
 #endif

...but I don't suppose that's what you want to do.

I wonder if there was a momentary mixup between 64 bits and 64kB pages -
I'm a non-conformist using 4kB pages on ppc64.

Hugh
