Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8CF841A0D52
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 01:03:40 +1000 (AEST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Mon, 20 Apr 2015 20:33:38 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id E66F2125805F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 20:35:30 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3KF3T4S62062796
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 20:33:30 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3KEeLvp015938
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 20:10:21 +0530
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/5] kvm/powerpc: Add exit reason for return code 0x0
Date: Mon, 20 Apr 2015 20:32:12 +0530
Message-Id: <1429542135-10632-3-git-send-email-hemant@linux.vnet.ibm.com>
In-Reply-To: <1429542135-10632-1-git-send-email-hemant@linux.vnet.ibm.com>
References: <1429542135-10632-1-git-send-email-hemant@linux.vnet.ibm.com>
Cc: maddy@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com, peterz@infradead.org,
 linux-kernel@vger.kernel.org, acme@kernel.org, paulus@samba.org,
 warrier@linux.vnet.ibm.com, Hemant Kumar <hemant@linux.vnet.ibm.com>,
 mingo@kernel.org
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
