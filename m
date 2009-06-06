Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 82499B70AE
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  7 Jun 2009 02:39:53 +1000 (EST)
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id 07BC1DDD0B
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Jun 2009 02:39:52 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id j37so456704waf.9
	for <linuxppc-dev@ozlabs.org>; Sat, 06 Jun 2009 09:39:50 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] powerpc/install: Bail with error code on error in install
	script
To: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org
Date: Sat, 06 Jun 2009 10:39:46 -0600
Message-ID: <20090606163837.17482.56209.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

If anything goes wrong when copying images into the install path, then
the install script should exit with an error code so that 'make' knows
about it and tells the user.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/boot/install.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)


diff --git a/arch/powerpc/boot/install.sh b/arch/powerpc/boot/install.sh
index 51b2387..98312d1 100644
--- a/arch/powerpc/boot/install.sh
+++ b/arch/powerpc/boot/install.sh
@@ -18,6 +18,9 @@
 #   $5 and more - kernel boot files; zImage*, uImage, cuImage.*, etc.
 #
 
+# Bail with error code if anything goes wrong
+set -e
+
 # User may have a custom install script
 
 if [ -x ~/bin/${CROSS_COMPILE}installkernel ]; then exec ~/bin/${CROSS_COMPILE}installkernel "$@"; fi
