Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1DD1D1A0C38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Dec 2015 18:30:15 +1100 (AEDT)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DD8AD140313
 for <linuxppc-dev@ozlabs.org>; Mon, 21 Dec 2015 18:30:14 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 21 Dec 2015 17:30:12 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3D8FA2CE8054
 for <linuxppc-dev@ozlabs.org>; Mon, 21 Dec 2015 18:30:10 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBL7U3ul18088156
 for <linuxppc-dev@ozlabs.org>; Mon, 21 Dec 2015 18:30:12 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBL7Tb5c031766
 for <linuxppc-dev@ozlabs.org>; Mon, 21 Dec 2015 18:29:37 +1100
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 tBL7TbFD031131
 for <linuxppc-dev@ozlabs.org>; Mon, 21 Dec 2015 18:29:37 +1100
Received: from ajd.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 by ozlabs.au.ibm.com (Postfix) with ESMTP id 892FEA0114
 for <linuxppc-dev@ozlabs.org>; Mon, 21 Dec 2015 18:28:42 +1100 (AEDT)
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/opal: fix minor off-by-one error in
 opal_mce_check_early_recovery()
Date: Mon, 21 Dec 2015 18:28:37 +1100
Message-Id: <1450682917-24913-1-git-send-email-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix off-by-one error in opal_mce_check_early_recovery() when checking
whether the NIP falls within OPAL space.

Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

---

Only very slightly more correct, but I'm fairly sure it's more correct...
---
 arch/powerpc/platforms/powernv/opal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 57cffb8..488b989 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -555,7 +555,7 @@ bool opal_mce_check_early_recovery(struct pt_regs *regs)
 		goto out;
 
 	if ((regs->nip >= opal.base) &&
-			(regs->nip <= (opal.base + opal.size)))
+			(regs->nip < (opal.base + opal.size)))
 		recover_addr = find_recovery_address(regs->nip);
 
 	/*
-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
