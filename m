Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 4C01B67C17
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 14:47:52 +1100 (EST)
Date: Fri, 17 Nov 2006 04:47:48 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] setup_kcore(): Fix incorrect function name in panic() call.
Message-ID: <Pine.LNX.4.62.0611170446250.16998@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


setup_kcore(): Fix incorrect function name in panic() call.

Signed-Off-By: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

--- linux-ps3-geert.orig/arch/powerpc/mm/init_64.c	2006-11-15 10:05:17.000000000 +0900
+++ linux-ps3-geert/arch/powerpc/mm/init_64.c	2006-11-17 12:36:49.000000000 +0900
@@ -130,7 +130,7 @@ static int __init setup_kcore(void)
 		/* GFP_ATOMIC to avoid might_sleep warnings during boot */
 		kcore_mem = kmalloc(sizeof(struct kcore_list), GFP_ATOMIC);
 		if (!kcore_mem)
-			panic("mem_init: kmalloc failed\n");
+			panic("setup_kcore: kmalloc failed\n");
 
 		kclist_add(kcore_mem, __va(base), size);
 	}

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
