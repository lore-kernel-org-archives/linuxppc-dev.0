Return-Path: <mikey@ozlabs.org>
To: Michael Ellerman <michael@ellerman.id.au>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc: Fix machine detection in prom_init.c 
Date: Fri, 07 Apr 2006 13:56:21 +1000
Sender: mikey@ozlabs.org
Message-Id: <20060407035637.D713367B34@ozlabs.org>
Reply-To: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Michael Ellerman <michael@ellerman.id.au>

In e8222502ee6157e2713da9e0792c21f4ad458d50 the detection of machine types
in prom_init broke for some machines. We should be checking /device_type
instead of /model. This should make Power3 and Power4 boot again. Haven't
been able to test this.  We also need to relocate before comparing. 

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
> > In e8222502ee6157e2713da9e0792c21f4ad458d50 the detection of machine
> > types in prom_init broke for some machines. We should be checking
> > /device_type instead of /model. This should make Power3 and Power4
> > boot again. Haven't been able to test this.
> 
> We also need to relocate the string before comparing.
> 
> Combined patch below.  Tested on POWER3.  

Oops, let's be a little more careful walking off into nowhere.

Again, combined patch below.  Tested on POWER3.  

 arch/powerpc/kernel/prom_init.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

Index: linux-2.6-powerpc/arch/powerpc/kernel/prom_init.c
===================================================================
--- linux-2.6-powerpc.orig/arch/powerpc/kernel/prom_init.c
+++ linux-2.6-powerpc/arch/powerpc/kernel/prom_init.c
@@ -1528,12 +1528,11 @@ static int __init prom_find_machine_type
 	 *    non-IBM designs !
 	 *  - it has /rtas
 	 */
-	len = prom_getprop(_prom->root, "model",
+	len = prom_getprop(_prom->root, "device_type",
 			   compat, sizeof(compat)-1);
 	if (len <= 0)
 		return PLATFORM_GENERIC;
-	compat[len] = 0;
-	if (strcmp(compat, "chrp"))
+	if (strncmp(compat, RELOC("chrp"), 4))
 		return PLATFORM_GENERIC;
 
 	/* Default to pSeries. We need to know if we are running LPAR */
