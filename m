Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 13DD52C009C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 03:44:38 +1100 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 28 Jan 2014 22:14:34 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 69862394005A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 22:14:32 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0SGiXxG3801446
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 22:14:33 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0SGiVAL020219
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 22:14:32 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [RFC PATCH 05/10] KVM: PPC: BOOK3S: PR: Doorbell support
Date: Tue, 28 Jan 2014 22:14:10 +0530
Message-Id: <1390927455-3312-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1390927455-3312-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1390927455-3312-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We don't have SMT support yet, hence we should not find a doorbell
message generated

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_emulate.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index e74dda36ebea..9cf0392e3dcf 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -28,7 +28,9 @@
 #define OP_19_XOP_RFI		50
 
 #define OP_31_XOP_MFMSR		83
+#define OP_31_XOP_MSGSNDP	142
 #define OP_31_XOP_MTMSR		146
+#define OP_31_XOP_MSGCLRP	174
 #define OP_31_XOP_MTMSRD	178
 #define OP_31_XOP_MTSR		210
 #define OP_31_XOP_MTSRIN	242
@@ -286,6 +288,22 @@ int kvmppc_core_emulate_op_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
 
 			break;
 		}
+		case OP_31_XOP_MSGSNDP:
+		{
+			/*
+			 * PR KVM still don't support SMT mode. So we should
+			 * not see a MSGSNDP/MSGCLRP used with PR KVM
+			 */
+			pr_info("KVM: MSGSNDP used in non SMT case\n");
+			emulated = EMULATE_FAIL;
+			break;
+		}
+		case OP_31_XOP_MSGCLRP:
+		{
+			pr_info"KVM: MSGCLRP used in non SMT case\n");
+			emulated = EMULATE_FAIL;
+			break;
+		}
 		default:
 			emulated = EMULATE_FAIL;
 		}
-- 
1.8.5.3
