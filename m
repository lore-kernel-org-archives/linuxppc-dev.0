Return-Path: <SRS0=NWA6=ON=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE1FC04EB9
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 00:01:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD93C2081C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 00:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sO7SZytz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD93C2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43827t4z9bzDqlm
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 11:00:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sO7SZytz";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="sO7SZytz"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43821W1BzgzDqlp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 10:55:27 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id 17so6476768pgg.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2018 15:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DZpxAhkJeS/FOj+/EL0o6jfR3Bwd3cLXiUwRQ25bPlY=;
 b=sO7SZytz7fFK7vyrhsKETIn4vQ4/WftHrAl/cnRe895Makc8Ry7cZDgn6xgKvbCi7r
 xxxDXnK+PA144DqGzwojnzCfut9oC15waIrxLAoSSlLLE5szTEz0uKbKPq83hH66aLBH
 dmBSd4EORl0g+6GYHKP4sFAL/8C5WEUFUb44x6z7gdYQd0MniJsgA27m13HPwFYyWelY
 c/9VwmdD3CHk8rQzokELmh2u58cMBVRNDr/07orvxWiaZqauwxO3Jf72yVeBRwGnBnXr
 Mb8OGxg8yijfoLhYhrj+LczpICHgaKvSgLEmZXUPEMyswDaZnFJECgLx1WGX+jXwpzmq
 ghDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=DZpxAhkJeS/FOj+/EL0o6jfR3Bwd3cLXiUwRQ25bPlY=;
 b=TLMHfxUdzfk9qH6FJDiJw2408vrnJ7ijfEmiDExfm5zx4atMx5PxMxMNO2fXNHV2Em
 KIi+DquS41N9qZAX8NlBwVu9IAy4SB49vVd6zG/H0fKbGHtFCDH5oTWeYGXG7h5c9Hey
 9o3fkkZ73qSYqdxJcxFqJakGdO2IWljKA+plyo7BDdmke+yHmUhzOhbtTd/L4ogZTPve
 Al+9p26Y2BP0mravONto+y8EoEJGAEAfdTDpKUj9n0s2TJiyZLiD/p6Ncoby5GcxaTAr
 yS/pfYNe0ZuQUtoiA1+ZrXnhsCaT8V6mCXKPCBJp0cMIeY2BAxz9IugDuN92gTOBAAKL
 JEKg==
X-Gm-Message-State: AA+aEWY+s+wZ/OgGz6gys1qiHFg0tx2tc/l5H0eV0Lq5BcfBu7x1UwfH
 GM79kzF8GT+U56Ra1UcP2vc+lwso
X-Google-Smtp-Source: AFSGD/UT4JpmJNFOsL4BvvrGzHnVikbYs7rgTl4SIUtp5ndhfSFMEm+XOkrPxcphoyVxN0r062SVkA==
X-Received: by 2002:a62:6a88:: with SMTP id
 f130mr18067654pfc.201.1543881324727; 
 Mon, 03 Dec 2018 15:55:24 -0800 (PST)
Received: from aurora.jms.id.au ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id c13sm29393003pfe.93.2018.12.03.15.55.22
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 15:55:24 -0800 (PST)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Tue, 04 Dec 2018 10:25:19 +1030
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc: Discard more sections in linker script
Date: Tue,  4 Dec 2018 10:25:01 +1030
Message-Id: <20181203235502.6366-2-joel@jms.id.au>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203235502.6366-1-joel@jms.id.au>
References: <20181203235502.6366-1-joel@jms.id.au>
MIME-Version: 1.0
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
Cc: Alan Modra <amodra@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Building the ppc64 kernel with a modern binutils results in this
warning:

 powerpc64le-linux-gnu-ld: warning: orphan section `.gnu.hash' from
 `linker stubs' being placed in section `.gnu.hash'

Alan Modra <amodra@gmail.com> explains:

 > .gnu.hash, like .hash, is used by glibc ld.so for dynamic symbol
 > lookup.  I imagine you don't need either section in a kernel, so
 > discarding both sounds reasonable.  Likely you could discard .interp
 > and .dynstr too, and .dynsym when !CONFIG_PPC32.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
See https://lore.kernel.org/lkml/CACPK8Xft3n5KkpTjN3=7_VUCXHFcK7mxvZm2Rrqu7tppcBoyOg@mail.gmail.com/T/#m58532c86cf0c7b4fb01cc1fe724e48d4c7d8e4a7

 arch/powerpc/kernel/vmlinux.lds.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 5c5d559a23fd..e14cde32b003 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -279,8 +279,6 @@ SECTIONS
 		__dynamic_start = .;
 		*(.dynamic)
 	}
-	.hash : AT(ADDR(.hash) - LOAD_OFFSET) { *(.hash) }
-	.interp : AT(ADDR(.interp) - LOAD_OFFSET) { *(.interp) }
 	.rela.dyn : AT(ADDR(.rela.dyn) - LOAD_OFFSET)
 	{
 		__rela_dyn_start = .;
@@ -389,5 +387,8 @@ SECTIONS
 		*(.gnu.version*)
 		*(.gnu.attributes)
 		*(.eh_frame)
+		*(.hash .gnu.hash)
+		*(.interp)
+		*(.dynstr)
 	}
 }
-- 
2.19.1

