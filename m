Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B16E1A0741
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2015 10:54:17 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Fri, 8 May 2015 10:54:16 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A2031357804C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2015 10:54:13 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t480s5sg19202100
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 May 2015 10:54:13 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t480rebO014402
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 May 2015 10:53:41 +1000
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] kvm/powerpc: Add exit reason for return code 0x0
Date: Fri,  8 May 2015 06:23:04 +0530
Message-Id: <1431046385-5772-2-git-send-email-hemant@linux.vnet.ibm.com>
In-Reply-To: <1431046385-5772-1-git-send-email-hemant@linux.vnet.ibm.com>
References: <1431046385-5772-1-git-send-email-hemant@linux.vnet.ibm.com>
Cc: maddy@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com, peterz@infradead.org,
 agraf@suse.de, kvm-ppc@vger.kernel.org,
 Hemant Kumar <hemant@linux.vnet.ibm.com>, mingo@redhat.com, paulus@samba.org,
 acme@kernel.org, warrier@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds an exit reason "RETURN_TO_HOST" for the return code
0x0.

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
