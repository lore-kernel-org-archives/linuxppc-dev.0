Return-Path: <SRS0=ax18=7C=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DB9C433E1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2020 16:53:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC6FA2065F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2020 16:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC6FA2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49RzNW2N5YzDqdX
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2020 02:53:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=ldufour@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49RzKx52mczDqTY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2020 02:51:30 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04KGXM0h064606; Wed, 20 May 2020 12:51:18 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 312bg8q2q4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2020 12:51:17 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04KGUb1P012254;
 Wed, 20 May 2020 16:51:15 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma04ams.nl.ibm.com with ESMTP id 313xehm0t1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2020 16:51:14 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04KGpCUR63701082
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 May 2020 16:51:12 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A799911C04C;
 Wed, 20 May 2020 16:51:12 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4065C11C050;
 Wed, 20 May 2020 16:51:12 +0000 (GMT)
Received: from pomme.tlslab.ibm.com (unknown [9.145.151.133])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 20 May 2020 16:51:12 +0000 (GMT)
From: Laurent Dufour <ldufour@linux.ibm.com>
To: kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, paulus@samba.org
Subject: [PATCH] KVM: PPC: Book3S HV: relax check on H_SVM_INIT_ABORT
Date: Wed, 20 May 2020 18:51:10 +0200
Message-Id: <20200520165110.71020-1-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-20_10:2020-05-20,
 2020-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 bulkscore=0 cotscore=-2147483648 malwarescore=0
 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0
 mlxlogscore=996 clxscore=1011 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005200135
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: sukadev@linux.ibm.com, linuxram@us.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The commit 8c47b6ff29e3 ("KVM: PPC: Book3S HV: Check caller of H_SVM_*
Hcalls") added checks of secure bit of SRR1 to filter out the Hcall
reserved to the Ultravisor.

However, the Hcall H_SVM_INIT_ABORT is made by the Ultravisor passing the
context of the VM calling UV_ESM. This allows the Hypervisor to return to
the guest without going through the Ultravisor. Thus the Secure bit of SRR1
is not set in that particular case.

In the case a regular VM is calling H_SVM_INIT_ABORT, this hcall will be
filtered out in kvmppc_h_svm_init_abort() because kvm->arch.secure_guest is
not set in that case.

Fixes: 8c47b6ff29e3 ("KVM: PPC: Book3S HV: Check caller of H_SVM_* Hcalls")
Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 93493f0cbfe8..eb1f96cb7b72 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1099,9 +1099,7 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 			ret = kvmppc_h_svm_init_done(vcpu->kvm);
 		break;
 	case H_SVM_INIT_ABORT:
-		ret = H_UNSUPPORTED;
-		if (kvmppc_get_srr1(vcpu) & MSR_S)
-			ret = kvmppc_h_svm_init_abort(vcpu->kvm);
+		ret = kvmppc_h_svm_init_abort(vcpu->kvm);
 		break;
 
 	default:
-- 
2.26.2

