Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D370C0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 19:54:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9708220657
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 19:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qgIXLFgS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9708220657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42lfF62WdRzF3L1
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 06:54:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qgIXLFgS";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=groeck7@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="qgIXLFgS"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42lfBR6CXRzF3KJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2018 06:52:31 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id 23-v6so7869031pgc.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 12:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=IEjr7pjOKiDHdXZG0NQrJu99vimFXUtb0MuO9FQ7m2I=;
 b=qgIXLFgS1mp5YfifpXqAHs6/G/o/2jFxx7Dra0Zm3PHib/mLyMecCErAekcSfjD9e5
 eoIQrs92AtXWJ0fnU7wUgT3aFMmmaucuzvxtQrjS5OyhHA4y4Uf0rI28syrxoZkSREGT
 +A1mrc3HOuH4Kt9fNsvHQyVItT9hLLQ0XM76ucaBUA1mlA205gdZx6rpfoDos5SQRYYC
 +Qh2XINJHasi5Dfvd57jXsyy1YCckw/365EF/EDHgG2KNeZm7ROBjQmwRWtm3pJLIzKp
 9ORz+XC68xDpXroxMwoIH052RzhwuYnQItWjeHSuNydtpUbxT7e/vAVOO3Jl0OafjRse
 6t1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=IEjr7pjOKiDHdXZG0NQrJu99vimFXUtb0MuO9FQ7m2I=;
 b=GPloDGEHwT5xKSfjhrJVCDjmvSdpfO0fkSQgdPr45cALjgiYakFvPPlcDL8aMsbyU+
 dO96rFgGb84/SBho5IzLCV81aRsKJTzvZXp+m2dhJoeRIqC2O2fHKwqN70WBR63hsNTW
 R9d6w4lmUkpkhoNhriaCUe0Po2mP2WMiGoRVpIa1J8jzxXjZtA7qaPOeBQ4qa6pZDFqQ
 uprCQGrzNQoZDEziUd7B9BDB2YD44vb0xzXHdW99zJ3ySV6OT98UM9DN4Zubdzdy7sqn
 XiM67vjomFC7+hDg4yhGR1KWm8qvw0GjWpsCyzsLjTLgm7fReU0Ft6KX7aChOiI4iMLK
 uNPQ==
X-Gm-Message-State: AGRZ1gIvnMHwsufpv6Asb3o7JnFLjJDWnnlJKxPA9zPmbnjw8TwHHy13
 tCys8Rfbt3miX0KZSQDd6LM=
X-Google-Smtp-Source: AJdET5eN9SB27XJaYjLQBPklnmkS8jmJdZobIhxLvKlL4Mips5LN68ltLYVOn4rRiU/ANweeGx+d9g==
X-Received: by 2002:a62:fb04:: with SMTP id
 x4-v6mr4732905pfm.210.1541015549299; 
 Wed, 31 Oct 2018 12:52:29 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id r5-v6sm36834557pgi.64.2018.10.31.12.52.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 Oct 2018 12:52:28 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
 James Hogan <jhogan@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [RFC PATCH] lib: Introduce generic __cmpxchg_u64() and use it where
 needed
Date: Wed, 31 Oct 2018 12:52:18 -0700
Message-Id: <1541015538-11382-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
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
Cc: linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Some architectures do not or not always support cmpxchg64(). This results
in on/off problems when the function is used in common code. The latest
example is

net/sunrpc/auth_gss/gss_krb5_seal.c: In function 'gss_seq_send64_fetch_and_inc':
net/sunrpc/auth_gss/gss_krb5_seal.c:145:14: error:
	implicit declaration of function 'cmpxchg64'

which is seen with some powerpc and mips builds.

Introduce a generic version of __cmpxchg_u64() and use it for affected
architectures.

Fixes: 21924765862a
	("SUNRPC: use cmpxchg64() in gss_seq_send64_fetch_and_inc()")
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Couple of questions:
- Is this the right (or an acceptable) approach to fix the problem ?
- Should I split the patch into three, one to introduce __cmpxchg_u64()
  and one per architecture ?
- Who should take the patch (series) ?

 arch/mips/Kconfig                  |  1 +
 arch/mips/include/asm/cmpxchg.h    |  3 ++
 arch/powerpc/Kconfig               |  1 +
 arch/powerpc/include/asm/cmpxchg.h |  3 ++
 lib/Kconfig                        |  3 ++
 lib/Makefile                       |  2 ++
 lib/cmpxchg64.c                    | 60 ++++++++++++++++++++++++++++++++++++++
 7 files changed, 73 insertions(+)
 create mode 100644 lib/cmpxchg64.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 80778b40f8fa..7392a5f4e517 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -18,6 +18,7 @@ config MIPS
 	select CPU_PM if CPU_IDLE
 	select DMA_DIRECT_OPS
 	select GENERIC_ATOMIC64 if !64BIT
+	select GENERIC_CMPXCHG64 if !64BIT && SMP
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
diff --git a/arch/mips/include/asm/cmpxchg.h b/arch/mips/include/asm/cmpxchg.h
index 89e9fb7976fe..ca837b05bf3d 100644
--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -206,6 +206,9 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 #define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
 #ifndef CONFIG_SMP
 #define cmpxchg64(ptr, o, n) cmpxchg64_local((ptr), (o), (n))
+#else
+extern u64 __cmpxchg_u64(u64 *p, u64 old, u64 new);
+#define cmpxchg64(ptr, o, n) __cmpxchg_u64((ptr), (o), (n))
 #endif
 #endif
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e84943d24e5c..bd1d99c664c4 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -161,6 +161,7 @@ config PPC
 	select EDAC_ATOMIC_SCRUB
 	select EDAC_SUPPORT
 	select GENERIC_ATOMIC64			if PPC32
+	select GENERIC_CMPXCHG64		if PPC32
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CLOCKEVENTS_BROADCAST	if SMP
 	select GENERIC_CMOS_UPDATE
diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
index 27183871eb3b..da8be4189731 100644
--- a/arch/powerpc/include/asm/cmpxchg.h
+++ b/arch/powerpc/include/asm/cmpxchg.h
@@ -534,8 +534,11 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
 	cmpxchg_acquire((ptr), (o), (n));				\
 })
 #else
+extern u64 __cmpxchg_u64(u64 *p, u64 old, u64 new);
+
 #include <asm-generic/cmpxchg-local.h>
 #define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
+#define cmpxchg64(ptr, o, n) __cmpxchg_u64((ptr), (o), (n))
 #endif
 
 #endif /* __KERNEL__ */
diff --git a/lib/Kconfig b/lib/Kconfig
index d1573a16aa92..2b581a70ded2 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -500,6 +500,9 @@ config NLATTR
 config GENERIC_ATOMIC64
        bool
 
+config GENERIC_CMPXCHG64
+	bool
+
 config LRU_CACHE
 	tristate
 
diff --git a/lib/Makefile b/lib/Makefile
index 988949c4fd3a..4646a06ed418 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -172,6 +172,8 @@ obj-$(CONFIG_GENERIC_CSUM) += checksum.o
 
 obj-$(CONFIG_GENERIC_ATOMIC64) += atomic64.o
 
+obj-$(CONFIG_GENERIC_CMPXCHG64) += cmpxchg64.o
+
 obj-$(CONFIG_ATOMIC64_SELFTEST) += atomic64_test.o
 
 obj-$(CONFIG_CPU_RMAP) += cpu_rmap.o
diff --git a/lib/cmpxchg64.c b/lib/cmpxchg64.c
new file mode 100644
index 000000000000..239c43d05d00
--- /dev/null
+++ b/lib/cmpxchg64.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generic implementation of cmpxchg64().
+ * Derived from implementation in arch/sparc/lib/atomic32.c
+ * and from locking code implemented in lib/atomic32.c.
+ */
+
+#include <linux/cache.h>
+#include <linux/export.h>
+#include <linux/irqflags.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+/*
+ * We use a hashed array of spinlocks to provide exclusive access
+ * to each variable. Since this is expected to used on systems
+ * with small numbers of CPUs (<= 4 or so), we use a relatively
+ * small array of 16 spinlocks to avoid wasting too much memory
+ * on the spinlock array.
+ */
+#define NR_LOCKS	16
+
+/* Ensure that each lock is in a separate cacheline */
+static union {
+	raw_spinlock_t lock;
+	char pad[L1_CACHE_BYTES];
+} cmpxchg_lock[NR_LOCKS] __cacheline_aligned_in_smp = {
+	[0 ... (NR_LOCKS - 1)] = {
+		.lock =  __RAW_SPIN_LOCK_UNLOCKED(cmpxchg_lock.lock),
+	},
+};
+
+static inline raw_spinlock_t *lock_addr(const u64 *v)
+{
+	unsigned long addr = (unsigned long) v;
+
+	addr >>= L1_CACHE_SHIFT;
+	addr ^= (addr >> 8) ^ (addr >> 16);
+	return &cmpxchg_lock[addr & (NR_LOCKS - 1)].lock;
+}
+
+/*
+ * Generic version of __cmpxchg_u64, to be used for cmpxchg64().
+ * Takes u64 parameters.
+ */
+u64 __cmpxchg_u64(u64 *ptr, u64 old, u64 new)
+{
+	raw_spinlock_t *lock = lock_addr(ptr);
+	unsigned long flags;
+	u64 prev;
+
+	raw_spin_lock_irqsave(lock, flags);
+	prev = READ_ONCE(*ptr);
+	if (prev == old)
+		*ptr = new;
+	raw_spin_unlock_irqrestore(lock, flags);
+
+	return prev;
+}
+EXPORT_SYMBOL(__cmpxchg_u64);
-- 
2.7.4

