Return-Path: <scottwood@freescale.com>
Date: Tue, 11 Dec 2007 15:23:04 -0600
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 1/2] wrapper: rename offset in offset_devp().
Message-ID: <20071211212303.GA3661@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

fdt_wrapper_create_node passes a variable called offset to offset_devp(),
which uses said parameter to initialize a local variable called offset.

Due to one of the odder aspects of the C language, the result is an
undefined variable, with no error or warning.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/libfdt-wrapper.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/libfdt-wrapper.c b/arch/powerpc/boot/libfdt-wrapper.c
index 002da16..868c504 100644
--- a/arch/powerpc/boot/libfdt-wrapper.c
+++ b/arch/powerpc/boot/libfdt-wrapper.c
@@ -44,8 +44,8 @@
 
 #define offset_devp(off)	\
 	({ \
-		int offset = (off); \
-		check_err(offset) ? NULL : (void *)(offset+1); \
+		int _offset = (off); \
+		check_err(_offset) ? NULL : (void *)(_offset+1); \
 	})
 
 #define devp_offset(devp)	(((int)(devp))-1)
-- 
1.5.3.7
