Return-Path: <bcollins@ubuntu.com>
Date: Sat, 21 Jan 2006 23:43:22 -0500
From: Ben Collins <bcollins@ubuntu.com>
Subject: [PATCH] Check for altname == NULL in snd-pmac-gpio.c
To: Linuxppc-dev@ozlabs.org
Message-id: <1137905002.5871.15.camel@grayson>
MIME-version: 1.0
Content-type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since callers don't have to pass altname, snd-pmac-gpio.c should have
been checking for NULL, and it wasn't.

Also, fixes the pmf_unregister_irq_client() call to match the previous
patch.

Signed-off-by: Ben Collins <bcollins@ubuntu.com>

diff --git a/sound/ppc/snd-pmac-gpio.c b/sound/ppc/snd-pmac-gpio.c
index 25ef5e9..480e1ca 100644
--- a/sound/ppc/snd-pmac-gpio.c
+++ b/sound/ppc/snd-pmac-gpio.c
@@ -41,7 +41,7 @@ static struct pmf_function *get_audio_pf
 		return NULL;
 
 	pfunc = pmf_find_function(np, name);
-	if (pfunc == NULL && altname != NULL)
+	if (pfunc == NULL && altname)
 		pfunc = pmf_find_function(np, altname);
 
 	return pfunc;
@@ -58,10 +58,10 @@ static struct device_node *find_audio_gp
 	for (np = np->child; np; np = np->sibling) {
 		char *property = get_property(np, "audio-gpio", NULL);
 		if (property && (strcmp(property, name) == 0 ||
-		    strcmp(property, altname) == 0))
+		    (altname && strcmp(property, altname) == 0)))
 			break;
 		if (device_is_compatible(np, name) ||
-		    device_is_compatible(np, altname))
+		    (altname && device_is_compatible(np, altname)))
 			break;
         }
 
@@ -136,11 +136,7 @@ void snd_pmac_free_gpio(snd_pmac_gpio_t 
 {
 	if (gp->pfunc != NULL) {
 		if (gp->irq_client.owner == THIS_MODULE) {
-			/* XXX: pmf_unregister_irq_client doesn't use its
-			 * first two arguments. We only need to send it
-			 * the irq_client. WATCH FOR THIS CHANGING!
-			 */
-			pmf_unregister_irq_client(NULL, NULL, &gp->irq_client);
+			pmf_unregister_irq_client(&gp->irq_client);
 			gp->irq_client.owner = NULL;
 		}
 
@@ -233,7 +229,7 @@ int snd_pmac_request_irq(snd_pmac_gpio_t
 
 		if ((np = find_devices("i2s-a"))) {
 			ret = pmf_register_irq_client(np, gp->name, &gp->irq_client);
-			if (ret < 0)
+			if (ret < 0 && gp->altname)
 				ret = pmf_register_irq_client(np, gp->altname, &gp->irq_client);
 		}
 		if (ret < 0)


-- 
Ben Collins
Kernel Developer - Ubuntu Linux
