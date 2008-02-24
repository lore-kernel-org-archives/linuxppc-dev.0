Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id D7D18DDD0C
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Feb 2008 07:24:06 +1100 (EST)
Date: Sun, 24 Feb 2008 14:12:33 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2][OF] Add of_device_is_disabled function
Message-ID: <20080224201233.GB16241@localdomain>
References: <20080223155823.2c85d829@zod.rchland.ibm.com>
	<20080223185904.757c2884@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080223185904.757c2884@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, sfr@canb.auug.org.au, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> On Sat, 23 Feb 2008 15:58:23 -0600
> Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> 
> > IEEE 1275 defined a standard "status" property to indicate the operational
> > status of a device.  The property has four possible values: okay, disabled,
> > fail, fail-xxx.  The absence of this property means the operational status
> > of the device is unknown or okay.
> > 
> > This adds a function called of_device_is_disabled that checks to see if a
> > node has the status property set to "disabled".  This can be quite useful
> > for devices that may be present but disabled due to pin sharing, etc.
> > 
> 
> Talking with Ben H a bit, he suggested to reverse this API.  Basically,
> create an of_device_is_available that returns 1 if the status property
> is completely missing, or if it's set to "okay" or "ok".  The latter is
> to cope with some broken firmwares.

I agree with Ben's suggestion.  The rtas_pci and eeh code could be
converted to use this, which gives a net savings of a few bytes with
ppc64_defconfig:


diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
index 433a0a0..39a752b 100644
--- a/arch/powerpc/kernel/rtas_pci.c
+++ b/arch/powerpc/kernel/rtas_pci.c
@@ -56,21 +56,6 @@ static inline int config_access_valid(struct pci_dn *dn, int where)
 	return 0;
 }
 
-static int of_device_available(struct device_node * dn)
-{
-        const char *status;
-
-        status = of_get_property(dn, "status", NULL);
-
-        if (!status)
-                return 1;
-
-        if (!strcmp(status, "okay"))
-                return 1;
-
-        return 0;
-}
-
 int rtas_read_config(struct pci_dn *pdn, int where, int size, u32 *val)
 {
 	int returnval = -1;
@@ -117,7 +102,7 @@ static int rtas_pci_read_config(struct pci_bus *bus,
 	for (dn = busdn->child; dn; dn = dn->sibling) {
 		struct pci_dn *pdn = PCI_DN(dn);
 		if (pdn && pdn->devfn == devfn
-		    && of_device_available(dn))
+		    && of_device_is_available(dn))
 			return rtas_read_config(pdn, where, size, val);
 	}
 
@@ -164,7 +149,7 @@ static int rtas_pci_write_config(struct pci_bus *bus,
 	for (dn = busdn->child; dn; dn = dn->sibling) {
 		struct pci_dn *pdn = PCI_DN(dn);
 		if (pdn && pdn->devfn == devfn
-		    && of_device_available(dn))
+		    && of_device_is_available(dn))
 			return rtas_write_config(pdn, where, size, val);
 	}
 	return PCIBIOS_DEVICE_NOT_FOUND;
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index 9eb539e..550b2f7 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -945,7 +945,6 @@ static void *early_enable_eeh(struct device_node *dn, void *data)
 	unsigned int rets[3];
 	struct eeh_early_enable_info *info = data;
 	int ret;
-	const char *status = of_get_property(dn, "status", NULL);
 	const u32 *class_code = of_get_property(dn, "class-code", NULL);
 	const u32 *vendor_id = of_get_property(dn, "vendor-id", NULL);
 	const u32 *device_id = of_get_property(dn, "device-id", NULL);
@@ -959,8 +958,8 @@ static void *early_enable_eeh(struct device_node *dn, void *data)
 	pdn->eeh_freeze_count = 0;
 	pdn->eeh_false_positives = 0;
 
-	if (status && strncmp(status, "ok", 2) != 0)
-		return NULL;	/* ignore devices with bad status */
+	if (!of_device_is_available(dn))
+		return NULL;
 
 	/* Ignore bad nodes. */
 	if (!class_code || !vendor_id || !device_id)
