Return-Path: <sfr@canb.auug.org.au>
Date: Wed, 15 Aug 2007 21:02:11 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Fix section mismatch in scc_sio.c
Message-Id: <20070815210211.9e6c8038.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

WARNING: vmlinux.o(.text+0x69d0c): Section mismatch: reference to .init.text:.early_serial_txx9_setup (between '.txx9_serial_init' and '.cpu_affinity_set')

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/celleb/scc_sio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/celleb/scc_sio.c b/arch/powerpc/platforms/celleb/scc_sio.c
index bcd25f5..d219b60 100644
--- a/arch/powerpc/platforms/celleb/scc_sio.c
+++ b/arch/powerpc/platforms/celleb/scc_sio.c
@@ -39,7 +39,7 @@ static struct {
 	{ 0x800, 1 }	/* 0xFF2800 */
 };
 
-static int txx9_serial_init(void)
+static int __init txx9_serial_init(void)
 {
 	extern int early_serial_txx9_setup(struct uart_port *port);
 	struct device_node *node;
-- 
1.5.2.4
