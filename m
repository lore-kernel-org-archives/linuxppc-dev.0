Return-Path: <anton@ozlabs.org>
Date: Tue, 20 Jun 2006 18:01:58 +1000
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Extra sanity check in EEH code
Message-ID: <20060620080158.GB30974@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Nathan Lynch <ntl@pobox.com>

Don't dereference a device node that isn't there.  A "shouldn't
happen" case, but someone ran into it with a possibly misconfigured
device tree.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: build/arch/powerpc/platforms/pseries/eeh_cache.c
===================================================================
--- build.orig/arch/powerpc/platforms/pseries/eeh_cache.c	2006-06-08 10:57:36.000000000 +1000
+++ build/arch/powerpc/platforms/pseries/eeh_cache.c	2006-06-20 12:01:49.000000000 +1000
@@ -304,6 +304,8 @@ void __init pci_addr_cache_build(void)
 		pci_addr_cache_insert_device(dev);
 
 		dn = pci_device_to_OF_node(dev);
+		if (!dn)
+			continue;
 		pci_dev_get (dev);  /* matching put is in eeh_remove_device() */
 		PCI_DN(dn)->pcidev = dev;
 	}
