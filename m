Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 15 May 2009 14:34:06 +1000
Subject: [PATCH] powerpc/pseries: Really fix the oprofile CPU type on pseries
Message-Id: <20090515043414.E5C7ADE071@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

My previous pach for fixing the oprofile CPU type got somewhat mismerged
(by my fault) when it collided with another related patch. This should
finally (fingers crossed) fix the whole thing.

We make sure we keep the -old- oprofile type and CPU type whenever
one of them was specified in the first pass through the function.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

More eyes welcome to check I finally got that right.

 arch/powerpc/kernel/cputable.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-work.orig/arch/powerpc/kernel/cputable.c	2009-05-15 14:24:53.000000000 +1000
+++ linux-work/arch/powerpc/kernel/cputable.c	2009-05-15 14:27:04.000000000 +1000
@@ -1836,7 +1836,7 @@ static void __init setup_cpu_spec(unsign
 		 * and, in that case, keep the current value for
 		 * oprofile_cpu_type.
 		 */
-		if (old.oprofile_cpu_type == NULL) {
+		if (old.oprofile_cpu_type != NULL) {
 			t->oprofile_cpu_type = old.oprofile_cpu_type;
 			t->oprofile_type = old.oprofile_type;
 		}
