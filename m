Return-Path: <haren@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B9DA8140101
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Apr 2014 20:00:06 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Sat, 12 Apr 2014 04:00:04 -0600
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id DFB006E803C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Apr 2014 05:59:53 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22035.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3CA00hc2228484
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Apr 2014 10:00:00 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3C9xxcM000497
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Apr 2014 05:59:59 -0400
Subject: Change MINSIGSTKSZ and SIGSTKSIZE
From: Haren Myneni <haren@linux.vnet.ibm.com>
To: amodra@gmail.com, benh@kernel.crashing.org
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 12 Apr 2014 02:59:55 -0700
Message-ID: <1397296795.11946.42.camel@hbabu-laptop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alan, 
	LTP test (signalstack02) is failing. This test expects -ENOMEM from
kernel when passing less than stack size (passing 4095). MINSIGSTKSZ in
signal.h (glibc) is changed to 4096 to support VSX changes
(https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=f7c399cff5bd04ee9dc117fb6b0f39597dc047c6)  We should also change these values in kernel to match with glibc. Any issues? 

diff --git a/arch/powerpc/include/uapi/asm/signal.h
b/arch/powerpc/include/uapi/
index 6c69ee9..18f498e 100644
--- a/arch/powerpc/include/uapi/asm/signal.h
+++ b/arch/powerpc/include/uapi/asm/signal.h
@@ -85,8 +85,8 @@ typedef struct {
 
 #define SA_RESTORER    0x04000000U
 
-#define MINSIGSTKSZ    2048
-#define SIGSTKSZ       8192
+#define MINSIGSTKSZ    4096
+#define SIGSTKSZ       16384

Thanks
Haren
