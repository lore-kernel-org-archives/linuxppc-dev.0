Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402JH033HQzF15q
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 06:16:28 +1100 (AEDT)
From: Michal Suchanek <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Michael Neuling <mikey@neuling.org>,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>, Nicholas Piggin <npiggin@gmail.com>,
 Al Viro <viro@zeniv.linux.org.uk>,
 David Gibson <david@gibson.dropbear.id.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Philippe Ombredanne <pombredanne@nexb.com>, Joe Perches <joe@perches.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Tobin C. Harding" <me@tobin.cc>, Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH RFC rebase 8/9] powerpc/64s: barrier_nospec: Add hcall triggerr
Date: Thu, 15 Mar 2018 20:15:57 +0100
Message-Id: <54913b22e2f3647c670b6fb3e1fecce34729b736.1521141122.git.msuchanek@suse.de>
In-Reply-To: <cover.1521141122.git.msuchanek@suse.de>
References: <20180313200108.GA4082@hirez.programming.kicks-ass.net>
 <cover.1521141122.git.msuchanek@suse.de>
In-Reply-To: <cover.1521141122.git.msuchanek@suse.de>
References: <cover.1521141122.git.msuchanek@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adapted from the RFI implementation

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/platforms/pseries/mobility.c |  2 +-
 arch/powerpc/platforms/pseries/pseries.h  |  2 +-
 arch/powerpc/platforms/pseries/setup.c    | 37 ++++++++++++++++++++++---------
 3 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index 8a8033a249c7..9d506be1580e 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -349,7 +349,7 @@ void post_mobility_fixup(void)
 			"failed: %d\n", rc);
 
 	/* Possibly switch to a new RFI flush type */
-	pseries_setup_rfi_flush();
+	pseries_setup_rfi_nospec();
 
 	return;
 }
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 27cdcb69fd18..d49670c67686 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -100,6 +100,6 @@ static inline unsigned long cmo_get_page_size(void)
 
 int dlpar_workqueue_init(void);
 
-void pseries_setup_rfi_flush(void);
+void pseries_setup_rfi_nospec(void);
 
 #endif /* _PSERIES_PSERIES_H */
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 9877c3dfcdc8..4b899a4db6dd 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -459,30 +459,47 @@ static void __init find_and_init_phbs(void)
 	of_pci_check_probe_only();
 }
 
-void pseries_setup_rfi_flush(void)
+void pseries_setup_rfi_nospec(void)
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
-	types = L1D_FLUSH_FALLBACK;
+	flush_enable = true;
+	flush_types = L1D_FLUSH_FALLBACK;
+	barrier_enable = true;
+	/* no fallback available if the firmware does not tell us */
+	barrier_type = SPEC_BARRIER_NONE;
 
 	rc = plpar_get_cpu_characteristics(&result);
 	if (rc == H_SUCCESS) {
 		if (result.character & H_CPU_CHAR_L1D_FLUSH_TRIG2)
-			types |= L1D_FLUSH_MTTRIG;
+			flush_types |= L1D_FLUSH_MTTRIG;
 		if (result.character & H_CPU_CHAR_L1D_FLUSH_ORI30)
-			types |= L1D_FLUSH_ORI;
+			flush_types |= L1D_FLUSH_ORI;
+		if (result.character & H_CPU_CHAR_SPEC_BAR_ORI31)
+			barrier_type |= SPEC_BARRIER_ORI;
 
 		if ((!(result.behaviour & H_CPU_BEHAV_L1D_FLUSH_PR)) ||
 		    (!(result.behaviour & H_CPU_BEHAV_FAVOUR_SECURITY)))
-			enable = false;
+			flush_enable = false;
+		/*
+		 * Do not check H_CPU_BEHAV_BNDS_CHK_SPEC_BAR - the ORI does
+		 * nothing anyway when not supported.
+		 */
+		if ((!(result.behaviour & H_CPU_BEHAV_FAVOUR_SECURITY)))
+			barrier_enable = false;
+	} else {
+		/* Default to fallback if case hcall is not available */
+		flush_types = L1D_FLUSH_FALLBACK;
 	}
 
-	setup_rfi_flush(types, enable);
+	setup_barrier_nospec(barrier_type, barrier_enable);
+	setup_rfi_flush(flush_types, flush_enable);
 }
 
 #ifdef CONFIG_PCI_IOV
@@ -658,7 +675,7 @@ static void __init pSeries_setup_arch(void)
 
 	fwnmi_init();
 
-	pseries_setup_rfi_flush();
+	pseries_setup_rfi_nospec();
 
 	/* By default, only probe PCI (can be overridden by rtas_pci) */
 	pci_add_flags(PCI_PROBE_ONLY);
-- 
2.13.6
