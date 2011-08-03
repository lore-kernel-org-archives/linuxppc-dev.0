Return-Path: <nacc@us.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e39.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 81927B71E3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  4 Aug 2011 04:57:26 +1000 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e39.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p73IgQhA012637
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Aug 2011 12:42:26 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p73Iu0l6154282
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Aug 2011 12:56:00 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p73Itwg8020045
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Aug 2011 12:55:59 -0600
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/kvm: fix build errors with older toolchains
Date: Wed,  3 Aug 2011 11:55:54 -0700
Message-Id: <1312397755-15737-1-git-send-email-nacc@us.ibm.com>
Cc: kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>,
	Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Avi Kivity <avi@redhat.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On a box with gcc 4.3.2, I see errors like:

arch/powerpc/kvm/book3s_hv_rmhandlers.S:1254: Error: Unrecognized opcode: stxvd2x
arch/powerpc/kvm/book3s_hv_rmhandlers.S:1316: Error: Unrecognized opcode: lxvd2x

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 6dd3358..de29501 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1251,7 +1251,7 @@ BEGIN_FTR_SECTION
 	reg = 0
 	.rept	32
 	li	r6,reg*16+VCPU_VSRS
-	stxvd2x	reg,r6,r3
+	STXVD2X(reg,r6,r3)
 	reg = reg + 1
 	.endr
 FTR_SECTION_ELSE
@@ -1313,7 +1313,7 @@ BEGIN_FTR_SECTION
 	reg = 0
 	.rept	32
 	li	r7,reg*16+VCPU_VSRS
-	lxvd2x	reg,r7,r4
+	LXVD2X(reg,r7,r4)
 	reg = reg + 1
 	.endr
 FTR_SECTION_ELSE
-- 
1.7.4.1
