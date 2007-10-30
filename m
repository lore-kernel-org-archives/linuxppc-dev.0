Return-Path: <Sergej.Stepanov@ids.de>
Received: from ares.ids.de (ares.ids.de [213.144.29.131])
	by ozlabs.org (Postfix) with ESMTP id D5CF2DE04C
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 18:43:47 +1100 (EST)
Received: from ares.ids.de (ares.ids.de [127.0.0.1])
	by ares.ids.de (PGP Universal) with ESMTP id 17415F49151
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 08:43:45 +0100 (CET)
Subject: Re: compile warning
From: Sergej Stepanov <Sergej.Stepanov@ids.de>
To: linux-ppc <linuxppc-dev@ozlabs.org>, Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <77CDBB94-A21E-4A84-9818-4622CB2F572C@kernel.crashing.org>
References: <1193405129.29250.2.camel@p60635-ste.ids.de>
	<77CDBB94-A21E-4A84-9818-4622CB2F572C@kernel.crashing.org>
Date: Tue, 30 Oct 2007 08:43:44 +0100
Message-Id: <1193730224.4997.13.camel@p60635-ste.ids.de>
Mime-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

thanks for your reply.
> >
> > WARNING: vmlinux.o(.text+0x10f5c): Section mismatch: reference
> > to .init.text:cpm_muram_init (between 'cpm2_reset' and
> > 'cpm2_smc_clk_setup')
> >
> It should be fixed, but its highly unlikely you'll see a problem  
> unless you start trying to build core parts of the CPM code as modules.
> 
> - k
we have no modules for CPM.
Fix it i could with :

diff --git a/arch/powerpc/sysdev/cpm2_common.c b/arch/powerpc/sysdev/cpm2_common.c
index f8a621e..f507ada 100644
--- a/arch/powerpc/sysdev/cpm2_common.c
+++ b/arch/powerpc/sysdev/cpm2_common.c
@@ -61,7 +61,7 @@ cpm2_map_t __iomem *cpm2_immr;
 					   of space for CPM as it is larger
 					   than on PQ2 */
 
-void
+void __init
 cpm2_reset(void)
 {
 #ifdef CONFIG_PPC_85xx

------------------
I am not sure it is ok.

But i have other 2 warnings (no modules).

WARNING: vmlinux.o(.exit.text+0x5da): Section mismatch: reference to .init.data:of_platform_serial_driver (between 'of_platform_serial_exit' and 'phy_exit')
WARNING: vmlinux.o(.exit.text+0x5e2): Section mismatch: reference to .init.data:of_platform_serial_driver (between 'of_platform_serial_exit' and 'phy_exit')
 
Regards.
-- 
Sergej Stepanov
IDS GmbH
Nobelstr. 18, Zim. 2.1.05
D-76275 Ettlingen
T +49 (0) 72 43/2 18-615
F +49 (0) 72 43/2 18-400
http://www.ids.de
Email: Sergej.Stepanov@ids.de
