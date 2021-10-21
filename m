Return-Path: <SRS0=ebkI=PJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB80DC433EF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Oct 2021 22:42:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45F8060EE5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Oct 2021 22:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 45F8060EE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hb2Y26qkkz3fNC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Oct 2021 09:42:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Kz6AB8Wc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::536;
 helo=mail-pg1-x536.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=Kz6AB8Wc; dkim-atps=neutral
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hb2JF48xvz3cVX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Oct 2021 09:31:09 +1100 (AEDT)
Received: by mail-pg1-x536.google.com with SMTP id g184so1572909pgc.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Oct 2021 15:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lBfegSip8uJBm6f+7E6aCO88l+bAoSzfsmhWLvtW/G4=;
 b=Kz6AB8WcnmJ/zZnC6KOC/fngWeBCphK36oDtWDLCGzYz1Sb/dEWEPLR+EBntiPNI//
 uraUzvjAKyUNEYVx1u/VehHadPr3bCnSpz4foPKwUYLpE9l+iHgbvIjB5aRldJwlqkPc
 qyfPlImb4PMWLomtSEfNv8UNB+NdmOP9cc6hSkjii+5sJvsXLLxwLeGiIEqSRn+A/v/v
 TdwFCBMcdkkyn1JvxiP+YScJHAqDYMg754GlsKppXOWPfSwsFUu/Ns61oJKI116TYLFI
 lTQFuAXZ8ChQz2KYfwPIRf2RrQJdN2YgE+vr9YJJuRM+0Hoij0xNWWOfIMGyN12dhuEs
 eWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lBfegSip8uJBm6f+7E6aCO88l+bAoSzfsmhWLvtW/G4=;
 b=Wy92uiwW1pNVobF5asQT6hyAMGIt6uQo70UYhu0DKY4ftA5JYZwzDJ92lZ3QCSk91x
 8YbzEJUuwciAn7JUEGyk9xL/OlpdPlh+sTt1IoG4MwxRXKQmkaLgXMzZ5JBY/+EL/V2d
 uwI2LRIB11UdnvAbABIflmarJ8z8Pl+X3pwKxnbFflvVWo3nMgvA5S1/QjKL92JVRAwH
 LLs9S6qS9mdHG0fJw5ayu0H+LPHz7lEaYdmoh09ZC3EQmVdd+BLF4ozIHv1A+MG77p5O
 +Xev+ESTHubEe6RFFM/beHkqjvqxhQqS+Kmx/J19NzXgDfhqZOWgzKayV8JffKaYK1qV
 hRgQ==
X-Gm-Message-State: AOAM532VLJjhIZuOHObqHlAJRYek5DBuVo0siNmNWEeRBa3dpZPIUz60
 1falqEnGeBEw4w2zjLDUGfSiVJT0esM=
X-Google-Smtp-Source: ABdhPJxTIVAb6mSWLYBgUwiZTeYu88cwzBg8Wpm7t4H91C96qUz3lD8M/a8ORWA/detuwFLWXfEZNQ==
X-Received: by 2002:a63:f30c:: with SMTP id l12mr6532805pgh.360.1634855467173; 
 Thu, 21 Oct 2021 15:31:07 -0700 (PDT)
Received: from bobo.ibm.com (14-203-144-177.static.tpgi.com.au.
 [14.203.144.177])
 by smtp.gmail.com with ESMTPSA id e6sm7205716pfm.212.2021.10.21.15.31.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Oct 2021 15:31:07 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 17/18] powerpc/configs/microwatt: add POWER9_CPU
Date: Fri, 22 Oct 2021 08:30:12 +1000
Message-Id: <20211021223013.2641952-18-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20211021223013.2641952-1-npiggin@gmail.com>
References: <20211021223013.2641952-1-npiggin@gmail.com>
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

Microwatt implements a subset of ISA v3.0 (which is equivalent to
the POWER9_CPU option).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/configs/microwatt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/configs/microwatt_defconfig b/arch/powerpc/configs/microwatt_defconfig
index 9465209b8c5b..6e62966730d3 100644
--- a/arch/powerpc/configs/microwatt_defconfig
+++ b/arch/powerpc/configs/microwatt_defconfig
@@ -15,6 +15,7 @@ CONFIG_EMBEDDED=y
 # CONFIG_COMPAT_BRK is not set
 # CONFIG_SLAB_MERGE_DEFAULT is not set
 CONFIG_PPC64=y
+CONFIG_POWER9_CPU=y
 # CONFIG_PPC_KUEP is not set
 # CONFIG_PPC_KUAP is not set
 CONFIG_CPU_LITTLE_ENDIAN=y
-- 
2.23.0

