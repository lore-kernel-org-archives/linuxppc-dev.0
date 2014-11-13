Return-Path: <geoff@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 172DC1A1E9E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Nov 2014 11:19:50 +1100 (AEDT)
Message-Id: <b0702fc4186db21820d686e89afd6480560823db.1415837218.git.geoff@infradead.org>
In-Reply-To: <cover.1415837218.git.geoff@infradead.org>
References: <cover.1415837218.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH V3 1/4] kexec: Fix make headers_check
To: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 13 Nov 2014 00:19:32 +0000
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove the unneded declaration for a kexec_load() routine.

Fixes errors like these when running 'make headers_check':

include/uapi/linux/kexec.h: userspace cannot reference function or variable defined in the kernel

Signed-off-by: Geoff Levand <geoff@infradead.org>
Acked-by: Paul Bolle <pebolle@tiscali.nl>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
---
 include/uapi/linux/kexec.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
index 6925f5b..99048e5 100644
--- a/include/uapi/linux/kexec.h
+++ b/include/uapi/linux/kexec.h
@@ -55,12 +55,6 @@ struct kexec_segment {
 	size_t memsz;
 };
 
-/* Load a new kernel image as described by the kexec_segment array
- * consisting of passed number of segments at the entry-point address.
- * The flags allow different useage types.
- */
-extern int kexec_load(void *, size_t, struct kexec_segment *,
-		unsigned long int);
 #endif /* __KERNEL__ */
 
 #endif /* _UAPILINUX_KEXEC_H */
-- 
1.9.1
