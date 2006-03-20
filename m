Return-Path: <galak@kernel.crashing.org>
Date: Mon, 20 Mar 2006 12:03:42 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from '83xx' branch of powerpc
Message-ID: <Pine.LNX.4.44.0603201202240.23637-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please pull from '83xx' branch of
master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git

to receive the following updates:

 arch/powerpc/platforms/83xx/misc.c    |    2 +-
 arch/ppc/platforms/83xx/mpc834x_sys.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Horst Kronstorfer:
      ppc32: Fix BCSR_SIZE for MPC834x SYS

Kumar Gala:
      powerpc: Fix mpc83xx restart bug

diff --git a/arch/powerpc/platforms/83xx/misc.c b/arch/powerpc/platforms/83xx/misc.c
index 0eb3d99..1455bce 100644
--- a/arch/powerpc/platforms/83xx/misc.c
+++ b/arch/powerpc/platforms/83xx/misc.c
@@ -35,7 +35,7 @@ void mpc83xx_restart(char *cmd)
 	out_be32(reg + (RST_PROT_REG >> 2), 0x52535445);
 
 	/* set software hard reset */
-	out_be32(reg + (RST_CTRL_REG >> 2), 0x52535445);
+	out_be32(reg + (RST_CTRL_REG >> 2), 0x2);
 	for (;;) ;
 }
 
diff --git a/arch/ppc/platforms/83xx/mpc834x_sys.h b/arch/ppc/platforms/83xx/mpc834x_sys.h
index aa86c22..6727bbd 100644
--- a/arch/ppc/platforms/83xx/mpc834x_sys.h
+++ b/arch/ppc/platforms/83xx/mpc834x_sys.h
@@ -23,7 +23,7 @@
 #define VIRT_IMMRBAR		((uint)0xfe000000)
 
 #define BCSR_PHYS_ADDR		((uint)0xf8000000)
-#define BCSR_SIZE		((uint)(128 * 1024))
+#define BCSR_SIZE		((uint)(32 * 1024))
 
 #define BCSR_MISC_REG2_OFF	0x07
 #define BCSR_MISC_REG2_PORESET	0x01
