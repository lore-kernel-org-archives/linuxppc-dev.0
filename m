Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp17.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AA65D2C00C6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 22:10:37 +1000 (EST)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Wed, 25 Sep 2013 13:10:32 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 94C5E1B0805F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 13:10:30 +0100 (BST)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
 [9.149.37.247])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8PCAG0F459234
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 12:10:16 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8PCARVW029717
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 06:10:28 -0600
Subject: [PATCH] powerpc/kvmbook3s_hv: propagate H_SET_MODE to the host
To: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Wed, 25 Sep 2013 14:10:27 +0200
Message-ID: <20130925121027.29504.19269.stgit@nimbus>
In-Reply-To: <1379901913-5945-37-git-send-email-anton@samba.org>
References: <1379901913-5945-37-git-send-email-anton@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Paul Mackerras <paulus@samba.org>
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

The hcall H_SET_MODE is processed in kvm then in the host.

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 998cad3..4a47c74 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -599,6 +599,14 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 					kvmppc_get_gpr(vcpu, 5),
 					kvmppc_get_gpr(vcpu, 6),
 					kvmppc_get_gpr(vcpu, 7));
+		/*
+		 * If the hcall succeeded, we propagate it to the host.
+		 * This way, it will be aware of the endianess's change too.
+		 * The assumption is made that the hcall will succeed in the
+		 * host.
+		 */
+		if (ret == H_SUCCESS)
+			return RESUME_HOST;
 		break;
 
 	case H_XIRR:
