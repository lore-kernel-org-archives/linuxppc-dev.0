Return-Path: <mgreer@mvista.com>
Date: Mon, 3 Dec 2007 22:44:30 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: [PATCH 2/7] powerpc: xmon should call machine_xxx not ppc_md.xxx
	directly
Message-ID: <20071204054430.GC27862@mag.az.mvista.com>
References: <20071204053736.GA27862@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071204053736.GA27862@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Mark A. Greer <mgreer@mvista.com>

xmon should call machine_[restart|halt|power_off] instead of
ppc_md.[restart|halt|power_off].

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---
I'm not sure about this one.  Does anyone see a problem with this?

 arch/powerpc/xmon/xmon.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 121b04d..56267e3 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -908,11 +908,11 @@ static void bootcmds(void)
 
 	cmd = inchar();
 	if (cmd == 'r')
-		ppc_md.restart(NULL);
+		machine_restart();
 	else if (cmd == 'h')
-		ppc_md.halt();
+		machine_halt();
 	else if (cmd == 'p')
-		ppc_md.power_off();
+		machine_power_off();
 }
 
 static int cpu_cmd(void)
