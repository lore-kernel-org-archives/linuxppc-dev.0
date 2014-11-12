Return-Path: <geoff@infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 190811A018C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Nov 2014 06:30:08 +1100 (AEDT)
Message-ID: <1415820588.15847.6.camel@smoke>
Subject: [PATCH V3] kexec: Add IND_FLAGS macro
From: Geoff Levand <geoff@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 12 Nov 2014 11:29:48 -0800
In-Reply-To: <20141007175248.GG27464@redhat.com>
References: <cover.1412640584.git.geoff@infradead.org>
 <adf97d602657c72f6ee59aefe5d51149159a3e99.1412640584.git.geoff@infradead.org>
 <20141007175248.GG27464@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
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

Add a new kexec preprocessor macro IND_FLAGS, which is the bitwise OR of
all the possible kexec IND_ kimage_entry indirection flags.  Having this
macro allows for simplified code in the processing of the kexec
kimage_entry items.  Also, remove the local powerpc definition and use
the generic one.

Signed-off-by: Geoff Levand <geoff@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Acked-by: Vivek Goyal <vgoyal@redhat.com>
---
Hi Ben,

Could you give your ack on this, then I'll try to get it
merged with my other kexec patches.

Thanks.

-Geoff

 arch/powerpc/kernel/machine_kexec_64.c | 2 --
 include/linux/kexec.h                  | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 879b3aa..75652a32 100644
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
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 25e039c..b23412c 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -10,6 +10,7 @@
 #define IND_INDIRECTION  (1 << IND_INDIRECTION_BIT)
 #define IND_DONE         (1 << IND_DONE_BIT)
 #define IND_SOURCE       (1 << IND_SOURCE_BIT)
+#define IND_FLAGS (IND_DESTINATION | IND_INDIRECTION | IND_DONE | IND_SOURCE)
 
 #if !defined(__ASSEMBLY__)
 
-- 
1.9.1
