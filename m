Return-Path: <ananth@in.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D02B92C00CF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Mar 2013 02:20:04 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Fri, 22 Mar 2013 11:20:02 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 699FE38C8068
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 11:19:59 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2MFJxuO30343298
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 11:19:59 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2MFJwvM025050
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 12:19:59 -0300
Date: Fri, 22 Mar 2013 20:49:46 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/4] uprobes/powerpc: remove additional trap instruction
 check
Message-ID: <20130322151946.GE20010@in.ibm.com>
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

prepare_uprobe() already checks if the underlying unstruction
(on file) is a trap variant. We don't need to check this again.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
---
 arch/powerpc/kernel/uprobes.c |    6 ------
 1 file changed, 6 deletions(-)

Index: linux-3.9-rc3/arch/powerpc/kernel/uprobes.c
===================================================================
--- linux-3.9-rc3.orig/arch/powerpc/kernel/uprobes.c
+++ linux-3.9-rc3/arch/powerpc/kernel/uprobes.c
@@ -53,12 +53,6 @@ int arch_uprobe_analyze_insn(struct arch
 	if (addr & 0x03)
 		return -EINVAL;
 
-	/*
-	 * We currently don't support a uprobe on an already
-	 * existing breakpoint instruction underneath
-	 */
-	if (is_trap(auprobe->ainsn))
-		return -ENOTSUPP;
 	return 0;
 }
 
