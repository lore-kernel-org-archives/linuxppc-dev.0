Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E86E2DDF14
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 03:42:38 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lBJGgWU3020661
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 11:42:32 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lBJGgQEH103004
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 09:42:28 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lBJGgQS0012202
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 09:42:26 -0700
Received: from zod.rchland.ibm.com (wecm-9-67-132-88.wecm.ibm.com
	[9.67.132.88])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	lBJGgPj1012147
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 09:42:25 -0700
Date: Wed, 19 Dec 2007 10:37:07 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC] [PATCH 3/3] Remove mkuboot.sh script
Message-ID: <20071219103707.01f06727@zod.rchland.ibm.com>
In-Reply-To: <20071219103351.6c4468f4@zod.rchland.ibm.com>
References: <20071219103351.6c4468f4@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that the mkimage tool is merged into the kernel, we can remove the unused
mkuboot.sh script.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 scripts/mkuboot.sh |   19 -------------------
 1 file changed, 19 deletions(-)

--- linux-2.6.orig/scripts/mkuboot.sh
+++ /dev/null
@@ -1,19 +0,0 @@
-#!/bin/bash
-
-#
-# Build U-Boot image when `mkimage' tool is available.
-#
-
-MKIMAGE=$(type -path "${CROSS_COMPILE}mkimage")
-
-if [ -z "${MKIMAGE}" ]; then
-	MKIMAGE=$(type -path mkimage)
-	if [ -z "${MKIMAGE}" ]; then
-		# Doesn't exist
-		echo '"mkimage" command not found - U-Boot images will not be built' >&2
-		exit 0;
-	fi
-fi
-
-# Call "mkimage" to create U-Boot image
-${MKIMAGE} "$@"
