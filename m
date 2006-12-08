Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 2FF8267A2E
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Dec 2006 16:57:46 +1100 (EST)
Date: Fri, 8 Dec 2006 16:57:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] iSeries: head_64.o needs to depend on lparmap.s
Message-Id: <20061208165749.250af49a.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This dependency was inadvertantly removed in a previous patch
(e73aedba562d1e7777287043afb8e46131ed402e).

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 4fe53d0..d2ded19 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -77,6 +77,7 @@ endif
 
 ifeq ($(CONFIG_PPC_ISERIES),y)
 extra-y += lparmap.s
+$(obj)/head_64.o:	$(obj)/lparmap.s
 AFLAGS_head_64.o += -I$(obj)
 endif
 
-- 
1.4.4.1
