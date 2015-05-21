Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5300C1A0AD8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 13:44:13 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Thu, 21 May 2015 13:44:11 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 331F72BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 13:44:10 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4L3i1Pn16580686
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 13:44:09 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4L3ha57010059
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 13:43:37 +1000
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: maddy@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
 scottwood@freescale.com, mpe@ellerman.id.au, agraf@suse.de,
 kvm-ppc@vger.kernel.org, paulus@samba.org, warrier@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, acme@kernel.org, mingo@redhat.com,
 peterz@infradead.org, Hemant Kumar <hemant@linux.vnet.ibm.com>
Subject: [PATCH v4 2/3] kvm/powerpc: Add exit reason for return code 0x0
Date: Thu, 21 May 2015 09:13:00 +0530
Message-Id: <1432179781-4739-2-git-send-email-hemant@linux.vnet.ibm.com>
In-Reply-To: <1432179781-4739-1-git-send-email-hemant@linux.vnet.ibm.com>
References: <1432179781-4739-1-git-send-email-hemant@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds an exit reason "RETURN_TO_HOST" for the return code
0x0. Note that this is not related to any interrupt vector address, but
this is added just to make sure that perf doesn't complain if and when a
kvm exit happens with a trap code as 0x0.

Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
---
 arch/powerpc/include/uapi/asm/trace_book3s.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/uapi/asm/trace_book3s.h b/arch/powerpc/include/uapi/asm/trace_book3s.h
index f647ce0..8635005 100644
--- a/arch/powerpc/include/uapi/asm/trace_book3s.h
+++ b/arch/powerpc/include/uapi/asm/trace_book3s.h
@@ -6,6 +6,7 @@
  */
 
 #define kvm_trace_symbol_exit \
+	{0x0,	"RETURN_TO_HOST"}, \
 	{0x100, "SYSTEM_RESET"}, \
 	{0x200, "MACHINE_CHECK"}, \
 	{0x300, "DATA_STORAGE"}, \
-- 
1.9.3
