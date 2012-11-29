Return-Path: <cel@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e35.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E41532C0082
 for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2012 03:42:27 +1100 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cel@linux.vnet.ibm.com>;
 Thu, 29 Nov 2012 09:42:24 -0700
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id EB6463E40055
 for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2012 09:42:18 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
 id qATGg99b232698
 for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2012 09:42:09 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qATGg8wk030096
 for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2012 09:42:08 -0700
Subject: [PATCH] powerpc/oprofile: Fix error in oprofile
 power7_marked_instr_event() function
From: "Carl E. Love" <cel@linux.vnet.ibm.com>
To: bherren@au1.ibm.com, linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 29 Nov 2012 08:42:03 -0800
Message-ID: <1354207323.5963.49.camel@oc5587145178.ibm.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben:

Please review the following patch.  If it is acceptable, will you please
commit it to the mainline tree.  Thanks.

              Carl Love

P.S.  Looks like I sent it to the wrong mailing list the first time to
get it into the patch queue.

--------------------------------------------------------------------------
powerpc/oprofile: Fix error in oprofile power7_marked_instr_event() function

The calculation for the left shift of the mask OPROFILE_PM_PMCSEL_MSK has an
error.  The calculation is should be to shift left by (max_cntrs - cntr) times
the width of the pmsel field width.  However, the #define OPROFILE_MAX_PMC_NUM
was used instead of OPROFILE_PMSEL_FIELD_WIDTH.  This patch fixes the
calculation.

Signed-off-by: Carl Love <cel@us.ibm.com>
---
 arch/powerpc/oprofile/op_model_power4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/oprofile/op_model_power4.c b/arch/powerpc/oprofile/op_model_power4.c
index 315f949..f444b94 100644
--- a/arch/powerpc/oprofile/op_model_power4.c
+++ b/arch/powerpc/oprofile/op_model_power4.c
@@ -52,7 +52,7 @@ static int power7_marked_instr_event(u64 mmcr1)
 	for (pmc = 0; pmc < 4; pmc++) {
 		psel = mmcr1 & (OPROFILE_PM_PMCSEL_MSK
 				<< (OPROFILE_MAX_PMC_NUM - pmc)
-				* OPROFILE_MAX_PMC_NUM);
+				* OPROFILE_PMSEL_FIELD_WIDTH);
 		psel = (psel >> ((OPROFILE_MAX_PMC_NUM - pmc)
 				 * OPROFILE_PMSEL_FIELD_WIDTH)) & ~1ULL;
 		unit = mmcr1 & (OPROFILE_PM_UNIT_MSK
-- 
1.7.12.rc1.22.gbfbf4d4
