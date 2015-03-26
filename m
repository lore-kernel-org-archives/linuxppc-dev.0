Return-Path: <clg@fr.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BD9321A01AA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2015 03:04:57 +1100 (AEDT)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Thu, 26 Mar 2015 16:04:54 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: =?UTF-8?q?=5BPATCH=20v2=203/3=5D=20powerpc/powernv=3A=20remove=20opal=5Fsensor=5Fmutex?=
Date: Thu, 26 Mar 2015 17:04:47 +0100
Message-Id: <1427385887-25403-3-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1427385887-25403-1-git-send-email-clg@fr.ibm.com>
References: <5514027D.8010501@fr.ibm.com>
 <1427385887-25403-1-git-send-email-clg@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 skiboot@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The opal sensor mutex protects the opal_sensor_read call which
can return a OPAL_BUSY code on IBM Power systems if a previous 
request is in progress.

This can be handled at user level with a retry.

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---
 arch/powerpc/platforms/powernv/opal-sensor.c |    5 -----
 1 file changed, 5 deletions(-)

Index: linux.git/arch/powerpc/platforms/powernv/opal-sensor.c
===================================================================
--- linux.git.orig/arch/powerpc/platforms/powernv/opal-sensor.c
+++ linux.git/arch/powerpc/platforms/powernv/opal-sensor.c
@@ -24,9 +24,6 @@
 #include <asm/opal.h>
 #include <asm/machdep.h>
 
-static DEFINE_MUTEX(opal_sensor_mutex);
-
-
 /*
  * opal_sensor_read() return codes
  *
@@ -76,7 +73,6 @@ int opal_get_sensor_data(u32 sensor_hndl
 		goto out;
 	}
 
-	mutex_lock(&opal_sensor_mutex);
 	ret = opal_sensor_read(sensor_hndl, token, &data);
 	switch (ret) {
 	case OPAL_ASYNC_COMPLETION:
@@ -102,7 +98,6 @@ int opal_get_sensor_data(u32 sensor_hndl
 	}
 
 out_token:
-	mutex_unlock(&opal_sensor_mutex);
 	opal_async_release_token(token);
 out:
 	return ret;
