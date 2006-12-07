Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 2214667D36
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Dec 2006 02:49:20 +1100 (EST)
Date: Thu, 7 Dec 2006 16:49:18 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] of_platform_make_bus_id(): make `magic` int
In-Reply-To: <F5EB4110-C3A8-4C7F-98AE-9096A12482B6@kernel.crashing.org>
Message-ID: <Pine.LNX.4.62.0612071648040.27097@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0612071627400.16653@pademelon.sonytel.be>
	<F5EB4110-C3A8-4C7F-98AE-9096A12482B6@kernel.crashing.org>
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


of_platform_make_bus_id(): Kill a compiler warning which is a real
bug on PPC64 by changing `magic' to `int'.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

--- ps3-linux-src.orig/arch/powerpc/kernel/of_platform.c	2006-12-05 11:16:13.000000000 +0100
+++ ps3-linux-src/arch/powerpc/kernel/of_platform.c	2006-12-07 16:47:21.000000000 +0100
@@ -169,7 +169,7 @@ static void of_platform_make_bus_id(stru
 	char *name = dev->dev.bus_id;
 	const u32 *reg;
 	u64 addr;
-	long magic;
+	int magic;
 
 	/*
 	 * If it's a DCR based device, use 'd' for native DCRs

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
