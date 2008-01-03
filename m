Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 2DC41DDE3C
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 15:15:37 +1100 (EST)
Date: Thu, 3 Jan 2008 15:15:28 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] therm_windtunnel: eliminate some build warnings
Message-Id: <20080103151528.7fa72813.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, samuel@ibrium.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We don't care if the device_create_file calls fail, the driver will work
just as well without them, so just issue a runtime warning.

drivers/macintosh/therm_windtunnel.c: In function 'setup_hardware':
drivers/macintosh/therm_windtunnel.c:268: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result
drivers/macintosh/therm_windtunnel.c:269: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/macintosh/therm_windtunnel.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/macintosh/therm_windtunnel.c b/drivers/macintosh/therm_windtunnel.c
index 3722402..63ef1f6 100644
--- a/drivers/macintosh/therm_windtunnel.c
+++ b/drivers/macintosh/therm_windtunnel.c
@@ -223,6 +223,7 @@ static void
 setup_hardware( void )
 {
 	int val;
+	int err;
 
 	/* save registers (if we unload the module) */
 	x.r0 = read_reg( x.fan, 0x00, 1 );
@@ -265,8 +266,11 @@ setup_hardware( void )
 	x.upind = -1;
 	/* tune_fan( fan_up_table[x.upind].fan_setting ); */
 
-	device_create_file( &x.of_dev->dev, &dev_attr_cpu_temperature );
-	device_create_file( &x.of_dev->dev, &dev_attr_case_temperature );
+	err = device_create_file( &x.of_dev->dev, &dev_attr_cpu_temperature );
+	err |= device_create_file( &x.of_dev->dev, &dev_attr_case_temperature );
+	if (err)
+		printk(KERN_WARNING
+			"Failed to create temperature attribute file(s).\n");
 }
 
 static void
-- 
1.5.3.7

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
