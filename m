Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1495D606A8A1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TatUIIgI
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQR013qjDz30g6;
	Fri, 13 Nov 2026 03:38:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794501489;
	cv=none; b=h3qD5dQCHBeifwDbOLTKyy5GFNIdOaDlA5IkN6QZtJ4hQyzv8BsJZ7alfaTFm+PSGHj5TGfRFYl7woEZLjYzYvfuKa8Oyzzb/g6vVMU3rBD3r3hKKMyTcEO1qzUIiEBtmV5zMYI43KEwDlRy9l0LGjirZUrvUtg9hhNu28O7+aNrhjzfTDCkGJGztoxpFAXmZT8oQ+TEV84OJw/u/bRsQKlDFLpfydG98t/8w3GrAGh5qW/L1L1V17s8znsS/25Ym3KSVsWzr+F0IXCK1OApp0jIskYbLLnysBm3Mtx0ERulqNOfydnXGo2YA1jsoTCv5FwvphicC64iQw4WBfacew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794501489; c=relaxed/relaxed;
	bh=G0+SfEEtgrOulP8YQCHeN+Vv1NUh1Gn7/+60elZfXAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R9p+Dg3DJe5wg33TuJrVgVOfU9MnIdnRNLKv/gFQ7Wm2XNt+7xuqvVXbsbhHr13sJj3QZLgqN3pdoS0bkH0pWINUPvxC8Pl/NZLSGPMuTJF/W9ZsjcDxvsCY7f2BuaQ0olMvwjNizKFbobqd0khIhC4GMaJNyjRzndyJKRWgwwrCh5R3Gi1ZH2VTO4sEFlwpdUuL0w1YumtXiIxm58diVwYIUuvnFvuUAN/x6N0h90zqoafK2Z7Z4O4zvGhGYEJXuxq3lZwZ/uptds0Z8cSbeL+bhqqUvIfQ1rPqH+Et5DtjsYgvvdvoSVtb03iDmiR9IKJHLuawS/5qzJJX2yKT6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TatUIIgI; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TatUIIgI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQR004sGtz30WS
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 03:38:08 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C9C2362330;
	Thu, 12 Nov 2026 16:38:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405ED1F000C6;
	Thu, 12 Nov 2026 16:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794501486;
	bh=G0+SfEEtgrOulP8YQCHeN+Vv1NUh1Gn7/+60elZfXAY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TatUIIgIPY9Rk2yojUYtl53O8qWT0lJaotYE+vgGtEQjE5+HBsMGO2D9JA2Mvp18/
	 IxX2JabQ4+fakTZ7OaJFOutCI5W5hiX2scmPGO21tNUwYTI2BKtmrvoym+vG0XnSFu
	 v/iFHm2REmIp2p/BLc8ESGX5tetaHaH0yBD9VxLlDUZejx966x6VG7KUPCg6fNaOqF
	 LyAgrEcHkkE0wSJ/MXSk7qyDLnWTFOR5wRqXK+N9/IKnI9DlTS+i9tiPPIdfhdfvgT
	 FSn0qxpGwPBVsY/1nme6/cGu5P3ERoZG9wcvEC+luDl5JZW0xKPudmSbZcBNFKytc5
	 AnlfkNK/qGtkg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Nov 2026 17:37:09 +0100
Subject: [PATCH RFC 3/4] crash_dump: recover from a machine check in
 copy_oldmem_page()
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-work-procfs-oldmem-v1-3-ecdcafd99265@kernel.org>
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
In-Reply-To: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Breno Leitao <leitao@debian.org>, Chris Mason <mason@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, x86@kernel.org, 
 kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Hildenbrand <david@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=7829; i=brauner@kernel.org;
 h=from:subject:message-id; bh=rgiGrvL4YSbWob21DTwG36MqG+gKRCzUU+Rt+CJ7Fjs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR9fR1dt0Zqqdri1WqxXOYsx75fe28o6K3fXu+jFLCq5
 +TWXnOVjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlsmcbI8H7S5VUxb95YlZzy
 dN5pl71g5bw85r9WF7Jd91UmP+bfeYyR4e47l78h+58rsX75utbPg6NrxVZnuVkK9gfeHHrykld
 LjAsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A capture kernel reads the memory of the crashed kernel, and that memory
may well have uncorrectable errors. That is after all what the first
kernel often died of. Every architecture that maps a page of the old
kernel and copies it out does so with copy_to_iter(), and a machine
check in that copy takes the capture kernel down.

On x86 a machine check in the kernel is only recovered from if the
instruction that took it has a machine check safe exception table entry
or copies from userspace (cf. error_context()). The copy of an old page
is neither. Its source is kernel memory, whether it goes to the buffer
of a read() or, since commit 4a22fd20379c ("vmcore: convert
__read_vmcore to use an iov_iter"), into a kernel page for splice(),
sendfile() and copy_file_range(). So a read of /proc/vmcore that runs
into a poisoned page panics the capture kernel, and so do vmcore's own
reads of the ELF headers and notes. Breno sees the result on a fleet:
the first kernel dies of a machine check and the capture kernel produces
no usable vmcore at all (cf. [1]).

On book3s64 a machine check in the kernel is recovered from if the
instruction that took it has an exception table entry (cf.
mce_common_process_ue()). The user copy has them, so a read() comes up
short there and read_from_oldmem() returns -EFAULT. The copies into
kernel pages have none and panic the same way. Other powerpc platforms
don't recover from a machine check in such a copy at all.

Copy with _copy_mc_to_iter() instead. x86_64 and PPC64 select
ARCH_HAS_COPY_MC, and on x86_64 and book3s64 the machine check safe copy
turns the machine check into a short copy, which read_from_oldmem()
turns into -EFAULT like any other short copy. On x86 that holds for the
fragile and the enhanced fast string variant, a CPU with neither gets
the plain copy it has today. Everywhere else _copy_mc_to_iter() is
_copy_to_iter(). Put the call into a helper, copy_oldmem_to_iter(), so
that the copy of a page of the old kernel lives in one place and an
architecture that gains a machine check safe copy later gets this for
free. The helper does the same check_copy_size() as copy_to_iter(), so
hardened usercopy keeps checking the copy.

With a v7.4-rc1 capture kernel reading /proc/vmcore and a machine check
injected into the copy of an old page the capture kernel is gone. A
machine check panic prints no trace of its own, this one comes from
panic_sys_info=all_bt:

[    0.580568] mce: [Hardware Error]: CPU 0: Machine Check Exception: 7 Bank 1: bd80000000000134
[    0.580574] mce: [Hardware Error]: RIP 10:<ffffffff81909b11> {_copy_to_iter+0x81/0x850}
[    0.580584] mce: [Hardware Error]: TSC 202f2117f ADDR 10000000 MISC 8c
[    0.580587] mce: [Hardware Error]: PROCESSOR 2:aa0f02 TIME 1794493617 SOCKET 0 APIC 0 microcode aa0021c
[    0.580589] mce: [Hardware Error]: Machine check: Uncorrected unrecoverable error in kernel context
[    0.580591] Kernel panic - not syncing: Fatal local machine check
[    0.582587] CPU: 0 UID: 0 PID: 1 Comm: init Not tainted 7.4.0-rc1-g6628e7d4c6b2 #1 PREEMPT(lazy)
[    0.583101] Call Trace:
[    0.583198]  <#MC>
[    0.583279]  dump_stack_lvl+0x4d/0x70
[    0.583419]  nmi_cpu_backtrace.cold+0x18/0x6e
[    0.583584]  ? __pfx_nmi_raise_cpu_backtrace+0x10/0x10
[    0.583772]  nmi_trigger_cpumask_backtrace+0xba/0xf0
[    0.583955]  sys_info+0x83/0xb0
[    0.584075]  vpanic+0x1b4/0x303
[    0.584197]  panic+0x66/0x70
[    0.584488]  mce_panic+0x19e/0x290
[    0.584799]  do_machine_check+0x627/0x9a0
[    0.584953]  ? _copy_to_iter+0x81/0x850
[    0.585099]  exc_machine_check+0x68/0xb0
[    0.585246]  asm_exc_machine_check+0x1e/0x40
[    0.587747]  </#MC>
[    0.587831]  <TASK>
[    0.588092]  ? iomem_map_sanity_check+0x98/0xb0
[    0.588430]  ? __ioremap_caller.isra.0+0x1a9/0x300
[    0.588604]  ? __copy_oldmem_page+0x3d/0xb0
[    0.588928]  __copy_oldmem_page+0x5e/0xb0
[    0.589079]  read_from_oldmem.part.0+0xe3/0x140
[    0.589247]  read_vmcore+0x137/0x280
[    0.589381]  proc_reg_read_iter+0x49/0x90
[    0.589533]  vfs_read+0x348/0x490
[    0.589666]  ksys_read+0x76/0x100
[    0.589792]  do_syscall_64+0xde/0x4b0
[    0.590103]  entry_SYSCALL_64_after_hwframe+0x77/0x7f

With this patch the same injection ends the read() with -EFAULT, the
capture kernel logs the machine check and keeps running.

[1]: https://lore.kernel.org/all/avRXzzCSzT9Qj2FC@gmail.com/

Reported-by: Chris Mason <mason@kernel.org>
Suggested-by: Breno Leitao <leitao@debian.org>
Fixes: 4ae362be5093 ("[PATCH] kdump: read previous kernel's memory")
Fixes: 54c32021eb6f ("[PATCH] powerpc: Add arch-dependent copy_oldmem_page")
Fixes: 4a22fd20379c ("vmcore: convert __read_vmcore to use an iov_iter")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/powerpc/kernel/crash_dump.c |  4 ++--
 arch/x86/kernel/crash_dump_64.c  |  2 +-
 include/linux/crash_dump.h       | 22 ++++++++++++++++++++++
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
index 1543917bd3e1d..f784fc5cb0030 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -83,12 +83,12 @@ ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
 
 	if (memblock_is_region_memory(paddr, csize)) {
 		vaddr = __va(paddr);
-		csize = copy_to_iter(vaddr + offset, csize, iter);
+		csize = copy_oldmem_to_iter(vaddr + offset, csize, iter);
 	} else {
 		vaddr = ioremap_cache(paddr, PAGE_SIZE);
 		if (!vaddr)
 			return -ENOMEM;
-		csize = copy_to_iter(vaddr + offset, csize, iter);
+		csize = copy_oldmem_to_iter(vaddr + offset, csize, iter);
 		iounmap(vaddr);
 	}
 
diff --git a/arch/x86/kernel/crash_dump_64.c b/arch/x86/kernel/crash_dump_64.c
index 32d710f7eb84c..e10dada855b70 100644
--- a/arch/x86/kernel/crash_dump_64.c
+++ b/arch/x86/kernel/crash_dump_64.c
@@ -29,7 +29,7 @@ static ssize_t __copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
 	if (!vaddr)
 		return -ENOMEM;
 
-	csize = copy_to_iter(vaddr + offset, csize, iter);
+	csize = copy_oldmem_to_iter(vaddr + offset, csize, iter);
 
 	iounmap((void __iomem *)vaddr);
 	return csize;
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 8315270e27b7a..12aeaa40c1c94 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -6,6 +6,7 @@
 #include <linux/proc_fs.h>
 #include <linux/elf.h>
 #include <linux/pgtable.h>
+#include <linux/uio.h>
 #include <uapi/linux/vmcore.h>
 
 /* For IS_ENABLED(CONFIG_CRASH_DUMP) */
@@ -33,6 +34,27 @@ ssize_t copy_oldmem_page(struct iov_iter *i, unsigned long pfn, size_t csize,
 ssize_t copy_oldmem_page_encrypted(struct iov_iter *iter, unsigned long pfn,
 				   size_t csize, unsigned long offset);
 
+/**
+ * copy_oldmem_to_iter - copy from the crashed kernel's memory
+ * @src: where in the mapped page of the crashed kernel to copy from
+ * @count: how many bytes to copy
+ * @iter: where to copy them
+ *
+ * The memory of the crashed kernel may well have uncorrectable errors.
+ * Where the architecture has a machine check safe copy a machine check
+ * in the copy ends it short, like a fault would, instead of taking the
+ * capture kernel down. Everywhere else this is copy_to_iter().
+ *
+ * Return: the number of bytes copied, like copy_to_iter().
+ */
+static inline size_t copy_oldmem_to_iter(const void *src, size_t count,
+					 struct iov_iter *iter)
+{
+	if (check_copy_size(src, count, true))
+		return _copy_mc_to_iter(src, count, iter);
+	return 0;
+}
+
 void vmcore_cleanup(void);
 
 /* Architecture code defines this if there are other possible ELF

-- 
2.53.0


