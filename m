Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id D4753B7C37
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Oct 2009 02:47:36 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm@vger.kernel.org
Subject: [PATCH 15/27] Add mfdec emulation
Date: Fri, 30 Oct 2009 16:47:15 +0100
Message-Id: <1256917647-6200-16-git-send-email-agraf@suse.de>
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

We support setting the DEC to a certain value right now. Doing that basically
triggers the CPU local timer.

But there's also an mfdec command that enabled the OS to read the decrementor.

This is required at least by all desktop and server PowerPC Linux kernels. It
can't really hurt to allow embedded ones to do it as well though.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/emulate.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
index 7737146..50d411d 100644
--- a/arch/powerpc/kvm/emulate.c
+++ b/arch/powerpc/kvm/emulate.c
@@ -66,12 +66,14 @@
 
 void kvmppc_emulate_dec(struct kvm_vcpu *vcpu)
 {
+	unsigned long nr_jiffies;
+
 	if (vcpu->arch.tcr & TCR_DIE) {
 		/* The decrementer ticks at the same rate as the timebase, so
 		 * that's how we convert the guest DEC value to the number of
 		 * host ticks. */
-		unsigned long nr_jiffies;
 
+		vcpu->arch.dec_jiffies = mftb();
 		nr_jiffies = vcpu->arch.dec / tb_ticks_per_jiffy;
 		mod_timer(&vcpu->arch.dec_timer,
 		          get_jiffies_64() + nr_jiffies);
@@ -211,6 +213,15 @@ int kvmppc_emulate_instruction(struct kvm_run *run, struct kvm_vcpu *vcpu)
 			/* Note: SPRG4-7 are user-readable, so we don't get
 			 * a trap. */
 
+			case SPRN_DEC:
+			{
+				u64 jd = mftb() - vcpu->arch.dec_jiffies;
+				vcpu->arch.gpr[rt] = vcpu->arch.dec - jd;
+#ifdef DEBUG_EMUL
+				printk(KERN_INFO "mfDEC: %x - %llx = %lx\n", vcpu->arch.dec, jd, vcpu->arch.gpr[rt]);
+#endif
+				break;
+			}
 			default:
 				emulated = kvmppc_core_emulate_mfspr(vcpu, sprn, rt);
 				if (emulated == EMULATE_FAIL) {
-- 
1.6.0.2
