Return-Path: <mgreer@mvista.com>
Date: Mon, 3 Dec 2007 22:45:56 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/7] powerpc: ras.c should call machine_power_off()
Message-ID: <20071204054556.GD27862@mag.az.mvista.com>
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

machine_power_off() is the proper interface to use for powering
off a machine.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---
 arch/powerpc/platforms/pseries/ras.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index a1ab25c..64564b2 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -242,7 +242,7 @@ static irqreturn_t ras_error_interrupt(int irq, void *dev_id)
 		 * without actually failing while injecting errors.
 		 * Error data will not be logged to syslog.
 		 */
-		ppc_md.power_off();
+		machine_power_off();
 #endif
 	} else {
 		udbg_printf("Recoverable HW Error <0x%lx 0x%x>\n",
