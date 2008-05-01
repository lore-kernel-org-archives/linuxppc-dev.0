Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 22396DDED5
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 18:04:39 +1000 (EST)
Date: Thu, 1 May 2008 10:04:09 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [PATCH 1/2] i2c: Add support for device alias names
Message-ID: <20080501100409.1b04fdb7@hyperion.delvare>
In-Reply-To: <1209399377.3666.30.camel@linux.site>
References: <20080428113052.6d024bda@hyperion.delvare>
	<20080428113901.2772e9d9@hyperion.delvare>
	<1209395245.3666.9.camel@linux.site>
	<20080428174010.5a40c2c0@hyperion.delvare>
	<1209399377.3666.30.camel@linux.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mundt <lethal@linux-sh.org>,
	Scott Wood <scottwood@freescale.com>, Jon, Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Kay,

On Mon, 28 Apr 2008 18:16:17 +0200, Kay Sievers wrote:
> On Mon, 2008-04-28 at 17:40 +0200, Jean Delvare wrote:
> > Why would i2c device modaliases ever contain multiple strings? A device
> > can't have multiple names, can it?
> 
> Like ACPI/PNP devices, which can have several compat id's, which means
> that a single device can have "multiple names":
>   $ cat /sys/bus/pnp/devices/00:09/id
>   IBM0057
>   PNP0f13

Ah, I didn't know about this. Now I'm curious how it can work. Does it
mean that several drivers attempt to bind to this device? 

> > Adding a ":" at the end of the i2c device names solves the problem I
> > was mentioning, sure, but why don't we simply remove the trailing "*",
> > instead of trying to work around it? A trailing "*" simply makes no
> > sense for aliases which are simple device names.
> 
> Sure, if there is only one single string, it's not useful.
> 
> > This is not only i2c
> > devices, but also platform devices, acpi, dmi, pnp...
> 
> ACPI, DMI, PNP (PNP does not do modalias) needs to be able to match only
> one string in a given list, so the trailing "*" is needed.

OK, I get the idea.

> > Can't we just stop handle_moddevtable() from adding a tailing "*"
> > automatically, and just let the device types which need it, add it on
> > their own?
> 
> For a lot subsystems it's fine to have it appended, as there is a
> defined list of identifiers, which must appear in the same order, and
> new identifiers are appended to the end. So the "*" still matches
> modules with possibly extended modalias strings.

I understand the logic, however I am skeptical how useful it is in
practice. If we add an identifier to the device aliases, then we also
update the corresponding modalias, so no in-tree driver can break. The
only case where it makes a difference, as far as I can see, is for
out-of-tree drivers. Am I correct? On top of that, I doubt that we
actually add new identifiers that frequently, do we?

> We would also need to review all buses which export modalias, if they
> need the "*" or not, and add them by hand, if needed.
> 
> I guess, it's easier to introduce an additional parameter to
> file2alias::do_table() and suppress the trailing "*" for i2c?

That's one possibility, but I had a slightly different approach, which
is to just let the type-specific handlers add the trailing "*" by
themselves if they need it. This allows for optimization in a few
cases.

Subject: modpost: i2c aliases need no trailing wildcard

Not all device type aliases need a trailing wildcard, in particular
the i2c aliases don't. Don't add a wildcard by default in do_table(),
instead let each device type handler add it if needed.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 scripts/mod/file2alias.c |   33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

--- linux-2.6.26-rc0.orig/scripts/mod/file2alias.c	2008-05-01 07:56:14.000000000 +0200
+++ linux-2.6.26-rc0/scripts/mod/file2alias.c	2008-05-01 09:39:37.000000000 +0200
@@ -51,6 +51,15 @@ do {                                    
                 sprintf(str + strlen(str), "*");                \
 } while(0)
 
+/* Always end in a wildcard, for future extension */
+static inline void add_wildcard(char *str)
+{
+	int len = strlen(str);
+
+	if (str[len - 1] != '*')
+		strcat(str + len, "*");
+}
+
 unsigned int cross_build = 0;
 /**
  * Check that sizeof(device_id type) are consistent with size of section
@@ -133,9 +142,7 @@ static void do_usb_entry(struct usb_devi
 	    id->match_flags&USB_DEVICE_ID_MATCH_INT_PROTOCOL,
 	    id->bInterfaceProtocol);
 
-	/* Always end in a wildcard, for future extension */
-	if (alias[strlen(alias)-1] != '*')
-		strcat(alias, "*");
+	add_wildcard(alias);
 	buf_printf(&mod->dev_table_buf,
 		   "MODULE_ALIAS(\"%s\");\n", alias);
 }
@@ -219,6 +226,7 @@ static int do_ieee1394_entry(const char 
 	ADD(alias, "ver", id->match_flags & IEEE1394_MATCH_VERSION,
 	    id->version);
 
+	add_wildcard(alias);
 	return 1;
 }
 
@@ -261,6 +269,7 @@ static int do_pci_entry(const char *file
 	ADD(alias, "bc", baseclass_mask == 0xFF, baseclass);
 	ADD(alias, "sc", subclass_mask == 0xFF, subclass);
 	ADD(alias, "i", interface_mask == 0xFF, interface);
+	add_wildcard(alias);
 	return 1;
 }
 
@@ -283,6 +292,7 @@ static int do_ccw_entry(const char *file
 	    id->dev_type);
 	ADD(alias, "dm", id->match_flags&CCW_DEVICE_ID_MATCH_DEVICE_MODEL,
 	    id->dev_model);
+	add_wildcard(alias);
 	return 1;
 }
 
@@ -290,7 +300,7 @@ static int do_ccw_entry(const char *file
 static int do_ap_entry(const char *filename,
 		       struct ap_device_id *id, char *alias)
 {
-	sprintf(alias, "ap:t%02X", id->dev_type);
+	sprintf(alias, "ap:t%02X*", id->dev_type);
 	return 1;
 }
 
@@ -309,6 +319,7 @@ static int do_serio_entry(const char *fi
 	ADD(alias, "id", id->id != SERIO_ANY, id->id);
 	ADD(alias, "ex", id->extra != SERIO_ANY, id->extra);
 
+	add_wildcard(alias);
 	return 1;
 }
 
@@ -316,7 +327,7 @@ static int do_serio_entry(const char *fi
 static int do_acpi_entry(const char *filename,
 			struct acpi_device_id *id, char *alias)
 {
-	sprintf(alias, "acpi*:%s:", id->id);
+	sprintf(alias, "acpi*:%s:*", id->id);
 	return 1;
 }
 
@@ -324,7 +335,7 @@ static int do_acpi_entry(const char *fil
 static int do_pnp_entry(const char *filename,
 			struct pnp_device_id *id, char *alias)
 {
-	sprintf(alias, "pnp:d%s", id->id);
+	sprintf(alias, "pnp:d%s*", id->id);
 	return 1;
 }
 
@@ -409,6 +420,7 @@ static int do_pcmcia_entry(const char *f
        ADD(alias, "pc", id->match_flags & PCMCIA_DEV_ID_MATCH_PROD_ID3, id->prod_id_hash[2]);
        ADD(alias, "pd", id->match_flags & PCMCIA_DEV_ID_MATCH_PROD_ID4, id->prod_id_hash[3]);
 
+	add_wildcard(alias);
        return 1;
 }
 
@@ -432,6 +444,7 @@ static int do_of_entry (const char *file
         if (isspace (*tmp))
             *tmp = '_';
 
+    add_wildcard(alias);
     return 1;
 }
 
@@ -448,6 +461,7 @@ static int do_vio_entry(const char *file
 		if (isspace (*tmp))
 			*tmp = '_';
 
+	add_wildcard(alias);
 	return 1;
 }
 
@@ -529,6 +543,7 @@ static int do_parisc_entry(const char *f
 	ADD(alias, "rev", id->hversion_rev != PA_HVERSION_REV_ANY_ID, id->hversion_rev);
 	ADD(alias, "sv", id->sversion != PA_SVERSION_ANY_ID, id->sversion);
 
+	add_wildcard(alias);
 	return 1;
 }
 
@@ -544,6 +559,7 @@ static int do_sdio_entry(const char *fil
 	ADD(alias, "c", id->class != (__u8)SDIO_ANY_ID, id->class);
 	ADD(alias, "v", id->vendor != (__u16)SDIO_ANY_ID, id->vendor);
 	ADD(alias, "d", id->device != (__u16)SDIO_ANY_ID, id->device);
+	add_wildcard(alias);
 	return 1;
 }
 
@@ -559,6 +575,7 @@ static int do_ssb_entry(const char *file
 	ADD(alias, "v", id->vendor != SSB_ANY_VENDOR, id->vendor);
 	ADD(alias, "id", id->coreid != SSB_ANY_ID, id->coreid);
 	ADD(alias, "rev", id->revision != SSB_ANY_REV, id->revision);
+	add_wildcard(alias);
 	return 1;
 }
 
@@ -573,6 +590,7 @@ static int do_virtio_entry(const char *f
 	ADD(alias, "d", 1, id->device);
 	ADD(alias, "v", id->vendor != VIRTIO_DEV_ANY_ID, id->vendor);
 
+	add_wildcard(alias);
 	return 1;
 }
 
@@ -612,9 +630,6 @@ static void do_table(void *symval, unsig
 
 	for (i = 0; i < size; i += id_size) {
 		if (do_entry(mod->name, symval+i, alias)) {
-			/* Always end in a wildcard, for future extension */
-			if (alias[strlen(alias)-1] != '*')
-				strcat(alias, "*");
 			buf_printf(&mod->dev_table_buf,
 				   "MODULE_ALIAS(\"%s\");\n", alias);
 		}

The patch only changes the i2c aliases, all the rest is the same as
before (unless I messed up somewhere, that is.) Do you think this would
be acceptable for upstream? If you think it's better to add a parameter
to do_table() and let it add the "*" as it did so far, that's also fine
with me, I can update the patch to do that.

Thanks,
-- 
Jean Delvare
