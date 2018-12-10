Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B04C5CFFE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 22:39:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87A182081F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 22:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUOil4zM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A182081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DJ0l20fQzDqjH
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 09:39:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HUOil4zM";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="HUOil4zM"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43DHmz6WYYzDqkk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 09:29:23 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id p8so5923649plo.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 14:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=c4gBFcajzgpVz3mIuYigk+ePJNILjxunDs0Xqtmk9l8=;
 b=HUOil4zMQkESYsbT5xQ6TKy1s+USJP86lty1ko+svfcysoRJzAiyyJrECiMn1Bmo5n
 CIeep1HZR6rcDHIHPGKMmDyHPyHIgYTEqVFRtSNU9EnEMvgzYTovMZKnrSURILyl7oN8
 MJ0aKFrOc2Ee28te8VlRPDNj6LzaJBt5Y7IyCCBP5NO/XxYVpInlmU7hfN6RaIQjZpVk
 auVR5puyDbykaihivyCYzLB3XAjJjlZxCGf6H/LrrG6Agg1C4aOziAzT8/gBo4m9ff90
 7cTGA4chkD0C79zYZSl1TY+Ecfsj06iL2QNmMPigu7vROonWH34j4mS41g/0hqRA4pCD
 3u6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=c4gBFcajzgpVz3mIuYigk+ePJNILjxunDs0Xqtmk9l8=;
 b=VPetAPqU5E1e8DwdFz0ntBCODIHNNPKLlcGtKG9oV/OaCwC9bZFvIvoGrmxEFGO1Qa
 8bRh64/g8EV6SVZz56wXSsGYxIuQhHVm/wcsHQzK1pOMsn0OD06tpbmnXxW6IVdZMuKS
 /OTVCw/0pMj/ShneFC9PPsyYWfNm2klLOGEItSbq7Fo6MyoYaoCLvX2JKcGkUtpNMf5o
 Zg8TuXRbRnTmsQ3j+KS5XBeM/BoevHSYQq2HxDtzlPQ/K/wtD2x2rhEj+e6aS7kfj/VW
 NIw8QpRLDnK/Y9yZi7WGCq9so0ZWc5taCMm9XAbq37PgzCmTu1qmcjZVjPTlPrSxFrS/
 qPqQ==
X-Gm-Message-State: AA+aEWZHeXzv0MzoihIVTwUpxhi/Ui/E8Vt8B9wSVelib2fyCUdKfFXo
 1PDKwYPvLdm2+TUpyQXEIqSPn6wh
X-Google-Smtp-Source: AFSGD/W2d+WDkI0RMN27bcsZTWl/Jf855xvU11FHLI+dkOT6XzKsjvjPafN4b69BUTBMyJ0sE7PeTg==
X-Received: by 2002:a17:902:6a8c:: with SMTP id
 n12mr13850304plk.85.1544480961553; 
 Mon, 10 Dec 2018 14:29:21 -0800 (PST)
Received: from aurora.jms.id.au ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id u137sm20225259pfc.140.2018.12.10.14.29.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Dec 2018 14:29:20 -0800 (PST)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Tue, 11 Dec 2018 08:59:15 +1030
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 3/3] powerpc: Discard .branch_lt section
Date: Tue, 11 Dec 2018 08:58:54 +1030
Message-Id: <20181210222854.21156-4-joel@jms.id.au>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181210222854.21156-1-joel@jms.id.au>
References: <20181210222854.21156-1-joel@jms.id.au>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Alan Modra <amodra@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When building a 32 bit powerpc kernel with Binutils 2.31.1 this warning
is emitted:

 powerpc-linux-gnu-ld: warning: orphan section `.branch_lt' from
 `arch/powerpc/kernel/head_44x.o' being placed in section `.branch_lt'

As of binutils commit 2d7ad24e8726 ("Support PLT16 relocs against local
symbols")[1], 32 bit targets can produce .branch_lt sections in their
output.

These sections should be empty for the kernel build so discard them for
both PPC64 and PPC32.

[1] https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=commitdiff;h=2d7ad24e8726ba4c45c9e67be08223a146a837ce
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2: Discard instead of keep. Alan said "[discarding] can be a recipe for
finding linker bugs", so lets go with that.
---
 arch/powerpc/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 2c93a420f456..af0f81df8bb9 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -316,7 +316,6 @@ SECTIONS
 		DATA_DATA
 		*(.data.rel*)
 		*(.toc1)
-		*(.branch_lt)
 	}
 
 	.opd : AT(ADDR(.opd) - LOAD_OFFSET) {
@@ -388,6 +387,7 @@ SECTIONS
 		*(.hash .gnu.hash)
 		*(.interp)
 		*(.dynstr)
+		*(.branch_lt)
 #ifndef CONFIG_PPC32
 		*(.dynsym)
 #endif
-- 
2.19.1

