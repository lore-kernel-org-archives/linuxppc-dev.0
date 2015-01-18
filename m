Return-Path: <gerhard_pircher@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 025311A0CC0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 03:17:35 +1100 (AEDT)
Message-ID: <54BBDB6E.6050808@gmx.net>
Date: Sun, 18 Jan 2015 17:12:30 +0100
From: Gerhard Pircher <gerhard_pircher@gmx.net>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: [PATCH] powerpc: kvm: Set M flag for KVM PTE depending on
 CPU_FTR_NEED_COHERENT
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Usually page table entries only have the M (coherence) flag set, if the
kernel is in SMP mode or to avoid data corruption due to CPU bugs (e.g.
some 74xx CPUs). KVM on book3s_32 however always sets the M flag for a
PTE, which locks up machines based on the amigaone platform when running
QEMU or MoL.
Setting the M flag depending on CPU_FTR_NEED_COHERENT also makes KVM work
on this platform and aligns the PTE setup to the rest of the kernel.

Signed-off-by: Gerhard Pircher <gerhard_pircher@gmx.net>
---
With this patch I could successfully run a Debian Wheezy installation
inside QEMU started with --enable-kvm on my AmigaOneG3SE.

 arch/powerpc/kvm/book3s_32_mmu_host.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_32_mmu_host.c b/arch/powerpc/kvm/book3s_32_mmu_host.c
index 2035d16..935c7d0 100644
--- a/arch/powerpc/kvm/book3s_32_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_32_mmu_host.c
@@ -204,7 +204,10 @@ next_pteg:
 
 	pteg0 = ((eaddr & 0x0fffffff) >> 22) | (vsid << 7) | PTE_V |
 		(primary ? 0 : PTE_SEC);
-	pteg1 = hpaddr | PTE_M | PTE_R | PTE_C;
+	pteg1 = hpaddr | PTE_R | PTE_C;
+
+	if (cpu_has_feature(CPU_FTR_NEED_COHERENT))
+		pteg1 |= PTE_M;
 
 	if (orig_pte->may_write && writable) {
 		pteg1 |= PP_RWRW;
-- 
1.9.1
