Date: Tue, 20 Aug 2002 10:45:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Compile fix for 4xx (linuxppc_2_4_devel)
Message-ID: <20020820004500.GB998@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This fixes compile on 4xx machines, which was broken by the recent
heartbeat changes.  Please apply.

diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/ppc4xx_setup.c linux-grinch/arch/ppc/kernel/ppc4xx_setup.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/ppc4xx_setup.c	2002-08-05 10:37:17.000000000 +1000
+++ linux-grinch/arch/ppc/kernel/ppc4xx_setup.c	2002-08-19 15:05:01.000000000 +1000
@@ -415,7 +415,7 @@
 #ifdef CONFIG_PPC405_WDT
 	ppc_md.heartbeat = ppc4xx_wdt_heartbeat;
 #endif
-	ppc_md.heartbeat_count = 0;
+	ppc_md.heartbeat_count[0] = 0;

 	ppc_md.find_end_of_memory = ppc4xx_find_end_of_memory;
 	ppc_md.setup_io_mappings = m4xx_map_io;


--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
