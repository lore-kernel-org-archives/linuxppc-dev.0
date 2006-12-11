Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id 8E43B67CC1
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 09:38:22 +1100 (EST)
Date: Mon, 11 Dec 2006 16:38:12 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/4] maple: match "pcie" name for CPC945
Message-ID: <20061211223812.GD6573@localdomain>
References: <11654526463043-git-send-email-ntl@pobox.com>
	<38E12654-EED6-4335-9DC6-293FE70A797C@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <38E12654-EED6-4335-9DC6-293FE70A797C@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
> >Some firmwares have "pcie" for the "name" property of the CPC945 PCI
> >Express host bridge.  Check for "pcie" in addition to "pci" so we
> >don't miss it.
> 
> You shouldn't use "name" but "device_type" and "compatible".

Like this?

(Hmm, does the u3-agp on maple have "pci" for device_type?)

diff --git a/arch/powerpc/platforms/maple/pci.c b/arch/powerpc/platforms/maple/pci.c
index 3a32ded..011f0f1 100644
--- a/arch/powerpc/platforms/maple/pci.c
+++ b/arch/powerpc/platforms/maple/pci.c
@@ -560,13 +560,16 @@ void __init maple_pci_init(void)
 		return;
 	}
 	for (np = NULL; (np = of_get_next_child(root, np)) != NULL;) {
-		if (np->name == NULL)
+		if (!np->type)
 			continue;
-		if (strcmp(np->name, "pci") == 0) {
-			if (add_bridge(np) == 0)
-				of_node_get(np);
-		}
-		if (strcmp(np->name, "ht") == 0) {
+		if (strcmp(np->type, "pci") && strcmp(np->type, "ht"))
+			continue;
+		if ((device_is_compatible(np, "u4-pcie") ||
+		     device_is_compatible(np, "u3-agp")) &&
+		    add_bridge(np) == 0)
+			of_node_get(np);
+
+		if (device_is_compatible(np, "u3-ht")) {
 			of_node_get(np);
 			ht = np;
 		}
