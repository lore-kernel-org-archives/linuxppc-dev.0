Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id A2C1ADDEC6
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 14:27:28 +1000 (EST)
Received: from pd4mr2so.prod.shaw.ca
	(pd4mr2so-qfe3.prod.shaw.ca [10.0.141.213]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JQC00LMNKDRJ770@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 22 Oct 2007 22:27:27 -0600 (MDT)
Received: from pn2ml9so.prod.shaw.ca ([10.0.121.7])
	by pd4mr2so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JQC00CNNKDR9330@pd4mr2so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Mon, 22 Oct 2007 22:27:27 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JQC0072OKDQIIE0@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 22 Oct 2007 22:27:27 -0600 (MDT)
Date: Mon, 22 Oct 2007 22:27:31 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 1/4] bootwrapper: Allow wrapper script to execute verbosely
In-reply-to: <20071023042353.30309.93118.stgit@trillian.cg.shawcable.net>
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Message-id: <20071023042731.30309.4940.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20071023042353.30309.93118.stgit@trillian.cg.shawcable.net>
Cc: David Gibson <david@gibson.dropbear.id.au>
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
Acked-by: David Gibson <david@gibson.dropbear.id.au>
---

 arch/powerpc/boot/wrapper |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 39b27e5..347639c 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -21,6 +21,11 @@
 #		(default ./arch/powerpc/boot)
 # -W dir	specify working directory for temporary files (default .)
 
+# Allow for verbose output
+if [ "$V" = 1 ]; then
+    set -x
+fi
+
 # defaults
 kernel=
 ofile=zImage
