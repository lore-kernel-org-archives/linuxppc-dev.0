Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Kumar Gala <galak@kernel.crashing.org>, sfr@canb.auug.org.au
Subject: [PATCH] powerpc: fix usage of setup_pci_atmu()
In-reply-to: <1363201636-7318-1-git-send-email-galak@kernel.crashing.org>
References: <1363201636-7318-1-git-send-email-galak@kernel.crashing.org>
Date: Mon, 15 Apr 2013 15:42:01 +1000
Message-ID: <5881.1366004521@ale.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Linux next is currently failing to compile mpc85xx_defconfig with:
  arch/powerpc/sysdev/fsl_pci.c:944:2: error: too many arguments to function 'setup_pci_atmu'

This is caused by (from Kumar's next branch):
  commit 34642bbb3d12121333efcf4ea7dfe66685e403a1
  Author: Kumar Gala <galak@kernel.crashing.org>
  powerpc/fsl-pci: Keep PCI SoC controller registers in pci_controller

Which changed definition of setup_pci_atmu() but didn't update one of
the callers.  Below fixes this.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
Kumar: this is for your next tree

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 83918c3..a10a036 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -941,7 +941,7 @@ static int fsl_pci_resume(struct device *dev)
 		return -ENODEV;
 	}
 
-	setup_pci_atmu(hose, &pci_rsrc);
+	setup_pci_atmu(hose);
 
 	return 0;
 }
