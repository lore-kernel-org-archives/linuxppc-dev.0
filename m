Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 1E468DE56E
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 04:28:53 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l2GHSpw7019024
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 10:28:51 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l2GHSoU2028089
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:28:50 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l2GH99Jh001404
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:09:09 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id AC5B4AEFC9
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:28:49 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l2GHSnsq029828
	for linuxppc-dev@ozlabs.org; Fri, 16 Mar 2007 12:28:49 -0500
Date: Fri, 16 Mar 2007 12:28:49 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 08/17] bootwrapper: Make setprop accept a const buffer.
Message-ID: <20070316172849.GH29784@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/ops.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index 1f1cda4..10c8787 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -92,7 +92,8 @@ static inline int getprop(void *devp, const char *name, void *buf, int buflen)
 	return (dt_ops.getprop) ? dt_ops.getprop(devp, name, buf, buflen) : -1;
 }
 
-static inline int setprop(void *devp, const char *name, void *buf, int buflen)
+static inline int setprop(void *devp, const char *name,
+                          const void *buf, int buflen)
 {
 	return (dt_ops.setprop) ? dt_ops.setprop(devp, name, buf, buflen) : -1;
 }
-- 
1.5.0.3
