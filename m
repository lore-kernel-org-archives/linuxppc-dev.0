Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A918F1A0026
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Oct 2015 10:28:28 +1100 (AEDT)
Date: Thu, 8 Oct 2015 10:28:28 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH FIX] powerpc: discard .exit.data at runtime
Message-ID: <20151008102828.00e869dc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

.exit.text is discarded at run time and there are some references from
that to .exit.data, so we need to discard .exit.data at run time as well.

Fixes these errors:

`.exit.data' referenced in section `.exit.text' of drivers/built-in.o: defined in discarded section `.exit.data' of drivers/built-in.o
`.exit.data' referenced in section `.exit.text' of drivers/built-in.o: defined in discarded section `.exit.data' of drivers/built-in.o

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/vmlinux.lds.S | 6 ++++++
 1 file changed, 6 insertions(+)

I have only seen this with an allyesconfig build which fails for other
reasons.

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 1db685104ffc..d41fd0af8980 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -183,6 +183,12 @@ SECTIONS
 		*(.rela*)
 	}
 #endif
+	/* .exit.data is discarded at runtime, not link time,
+	 * to deal with references from .exit.text
+	 */
+	.exit.data : AT(ADDR(.exit.data) - LOAD_OFFSET) {
+		EXIT_DATA
+	}
 
 	/* freed after init ends here */
 	. = ALIGN(PAGE_SIZE);
-- 
2.5.3

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
