Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id C5EB9B7C36
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Oct 2009 02:47:34 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm@vger.kernel.org
Subject: [PATCH 26/27] Use Little Endian for Dirty Bitmap
Date: Fri, 30 Oct 2009 16:47:26 +0100
Message-Id: <1256917647-6200-27-git-send-email-agraf@suse.de>
In-Reply-To: <1256917647-6200-1-git-send-email-agraf@suse.de>
References: <1256917647-6200-1-git-send-email-agraf@suse.de>
Cc: Kevin Wolf <kwolf@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Hollis Blanchard <hollisb@us.ibm.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	kvm-ppc <kvm-ppc@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Avi Kivity <avi@redhat.com>, bphilips@suse.de,
	Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We currently use host endian long types to store information
in the dirty bitmap.

This works reasonably well on Little Endian targets, because the
u32 after the first contains the next 32 bits. On Big Endian this
breaks completely though, forcing us to be inventive here.

So Ben suggested to always use Little Endian, which looks reasonable.

We only have dirty bitmap implemented in Little Endian targets so far
and since PowerPC would be the first Big Endian platform, we can just
as well switch to Little Endian always with little effort without
breaking existing targets.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 virt/kvm/kvm_main.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index bd44fb4..972f9fb 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -49,6 +49,7 @@
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
+#include <asm-generic/bitops/le.h>
 
 #ifdef KVM_COALESCED_MMIO_PAGE_OFFSET
 #include "coalesced_mmio.h"
@@ -1071,8 +1072,8 @@ void mark_page_dirty(struct kvm *kvm, gfn_t gfn)
 		unsigned long rel_gfn = gfn - memslot->base_gfn;
 
 		/* avoid RMW */
-		if (!test_bit(rel_gfn, memslot->dirty_bitmap))
-			set_bit(rel_gfn, memslot->dirty_bitmap);
+		if (!generic_test_le_bit(rel_gfn, memslot->dirty_bitmap))
+			generic___set_le_bit(rel_gfn, memslot->dirty_bitmap);
 	}
 }
 
-- 
1.6.0.2
