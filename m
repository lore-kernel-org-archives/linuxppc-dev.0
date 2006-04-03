Return-Path: <vbordug@ru.mvista.com>
Received: from vitb.dev.rtsoft.ru (unknown [85.21.88.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 69D9E679F8
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  3 Apr 2006 21:26:39 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH] ppc32: Fix string comparing in platform_notify_map
Date: Mon, 03 Apr 2006 15:26:32 +0400
Message-Id: <20060403112632.17790.24809.stgit@vitb.ru.mvista.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Fixed odd function behavior when dev->bus_id does not contain '.' - it
compared that case 0 characters of the string and hereby reported success and
executed callback. Now bus_id's are compared correctly, extra callback
triggering eliminated.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 arch/ppc/syslib/ppc_sys.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/ppc/syslib/ppc_sys.c b/arch/ppc/syslib/ppc_sys.c
index 60c724e..7662c4e 100644
--- a/arch/ppc/syslib/ppc_sys.c
+++ b/arch/ppc/syslib/ppc_sys.c
@@ -156,12 +156,13 @@ void platform_notify_map(const struct pl
 	while (map->bus_id != NULL) {
 		idx = -1;
 		s = strrchr(dev->bus_id, '.');
-		if (s != NULL)
+		if (s != NULL) {
 			idx = (int)simple_strtol(s + 1, NULL, 10);
-		else
+			len = s - dev->bus_id;
+		} else {
 			s = dev->bus_id;
-
-		len = s - dev->bus_id;
+			len = strlen(dev->bus_id);
+		}
 
 		if (!strncmp(dev->bus_id, map->bus_id, len)) {
 			pdev = container_of(dev, struct platform_device, dev);
