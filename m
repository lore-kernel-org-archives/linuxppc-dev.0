Return-Path: <xerofoiify@gmail.com>
Received: from mail-yk0-x243.google.com (mail-yk0-x243.google.com
 [IPv6:2607:f8b0:4002:c07::243])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 184221A087B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 13:46:32 +1000 (EST)
Received: by mail-yk0-f195.google.com with SMTP id 79so596367ykr.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Aug 2014 20:46:30 -0700 (PDT)
From: Nick Krause <xerofoiify@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC...),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] powerpc: Fix warnings about right shift count
Date: Thu,  7 Aug 2014 05:46:38 +0200
Message-Id: <1407383199-7919-1-git-send-email-xerofoiify@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix warnings like the following using upper_32_bits(), discussed after mail with
someone on kernelnewbies

arch/powerpc/boot/addnote.c:183:3: warning: right shift count >= width of type
arch/powerpc/boot/addnote.c:188:3: warning: right shift count >= width of type
arch/powerpc/boot/addnote.c:206:3: warning: right shift count >= width of type
arch/powerpc/boot/addnote.c:211:3: warning: right shift count >= width of type

Signed-off-by: Nick Krause <xerofoify@gmail.com>
---
 arch/powerpc/boot/addnote.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/addnote.c b/arch/powerpc/boot/addnote.c
index 9d9f6f3..4611c12 100644
--- a/arch/powerpc/boot/addnote.c
+++ b/arch/powerpc/boot/addnote.c
@@ -72,7 +72,7 @@ static int e_class = ELFCLASS32;
 #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
 			 buf[(off) + 1] = (v) & 0xff)
 #define PUT_32BE(off, v)(PUT_16BE((off), (v) >> 16L), PUT_16BE((off) + 2, (v)))
-#define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
+#define PUT_64BE(off, v)((PUT_32BE((off), upper_32_bits(v)), \
 			  PUT_32BE((off) + 4, (v))))
 
 #define GET_16LE(off)	((buf[off]) + (buf[(off)+1] << 8))
@@ -82,7 +82,8 @@ static int e_class = ELFCLASS32;
 #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
 			  buf[(off) + 1] = ((v) >> 8) & 0xff)
 #define PUT_32LE(off, v) (PUT_16LE((off), (v)), PUT_16LE((off) + 2, (v) >> 16L))
-#define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
+#define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, \
+						upper_32_bits(v)))
 
 #define GET_16(off)	(e_data == ELFDATA2MSB ? GET_16BE(off) : GET_16LE(off))
 #define GET_32(off)	(e_data == ELFDATA2MSB ? GET_32BE(off) : GET_32LE(off))
-- 
2.0.1
