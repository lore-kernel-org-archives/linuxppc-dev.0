Return-Path: <sfalco@harris.com>
Received: from mlbe2k1.cs.myharris.net (mlbe2k1.cs.myharris.net
	[137.237.90.88]) by ozlabs.org (Postfix) with ESMTP id 5D386DDE98
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 23:36:16 +1000 (EST)
Message-ID: <49F06ECC.7030904@harris.com>
Date: Thu, 23 Apr 2009 09:36:12 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: [PATCH] PPC440EPx SDRAM width
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There is an error in the way ibm4xx_denali_fixup_memsize calculates
memory size.  When testing the DDR_REDUC bit, the polarity is
backwards.  A "1" implies 32-bit wide memory while a "0" implies
64-bit wide memory.

For a 32-bit wide system, this bug causes twice the memory to be
reported, leading to boot failure.

Signed-off-by: Steven A. Falco <sfalco@harris.com>
---

Here is a partial log showing what happens in the
ibm4xx_denali_fixup_memsize routine.  This board has
128 Mbytes of RAM in a 32-bit wide configuration, but
the REDUC bug causes the path width to report as "8",
and the memory size to be doubled to 255 MB.  Once I
applied my patch, the memory correctly reported as
127 MB.

max_cs=00000002 max_col=0000000c max_row=0000000e
cs 00000001
path width 00000008
row=0000000d col=0000000a bank=00000004
ibm4xx_denali_fixup_memsize 10000000
Memory <- <0x0 0x0 0xffff000> (255MB)

diff --git a/arch/powerpc/boot/4xx.c b/arch/powerpc/boot/4xx.c
index 5c87843..3595c0a 100644
--- a/arch/powerpc/boot/4xx.c
+++ b/arch/powerpc/boot/4xx.c
@@ -193,9 +193,9 @@ void ibm4xx_denali_fixup_memsize(void)
        val = SDRAM0_READ(DDR0_14);

        if (DDR_GET_VAL(val, DDR_REDUC, DDR_REDUC_SHIFT))
-               dpath = 8; /* 64 bits */
-       else
                dpath = 4; /* 32 bits */
+       else
+               dpath = 8; /* 64 bits */

        /* get address pins (rows) */
        val = SDRAM0_READ(DDR0_42);
