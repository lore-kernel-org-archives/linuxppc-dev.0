Return-Path: <paulus@ozlabs.org>
Date: Fri, 24 May 2013 11:42:21 +1000
From: Paul Mackerras <paulus@samba.org>
To: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] KVM: PPC: Book3S: Add support for H_IPOLL and H_XIRR_X in
 XICS emulation
Message-ID: <20130524014221.GA19310@iris.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds the remaining two hypercalls defined by PAPR for manipulating
the XICS interrupt controller, H_IPOLL and H_XIRR_X.  H_IPOLL returns
information about the priority and pending interrupts for a virtual
cpu, without changing any state.  H_XIRR_X is like H_XIRR in that it
reads and acknowledges the highest-priority pending interrupt, but it
also returns the timestamp (timebase register value) from when the
interrupt was first received by the hypervisor.  Currently we just
return the current time, since we don't do any software queueing of
virtual interrupts inside the XICS emulation code.

These hcalls are not currently used by Linux guests, but may be in
future.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
Unfortunately I missed these two hcalls in the previous submissions.
It would be good to get this patch into 3.10 so we don't have a
kernel version with these calls missing from the API, in case future
guest kernels want to use them.

Alex, given you're on vacation at the moment, are you OK with Ben
taking this through his tree?

 arch/powerpc/include/asm/hvcall.h |    1 +
 arch/powerpc/kvm/book3s_hv.c      |    2 ++
 arch/powerpc/kvm/book3s_pr_papr.c |    2 ++
 arch/powerpc/kvm/book3s_xics.c    |   29 +++++++++++++++++++++++++++++
 4 files changed, 34 insertions(+)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index cf4df8e..0c7f2bf 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -264,6 +264,7 @@
 #define H_GET_MPP		0x2D4
 #define H_HOME_NODE_ASSOCIATIVITY 0x2EC
 #define H_BEST_ENERGY		0x2F4
+#define H_XIRR_X		0x2FC
 #define H_RANDOM		0x300
 #define H_COP			0x304
 #define H_GET_MPP_X		0x314
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 065c9df..7e2059e 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -562,6 +562,8 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 	case H_CPPR:
 	case H_EOI:
 	case H_IPI:
+	case H_IPOLL:
+	case H_XIRR_X:
 		if (kvmppc_xics_enabled(vcpu)) {
 			ret = kvmppc_xics_hcall(vcpu, req);
 			break;
diff --git a/arch/powerpc/kvm/book3s_pr_papr.c b/arch/powerpc/kvm/book3s_pr_papr.c
index 3750e3c..91d4b45 100644
--- a/arch/powerpc/kvm/book3s_pr_papr.c
+++ b/arch/powerpc/kvm/book3s_pr_papr.c
@@ -292,6 +292,8 @@ int kvmppc_h_pr(struct kvm_vcpu *vcpu, unsigned long cmd)
 	case H_CPPR:
 	case H_EOI:
 	case H_IPI:
+	case H_IPOLL:
+	case H_XIRR_X:
 		if (kvmppc_xics_enabled(vcpu))
 			return kvmppc_h_pr_xics_hcall(vcpu, cmd);
 		break;
diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_xics.c
index f7a1037..94c1dd4 100644
--- a/arch/powerpc/kvm/book3s_xics.c
+++ b/arch/powerpc/kvm/book3s_xics.c
@@ -650,6 +650,23 @@ static noinline int kvmppc_h_ipi(struct kvm_vcpu *vcpu, unsigned long server,
 	return H_SUCCESS;
 }
 
+static int kvmppc_h_ipoll(struct kvm_vcpu *vcpu, unsigned long server)
+{
+	union kvmppc_icp_state state;
+	struct kvmppc_icp *icp;
+
+	icp = vcpu->arch.icp;
+	if (icp->server_num != server) {
+		icp = kvmppc_xics_find_server(vcpu->kvm, server);
+		if (!icp)
+			return H_PARAMETER;
+	}
+	state = ACCESS_ONCE(icp->state);
+	kvmppc_set_gpr(vcpu, 4, ((u32)state.cppr << 24) | state.xisr);
+	kvmppc_set_gpr(vcpu, 5, state.mfrr);
+	return H_SUCCESS;
+}
+
 static noinline void kvmppc_h_cppr(struct kvm_vcpu *vcpu, unsigned long cppr)
 {
 	union kvmppc_icp_state old_state, new_state;
@@ -787,6 +804,18 @@ int kvmppc_xics_hcall(struct kvm_vcpu *vcpu, u32 req)
 	if (!xics || !vcpu->arch.icp)
 		return H_HARDWARE;
 
+	/* These requests don't have real-mode implementations at present */
+	switch (req) {
+	case H_XIRR_X:
+		res = kvmppc_h_xirr(vcpu);
+		kvmppc_set_gpr(vcpu, 4, res);
+		kvmppc_set_gpr(vcpu, 5, get_tb());
+		return rc;
+	case H_IPOLL:
+		rc = kvmppc_h_ipoll(vcpu, kvmppc_get_gpr(vcpu, 4));
+		return rc;
+	}
+
 	/* Check for real mode returning too hard */
 	if (xics->real_mode)
 		return kvmppc_xics_rm_complete(vcpu, req);
-- 
1.7.10.4
