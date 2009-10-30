Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 53B51B7C3A
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Oct 2009 02:47:40 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm@vger.kernel.org
Subject: [PATCH 23/27] Export new PACA constants in asm-offsets
Date: Fri, 30 Oct 2009 16:47:23 +0100
Message-Id: <1256917647-6200-24-git-send-email-agraf@suse.de>
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

In order to access fields in the PACA from assembly code, we need
to generate offsets using asm-offsets.c.

So let's add the new PACA related bits, we just introduced!

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kernel/asm-offsets.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index aba3ea6..e2e2082 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -190,6 +190,11 @@ int main(void)
 	DEFINE(PACA_SYSTEM_TIME, offsetof(struct paca_struct, system_time));
 	DEFINE(PACA_DATA_OFFSET, offsetof(struct paca_struct, data_offset));
 	DEFINE(PACA_TRAP_SAVE, offsetof(struct paca_struct, trap_save));
+#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
+	DEFINE(PACA_KVM_IN_GUEST, offsetof(struct paca_struct, kvm_in_guest));
+	DEFINE(PACA_KVM_SLB, offsetof(struct paca_struct, kvm_slb));
+	DEFINE(PACA_KVM_SLB_MAX, offsetof(struct paca_struct, kvm_slb_max));
+#endif
 #endif /* CONFIG_PPC64 */
 
 	/* RTAS */
-- 
1.6.0.2
