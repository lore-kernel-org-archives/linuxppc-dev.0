Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 5E0E567C6B
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Dec 2006 02:29:56 +1100 (EST)
Date: Thu, 7 Dec 2006 16:29:48 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] of_platform_make_bus_id(): kill compiler warning
Message-ID: <Pine.LNX.4.62.0612071627400.16653@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="-584337861-660284072-1164301560=:9383"
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-660284072-1164301560=:9383
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.62.0612071627402.16653@pademelon.sonytel.be>


of_platform_make_bus_id(): Kill a compiler warning which is a real bug on
PPC64: format ‘%d’ expects type ‘int’, but argument 5 has type ‘long int’

Signed-Off-By: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Index: ps3-linux-src/arch/powerpc/kernel/of_platform.c
===================================================================
--- ps3-linux-src.orig/arch/powerpc/kernel/of_platform.c	2006-12-05 11:16:13.000000000 +0100
+++ ps3-linux-src/arch/powerpc/kernel/of_platform.c	2006-12-07 16:24:26.000000000 +0100
@@ -212,7 +212,7 @@ static void of_platform_make_bus_id(stru
 	 * counter (and pray...)
 	 */
 	magic = atomic_add_return(1, &bus_no_reg_magic);
-	snprintf(name, BUS_ID_SIZE, "%s.%d", node->name, magic - 1);
+	snprintf(name, BUS_ID_SIZE, "%s.%ld", node->name, magic - 1);
 }
 
 struct of_device* of_platform_device_create(struct device_node *np,

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
---584337861-660284072-1164301560=:9383
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-ID: <Pine.LNX.4.62.0612071627403.16653@pademelon.sonytel.be>
Content-Description: 
Content-Disposition: INLINE

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
---584337861-660284072-1164301560=:9383--
