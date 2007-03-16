Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 9AB53DE764
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 04:29:11 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l2GHT802019109
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 10:29:09 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l2GHT8jF009999
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:29:08 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l2GH9QmW001446
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:09:27 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 64C1CAEFC9
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:29:07 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l2GHT7G2029845
	for linuxppc-dev@ozlabs.org; Fri, 16 Mar 2007 12:29:07 -0500
Date: Fri, 16 Mar 2007 12:29:07 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 12/17] bootwrapper: Make set_cmdline() create /chosen if it
	doesn't exist.
Message-ID: <20070316172907.GL29784@ld0162-tx32.am.freescale.net>
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
 arch/powerpc/boot/main.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/main.c b/arch/powerpc/boot/main.c
index 506d7db..d0c588c 100644
--- a/arch/powerpc/boot/main.c
+++ b/arch/powerpc/boot/main.c
@@ -245,9 +245,11 @@ static void get_cmdline(char *buf, int size)
 
 void set_cmdline(const char *buf)
 {
-	void *devp;
+	void *devp = finddevice("/chosen");
 
-	if ((devp = finddevice("/chosen")))
+	if (!devp)
+		devp = create_node(NULL, "/chosen");
+	if (devp)
 		setprop(devp, "bootargs", buf, strlen(buf) + 1);
 }
 
-- 
1.5.0.3
