Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F51C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 21:31:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43E6320883
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 21:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="dJkH3pTk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E6320883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44f0pY2SC7zDq9s
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 07:31:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=rasmusvillemoes.dk
 (client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com;
 envelope-from=linux@rasmusvillemoes.dk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.b="dJkH3pTk"; dkim-atps=neutral
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44f0hW2JQwzDqJL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 07:26:03 +1000 (AEST)
Received: by mail-ed1-x544.google.com with SMTP id s16so140175edr.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Apr 2019 14:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QJAxNVsdZpvgQ0lycDmUvZ/w5aUsw9h9L87n2JSUnEY=;
 b=dJkH3pTk5Euyl6AnuMTJVWpsHfbXhza0vHCBLB/kgIB/5IVjmFm+TZMTTZfA8ZCPIu
 yQiCbVbv4J51PAnNP5TOkxdC2ztuNqrvxYRVB3esWN7AnwbF6R+aA869+HMRaGeMp2ih
 7g60BKCA5L44+IsOaByY2KVh0D8iMGvH9Yhro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QJAxNVsdZpvgQ0lycDmUvZ/w5aUsw9h9L87n2JSUnEY=;
 b=e5Zp8KgrGE8rOFfuTkJuSrZq9mMVIjdIOmR0cJYjIzIQL8eXYesod+0GaRG17dldHh
 1zeJjYIVvqX1CpJZ/1m9oWPpImzer5FWaKHuNpiHpNFQXfCfSbUw4fZn/ymKyOWkzTS+
 9fLX+VPObRr7QMyfhv7fu2W6Gwn9Exr67ljQ1XBnLeBP5AZJAfTEhLMCr2j4lbXVrQnF
 zzya7zBEojsETReuIQcUNaUGvuB2G5n7j3jqIU32poDLrftqRe2gHxR2qDhpeabXC/U6
 9xvzwfITy69PqqL3vBJv6YP9SCQyNTSdHcuLGBo6+C97p1Z9yNFOzKVTi2adTb501Ssj
 WIow==
X-Gm-Message-State: APjAAAVTAd1nu3w1oHqNKc9V8vqtvya04z2npO5I3H36CnmfMIi2QmKi
 Re00j1L4a6vNPhdg4YFF5sGFcw==
X-Google-Smtp-Source: APXvYqx92lGbh5GjPk75seT6pvqLK58Ld7lPc1nByda+1LtFL6qiVgkxzGCRs7R0ZEXtFBJ7TZrwUA==
X-Received: by 2002:a50:9438:: with SMTP id p53mr24334679eda.92.1554845160122; 
 Tue, 09 Apr 2019 14:26:00 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-118-63.cgn.fibianet.dk.
 [5.186.118.63])
 by smtp.gmail.com with ESMTPSA id i26sm3477986ejc.51.2019.04.09.14.25.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Apr 2019 14:25:59 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 10/10] powerpc: select DYNAMIC_DEBUG_RELATIVE_POINTERS for
 PPC64
Date: Tue,  9 Apr 2019 23:25:17 +0200
Message-Id: <20190409212517.7321-11-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190409212517.7321-1-linux@rasmusvillemoes.dk>
References: <20190409212517.7321-1-linux@rasmusvillemoes.dk>
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
Cc: Jason Baron <jbaron@akamai.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Similar to GENERIC_BUG_RELATIVE_POINTERS, one can now relativize the
four const char* members of struct _ddebug, thus saving 16 bytes per
instance (one for each pr_debug(), dev_debug() etc. in a
CONFIG_DYNAMIC_DEBUG kernel). The asm-generic implementation seems to
work out-of-the-box, though this is only compile-tested.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/powerpc/Kconfig            | 1 +
 arch/powerpc/include/asm/Kbuild | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2d0be82c3061..6821c8ae1d62 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -155,6 +155,7 @@ config PPC
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS
 	select DCACHE_WORD_ACCESS		if PPC64 && CPU_LITTLE_ENDIAN
+	select DYNAMIC_DEBUG_RELATIVE_POINTERS	if PPC64
 	select DYNAMIC_FTRACE			if FUNCTION_TRACER
 	select EDAC_ATOMIC_SCRUB
 	select EDAC_SUPPORT
diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
index a0c132bedfae..f332e202192a 100644
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -3,6 +3,7 @@ generated-y += syscall_table_64.h
 generated-y += syscall_table_c32.h
 generated-y += syscall_table_spu.h
 generic-y += div64.h
+generic-y += dynamic_debug.h
 generic-y += export.h
 generic-y += irq_regs.h
 generic-y += local64.h
-- 
2.20.1

