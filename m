Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 8C16ADDF7A
	for <linuxppc-dev@ozlabs.org>; Tue,  1 May 2007 01:58:29 +1000 (EST)
Date: Mon, 30 Apr 2007 17:58:23 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH 13/14] powerpc: add ps3 platform system bus support
Message-ID: <20070430155823.GA30344@aepfle.de>
References: <4563D02F.9010307@am.sony.com> <20070430104714.GA25815@aepfle.de>
	<4636100C.7020006@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4636100C.7020006@am.sony.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 30, Geoff Levand wrote:

> > The generated modalias files do not match anything.
>  
> Module support is still todo.  I am just now started on it.  David
> Woodhouse sent a few patches, but I just merged them in without
> testing.

This is my version, compile tested.

ps3fb calls into ps3av.
ps3av can be a module, but it does not force ps3fb to be a module as
well. Maybe this can be enforced via some Kconfig tweaks.

---
 arch/powerpc/platforms/ps3/system-bus.c |   30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -167,6 +167,30 @@ static int ps3_system_bus_remove(struct 
 	return 0;
 }
 
+static const char *ps3_system_bus_modalias(enum ps3_match_id match_id)
+{
+	const char *p;
+	switch (match_id) {
+		case PS3_MATCH_ID_EHCI:
+			p = "ps3-ehci";
+			break;
+		case PS3_MATCH_ID_OHCI:
+			p = "ps3-ohci";
+			break;
+		case PS3_MATCH_ID_GELIC:
+			p = "gelic_net";
+			break;
+		case PS3_MATCH_ID_AV_SETTINGS:
+			p = "ps3av";
+			break;
+		case PS3_MATCH_ID_SYSTEM_MANAGER:
+		default:
+			p = "unknown";
+			break;
+	}
+	return p;
+}
+
 static int ps3_system_bus_uevent(struct device *_dev, char **envp,
 				 int num_envp, char *buffer, int buffer_size)
 {
@@ -174,8 +198,8 @@ static int ps3_system_bus_uevent(struct 
 	int i=0, length = 0;
 
 	if (add_uevent_var(envp, num_envp, &i, buffer, buffer_size,
-			   &length, "MODALIAS=ps3:%d",
-			   dev->match_id))
+			   &length, "MODALIAS=%s",
+			   ps3_system_bus_modalias(dev->match_id)))
 		return -ENOMEM;
 
 	envp[i] = NULL;
@@ -186,7 +210,7 @@ static ssize_t modalias_show(struct devi
 			     char *buf)
 {
 	struct ps3_system_bus_device *dev = to_ps3_system_bus_device(_dev);
-        int len = snprintf(buf, PAGE_SIZE, "ps3:%d\n", dev->match_id);
+        int len = snprintf(buf, PAGE_SIZE, "%s\n", ps3_system_bus_modalias(dev->match_id));
 
         return (len >= PAGE_SIZE) ? (PAGE_SIZE - 1) : len;
 }
