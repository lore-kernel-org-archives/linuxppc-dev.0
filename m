Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 426DDDE07E
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 01:27:37 +1000 (EST)
Date: Tue, 6 May 2008 11:27:35 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [RESEND][PATCH 1/2][POWERPC] PIKA Warp: Update platform code
	tosupportRev B boards
Message-ID: <20080506112735.7c2c720e@lappy.seanm.ca>
In-Reply-To: <20080428232855.22c13830@lappy.seanm.ca>
References: <20080417152251.2bf07219@lappy.seanm.ca>
	<20080428214711.240419c3@lappy.seanm.ca>
	<20080428232855.22c13830@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Opps, there is a bug in this patch. The file pika.h is not included. I
have attached it below, but a simpler solution might be to just delete
it from this file. It is not required to build the kernel.

The file currently contains the exported dtm functions. These functions
are only used by the telephony driver, which is not in the mainline
kernel.

Cheers,
   Sean

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>

diff --git a/include/linux/pika.h b/include/linux/pika.h
new file mode 100644
index 0000000..83d51df
--- /dev/null
+++ b/include/linux/pika.h
@@ -0,0 +1,18 @@
+/*
+ * PIKA exported functions
+ *
+ * Copyright (c) 2008 PIKA Technologies
+ *   Sean MacLennan <smaclennan@pikatech.com>
+ */
+
+#ifndef _LINUX_PIKA_H
+#define _LINUX_PIKA_H
+
+#ifdef __KERNEL__
+
+int pika_dtm_register_shutdown(void (*func)(void *arg), void *arg);
+int pika_dtm_unregister_shutdown(void (*func)(void *arg), void *arg);
+
+#endif
+
+#endif
