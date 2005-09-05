Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B9E0768106
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Sep 2005 02:37:49 +1000 (EST)
Date: Mon, 5 Sep 2005 09:37:46 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <20050905163746.GB6341@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc32: fix ocp_device_suspend to use pm_message_t instead
	of u32
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Recent "u32 -> pm_message_t" change triggered hidden bug in 
ocp_device_suspend. Fix it to correctly use pm_message_t instead of 
u32.

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>

diff --git a/arch/ppc/syslib/ocp.c b/arch/ppc/syslib/ocp.c
--- a/arch/ppc/syslib/ocp.c
+++ b/arch/ppc/syslib/ocp.c
@@ -165,7 +165,7 @@ ocp_device_remove(struct device *dev)
 }
 
 static int
-ocp_device_suspend(struct device *dev, u32 state)
+ocp_device_suspend(struct device *dev, pm_message_t state)
 {
 	struct ocp_device *ocp_dev = to_ocp_dev(dev);
 	struct ocp_driver *ocp_drv = to_ocp_drv(dev->driver);
