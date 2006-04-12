Return-Path: <arnd.bergmann@de.ibm.com>
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] spufs: fix context-switch decrementer code
Date: Wed, 12 Apr 2006 17:44:27 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200604121744.27674.arnd.bergmann@de.ibm.com>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jordi Caubet <jordi_caubet@es.ibm.com>

We found that when the 'decrementer' is saved, the PPE saves the current
time 'csa->suspend_time'. When restoring the 'decrementer', (Step 34)
decrementer seems to be adjusted with the number of cycles th= at a spu
thread has not been running.

In that code it is missing a substract ('-') because 'delta_time' is
assigned a not substracted(see bellow).

Acked-by: Mark Nutter <mnutter@us.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---

Index: linus-2.6/arch/powerpc/platforms/cell/spufs/switch.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/spufs/switch.c
+++ linus-2.6/arch/powerpc/platforms/cell/spufs/switch.c
@@ -1299,7 +1299,7 @@ static inline void setup_decr(struct spu
 		cycles_t resume_time = get_cycles();
 		cycles_t delta_time = resume_time - csa->suspend_time;
 
-		csa->lscsa->decr.slot[0] = delta_time;
+		csa->lscsa->decr.slot[0] -= delta_time;
 	}
 }
 
