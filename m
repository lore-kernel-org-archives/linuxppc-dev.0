Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 706BE1A1943
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 14:59:56 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Mon, 15 Jun 2015 14:59:56 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1A6862BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 14:59:53 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5F4wUlB59506738
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 14:58:38 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5F4w5sS003182
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 14:58:06 +1000
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, acme@kernel.org, mingo@kernel.org,
 mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com,
 maddy@linux.vnet.ibm.com, warrier@linux.vnet.ibm.com,
 srikar@linux.vnet.ibm.com, paulus@samba.org, scottwood@freescale.com,
 Hemant Kumar <hemant@linux.vnet.ibm.com>
Subject: [PATCH RESEND v4 2/3] kvm/powerpc: Add exit reason for return code 0x0
Date: Mon, 15 Jun 2015 10:26:08 +0530
Message-Id: <1434344169-32438-2-git-send-email-hemant@linux.vnet.ibm.com>
In-Reply-To: <1434344169-32438-1-git-send-email-hemant@linux.vnet.ibm.com>
References: <1434344169-32438-1-git-send-email-hemant@linux.vnet.ibm.com>
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
