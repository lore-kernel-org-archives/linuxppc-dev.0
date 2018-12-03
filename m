Return-Path: <SRS0=NWA6=ON=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A4CC04EB9
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 00:03:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB4752081C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 00:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDGyE3wh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB4752081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4382C46qdczDqQ3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 11:03:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MDGyE3wh";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="MDGyE3wh"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43821d3hCwzDqlX
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 10:55:33 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id u6so7193112pfh.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2018 15:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cDeC9G5ZNTJyUkazJx9lWLmaAK56fapbrvcrVw8dLyM=;
 b=MDGyE3whzZue5/IIjkWpDn/PHcS+NXT7rJoO/pe5cwcSrYDoeqJ2eHvGbY8tCbBwih
 C60dK7iW0bMUjIACctLOpFT7i+ZQ9h83BhvQN8l370Yk71B7ZaCFTmrREjD66zkNH69T
 pas7SEB/kbVsXiXuOn7ArEX7i0Isuiy0QfV1FX5qyQPB4yvzVElKpGbn4zPKCk7SPuaW
 cZKXFHIcCiKZTncBF8fCHP7NZ+CFH4qJg3Mu1vsy7qPn3/1YQxRljs9dD1FMwM68US+d
 FY9zl2KB9wZHF6J5sbwTsppCJgyBYc8IQ2giFZJQUzm5JaoJlGq+3kdFM9RWnJ83GrgD
 AAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=cDeC9G5ZNTJyUkazJx9lWLmaAK56fapbrvcrVw8dLyM=;
 b=sETXarju1prtmivbLo5BxjnNNNsBapOwhjVBRKET9i+9Ckb1HoaIVrwR6OejpjqnRn
 ZgladI6BTMaM8XPbeZgYLJCxYnyItHYx8WSFzxKyWM3kXD4AXLJirTutPPpNNwhIJhks
 Ab9UqKp6LjfWE0se0b4s64wIXsKtStyyD3+NgZ5Iq4HdkofmNcSvlpSlzHstatOtsAU1
 i7erb0l5XfHEahHfk+4aY90HGPYM0elP57CO+r2/+t022/s+x4G7inarRRnuUn4ZW9ok
 wosh/bGetSM9kaJhJ1ji2SFgEGEzZle3jABQmtPVQvuSGUOQH3Ks1R1IAE5Q/ajNFKMy
 hyhA==
X-Gm-Message-State: AA+aEWYO/tq5J3oCFToIs/bGArVMURSIBjuIAK/cqk74SRmXeVktqyZU
 z7wyTe2qxDyJXjsUIfB64k3N/1HG
X-Google-Smtp-Source: AFSGD/V9cuPKO9KhZZHqhm4hWErcVwrfzl2dcIBev1Z8KZgFWClWcNsf7L3Y7coFSNd84BYO3Jc7uw==
X-Received: by 2002:a62:7892:: with SMTP id
 t140mr17765735pfc.237.1543881331126; 
 Mon, 03 Dec 2018 15:55:31 -0800 (PST)
Received: from aurora.jms.id.au ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id y89sm20000557pfa.136.2018.12.03.15.55.28
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 15:55:30 -0800 (PST)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Tue, 04 Dec 2018 10:25:25 +1030
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc: Discard dynsym section for !PPC32
Date: Tue,  4 Dec 2018 10:25:02 +1030
Message-Id: <20181203235502.6366-3-joel@jms.id.au>
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

Alan Modra <amodra@gmail.com> explains:

 > Likely you could discard .interp > and .dynstr too, and .dynsym when
 > !CONFIG_PPC32.

Discarding of interp and dynstr happened in a previous patch. The dynsym
cleanup was a bit less straightforward, so it gets it's own patch.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
See https://lore.kernel.org/lkml/CACPK8Xft3n5KkpTjN3=7_VUCXHFcK7mxvZm2Rrqu7tppcBoyOg@mail.gmail.com/T/#m58532c86cf0c7b4fb01cc1fe724e48d4c7d8e4a7

 arch/powerpc/kernel/vmlinux.lds.S | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index e14cde32b003..49dd678a2de4 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -266,14 +266,13 @@ SECTIONS
 	}
 #ifdef CONFIG_RELOCATABLE
 	. = ALIGN(8);
+#ifdef CONFIG_PPC32
 	.dynsym : AT(ADDR(.dynsym) - LOAD_OFFSET)
 	{
-#ifdef CONFIG_PPC32
 		__dynamic_symtab = .;
-#endif
 		*(.dynsym)
 	}
-	.dynstr : AT(ADDR(.dynstr) - LOAD_OFFSET) { *(.dynstr) }
+#endif
 	.dynamic : AT(ADDR(.dynamic) - LOAD_OFFSET)
 	{
 		__dynamic_start = .;
@@ -390,5 +389,8 @@ SECTIONS
 		*(.hash .gnu.hash)
 		*(.interp)
 		*(.dynstr)
+#ifndef CONFIG_PPC32
+		*(.dynsym)
+#endif
 	}
 }
-- 
2.19.1

