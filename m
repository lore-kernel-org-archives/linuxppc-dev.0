Return-Path: <joakim.tjernlund@transmode.com>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BE125B7BBA
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Oct 2009 23:16:49 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Scott Wood <scottwood@freescale.com>, Rex Feany <RFeany@mrv.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/6] 8xx: DTLB Error must check for more errors.
Date: Mon, 5 Oct 2009 14:16:34 +0200
Message-Id: <1254744999-3158-2-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1254744999-3158-1-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1254744999-3158-1-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DataTLBError currently does:
 if ((err & 0x02000000) == 0)
    DSI();
This won't handle a store with no valid translation.
Change this to
 if ((err & 0x48000000) != 0)
    DSI();
that is, branch to DSI if either !permission or
!translation.
---
 arch/powerpc/kernel/head_8xx.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 52ff8c5..118bb05 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -472,8 +472,8 @@ DataTLBError:
 	/* First, make sure this was a store operation.
 	*/
 	mfspr	r10, SPRN_DSISR
-	andis.	r11, r10, 0x0200	/* If set, indicates store op */
-	beq	2f
+	andis.	r11, r10, 0x4800 /* no translation, no permission. */
+	bne	2f	/* branch if either is set */
 
 	/* The EA of a data TLB miss is automatically stored in the MD_EPN
 	 * register.  The EA of a data TLB error is automatically stored in
-- 
1.6.4.4
