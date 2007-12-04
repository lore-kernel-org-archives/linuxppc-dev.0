Return-Path: <mgreer@mvista.com>
Date: Mon, 3 Dec 2007 22:50:16 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [PATCH 7/7] powerpc: Remove incorrect panic() calls
Message-ID: <20071204055016.GH27862@mag.az.mvista.com>
References: <20071204053736.GA27862@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071204053736.GA27862@mag.az.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Mark A. Greer <mgreer@mvista.com>

Platform-specific restart routines should not call panic() when they
fail.  Instead, they should return so the caller (machine_restart())
can halt the system more gracefully.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---
 arch/powerpc/platforms/82xx/pq2.c              |    2 --
 arch/powerpc/platforms/8xx/m8xx_setup.c        |    1 -
 arch/powerpc/platforms/embedded6xx/prpmc2800.c |    1 -
 3 files changed, 4 deletions(-)

diff --git a/arch/powerpc/platforms/82xx/pq2.c b/arch/powerpc/platforms/82xx/pq2.c
index a497cba..16cd460 100644
--- a/arch/powerpc/platforms/82xx/pq2.c
+++ b/arch/powerpc/platforms/82xx/pq2.c
@@ -31,8 +31,6 @@ void pq2_restart(char *cmd)
 	/* Clear the ME,EE,IR & DR bits in MSR to cause checkstop */
 	mtmsr(mfmsr() & ~(MSR_ME | MSR_EE | MSR_IR | MSR_DR));
 	in_8(&cpm2_immr->im_clkrst.res[0]);
-
-	panic("Restart failed\n");
 }
 
 #ifdef CONFIG_PCI
diff --git a/arch/powerpc/platforms/8xx/m8xx_setup.c b/arch/powerpc/platforms/8xx/m8xx_setup.c
index d35eda8..1014310 100644
--- a/arch/powerpc/platforms/8xx/m8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/m8xx_setup.c
@@ -221,7 +221,6 @@ void mpc8xx_restart(char *cmd)
 	mtmsr(mfmsr() & ~0x1000);
 
 	in_8(&clk_r->res[0]);
-	panic("Restart failed\n");
 }
 
 static void cpm_cascade(unsigned int irq, struct irq_desc *desc)
diff --git a/arch/powerpc/platforms/embedded6xx/prpmc2800.c b/arch/powerpc/platforms/embedded6xx/prpmc2800.c
index 653a5eb..fe5920c 100644
--- a/arch/powerpc/platforms/embedded6xx/prpmc2800.c
+++ b/arch/powerpc/platforms/embedded6xx/prpmc2800.c
@@ -108,7 +108,6 @@ static void prpmc2800_restart(char *cmd)
 	prpmc2800_reset_board();
 
 	while (i-- > 0);
-	panic("restart failed\n");
 }
 
 #ifdef CONFIG_NOT_COHERENT_CACHE
