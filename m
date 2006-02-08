Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E2125689AE
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Feb 2006 14:18:22 +1100 (EST)
To: torvalds@osdl.org
Subject: [PATCH 05/29] fix breakage in ocp.c
Message-Id: <E1F6fqT-0006Bi-0E@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 03:18:17 +0000
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Date: 1137627616 -0500

it's ocp_device_...., not ocp_driver_....

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/ppc/syslib/ocp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

83ec98be051b277635bc7379b863b25f6dbe54ce
diff --git a/arch/ppc/syslib/ocp.c b/arch/ppc/syslib/ocp.c
index ab34b1d..2fe28de 100644
--- a/arch/ppc/syslib/ocp.c
+++ b/arch/ppc/syslib/ocp.c
@@ -189,8 +189,8 @@ ocp_device_resume(struct device *dev)
 struct bus_type ocp_bus_type = {
 	.name = "ocp",
 	.match = ocp_device_match,
-	.probe = ocp_driver_probe,
-	.remove = ocp_driver_remove,
+	.probe = ocp_device_probe,
+	.remove = ocp_device_remove,
 	.suspend = ocp_device_suspend,
 	.resume = ocp_device_resume,
 };
-- 
0.99.9.GIT
