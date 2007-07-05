Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 4E308DDF4C
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 03:03:50 +1000 (EST)
Message-Id: <20070705170240.803460000@lixom.net>
References: <20070705170233.258351000@lixom.net>
Date: Thu, 05 Jul 2007 12:03:00 -0500
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [patch 27/35] Work around errata 4290
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Workaround for errata 4290: The decrementer ticks at half the expected rate
so load it with half the value it would otherwise be loaded with.


Index: 2.6.21/include/asm-powerpc/time.h
===================================================================
--- 2.6.21.orig/include/asm-powerpc/time.h
+++ 2.6.21/include/asm-powerpc/time.h
@@ -173,6 +173,13 @@ static inline unsigned int get_dec(void)
 
 static inline void set_dec(int val)
 {
+#ifdef CONFIG_PPC_PASEMI
+	/* PA6T rev Ax have decrementer ticking at 1/2 tb rate */
+	val >>= 2;
+	if (!val)
+		val = 1;
+#endif
+
 #if defined(CONFIG_40x)
 	return;		/* Have to let it auto-reload */
 #elif defined(CONFIG_8xx_CPU6)

--
