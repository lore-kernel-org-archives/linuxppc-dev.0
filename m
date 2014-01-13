Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6BF7A2C009F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 03:36:16 +1100 (EST)
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Mon, 13 Jan 2014 16:36:11 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9DE8F1B08069
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jan 2014 16:35:31 +0000 (GMT)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0DGZwOf51118166
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jan 2014 16:35:58 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0DGa942023645
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jan 2014 09:36:09 -0700
Subject: [PATCH] powerpc/relocate fix relocate processing in LE mode
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Mon, 13 Jan 2014 17:36:08 +0100
Message-ID: <20140113163608.10118.11793.stgit@nimbus>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Relocation's code is not working in little endian mode because the r_info
field, which is a 64 bits value, should be read from the right offset.

The current code is optimized to read the r_info field as a 32 bits value
starting at the middle of the double word (offset 12). When running in LE
mode, the read value is not correct since only the MSB is read.

This patch removes this optimization which consist to deal with a 32 bits
value instead of a 64 bits one. This way it works in big and little endian
mode.

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/reloc_64.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/reloc_64.S b/arch/powerpc/kernel/reloc_64.S
index b47a0e1..1482327 100644
--- a/arch/powerpc/kernel/reloc_64.S
+++ b/arch/powerpc/kernel/reloc_64.S
@@ -69,8 +69,8 @@ _GLOBAL(relocate)
 	 * R_PPC64_RELATIVE ones.
 	 */
 	mtctr	r8
-5:	lwz	r0,12(9)	/* ELF64_R_TYPE(reloc->r_info) */
-	cmpwi	r0,R_PPC64_RELATIVE
+5:	ld	r0,8(9)		/* ELF64_R_TYPE(reloc->r_info) */
+	cmpdi	r0,R_PPC64_RELATIVE
 	bne	6f
 	ld	r6,0(r9)	/* reloc->r_offset */
 	ld	r0,16(r9)	/* reloc->r_addend */
