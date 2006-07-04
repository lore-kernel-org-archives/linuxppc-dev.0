Return-Path: <jk@ozlabs.org>
To: linuxppc-dev@ozlabs.org
From: Jeremy Kerr <jk@ozlabs.org>
Subject: [PATCH 16/20] [powerpc,sound] Constify & voidify get_property()
Message-ID: 1151993427.2210.17@pokey
Date: Tue,  4 Jul 2006 16:47:18 +1000 (EST)
Cc: linux-sound@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that get_property() returns a void *, there's no need to cast its
return value. Also, treat the return value as const, so we can
constify get_property later.

powerpc-specific sound driver changes.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
---

 aoa/core/snd-aoa-gpio-feature.c |    2 +-
 oss/dmasound/dmasound_awacs.c   |   11 ++++++-----
 ppc/tumbler.c                   |   15 ++++++++-------
 3 files changed, 15 insertions(+), 13 deletions(-)

Index: linux-2.6/sound/oss/dmasound/dmasound_awacs.c
===================================================================
--- linux-2.6.orig/sound/oss/dmasound/dmasound_awacs.c
+++ linux-2.6/sound/oss/dmasound/dmasound_awacs.c
@@ -347,8 +347,8 @@ int
 setup_audio_gpio(const char *name, const char* compatible, int *gpio_addr, int* gpio_pol)
 {
 	struct device_node *np;
-	u32* pp;
-	
+	const u32* pp;
+
 	np = find_devices("gpio");
 	if (!np)
 		return -ENODEV;
@@ -356,7 +356,8 @@ setup_audio_gpio(const char *name, const
 	np = np->child;
 	while(np != 0) {
 		if (name) {
-			char *property = get_property(np,"audio-gpio",NULL);
+			const char *property =
+				get_property(np,"audio-gpio",NULL);
 			if (property != 0 && strcmp(property,name) == 0)
 				break;
 		} else if (compatible && device_is_compatible(np, compatible))
@@ -365,11 +366,11 @@ setup_audio_gpio(const char *name, const
 	}
 	if (!np)
 		return -ENODEV;
-	pp = (u32 *)get_property(np, "AAPL,address", NULL);
+	pp = get_property(np, "AAPL,address", NULL);
 	if (!pp)
 		return -ENODEV;
 	*gpio_addr = (*pp) & 0x0000ffff;
-	pp = (u32 *)get_property(np, "audio-gpio-active-state", NULL);
+	pp = get_property(np, "audio-gpio-active-state", NULL);
 	if (pp)
 		*gpio_pol = *pp;
 	else
Index: linux-2.6/sound/ppc/tumbler.c
===================================================================
--- linux-2.6.orig/sound/ppc/tumbler.c
+++ linux-2.6/sound/ppc/tumbler.c
@@ -1035,7 +1035,7 @@ static struct device_node *find_audio_de
 		return NULL;
   
 	for (np = np->child; np; np = np->sibling) {
-		char *property = get_property(np, "audio-gpio", NULL);
+		const char *property = get_property(np, "audio-gpio", NULL);
 		if (property && strcmp(property, name) == 0)
 			return np;
 	}  
@@ -1062,7 +1062,8 @@ static long tumbler_find_device(const ch
 				struct pmac_gpio *gp, int is_compatible)
 {
 	struct device_node *node;
-	u32 *base, addr;
+	const u32 *base;
+	u32 addr;
 
 	if (is_compatible)
 		node = find_compatible_audio_device(device);
@@ -1074,9 +1075,9 @@ static long tumbler_find_device(const ch
 		return -ENODEV;
 	}
 
-	base = (u32 *)get_property(node, "AAPL,address", NULL);
+	base = get_property(node, "AAPL,address", NULL);
 	if (! base) {
-		base = (u32 *)get_property(node, "reg", NULL);
+		base = get_property(node, "reg", NULL);
 		if (!base) {
 			DBG("(E) cannot find address for device %s !\n", device);
 			snd_printd("cannot find address for device %s\n", device);
@@ -1090,13 +1091,13 @@ static long tumbler_find_device(const ch
 
 	gp->addr = addr & 0x0000ffff;
 	/* Try to find the active state, default to 0 ! */
-	base = (u32 *)get_property(node, "audio-gpio-active-state", NULL);
+	base = get_property(node, "audio-gpio-active-state", NULL);
 	if (base) {
 		gp->active_state = *base;
 		gp->active_val = (*base) ? 0x5 : 0x4;
 		gp->inactive_val = (*base) ? 0x4 : 0x5;
 	} else {
-		u32 *prop = NULL;
+		const u32 *prop = NULL;
 		gp->active_state = 0;
 		gp->active_val = 0x4;
 		gp->inactive_val = 0x5;
@@ -1105,7 +1106,7 @@ static long tumbler_find_device(const ch
 		 * as we don't yet have an interpreter for these things
 		 */
 		if (platform)
-			prop = (u32 *)get_property(node, platform, NULL);
+			prop = get_property(node, platform, NULL);
 		if (prop) {
 			if (prop[3] == 0x9 && prop[4] == 0x9) {
 				gp->active_val = 0xd;
Index: linux-2.6/sound/aoa/core/snd-aoa-gpio-feature.c
===================================================================
--- linux-2.6.orig/sound/aoa/core/snd-aoa-gpio-feature.c
+++ linux-2.6/sound/aoa/core/snd-aoa-gpio-feature.c
@@ -56,7 +56,7 @@ static struct device_node *get_gpio(char
 {
 	struct device_node *np, *gpio;
 	u32 *reg;
-	char *audio_gpio;
+	const char *audio_gpio;
 
 	*gpioptr = -1;
 
