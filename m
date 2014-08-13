Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 204241A01F4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 21:14:28 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Wed, 13 Aug 2014 21:14:23 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9E6FB2CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 21:14:21 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s7DBF3mI14549048
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 21:15:04 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7DBEK4v025191
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 21:14:21 +1000
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/powernv: Avoid to set EEH_PE_ISOLATED for passed PE
Date: Wed, 13 Aug 2014 07:14:18 -0400
Message-Id: <1407928458-8125-1-git-send-email-qiudayu@linux.vnet.ibm.com>
Cc: Mike Qiu <qiudayu@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When PE passed to guest, and guest EEH occured with this PE,
EEH_PE_ISOLATED maybe set in host.

It is a big issue when the PE  is reused by host, host EEH
will not work on this PE because it was set to EEH_PE_ISOLATED
unexpectly.

Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index c945bed..e88eaf6 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -371,7 +371,8 @@ static int ioda_eeh_get_pe_state(struct eeh_pe *pe)
 	    !(result & EEH_STATE_UNAVAILABLE) &&
 	    !(result & EEH_STATE_MMIO_ACTIVE) &&
 	    !(result & EEH_STATE_DMA_ACTIVE)  &&
-	    !(pe->state & EEH_PE_ISOLATED)) {
+	    !(pe->state & EEH_PE_ISOLATED)    &&
+	    !eeh_pe_passed(pe)) {
 		if (phb->freeze_pe)
 			phb->freeze_pe(phb, pe->addr);
 
-- 
1.8.1.4
