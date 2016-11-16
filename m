Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJnmR6Q3NzDrBs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 02:12:07 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAGF8kWb097465
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 10:12:04 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26rmu8edut-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 10:12:04 -0500
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 17 Nov 2016 01:12:02 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E9F3D2CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 02:11:59 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAGFBxbE52297926
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 02:11:59 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAGFBxPL006260
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 02:11:59 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: "Leonidas S. Barbosa" <leosilva@linux.vnet.ibm.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: crypto/vmx: various build fixes
Date: Wed, 16 Nov 2016 20:41:46 +0530
Message-Id: <20161116151146.15720-1-naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

First up, clean up the generated .S files properly on a 'make clean'.
Secondly, force re-generation of these files when building for different
endian-ness than what was built previously. Finally, generate the new
files in the build tree, rather than the source tree.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
Michael,
I've added your SOB here though you didn't explicitly include it in your
previous mail. I hope that's fine from your end.

- Naveen

 drivers/crypto/vmx/Makefile | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/vmx/Makefile b/drivers/crypto/vmx/Makefile
index de6e241..55f7c39 100644
--- a/drivers/crypto/vmx/Makefile
+++ b/drivers/crypto/vmx/Makefile
@@ -10,10 +10,12 @@ endif
 quiet_cmd_perl = PERL $@
       cmd_perl = $(PERL) $(<) $(TARGET) > $(@)
 
-$(src)/aesp8-ppc.S: $(src)/aesp8-ppc.pl
-	$(call cmd,perl)
+targets += aesp8-ppc.S ghashp8-ppc.S
+
+$(obj)/aesp8-ppc.S: $(src)/aesp8-ppc.pl FORCE
+	$(call if_changed,perl)
   
-$(src)/ghashp8-ppc.S: $(src)/ghashp8-ppc.pl
-	$(call cmd,perl)
+$(obj)/ghashp8-ppc.S: $(src)/ghashp8-ppc.pl FORCE
+	$(call if_changed,perl)
 
-.PRECIOUS: $(obj)/aesp8-ppc.S $(obj)/ghashp8-ppc.S
+clean-files := aesp8-ppc.S ghashp8-ppc.S
-- 
2.10.2
