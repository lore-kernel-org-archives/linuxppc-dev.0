Return-Path: <shaggy@linux.vnet.ibm.com>
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: [PATCH 1/4] powerpc/47x: Make sure mcsr is cleared before enabling
	machine check interrupts
Date: Wed, 18 Aug 2010 11:44:23 -0500
Message-Id: <1282149866-4710-2-git-send-email-shaggy@linux.vnet.ibm.com>
In-Reply-To: <1282149866-4710-1-git-send-email-shaggy@linux.vnet.ibm.com>
References: <1282149866-4710-1-git-send-email-shaggy@linux.vnet.ibm.com>
Cc: Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
	linuxppc-dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Clear the machine check syndrom register before enabling machine check
interrupts.  The initial state of the tlb can lead to parity errors being
flagged early after a cold boot.

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/head_44x.S |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index 5ab484e..562305b 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -113,6 +113,10 @@ _ENTRY(_start);
 	stw	r5, 0(r4)	/* Save abatron_pteptrs at a fixed location */
 	stw	r6, 0(r5)
 
+	/* Clear the Machine Check Syndrome Register */
+	li	r0,0
+	mtspr	SPRN_MCSR,r0
+
 	/* Let's move on */
 	lis	r4,start_kernel@h
 	ori	r4,r4,start_kernel@l
-- 
1.7.1
