Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4013Qs5BpwzDqG4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 05:33:57 +1100 (AEDT)
From: Michal Suchanek <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Peter Zijlstra <peterz@infradead.org>, Michal Suchanek <msuchanek@suse.de>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Nicholas Piggin <npiggin@gmail.com>, "Tobin C. Harding" <me@tobin.cc>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Al Viro <viro@zeniv.linux.org.uk>, Michael Neuling <mikey@neuling.org>,
 "Oliver O'Halloran" <oohall@gmail.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Balbir Singh <bsingharora@gmail.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Daniel Axtens <dja@axtens.net>, Russell Currey <ruscur@russell.cc>,
 Joe Perches <joe@perches.com>,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 linux-kernel@vger.kernel.org
Subject: [PATCH RFC 7/8] powerpc/64s: barrier_nospec: Add hcall triggerr
Date: Tue, 13 Mar 2018 19:33:05 +0100
Message-Id: <1c687d0e029de81ae27465dd4c32036e956f4970.1520965380.git.msuchanek@suse.de>
In-Reply-To: <cover.1520965380.git.msuchanek@suse.de>
References: <cover.1520965380.git.msuchanek@suse.de>
In-Reply-To: <cover.1520965380.git.msuchanek@suse.de>
References: <cover.1520965380.git.msuchanek@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Copypasta from rfi implementation

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/platforms/pseries/setup.c | 38 ++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 1a527625acf7..b779ddb8e250 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -459,38 +459,50 @@ static void __init find_and_init_phbs(void)
 	of_pci_check_probe_only();
 }
 
-static void pseries_setup_rfi_flush(void)
+static void pseries_setup_rfi_nospec(void)
 {
 	struct h_cpu_char_result result;
-	enum l1d_flush_type types;
-	bool enable;
+	enum l1d_flush_type flush_types;
+	enum spec_barrier_type barrier_type;
+	bool flush_enable;
+	bool barrier_enable;
 	long rc;
 
 	/* Enable by default */
-	enable = true;
+	flush_enable = true;
+	barrier_enable = true;
+	/* no fallback if the firmware does not tell us */
+	barrier_type = SPEC_BARRIER_NONE;
 
 	rc = plpar_get_cpu_characteristics(&result);
 	if (rc == H_SUCCESS) {
-		types = L1D_FLUSH_NONE;
+		flush_types = L1D_FLUSH_NONE;
 
 		if (result.character & H_CPU_CHAR_L1D_FLUSH_TRIG2)
-			types |= L1D_FLUSH_MTTRIG;
+			flush_types |= L1D_FLUSH_MTTRIG;
 		if (result.character & H_CPU_CHAR_L1D_FLUSH_ORI30)
-			types |= L1D_FLUSH_ORI;
+			flush_types |= L1D_FLUSH_ORI;
+		if (result.character & H_CPU_CHAR_SPEC_BAR_ORI31)
+			barrier_type |= SPEC_BARRIER_ORI;
 
 		/* Use fallback if nothing set in hcall */
-		if (types == L1D_FLUSH_NONE)
-			types = L1D_FLUSH_FALLBACK;
+		if (flush_types == L1D_FLUSH_NONE)
+			flush_types = L1D_FLUSH_FALLBACK;
 
 		if ((!(result.behaviour & H_CPU_BEHAV_L1D_FLUSH_PR)) ||
 		    (!(result.behaviour & H_CPU_BEHAV_FAVOUR_SECURITY)))
-			enable = false;
+			flush_enable = false;
+
+		if ((!(result.behaviour & H_CPU_BEHAV_BNDS_CHK_SPEC_BAR)) ||
+		    (!(result.behaviour & H_CPU_BEHAV_FAVOUR_SECURITY)))
+			barrier_enable = false;
 	} else {
 		/* Default to fallback if case hcall is not available */
-		types = L1D_FLUSH_FALLBACK;
+		flush_types = L1D_FLUSH_FALLBACK;
 	}
 
-	setup_rfi_flush(types, enable);
+	setup_barrier_nospec(barrier_type, barrier_enable);
+	setup_rfi_flush(flush_types, flush_enable);
 }
 
 #ifdef CONFIG_PCI_IOV
@@ -666,7 +678,7 @@ static void __init pSeries_setup_arch(void)
 
 	fwnmi_init();
 
-	pseries_setup_rfi_flush();
+	pseries_setup_rfi_nospec();
 
 	/* By default, only probe PCI (can be overridden by rtas_pci) */
 	pci_add_flags(PCI_PROBE_ONLY);
-- 
2.13.6
