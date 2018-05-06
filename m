Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40dy7v3tsfzDrnp
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 May 2018 17:30:02 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id p14so9093603pfh.9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 May 2018 00:30:02 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH QEMU] osdep: powerpc64 align memory to allow 2MB radix THP
 page tables
Date: Sun,  6 May 2018 17:29:49 +1000
Message-Id: <20180506072949.12783-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This allows KVM with the Book3S radix MMU mode to take advantage of
THP and install larger pages in the partition scope page tables (the
host translation).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/qemu/osdep.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 41658060a7..5910682221 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -357,7 +357,8 @@ void qemu_anon_ram_free(void *ptr, size_t size);
 #endif
 
 #if defined(__linux__) && \
-    (defined(__x86_64__) || defined(__arm__) || defined(__aarch64__))
+    (defined(__x86_64__) || defined(__arm__) || defined(__aarch64__) \
+     || defined(__powerpc64__))
    /* Use 2 MiB alignment so transparent hugepages can be used by KVM.
       Valgrind does not support alignments larger than 1 MiB,
       therefore we need special code which handles running on Valgrind. */
-- 
2.17.0
