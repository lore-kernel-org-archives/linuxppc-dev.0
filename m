Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AC42C1A17F5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 17:08:01 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 1 Oct 2014 17:08:01 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3218A357804E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 17:07:58 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s916nb6745809708
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Oct 2014 16:49:37 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9177uhw004759
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Oct 2014 17:07:57 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 6/6] powerpc/eeh: Don't collect logs on PE with blocked config
 space
Date: Wed,  1 Oct 2014 17:07:54 +1000
Message-Id: <1412147274-28770-7-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1412147274-28770-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1412147274-28770-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When the PE's config space is marked as blocked, PCI config read
requests always return 0xFF's. It's pointless to collect logs in
this case.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index c9d274e..e6a718f 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -257,6 +257,13 @@ static void *eeh_dump_pe_log(void *data, void *flag)
 	struct eeh_dev *edev, *tmp;
 	size_t *plen = flag;
 
+	/* If the PE's config space is blocked, 0xFF's will be
+	 * returned. It's pointless to collect the log in this
+	 * case.
+	 */
+	if (pe->state & EEH_PE_CFG_BLOCKED)
+		return NULL;
+
 	eeh_pe_for_each_dev(pe, edev, tmp)
 		*plen += eeh_dump_dev_log(edev, pci_regs_buf + *plen,
 					  EEH_PCI_REGS_LOG_LEN - *plen);
-- 
1.8.3.2
