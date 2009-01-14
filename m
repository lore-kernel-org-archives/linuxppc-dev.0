Return-Path: <sfr@canb.auug.org.au>
Date: Wed, 14 Jan 2009 17:00:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: [PATCH 04/13] powerpc/ps3: clear_bit/set_bit operate on unsigned longs
Message-Id: <20090114170029.702de0cd.sfr@canb.auug.org.au>
In-Reply-To: <20090114165450.ebbc11a7.sfr@canb.auug.org.au>
References: <20090114165450.ebbc11a7.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This fixes these compiler warning:

arch/powerpc/platforms/ps3/interrupt.c:109: warning: passing argument 2 of 'clear_bit' from incompatible pointer type
arch/powerpc/platforms/ps3/interrupt.c:130: warning: passing argument 2 of 'set_bit' from incompatible pointer type

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/ps3/interrupt.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/interrupt.c b/arch/powerpc/platforms/ps3/interrupt.c
index b746792..3ea6e51 100644
--- a/arch/powerpc/platforms/ps3/interrupt.c
+++ b/arch/powerpc/platforms/ps3/interrupt.c
@@ -60,6 +60,8 @@
  * gives a usable range of plug values of  {NUM_ISA_INTERRUPTS..63}.  Note
  * that there is no constraint on how many in this set an individual thread
  * can acquire.
+ *
+ * The mask is declared as unsigned long so we can use set/clear_bit on it.
  */
 
 #define PS3_BMP_MINALIGN 64
@@ -68,7 +70,7 @@ struct ps3_bmp {
 	struct {
 		u64 status;
 		u64 unused_1[3];
-		u64 mask;
+		unsigned long mask;
 		u64 unused_2[3];
 	};
 	u64 ipi_debug_brk_mask;
-- 
1.6.0.5

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
