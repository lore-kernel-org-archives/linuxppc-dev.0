Return-Path: <michel@tungstengraphics.com>
Received: from admin.zirkelwireless.com (admin.zirkelwireless.com
	[209.216.203.65])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2F89E67C07
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 02:09:27 +1000 (EST)
Received: from [192.168.9.2] (80-218-118-103.dclient.hispeed.ch
	[80.218.118.103]) (authenticated bits=0)
	by admin.zirkelwireless.com (8.12.10/8.12.10) with ESMTP id
	k7LG7AdM015000
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 10:07:11 -0600
Subject: [PATCH 2/2] uninorth: Add module param 'aperture' for aperture size
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <11560844762890-git-send-email->
References: <115608447678-git-send-email->  <11560844762890-git-send-email->
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Aug 2006 18:09:18 +0200
Message-Id: <1156176559.16513.78.camel@thor.lorrainebruecke.local>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In contrast to most if not all PC BIOSes, OpenFirmware (OF) on PowerMacs with
UniNorth bridges does not allow changing the aperture size. The size set up by
OF is usually 16 MB, which is too low for graphics intensive environments.
Hence, add a module parameter that allows changing the aperture size at driver
initialization time. When the parameter is not specified, the default is still
to leave the size unchanged, usually as set up by OF.

Signed-off-by: Michel Dänzer <michel@tungstengraphics.com>
---
 drivers/char/agp/uninorth-agp.c |   59 ++++++++++++++++++++++++++-------------
 1 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/drivers/char/agp/uninorth-agp.c b/drivers/char/agp/uninorth-agp.c
index 78c8cb2..ef2010c 100644
--- a/drivers/char/agp/uninorth-agp.c
+++ b/drivers/char/agp/uninorth-agp.c
@@ -27,32 +27,48 @@ #include "agp.h"
 static int uninorth_rev;
 static int is_u3;
 
+static char __devinitdata *aperture = NULL;
 
 static int uninorth_fetch_size(void)
 {
-	int i;
-	u32 temp;
-	struct aper_size_info_32 *values;
-
-	pci_read_config_dword(agp_bridge->dev, UNI_N_CFG_GART_BASE, &temp);
-	temp &= ~(0xfffff000);
-	values = A_SIZE_32(agp_bridge->driver->aperture_sizes);
-
-	for (i = 0; i < agp_bridge->driver->num_aperture_sizes; i++) {
-		if (temp == values[i].size_value) {
-			agp_bridge->previous_size =
-			    agp_bridge->current_size = (void *) (values + i);
-			agp_bridge->aperture_size_idx = i;
-			return values[i].size;
+	int i = 0, size = 0;
+	struct aper_size_info_32 *values =
+	    A_SIZE_32(agp_bridge->driver->aperture_sizes);
+
+	if (aperture) {
+		char *save = aperture;
+
+		size = memparse(aperture, &aperture) >> 20;
+		aperture = save;
+
+		for (i = 0; i < agp_bridge->driver->num_aperture_sizes; i++)
+			if (size == values[i].size)
+				break;
+
+		if (i == agp_bridge->driver->num_aperture_sizes) {
+			printk(KERN_ERR PFX "Invalid aperture size, using"
+			       " default\n");
+			size = 0;
+			aperture = NULL;
 		}
 	}
 
-	agp_bridge->previous_size =
-	    agp_bridge->current_size = (void *) (values + 1);
-	agp_bridge->aperture_size_idx = 1;
-	return values[1].size;
+	if (!size) {
+		u32 temp;
 
-	return 0;
+		pci_read_config_dword(agp_bridge->dev, UNI_N_CFG_GART_BASE,
+				      &temp);
+		temp &= ~(0xfffff000);
+
+		for (i = 0; i < agp_bridge->driver->num_aperture_sizes; i++)
+			if (temp == values[i].size_value)
+				break;
+	}
+
+	agp_bridge->previous_size =
+	    agp_bridge->current_size = (void *)(values + i);
+	agp_bridge->aperture_size_idx = i;
+	return values[i].size;
 }
 
 static void uninorth_tlbflush(struct agp_memory *mem)
@@ -668,5 +684,10 @@ static void __exit agp_uninorth_cleanup(
 module_init(agp_uninorth_init);
 module_exit(agp_uninorth_cleanup);
 
+module_param(aperture, charp, 0);
+MODULE_PARM_DESC(aperture,
+		 "Aperture size, must be power of two between 4MB and 512MB.\n"
+		 "Default: Leave unchanged, e.g. as set up by firmware");
+
 MODULE_AUTHOR("Ben Herrenschmidt & Paul Mackerras");
 MODULE_LICENSE("GPL");


-- 
Earthling Michel Dänzer           |          http://tungstengraphics.com
Libre software enthusiast         |          Debian, X and DRI developer
