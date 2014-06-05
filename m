Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2AB8B1A01CC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 22:08:38 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 5 Jun 2014 22:08:27 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 1B17A3578047
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 22:08:26 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s55C8AFo6291736
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jun 2014 22:08:10 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s55C8Pcx010900
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jun 2014 22:08:25 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 2/4] KVM: PPC: BOOK3S: PR: Doorbell support
Date: Thu,  5 Jun 2014 17:38:03 +0530
Message-Id: <1401970085-14493-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1401970085-14493-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1401970085-14493-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
index 1bb16a59dcbc..d6c87d085182 100644
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
@@ -303,6 +305,22 @@ int kvmppc_core_emulate_op_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
 
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
+			pr_info("KVM: MSGCLRP used in non SMT case\n");
+			emulated = EMULATE_FAIL;
+			break;
+		}
 		default:
 			emulated = EMULATE_FAIL;
 		}
-- 
1.9.1
