Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 4D676DDED5
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 11:22:18 +1000 (EST)
Date: Thu, 17 May 2007 11:22:15 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] [POWERPC] remove build warnings in windfarm_core
Message-Id: <20070517112215.6261992d.sfr@canb.auug.org.au>
In-Reply-To: <20070516112449.9f0ae1a2.sfr@canb.auug.org.au>
References: <20070514163219.9d78cde0.sfr@canb.auug.org.au>
	<17993.20745.432703.238649@cargo.ozlabs.ibm.com>
	<20070516112449.9f0ae1a2.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Segher, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

drivers/macintosh/windfarm_core.c: In function 'wf_register_control':
drivers/macintosh/windfarm_core.c:219: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result
drivers/macintosh/windfarm_core.c: In function 'wf_register_sensor':
drivers/macintosh/windfarm_core.c:329: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/macintosh/windfarm_core.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

White space and spelling fixes over last version.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/macintosh/windfarm_core.c b/drivers/macintosh/windfarm_core.c
index 192b26e..11ced17 100644
--- a/drivers/macintosh/windfarm_core.c
+++ b/drivers/macintosh/windfarm_core.c
@@ -216,7 +216,10 @@ int wf_register_control(struct wf_control *new_ct)
 	new_ct->attr.attr.mode = 0644;
 	new_ct->attr.show = wf_show_control;
 	new_ct->attr.store = wf_store_control;
-	device_create_file(&wf_platform_device.dev, &new_ct->attr);
+	if (device_create_file(&wf_platform_device.dev, &new_ct->attr))
+		printk(KERN_WARNING "windfarm: device_create_file failed"
+			" for %s\n", new_ct->name);
+		/* the subsystem still does useful work without the file */
 
 	DBG("wf: Registered control %s\n", new_ct->name);
 
@@ -326,7 +329,10 @@ int wf_register_sensor(struct wf_sensor *new_sr)
 	new_sr->attr.attr.mode = 0444;
 	new_sr->attr.show = wf_show_sensor;
 	new_sr->attr.store = NULL;
-	device_create_file(&wf_platform_device.dev, &new_sr->attr);
+	if (device_create_file(&wf_platform_device.dev, &new_sr->attr))
+		printk(KERN_WARNING "windfarm: device_create_file failed"
+			" for %s\n", new_sr->name);
+		/* the subsystem still does useful work without the file */
 
 	DBG("wf: Registered sensor %s\n", new_sr->name);
 
-- 
1.5.1.4
