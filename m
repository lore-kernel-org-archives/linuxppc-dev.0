Return-Path: <SRS0=NWA6=ON=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45646C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 01:02:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E30920851
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 01:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GY2n2qvd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E30920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4383WC34cFzDqgC
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 12:02:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GY2n2qvd";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="GY2n2qvd"; 
 dkim-atps=neutral
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4383L82mh9zDqg5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 11:54:56 +1100 (AEDT)
Received: by mail-pg1-x531.google.com with SMTP id 70so6524022pgh.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2018 16:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=peG3XXL+nSraTU4SyZNXqTpiPMjYWqXusdo6G96O6xA=;
 b=GY2n2qvdOiOl/6LdMTAv3tipPfpol5QuURAjFxF4XFpyvGxby84rcp02A9tpbNEun6
 3bex+Zer/lP5mj4O0AUYyVJTGchqqymNukE9a+oNBgQSNMNKH7xh28ZESF+0ABvE+QdI
 vj5WqaFGhxTGFVvvZeQCojVf91NiELB4hS6Z+LLQoPBT8O360LDQqSkL9HYA7LIjrme5
 ND/eO9cm3a1gk8VNaGlUBWBw+rkFUPJoe0+NIiaaGnLbD+50vqmJu9RTRKIx4Tud6vpe
 ZSdJQ56Qqh0xSeCU30Ad52+5mRatAytgRNcbRMvc91lwV21njSkjEw4o4YZo538sKp8A
 ti3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=peG3XXL+nSraTU4SyZNXqTpiPMjYWqXusdo6G96O6xA=;
 b=T2tovTSJY532FklxT6eS0+cB0cB1vqRjaRg4w/wfT5ozDreAfibA9xqBnHg3tK8SbQ
 HR//IW6vd9zMd8arLzM6Ki0rrjqs6jkE8Wk9bZwVA2UjxxJWtu1f4uF9vNy/pus8T3su
 KQUMBvDWTQ6lF33zqh5oMbLtQwpdwRY12jlU99Vs5SwpLi7RpkKrmvJtCVRTp1+uCjW9
 9jfqGEVCon4NpLxiin5LfxzKkeFHV5jt6Zsp/1NLuyAe9nhWj3aR/kelkiVbh9RHO8xZ
 EpugRHhtxlVqSr5gZea+Fqh7oF4PgqOay05dIpn3pRe0VaZ1xzrBz2SdDTPZ0yOPVh5X
 PbkA==
X-Gm-Message-State: AA+aEWbWetIWDBOQnY6BJUiYNWzg5Zy35Nz1hJav57fWf9nFXHxS8cc/
 Xh0t6rLuo3nG6wRoj+vOnyQG/nRP
X-Google-Smtp-Source: AFSGD/U9zBWk3QMC8HFLbzUvXmfnNTjaSxOzmbCNCc5+0lYEOhUYgrBni/TswMxxtNy1Rtyq39dnxg==
X-Received: by 2002:a62:4bcf:: with SMTP id d76mr18944294pfj.170.1543884894068; 
 Mon, 03 Dec 2018 16:54:54 -0800 (PST)
Received: from aurora.jms.id.au ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id w184sm17126468pgd.34.2018.12.03.16.54.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 16:54:53 -0800 (PST)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Tue, 04 Dec 2018 11:24:47 +1030
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/3] powerpc: Discard dynsym section for !PPC32
Date: Tue,  4 Dec 2018 11:24:28 +1030
Message-Id: <20181204005429.32681-3-joel@jms.id.au>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204005429.32681-1-joel@jms.id.au>
References: <20181204005429.32681-1-joel@jms.id.au>
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

Alan Modra <amodra@gmail.com> explains:

 > Likely you could discard .interp > and .dynstr too, and .dynsym when
 > !CONFIG_PPC32.

Discarding of interp and dynstr happened in a previous patch. The dynsym
cleanup was a bit less straightforward, so it gets it's own patch.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
See https://lore.kernel.org/lkml/CACPK8Xft3n5KkpTjN3=7_VUCXHFcK7mxvZm2Rrqu7tppcBoyOg@mail.gmail.com/T/#m58532c86cf0c7b4fb01cc1fe724e48d4c7d8e4a7
---
 arch/powerpc/kernel/vmlinux.lds.S | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 6570209b0671..2c93a420f456 100644
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
@@ -389,5 +388,8 @@ SECTIONS
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

