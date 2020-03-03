Return-Path: <SRS0=Civx=4U=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EC7C3F2D1
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Mar 2020 01:29:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4371324673
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Mar 2020 01:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buAZSDJA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4371324673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48WfZL6RXjzDqfv
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Mar 2020 12:29:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1043;
 helo=mail-pj1-x1043.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=buAZSDJA; dkim-atps=neutral
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48WfXK2jMJzDqXZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Mar 2020 12:28:01 +1100 (AEDT)
Received: by mail-pj1-x1043.google.com with SMTP id m7so525268pjs.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Mar 2020 17:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZVj2X/81WCTpFsIK2e8dqnIoQY3Y8oBDa4zdgXAM5a4=;
 b=buAZSDJAbWamKExrpVAVltCzA//Efs87pEt632H0VfIfloJPHjzQ9ac6hSOBCs/ode
 Fo0Yfdes9v6ChA+w7Cbe/XLCcZoTEpvYtVyv7SW1P+fPaKxagRW3UL3jGlBEVoxCZPfF
 tsy9ILpVI+N4jj9Iv6CbDO6ujl2pMktmnnez/c9ageHjR5UKrgl8sdDtMuPPBvdvfdvb
 O7U3d6vcLisH5TTo0kaoMkdK1y1AGVQQgkn6GpNOvLrK6Rl1iFCdIxdkYp1LHRKabqwr
 bzCOLnY5kCXgytgG7grqPhPq7SJVERp3HLsw+Eard/0DVX0wETFg+f5NHEHZklv0Tdrq
 WJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZVj2X/81WCTpFsIK2e8dqnIoQY3Y8oBDa4zdgXAM5a4=;
 b=EiA3/0my4h6rD2zU5C6LhKmjeJgvxRFtyovnV/xzynZ0FqKUT23twAAme7YlAHsYfE
 9k4HvzVRM9CT3zy1w7CR+6lup/gBiVGBBByrvTnxktdrZvEQDHLMz5zNiCQn4kUHR6O5
 YNRQhcEA577siVFtAzuA5HYU4b3VYsnGC+Lwk+1xQlrp1/rvgzGvyxcJleKAmVCk1hVI
 FUdXZqhOkWc8ZyfQSakeoqiP1vvIjfC0ILrVyfFQJFngLkJi0I7RqEK0eoq5IcUAdFon
 iffP9Gz01cBlNsiF9fJUOibcCYYI/5NZewltzcODxAeV1MRml5F0OEqvlnZa6rn9bHH1
 gRAQ==
X-Gm-Message-State: ANhLgQ1b0CCcC3O6ShzhoT1DB4cruQJVaODRudwgIqBvGt2gIJ/FolNd
 K5jttMCsNquGfcCM02yc6QlbHzAb
X-Google-Smtp-Source: ADFU+vswYhO704DVICorzZ6A+LQuqDJrinCp8y0Gvd7f81xVCOXOmoJyF1s/slaK2WVNmFMCUqIMPg==
X-Received: by 2002:a17:90a:9416:: with SMTP id
 r22mr1432734pjo.2.1583198877133; 
 Mon, 02 Mar 2020 17:27:57 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (193-116-117-248.tpgi.com.au.
 [193.116.117.248])
 by smtp.gmail.com with ESMTPSA id md5sm349141pjb.0.2020.03.02.17.27.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 17:27:56 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/build: vdso linker warning for orphan sections
Date: Tue,  3 Mar 2020 11:27:48 +1000
Message-Id: <20200303012748.4190929-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/vdso32/Makefile     | 2 +-
 arch/powerpc/kernel/vdso32/vdso32.lds.S | 1 +
 arch/powerpc/kernel/vdso64/Makefile     | 2 +-
 arch/powerpc/kernel/vdso64/vdso64.lds.S | 3 ++-
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/vdso32/Makefile b/arch/powerpc/kernel/vdso32/Makefile
index e147bbdc12cd..87ab1152d5ce 100644
--- a/arch/powerpc/kernel/vdso32/Makefile
+++ b/arch/powerpc/kernel/vdso32/Makefile
@@ -50,7 +50,7 @@ $(obj-vdso32): %.o: %.S FORCE
 
 # actual build commands
 quiet_cmd_vdso32ld = VDSO32L $@
-      cmd_vdso32ld = $(VDSOCC) $(c_flags) $(CC32FLAGS) -o $@ -Wl,-T$(filter %.lds,$^) $(filter %.o,$^)
+      cmd_vdso32ld = $(VDSOCC) $(c_flags) $(CC32FLAGS) -o $@ $(call cc-ldoption, -Wl$(comma)--orphan-handling=warn) -Wl,-T$(filter %.lds,$^) $(filter %.o,$^)
 quiet_cmd_vdso32as = VDSO32A $@
       cmd_vdso32as = $(VDSOCC) $(a_flags) $(CC32FLAGS) -c -o $@ $<
 
diff --git a/arch/powerpc/kernel/vdso32/vdso32.lds.S b/arch/powerpc/kernel/vdso32/vdso32.lds.S
index 5206c2eb2a1d..4c985467a668 100644
--- a/arch/powerpc/kernel/vdso32/vdso32.lds.S
+++ b/arch/powerpc/kernel/vdso32/vdso32.lds.S
@@ -111,6 +111,7 @@ SECTIONS
 		*(.note.GNU-stack)
 		*(.data .data.* .gnu.linkonce.d.* .sdata*)
 		*(.bss .sbss .dynbss .dynsbss)
+		*(.glink .iplt .plt .rela*)
 	}
 }
 
diff --git a/arch/powerpc/kernel/vdso64/Makefile b/arch/powerpc/kernel/vdso64/Makefile
index 32ebb3522ea1..38c317f25141 100644
--- a/arch/powerpc/kernel/vdso64/Makefile
+++ b/arch/powerpc/kernel/vdso64/Makefile
@@ -34,7 +34,7 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
 
 # actual build commands
 quiet_cmd_vdso64ld = VDSO64L $@
-      cmd_vdso64ld = $(CC) $(c_flags) -o $@ -Wl,-T$(filter %.lds,$^) $(filter %.o,$^)
+      cmd_vdso64ld = $(CC) $(c_flags) -o $@ -Wl,-T$(filter %.lds,$^) $(filter %.o,$^) $(call cc-ldoption, -Wl$(comma)--orphan-handling=warn)
 
 # install commands for the unstripped file
 quiet_cmd_vdso_install = INSTALL $@
diff --git a/arch/powerpc/kernel/vdso64/vdso64.lds.S b/arch/powerpc/kernel/vdso64/vdso64.lds.S
index 256fb9720298..4e3a8d4ee614 100644
--- a/arch/powerpc/kernel/vdso64/vdso64.lds.S
+++ b/arch/powerpc/kernel/vdso64/vdso64.lds.S
@@ -30,7 +30,7 @@ SECTIONS
 	. = ALIGN(16);
 	.text		: {
 		*(.text .stub .text.* .gnu.linkonce.t.* __ftr_alt_*)
-		*(.sfpr .glink)
+		*(.sfpr)
 	}						:text
 	PROVIDE(__etext = .);
 	PROVIDE(_etext = .);
@@ -111,6 +111,7 @@ SECTIONS
 		*(.branch_lt)
 		*(.data .data.* .gnu.linkonce.d.* .sdata*)
 		*(.bss .sbss .dynbss .dynsbss)
+		*(.glink .iplt .plt .rela*)
 	}
 }
 
-- 
2.23.0

