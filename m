Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 30 Apr 2009 15:39:38 +1000
Subject: [PATCH] powerpc: Fix setting of oprofile cpu type
Message-Id: <20090430053943.93CF7DDED6@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

commit 2657dd4e301d4841ed67a4fac7d145ad8f3e1b28 introduced a
bug where we would now always override the "real" oprofile CPU
type with the "compatible" one provided by a pseudo-PVR in the
device-tree which is incorrect and breaks oprofile on all current
configs since the "compatible" ones aren't yet recognized.

This fixes it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Bug hit 2.6.29 too. I'll send this to Linus and Greg tomorrow unless
somebody thinks it's wrong. I've tested on POWER6 and verified the
bug and the fix.

 arch/powerpc/kernel/cputable.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-work.orig/arch/powerpc/kernel/cputable.c	2009-04-30 14:22:30.000000000 +1000
+++ linux-work/arch/powerpc/kernel/cputable.c	2009-04-30 14:22:41.000000000 +1000
@@ -1833,8 +1833,8 @@ static void __init setup_cpu_spec(unsign
 		 * and, in that case, keep the current value for
 		 * oprofile_cpu_type.
 		 */
-		if (old.oprofile_cpu_type == NULL)
-			t->oprofile_cpu_type = s->oprofile_cpu_type;
+		if (old.oprofile_cpu_type != NULL)
+			t->oprofile_cpu_type = old.oprofile_cpu_type;
 	}
 
 	*PTRRELOC(&cur_cpu_spec) = &the_cpu_spec;
