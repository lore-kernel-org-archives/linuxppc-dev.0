Return-Path: <SRS0=5tyt=IO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46690C433E9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Mar 2021 17:51:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9930A65104
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Mar 2021 17:51:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9930A65104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F0LSl5zxNz30QC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Mar 2021 04:51:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=merlin.20170209 header.b=1b8wl9YJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1234::107; helo=merlin.infradead.org;
 envelope-from=geoff@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=merlin.20170209 header.b=1b8wl9YJ; 
 dkim-atps=neutral
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1234::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F0LSK6tkdz30Dp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Mar 2021 04:51:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Date:Cc:To:Subject:From:References:
 In-Reply-To:Message-Id:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=daDjuKp3v3AZM2+NFJem86trbpyHiWImyVHebGvZ5qw=; b=1b8wl9YJJ4XP3gzEKbLqvhrITo
 +IklB+LnXnWPzeWOHIrQjOL4yS/vmWhv1xWo46L9XMZt6pgjix45F72mad9EiSwjbsI7lRrAZvNIt
 rsdYMXIxhudBIlXvfNP/vKgOWiDB5nU3OfDqn/jnpLiZQ5A8sbcnUA7ikPeJDMBMLCmysPbdyGihA
 K4FYiJOUEI3Wu5Y8IZ/4dZVVb2WtJTXBoVo+Iez7Xq2yJP8rvB4KejosOWatZeT5HwebQWESjaQ6m
 nBzTYwtpsVB9LvQ0iJuF92GFNBaeakcYsF/Xk2tkQ4O5YDPUVWrG4ab9dOrlujpbRjb3hc4RATj1G
 GCJ5HhIg==;
Received: from geoff by merlin.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lMDqV-001UqZ-Rw; Tue, 16 Mar 2021 17:51:09 +0000
Message-Id: <7bee1153671a3ec71775246887894eefbfcb4b25.1615916650.git.geoff@infradead.org>
In-Reply-To: <cover.1615916650.git.geoff@infradead.org>
References: <cover.1615916650.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Patch-Date: Sat, 13 Mar 2021 18:43:16 -0800
Subject: [PATCH v1 2/2] powerpc/ps3: Re-align DTB in image
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 16 Mar 2021 17:51:07 +0000
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

Change the PS3 linker script to align the DTB at 8 bytes,
the same alignment as that of the of the 'generic' powerpc
linker script.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/powerpc/boot/zImage.ps3.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/zImage.ps3.lds.S b/arch/powerpc/boot/zImage.ps3.lds.S
index 7b2ff2eaa73a..d0ffb493614d 100644
--- a/arch/powerpc/boot/zImage.ps3.lds.S
+++ b/arch/powerpc/boot/zImage.ps3.lds.S
@@ -8,7 +8,7 @@ SECTIONS
   .kernel:vmlinux.bin : { *(.kernel:vmlinux.bin) }
   _vmlinux_end =  .;
 
-  . = ALIGN(4096);
+  . = ALIGN(8);
   _dtb_start = .;
   .kernel:dtb : { *(.kernel:dtb) }
   _dtb_end = .;
-- 
2.25.1

