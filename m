Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C77551A0048
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 19:30:47 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 21 Sep 2015 19:30:46 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0AA202CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 19:30:45 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8L9UXrf18874446
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 19:30:41 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8L9UCT3013955
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 19:30:12 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/eeh: Avoid to handle EEH on a passed Child PE
Date: Mon, 21 Sep 2015 17:29:48 +0800
Message-Id: <1442827788-10385-1-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Current EEH infrastructure would avoid to handle EEH when a PE is passed to
guest, while if this PE is a Child PE of the one hit EEH, host would handle
this. By doing so, this would leads to guest hang. The correct way is
avoid to handle it on host and let guest to recover.

This patch avoids to handle EEH on a passed Child PE.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_pe.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 5cde950..c6d0e9f 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -172,6 +172,7 @@ static struct eeh_pe *eeh_pe_next(struct eeh_pe *pe,
  * callback returns something other than NULL, or no more PEs
  * to be traversed.
  */
+static void *__eeh_pe_get(void *data, void *flag);
 void *eeh_pe_traverse(struct eeh_pe *root,
 		      eeh_traverse_func fn, void *flag)
 {
@@ -179,6 +180,8 @@ void *eeh_pe_traverse(struct eeh_pe *root,
 	void *ret;
 
 	for (pe = root; pe; pe = eeh_pe_next(pe, root)) {
+		if (eeh_pe_passed(pe) && (fn != __eeh_pe_get))
+			continue;
 		ret = fn(pe, flag);
 		if (ret) return ret;
 	}
@@ -210,6 +213,8 @@ void *eeh_pe_dev_traverse(struct eeh_pe *root,
 
 	/* Traverse root PE */
 	for (pe = root; pe; pe = eeh_pe_next(pe, root)) {
+		if (eeh_pe_passed(pe))
+			continue;
 		eeh_pe_for_each_dev(pe, edev, tmp) {
 			ret = fn(edev, flag);
 			if (ret)
-- 
2.5.0
