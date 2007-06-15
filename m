Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound3-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 958CFDE6AC
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 08:23:16 +1000 (EST)
Message-ID: <46730AC2.2030002@am.sony.com>
Date: Fri, 15 Jun 2007 14:55:14 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 12/33] PS3: System-bus uevent
References: <20070615204749.629571012@am.sony.com>>
In-Reply-To: <20070615204749.629571012@am.sony.com>>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: David Woodhouse <dwmw2@infradead.org>

To allow userspace to automatically load modules, we need to hook up
uevent for ps3_system_bus devices. I've used the form 'ps3:%d' with the
ps3_match_id, since that's what we use for matching drivers.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
  o Fixed WS.

 arch/powerpc/platforms/ps3/system-bus.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -437,9 +437,25 @@ static void ps3_system_bus_shutdown(stru
 	dev_dbg(&dev->core, " <- %s:%d\n", __func__, __LINE__);
 }
 
+static int ps3_system_bus_uevent(struct device *_dev, char **envp,
+				 int num_envp, char *buffer, int buffer_size)
+{
+	struct ps3_system_bus_device *dev = ps3_dev_to_system_bus_dev(_dev);
+	int i = 0, length = 0;
+
+	if (add_uevent_var(envp, num_envp, &i, buffer, buffer_size,
+			   &length, "MODALIAS=ps3:%d",
+			   dev->match_id))
+		return -ENOMEM;
+
+	envp[i] = NULL;
+	return 0;
+}
+
 struct bus_type ps3_system_bus_type = {
 	.name = "ps3_system_bus",
 	.match = ps3_system_bus_match,
+	.uevent = ps3_system_bus_uevent,
 	.probe = ps3_system_bus_probe,
 	.remove = ps3_system_bus_remove,
 	.shutdown = ps3_system_bus_shutdown,

-- 
