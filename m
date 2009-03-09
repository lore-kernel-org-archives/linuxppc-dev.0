Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.230])
	by ozlabs.org (Postfix) with ESMTP id A6132DE034
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 02:23:14 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id l9so1546033rvb.9
	for <linuxppc-dev@ozlabs.org>; Mon, 09 Mar 2009 08:23:13 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] powerpc/bootwrapper: add fixed-head.o to simpleimage wrappers
To: linuxppc-dev@ozlabs.org
Date: Mon, 09 Mar 2009 09:23:09 -0600
Message-ID: <20090309152047.25290.29963.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: eddie@embeddedarm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

fixed-head.o must be linked into the bootwrapper for raw-binary images to
work.  This patch adds it into the bootwrapper.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Reported-by: Eddie Dawydiuk <eddie@embeddedarm.com>
---

I pulled this chunk out of Eddie's bigger patch and also modified the other
case where it applies.  This is a definite bug on the simpleimage generation.
Once I get an ack, I'll add it to my -next tree and ask Ben to pull.

Cheers,
g.

 arch/powerpc/boot/wrapper |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 965c237..c5bd9cf 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -211,11 +211,11 @@ simpleboot-virtex405-*)
     binary=y
     ;;
 simpleboot-virtex440-*)
-    platformo="$object/simpleboot.o $object/virtex.o"
+    platformo="$object/fixed-head.o $object/simpleboot.o $object/virtex.o"
     binary=y
     ;;
 simpleboot-*)
-    platformo="$object/simpleboot.o"
+    platformo="$object/fixed-head.o $object/simpleboot.o"
     binary=y
     ;;
 asp834x-redboot)
