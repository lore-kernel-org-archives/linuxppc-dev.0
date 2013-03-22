Return-Path: <ananth@in.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 00FA72C00C2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Mar 2013 02:18:18 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Fri, 22 Mar 2013 09:18:14 -0600
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id C8C5CC9007A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 11:18:11 -0400 (EDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2MFIA2M220950
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 11:18:11 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2MFI5p4006448
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 09:18:06 -0600
Date: Fri, 22 Mar 2013 20:47:58 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/4] uprobes: refuse uprobe on trap variants
Message-ID: <20130322151758.GC20010@in.ibm.com>
References: <20130322151627.GB20010@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130322151627.GB20010@in.ibm.com>
Cc: ppcdev <linuxppc-dev@lists.ozlabs.org>, oleg@redhat.com,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

Refuse to place a uprobe if a trap variant already exists in the
file copy at the address.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
---
 kernel/events/uprobes.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-3.9-rc3/kernel/events/uprobes.c
===================================================================
--- linux-3.9-rc3.orig/kernel/events/uprobes.c
+++ linux-3.9-rc3/kernel/events/uprobes.c
@@ -573,7 +573,7 @@ static int prepare_uprobe(struct uprobe
 		goto out;
 
 	ret = -ENOTSUPP;
-	if (is_swbp_insn((uprobe_opcode_t *)uprobe->arch.insn))
+	if (is_trap_insn((uprobe_opcode_t *)uprobe->arch.insn))
 		goto out;
 
 	ret = arch_uprobe_analyze_insn(&uprobe->arch, mm, vaddr);
