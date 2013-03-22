Return-Path: <ananth@in.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e37.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BD6C82C0259
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 22:46:33 +1100 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Fri, 22 Mar 2013 05:46:31 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id E6B0A1FF0039
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 05:41:31 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2MBkRoB283328
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 05:46:27 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2MBkRPj030497
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 05:46:27 -0600
Date: Fri, 22 Mar 2013 17:16:24 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] uprobes/powerpc: ignore trap variants during register
Message-ID: <20130322114624.GI26183@in.ibm.com>
References: <20130322114446.GG26183@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130322114446.GG26183@in.ibm.com>
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

The current implementation of uprobes assumes that uprobes always wins
even when a register request is at a location with a conditional
breakpoint by some other entity. Refer to [1] for more details.

Remove the breakpoint instruction check during registration on powerpc,
so that uprobes behavior on powerpc matches that of x86.

[1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2013-March/104771.html

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
 
