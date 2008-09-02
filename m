Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 8C00BDDDDB
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Sep 2008 15:04:17 +1000 (EST)
Date: Tue, 2 Sep 2008 15:04:09 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] powerpc: make sure all kernel text is before _etext
Message-Id: <20080902150409.5aca2198.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Arjan van de Ven <arjan@linux.intel.com>,
	LKML <linux-kernel@vger.kernel.org>, Miller <miltonm@bga.com>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	ppc-dev <linuxppc-dev@ozlabs.org>,
	David Woodhouse <dwmw2@infradead.org>, Milton
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This makes core_kernel_text() (and therefore kernel_text_address())
return the correct result.  Currently all the __devinit routines (at
least) will not be considered to be kernel text.

This is just a quick fix for 2.6.27 - hopefully we will be able to fix
this better in 2.6.28.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/vmlinux.lds.S |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 4a8ce62..9f6c1ca 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -66,11 +66,12 @@ SECTIONS
 		__got2_end = .;
 #endif /* CONFIG_PPC32 */
 
-		. = ALIGN(PAGE_SIZE);
-		_etext = .;
-		PROVIDE32 (etext = .);
 	} :kernel
 
+	. = ALIGN(PAGE_SIZE);
+	_etext = .;
+	PROVIDE32 (etext = .);
+
 	/* Read-only data */
 	RODATA
 
-- 
1.5.6.5

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
