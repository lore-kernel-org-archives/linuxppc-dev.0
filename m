Return-Path: <geoff@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 80D612C022C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Dec 2013 11:19:11 +1100 (EST)
Message-Id: <868c991fa6d0f1e7c411626a9bb8c7785a6a46f1.1386807069.git.geoff@infradead.org>
In-Reply-To: <cover.1386807069.git.geoff@infradead.org>
References: <cover.1386807069.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 3/4] powerpc/kexec: Use global IND_FLAGS macro
To: Eric Biederman <ebiederm@xmission.com>
Date: Thu, 12 Dec 2013 00:18:56 +0000
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

linux/kexec.h now defines an IND_FLAGS macro.  Remove the local powerpc
definition and use the generic one.

Signed-off-by: Geoff Levand <geoff@infradead.org> for Huawei, Linaro
---
 arch/powerpc/kernel/machine_kexec_64.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index be4e6d6..1fab1f0 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -96,8 +96,6 @@ int default_machine_kexec_prepare(struct kimage *image)
 	return 0;
 }
 
-#define IND_FLAGS (IND_DESTINATION | IND_INDIRECTION | IND_DONE | IND_SOURCE)
-
 static void copy_segments(unsigned long ind)
 {
 	unsigned long entry;
-- 
1.8.1.2
