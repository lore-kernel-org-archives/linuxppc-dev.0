Return-Path: <anton@samba.org>
Date: Mon, 15 Aug 2011 10:30:30 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, nfont@austin.ibm.com
Subject: [PATCH] powerpc: pseries: Avoid spurious error during hotplug CPU add
Message-ID: <20110815103030.2e90f017@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


During hotplug CPU add we get the following error:

Unexpected Error (0) returned from configure-connector

ibm,configure-connector returns 0 for configuration complete, so
catch this and avoid the error.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-powerpc/arch/powerpc/platforms/pseries/dlpar.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/platforms/pseries/dlpar.c	2011-08-12 09:37:11.921180339 +1000
+++ linux-powerpc/arch/powerpc/platforms/pseries/dlpar.c	2011-08-15 10:09:25.940626779 +1000
@@ -112,6 +112,7 @@ void dlpar_free_cc_nodes(struct device_n
 	dlpar_free_one_cc_node(dn);
 }
 
+#define COMPLETE	0
 #define NEXT_SIBLING    1
 #define NEXT_CHILD      2
 #define NEXT_PROPERTY   3
@@ -158,6 +159,9 @@ struct device_node *dlpar_configure_conn
 		spin_unlock(&rtas_data_buf_lock);
 
 		switch (rc) {
+		case COMPLETE:
+			break;
+
 		case NEXT_SIBLING:
 			dn = dlpar_parse_cc_node(ccwa);
 			if (!dn)
