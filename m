Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C75ECDE43
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 15:17:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 999F32145D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 15:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 999F32145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42c8fH4JYFzF3cP
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Oct 2018 02:17:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42c8bm6KgpzF3bR
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Oct 2018 02:15:00 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42c8bg0gMsz9ttS0;
 Fri, 19 Oct 2018 17:14:55 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 5yksk3zlssSd; Fri, 19 Oct 2018 17:14:55 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42c8bf6rrWz9ttRV;
 Fri, 19 Oct 2018 17:14:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D382B8B93C;
 Fri, 19 Oct 2018 17:14:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id PDDxes12-UzN; Fri, 19 Oct 2018 17:14:54 +0200 (CEST)
Received: from pc13168vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9A7118B935;
 Fri, 19 Oct 2018 17:14:54 +0200 (CEST)
Received: by pc13168vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 5FF53674CC; Fri, 19 Oct 2018 15:14:54 +0000 (UTC)
Message-Id: <336eb81e62d6c683a69d312f533899dcb6bcf770.1539959864.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH] mm: add probe_user_read() and probe_user_address()
To: Kees Cook <keescook@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 19 Oct 2018 15:14:54 +0000 (UTC)
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In the powerpc, there are several places implementing safe
access to user data. This is sometimes implemented using
probe_kerne_address() with additional access_ok() verification,
sometimes with get_user() enclosed in a pagefault_disable()/enable()
pair, etc... :
    show_user_instructions()
    bad_stack_expansion()
    p9_hmi_special_emu()
    fsl_pci_mcheck_exception()
    read_user_stack_64()
    read_user_stack_32() on PPC64
    read_user_stack_32() on PPC32
    power_pmu_bhrb_to()

In the same spirit as probe_kernel_read() and probe_kernel_address(),
this patch adds probe_user_read() and probe_user_address().

probe_user_read() does the same as probe_kernel_read() but
first checks that it is really a user address.

probe_user_address() is a shortcut to probe_user_read()

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 include/linux/uaccess.h | 10 ++++++++++
 mm/maccess.c            | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index efe79c1cdd47..fb00e3f847d7 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -266,6 +266,16 @@ extern long strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count);
 #define probe_kernel_address(addr, retval)		\
 	probe_kernel_read(&retval, addr, sizeof(retval))
 
+/**
+ * probe_user_address(): safely attempt to read from a user location
+ * @addr: address to read from
+ * @retval: read into this variable
+ *
+ * Returns 0 on success, or -EFAULT.
+ */
+#define probe_user_address(addr, retval)		\
+	probe_user_read(&(retval), addr, sizeof(retval))
+
 #ifndef user_access_begin
 #define user_access_begin() do { } while (0)
 #define user_access_end() do { } while (0)
diff --git a/mm/maccess.c b/mm/maccess.c
index ec00be51a24f..85d4a88a6917 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -67,6 +67,39 @@ long __probe_kernel_write(void *dst, const void *src, size_t size)
 EXPORT_SYMBOL_GPL(probe_kernel_write);
 
 /**
+ * probe_user_read(): safely attempt to read from a user location
+ * @dst: pointer to the buffer that shall take the data
+ * @src: address to read from
+ * @size: size of the data chunk
+ *
+ * Safely read from address @src to the buffer at @dst.  If a kernel fault
+ * happens, handle that and return -EFAULT.
+ *
+ * We ensure that the copy_from_user is executed in atomic context so that
+ * do_page_fault() doesn't attempt to take mmap_sem.  This makes
+ * probe_user_read() suitable for use within regions where the caller
+ * already holds mmap_sem, or other locks which nest inside mmap_sem.
+ */
+
+long __weak probe_user_read(void *dst, const void *src, size_t size)
+	__attribute__((alias("__probe_user_read")));
+
+long __probe_user_read(void *dst, const void __user *src, size_t size)
+{
+	long ret;
+
+	if (!access_ok(VERIFY_READ, src, size))
+		return -EFAULT;
+
+	pagefault_disable();
+	ret = __copy_from_user_inatomic(dst, src, size);
+	pagefault_enable();
+
+	return ret ? -EFAULT : 0;
+}
+EXPORT_SYMBOL_GPL(probe_user_read);
+
+/**
  * strncpy_from_unsafe: - Copy a NUL terminated string from unsafe address.
  * @dst:   Destination address, in kernel space.  This buffer must be at
  *         least @count bytes long.
-- 
2.13.3

