Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 3E915B7C34
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Oct 2009 02:47:37 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm@vger.kernel.org
Subject: [PATCH 22/27] Add fields to PACA
Date: Fri, 30 Oct 2009 16:47:22 +0100
Message-Id: <1256917647-6200-23-git-send-email-agraf@suse.de>
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

For KVM we need to store some information in the PACA, so we
need to extend it.

This patch adds KVM SLB shadow related entries to the PACA and
a field that indicates if we're inside a guest.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/include/asm/paca.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 7d8514c..5e9b4ef 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -129,6 +129,15 @@ struct paca_struct {
 	u64 system_time;		/* accumulated system TB ticks */
 	u64 startpurr;			/* PURR/TB value snapshot */
 	u64 startspurr;			/* SPURR value snapshot */
+
+#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
+	struct  {
+		u64     esid;
+		u64     vsid;
+	} kvm_slb[64];			/* guest SLB */
+	u8 kvm_slb_max;			/* highest used guest slb entry */
+	u8 kvm_in_guest;		/* are we inside the guest? */
+#endif
 };
 
 extern struct paca_struct paca[];
-- 
1.6.0.2
