Return-Path: <galak@gate.crashing.org>
Date: Tue, 20 Dec 2005 16:16:26 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.44.0512201615540.26351-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Loosen udbg_probe_uart_speed sanity checking
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The checking of the baudrate in udbg_probe_uart_speed was
too tight and would cause reporting back of the default
baud rate in cases where the computed speed was valid.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 8bec94b3bb35c0273fbab5a6aa477ec71a4d1fab
tree c2dde72aa75a3d807a918556e97b21723c10267b
parent a86f866f7b31e01c729ee7498228c547a51d8514
author Kumar Gala <galak@kernel.crashing.org> Tue, 20 Dec 2005 16:17:13 -0600
committer Kumar Gala <galak@kernel.crashing.org> Tue, 20 Dec 2005 16:17:13 -0600

 arch/powerpc/kernel/udbg_16550.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/udbg_16550.c b/arch/powerpc/kernel/udbg_16550.c
index e58c048..7541bf4 100644
--- a/arch/powerpc/kernel/udbg_16550.c
+++ b/arch/powerpc/kernel/udbg_16550.c
@@ -137,7 +137,7 @@ unsigned int udbg_probe_uart_speed(void 
 	speed = (clock / prescaler) / (divisor * 16);
 
 	/* sanity check */
-	if (speed < 9600 || speed > 115200)
+	if (speed < 0 || speed > (clock / 16))
 		speed = 9600;
 
 	return speed;
