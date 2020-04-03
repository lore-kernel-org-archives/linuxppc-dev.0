Return-Path: <SRS0=ATRk=5T=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67113C43331
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2020 09:37:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1195D20737
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2020 09:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2cms1uw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1195D20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48tvxG0hQNzDrFD
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2020 20:37:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::643;
 helo=mail-pl1-x643.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=b2cms1uw; dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48tvtk2yR8zDqB5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2020 20:35:41 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id e1so2490436plt.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2020 02:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MjgkoeP0/roLx7D9QHzWKoIMPSg37cQSwDFsx+pToN8=;
 b=b2cms1uw77spAu+WAeXdwr8XKVeYEytzad/tl2C9vF2a0F3SAIkueK9Ak4067OiPHt
 p0nqWC69dJZWBMhONH6K5AfKyubkVvKgKJxZmkxvmXCnKQ045J2+pIZUsQYJKmlravH2
 hs3Yee2pzR3ANWWAQtBHOBTxYVja0HhsBJWLX94sUxiebn+jTQG4MEJnplPsjgUECPXd
 ftlX6Y1eCq/sOtQLa7CkWdodjkGaYFBJFGl9l9qJGnj8GwKH6mP5i7JhkcgV5Fyb2NKd
 uyL8ZVfIT3oYUwR3Zj4+SI0OJhRHMb4RR0p1B6KPnO7Xj+j4xd1MHDD20Xq1y9KJB237
 BImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MjgkoeP0/roLx7D9QHzWKoIMPSg37cQSwDFsx+pToN8=;
 b=Pv63rqy/IxNyhDah06aWqU/BBZN1Qgei3Nv53ZLSJzRz+Tc/AKV3CHZEI5AzlvPPOM
 xVv9wf8QiyTjvmSX92uSFqimoYXLpdC7736RB+ElLFGJyCvz+8cXo6f3o1SOd8nJFy2L
 KPk9x5azjBZVQzQ8AR6Jy6USDkFP0C6YRaPXyyDCewFB3p9xe2AoIrZ389fRNHmcmFUz
 /kDwb6Q1zKUu1EtaaOpf3HOYA23zzIVnmjkVgXn6Bs6r2kKXhQ6deESH43wO3KOW53iO
 VJ/VPWyw8XMad7nRA57lIlGEsjhuJVq7jzEoE9SbJWLtdCGaC9AIR4lpg3pce/TDiKLW
 1fPA==
X-Gm-Message-State: AGi0PuZL21m3pbSX6KcBsl0tgJAVJ4a/O/0VVJyokR0exRVDCRikSHT3
 l/XsUc0k967prT6iQNt8Kx3XAHTU
X-Google-Smtp-Source: APiQypIRuc2EB0WTT6O+Id0bN83sdd5nRnQq7Dw1spa1SiQqeTKUB3jjjfgK1u2Ifg79nev+d+nRHQ==
X-Received: by 2002:a17:90a:26e3:: with SMTP id
 m90mr8918565pje.144.1585906539305; 
 Fri, 03 Apr 2020 02:35:39 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (60-241-117-97.tpgi.com.au. [60.241.117.97])
 by smtp.gmail.com with ESMTPSA id i7sm5502677pfq.217.2020.04.03.02.35.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 02:35:38 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/4] powerpc/64s: implement probe_kernel_read/write without
 touching AMR
Date: Fri,  3 Apr 2020 19:35:26 +1000
Message-Id: <20200403093529.43587-1-npiggin@gmail.com>
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

There is no need to allow user accesses when probing kernel addresses.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
v2:
- Enable for all powerpc (suggested by Christophe)
- Fold helper function together (Christophe)
- Rename uaccess.c to maccess.c to match kernel/maccess.c.

 arch/powerpc/include/asm/uaccess.h | 25 +++++++++++++++-------
 arch/powerpc/lib/Makefile          |  2 +-
 arch/powerpc/lib/maccess.c         | 34 ++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 9 deletions(-)
 create mode 100644 arch/powerpc/lib/maccess.c

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 2f500debae21..670910df3cc7 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -341,8 +341,8 @@ raw_copy_in_user(void __user *to, const void __user *from, unsigned long n)
 }
 #endif /* __powerpc64__ */
 
-static inline unsigned long raw_copy_from_user(void *to,
-		const void __user *from, unsigned long n)
+static inline unsigned long
+raw_copy_from_user_allowed(void *to, const void __user *from, unsigned long n)
 {
 	unsigned long ret;
 	if (__builtin_constant_p(n) && (n <= 8)) {
@@ -351,19 +351,19 @@ static inline unsigned long raw_copy_from_user(void *to,
 		switch (n) {
 		case 1:
 			barrier_nospec();
-			__get_user_size(*(u8 *)to, from, 1, ret);
+			__get_user_size_allowed(*(u8 *)to, from, 1, ret);
 			break;
 		case 2:
 			barrier_nospec();
-			__get_user_size(*(u16 *)to, from, 2, ret);
+			__get_user_size_allowed(*(u16 *)to, from, 2, ret);
 			break;
 		case 4:
 			barrier_nospec();
-			__get_user_size(*(u32 *)to, from, 4, ret);
+			__get_user_size_allowed(*(u32 *)to, from, 4, ret);
 			break;
 		case 8:
 			barrier_nospec();
-			__get_user_size(*(u64 *)to, from, 8, ret);
+			__get_user_size_allowed(*(u64 *)to, from, 8, ret);
 			break;
 		}
 		if (ret == 0)
@@ -371,9 +371,18 @@ static inline unsigned long raw_copy_from_user(void *to,
 	}
 
 	barrier_nospec();
-	allow_read_from_user(from, n);
 	ret = __copy_tofrom_user((__force void __user *)to, from, n);
-	prevent_read_from_user(from, n);
+	return ret;
+}
+
+static inline unsigned long
+raw_copy_from_user(void *to, const void __user *from, unsigned long n)
+{
+	unsigned long ret;
+
+	allow_read_from_user(to, n);
+	ret = raw_copy_from_user_allowed(to, from, n);
+	prevent_read_from_user(to, n);
 	return ret;
 }
 
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index b8de3be10eb4..77af10ad0b0d 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -16,7 +16,7 @@ CFLAGS_code-patching.o += -DDISABLE_BRANCH_PROFILING
 CFLAGS_feature-fixups.o += -DDISABLE_BRANCH_PROFILING
 endif
 
-obj-y += alloc.o code-patching.o feature-fixups.o pmem.o
+obj-y += alloc.o code-patching.o feature-fixups.o pmem.o maccess.o
 
 ifndef CONFIG_KASAN
 obj-y	+=	string.o memcmp_$(BITS).o
diff --git a/arch/powerpc/lib/maccess.c b/arch/powerpc/lib/maccess.c
new file mode 100644
index 000000000000..ce5465db1e2d
--- /dev/null
+++ b/arch/powerpc/lib/maccess.c
@@ -0,0 +1,34 @@
+#include <linux/mm.h>
+#include <linux/uaccess.h>
+
+/*
+ * Override the generic weak linkage functions to avoid changing KUP state via
+ * the generic user access functions, as this is accessing kernel addresses.
+ */
+long probe_kernel_read(void *dst, const void *src, size_t size)
+{
+	long ret;
+	mm_segment_t old_fs = get_fs();
+
+	set_fs(KERNEL_DS);
+	pagefault_disable();
+	ret = raw_copy_from_user_allowed(dst, (__force const void __user *)src, size);
+	pagefault_enable();
+	set_fs(old_fs);
+
+	return ret ? -EFAULT : 0;
+}
+
+long probe_kernel_write(void *dst, const void *src, size_t size)
+{
+	long ret;
+	mm_segment_t old_fs = get_fs();
+
+	set_fs(KERNEL_DS);
+	pagefault_disable();
+	ret = raw_copy_to_user_allowed((__force void __user *)dst, src, size);
+	pagefault_enable();
+	set_fs(old_fs);
+
+	return ret ? -EFAULT : 0;
+}
-- 
2.23.0

