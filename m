Return-Path: <clg@fr.ibm.com>
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DADAE1A0A09
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 21:06:54 +1100 (AEDT)
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Mon, 30 Mar 2015 11:06:50 +0100
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 1/2] powerpc/powernv: convert codes returned by OPAL calls
Date: Mon, 30 Mar 2015 12:06:09 +0200
Message-Id: <1427709970-10207-1-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1427698456.28219.2.camel@ellerman.id.au>
References: <1427698456.28219.2.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, benh@au1.ibm.com,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

OPAL has its own list of return codes. The patch provides a translation
of such codes in errnos for the opal_sensor_read call, and possibly 
others if needed.

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---

 Changes since v3 :

 - reworked the return codes a little as suggested by Michael Ellerman

 Changes since v2 :

 - renamed and moved the routine to opal.[ch]
 - changed default value to ERANGE like rtas

 arch/powerpc/include/asm/opal.h              |    2 ++
 arch/powerpc/platforms/powernv/opal-sensor.c |    6 ++++--
 arch/powerpc/platforms/powernv/opal.c        |   19 +++++++++++++++++++
 3 files changed, 25 insertions(+), 2 deletions(-)

Index: linux.git/arch/powerpc/platforms/powernv/opal-sensor.c
===================================================================
--- linux.git.orig/arch/powerpc/platforms/powernv/opal-sensor.c
+++ linux.git/arch/powerpc/platforms/powernv/opal-sensor.c
@@ -46,8 +46,10 @@ int opal_get_sensor_data(u32 sensor_hndl
 
 	mutex_lock(&opal_sensor_mutex);
 	ret = opal_sensor_read(sensor_hndl, token, &data);
-	if (ret != OPAL_ASYNC_COMPLETION)
+	if (ret != OPAL_ASYNC_COMPLETION) {
+		ret = opal_error_code(ret);
 		goto out_token;
+	}
 
 	ret = opal_async_wait_response(token, &msg);
 	if (ret) {
@@ -57,7 +59,7 @@ int opal_get_sensor_data(u32 sensor_hndl
 	}
 
 	*sensor_data = be32_to_cpu(data);
-	ret = be64_to_cpu(msg.params[1]);
+	ret = opal_error_code(be64_to_cpu(msg.params[1]));
 
 out_token:
 	mutex_unlock(&opal_sensor_mutex);
Index: linux.git/arch/powerpc/include/asm/opal.h
===================================================================
--- linux.git.orig/arch/powerpc/include/asm/opal.h
+++ linux.git/arch/powerpc/include/asm/opal.h
@@ -983,6 +983,8 @@ struct opal_sg_list *opal_vmalloc_to_sg_
 					     unsigned long vmalloc_size);
 void opal_free_sg_list(struct opal_sg_list *sg);
 
+extern int opal_error_code(int rc);
+
 /*
  * Dump region ID range usable by the OS
  */
Index: linux.git/arch/powerpc/platforms/powernv/opal.c
===================================================================
--- linux.git.orig/arch/powerpc/platforms/powernv/opal.c
+++ linux.git/arch/powerpc/platforms/powernv/opal.c
@@ -894,6 +894,25 @@ void opal_free_sg_list(struct opal_sg_li
 	}
 }
 
+int opal_error_code(int rc)
+{
+	switch (rc) {
+	case OPAL_SUCCESS:		return 0;
+
+	case OPAL_PARAMETER:		return -EINVAL;
+	case OPAL_ASYNC_COMPLETION:	return -EINPROGRESS;
+	case OPAL_BUSY_EVENT:		return -EBUSY;
+	case OPAL_NO_MEM:		return -ENOMEM;
+
+	case OPAL_UNSUPPORTED:		return -EIO;
+	case OPAL_HARDWARE:		return -EIO;
+	case OPAL_INTERNAL_ERROR:	return -EIO;
+	default:
+		pr_err("%s: unexpected OPAL error %d\n", __func__, rc);
+		return -EIO;
+	}
+}
+
 EXPORT_SYMBOL_GPL(opal_poll_events);
 EXPORT_SYMBOL_GPL(opal_rtc_read);
 EXPORT_SYMBOL_GPL(opal_rtc_write);
