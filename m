Return-Path: <cascardo@linux.vnet.ibm.com>
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp02.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 26CB22C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Dec 2013 03:41:11 +1100 (EST)
Received: from /spool/local
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cascardo@linux.vnet.ibm.com>;
 Thu, 12 Dec 2013 14:41:07 -0200
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id C51193520054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Dec 2013 11:41:02 -0500 (EST)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay02.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rBCGeg2352494436
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Dec 2013 14:40:44 -0200
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rBCGf2CW021874
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Dec 2013 14:41:02 -0200
Received: from oc0268524204.ibm.com ([9.8.8.171])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 rBCGf0fc021822
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Dec 2013 14:41:01 -0200
Resent-Message-ID: <20131212164059.GC27808@oc0268524204.ibm.com>
Message-ID: <52A9DA34.40905@linux.vnet.ibm.com>
Date: Thu, 12 Dec 2013 21:15:56 +0530
From: Rajesh B Prathipati <rprathip@linux.vnet.ibm.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, anton@au1.ibm.com
Subject: [PATCH] powerpc: Make unaligned accesses endian-safe for powerpc
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Rajesh B Prathipati <rprathip@linux.vnet.ibm.com>

The generic put_unaligned/get_unaligned macros were made endian-safe by 
calling the appropriate endian dependent macros based on the endian type 
of the powerpc processor.

Signed-off-by: Rajesh B Prathipati <rprathip@linux.vnet.ibm.com>
---
This patch applies to linux kernel version 3.12. This patch has been 
tested and it fixes the problem with linux 3.12 USB stack.

--- linux/arch/powerpc/include/asm/unaligned.h.orig     2013-12-12 
00:07:05.329073544 -0200
+++ linux/arch/powerpc/include/asm/unaligned.h  2013-12-11 
23:56:52.918630238 -0200
@@ -4,13 +4,18 @@
  #ifdef __KERNEL__

  /*
- * The PowerPC can do unaligned accesses itself in big endian mode.
+ * The PowerPC can do unaligned accesses itself based on its endian mode.
   */
  #include <linux/unaligned/access_ok.h>
  #include <linux/unaligned/generic.h>

+#ifdef __LITTLE_ENDIAN__
+#define get_unaligned  __get_unaligned_le
+#define put_unaligned  __put_unaligned_le
+#else
  #define get_unaligned  __get_unaligned_be
  #define put_unaligned  __put_unaligned_be
+#endif

  #endif /* __KERNEL__ */
  #endif /* _ASM_POWERPC_UNALIGNED_H */

