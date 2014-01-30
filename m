Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7D0142C0256
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 02:58:51 +1100 (EST)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Thu, 30 Jan 2014 15:58:47 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id C5060219005C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 15:58:42 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0UFwWx749020978
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 15:58:32 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0UFwhYm006080
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 08:58:43 -0700
Subject: [RESEND PATCH] powerpc/relocate fix relocate processing in LE mode
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Thu, 30 Jan 2014 16:58:42 +0100
Message-ID: <20140130155842.13033.3091.stgit@nimbus>
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
