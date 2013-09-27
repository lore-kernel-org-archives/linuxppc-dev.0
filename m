Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp18.uk.ibm.com (e06smtp18.uk.ibm.com [195.75.94.114])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp18.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 271792C0333
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 23:59:43 +1000 (EST)
Received: from /spool/local
 by e06smtp18.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Fri, 27 Sep 2013 14:59:34 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5DA2B17D805C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 14:59:48 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8RDxK3856099070
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 13:59:20 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8RDxWxv018904
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 07:59:32 -0600
Subject: [PATCH V2] powerpc/kvm/book3s_hv: propagate H_SET_MODE_RESOURCE_LE to
 the host
To: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Fri, 27 Sep 2013 15:59:30 +0200
Message-ID: <20130927135930.10288.86526.stgit@nimbus>
In-Reply-To: <20130925223118.GA2844@iris.ozlabs.ibm.com>
References: <20130925223118.GA2844@iris.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Follow-up to Anton's H_SET_MODE patch, the host should be taken aware of
guest endianess change.

The hcall H_SET_MODE/H_SET_MODE_RESOURCE_LE is processed in kvm and then
propagated to the host.

v2: taking in account the Paul Mackerras's comment, using H_TOO_HARD to
propagate only H_SET_MODE_RESOURCE_LE to the host.

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 998cad3..be0af39 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -523,14 +523,14 @@ static int kvmppc_h_set_mode(struct kvm_vcpu *vcpu, unsigned long mflags,
 			kvm_for_each_vcpu(n, v, kvm)
 				v->arch.intr_msr &= ~MSR_LE;
 			kick_all_cpus_sync();
-			return H_SUCCESS;
+			return H_TOO_HARD; /* propagating to the host */
 
 		case 1:
 			kvm->arch.lpcr |= LPCR_ILE;
 			kvm_for_each_vcpu(n, v, kvm)
 				v->arch.intr_msr |= MSR_LE;
 			kick_all_cpus_sync();
-			return H_SUCCESS;
+			return H_TOO_HARD; /* propagating to the host */
 
 		default:
 			return H_UNSUPPORTED_FLAG_START;
@@ -599,6 +599,8 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 					kvmppc_get_gpr(vcpu, 5),
 					kvmppc_get_gpr(vcpu, 6),
 					kvmppc_get_gpr(vcpu, 7));
+		if (ret == H_TOO_HARD)
+			return RESUME_HOST;
 		break;
 
 	case H_XIRR:
