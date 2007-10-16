Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 9FB7CDDEC9
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 07:32:40 +1000 (EST)
Received: from pd2mr1so.prod.shaw.ca
	(pd2mr1so-qfe3.prod.shaw.ca [10.0.141.110]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JQ00035VX3PJLD0@l-daemon> for linuxppc-dev@ozlabs.org;
	Tue, 16 Oct 2007 15:31:01 -0600 (MDT)
Received: from pn2ml4so.prod.shaw.ca ([10.0.121.148])
	by pd2mr1so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JQ000GGZX3PHX30@pd2mr1so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Tue, 16 Oct 2007 15:31:01 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JQ000BASX3OPCS1@l-daemon> for linuxppc-dev@ozlabs.org;
	Tue, 16 Oct 2007 15:31:01 -0600 (MDT)
Date: Tue, 16 Oct 2007 15:31:01 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 1/2] bootwrapper: Allow wrapper script to execute verbosely
To: linuxppc-dev@ozlabs.org, paulus@samba.org,
	David Gibson <david@gibson.dropbear.id.au>,
	Scott Wood <scottwood@freescale.com>
Message-id: <20071016213101.14117.43657.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Allow wrapper script to print verbose progress when the V is set in the
environment.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/boot/wrapper |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 39b27e5..8323ea4 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -21,6 +21,11 @@
 #		(default ./arch/powerpc/boot)
 # -W dir	specify working directory for temporary files (default .)
 
+# Allow for verbose output
+if [ "$V" == "1" ]; then
+    set -x
+fi
+
 # defaults
 kernel=
 ofile=zImage
