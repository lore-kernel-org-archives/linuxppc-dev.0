Return-Path: <mgreer@mvista.com>
Date: Mon, 3 Dec 2007 22:43:22 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Helge Deller <deller@gmx.de>
Subject: [PATCH 1/7] powerpc: Drivers should call machine_power_off not
	pm_power_off
Message-ID: <20071204054322.GB27862@mag.az.mvista.com>
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

Drivers should call machine_power_off() not pm_power_off to power off
a machine.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---
 drivers/parisc/power.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/parisc/power.c b/drivers/parisc/power.c
index 90cca5e..188a1ac 100644
--- a/drivers/parisc/power.c
+++ b/drivers/parisc/power.c
@@ -93,11 +93,9 @@ static void process_shutdown(void)
 		lcd_print(msg);
 
 		/* send kill signal */
-		if (kill_cad_pid(SIGINT, 1)) {
+		if (kill_cad_pid(SIGINT, 1))
 			/* just in case killing init process failed */
-			if (pm_power_off)
-				pm_power_off();
-		}
+			machine_power_off();
 	}
 }
 
