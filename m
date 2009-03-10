Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [93.92.193.118])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 438B9DE055
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 07:52:12 +1100 (EST)
Date: Tue, 10 Mar 2009 22:50:13 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] PowerPC 440EPx/GRx fix memory size calculation
Message-ID: <20090310195013.GA27835@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49B58779.9040905@lebon.org.ua>
Cc: lebon@lebon.org.ua
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I was just going to submit a patch for that too.
Indeed, the denali_fixup_memsize() miscalculated a couple of address
field widths. We were lucky to eventually get the right result,
because the effect of the first error was killed by the other one.
According to the AMCC 440EPX/GRX user manual,
the Chip Select width is always fixed at 1 bit no matter
what is actually read from register DDR_10.
The workaround is to use a predefined chipselect value for 440EPx/GRx.
Also, setting the REDUC bit (REDUC = 1) enables 32-bit data path.
If REDUC = 0, full data path of 64 bits is used.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
Signed-off-by: Mikhail Zolotaryov <lebon@lebon.org.ua>


--- a/arch/powerpc/boot/4xx.c	2008-04-26 02:18:34.000000000 +0400
+++ b/arch/powerpc/boot/4xx.c	2008-10-26 01:40:27.000000000 +0400
@@ -173,15 +173,20 @@ void ibm4xx_denali_fixup_memsize(void)
 	max_col = DDR_GET_VAL(val, DDR_MAX_COL_REG, DDR_MAX_COL_REG_SHIFT);
 	max_row = DDR_GET_VAL(val, DDR_MAX_ROW_REG, DDR_MAX_ROW_REG_SHIFT);
 
-	/* get CS value */
-	val = SDRAM0_READ(DDR0_10);
-
-	val = DDR_GET_VAL(val, DDR_CS_MAP, DDR_CS_MAP_SHIFT);
-	cs = 0;
-	while (val) {
-		if (val & 0x1)
-			cs++;
-		val = val >> 1;
+	/* 440EPx/GRx chipselect always fixed at 1 bit */
+	if ((mfpvr() & 0xf0000ff0) == 0x200008D0)
+		cs = 1;
+	else {
+		/* get CS value */
+		val = SDRAM0_READ(DDR0_10);
+		val = DDR_GET_VAL(val, DDR_CS_MAP, DDR_CS_MAP_SHIFT);
+
+		cs = 0;
+		while (val) {
+			if (val & 0x1)
+				cs++;
+			val = val >> 1;
+		}
 	}
 
 	if (!cs)
@@ -192,7 +197,7 @@ void ibm4xx_denali_fixup_memsize(void)
 	/* get data path bytes */
 	val = SDRAM0_READ(DDR0_14);
 
-	if (DDR_GET_VAL(val, DDR_REDUC, DDR_REDUC_SHIFT))
+	if (!DDR_GET_VAL(val, DDR_REDUC, DDR_REDUC_SHIFT))
 		dpath = 8; /* 64 bits */
 	else
 		dpath = 4; /* 32 bits */
