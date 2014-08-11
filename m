Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9AFFB1A087F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Aug 2014 09:53:27 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Mon, 11 Aug 2014 19:53:24 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id B6C61C90043
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Aug 2014 19:53:14 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s7BNrMsT8913390
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Aug 2014 23:53:22 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7BNrLRL017969
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Aug 2014 19:53:22 -0400
Date: Mon, 11 Aug 2014 16:43:18 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Subject: [PATCH] powerpc: remove duplicate definition of TEXASR_FS
Message-ID: <20140811234317.GC4497@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It appears that commits 7f06f21d40a6 ("powerpc/tm: Add checking to
treclaim/trechkpt") and e4e38121507a ("KVM: PPC: Book3S HV: Add
transactional memory support") both added definitions of TEXASR_FS.
Remove one of them. At the same time, fix the alignment of the remaining
definition (should be tab-separated like the rest of the #defines).

Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 1c987bf794ef..0c0505956a29 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -213,9 +213,8 @@
 #define SPRN_ACOP	0x1F	/* Available Coprocessor Register */
 #define SPRN_TFIAR	0x81	/* Transaction Failure Inst Addr   */
 #define SPRN_TEXASR	0x82	/* Transaction EXception & Summary */
-#define   TEXASR_FS	__MASK(63-36)	/* Transaction Failure Summary */
 #define SPRN_TEXASRU	0x83	/* ''	   ''	   ''	 Upper 32  */
-#define   TEXASR_FS     __MASK(63-36) /* TEXASR Failure Summary */
+#define   TEXASR_FS	__MASK(63-36) /* TEXASR Failure Summary */
 #define SPRN_TFHAR	0x80	/* Transaction Failure Handler Addr */
 #define SPRN_CTRLF	0x088
 #define SPRN_CTRLT	0x098
