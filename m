Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 08E1F1A0452
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Oct 2014 16:19:20 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4F75A14007F
 for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2014 16:19:18 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id s9U5JDGX017486
 for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2014 00:19:15 -0500
Message-ID: <1414646353.25695.12.camel@pasglop>
Subject: [PATCH] powerpc/powernv: Properly fix LPC debugfs endianness
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Date: Thu, 30 Oct 2014 16:19:13 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Endian is hard, especially when I designed a stupid FW interface, and
I should know better... oh well, this is attempt #2 at fixing this
properly. This time it seems to work with all access sizes and I
can run my flashing tool (which exercises all sort of access sizes
and types to access the SPI controller in the BMC) just fine.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: <stable@vger.kernel.org>

diff --git a/arch/powerpc/platforms/powernv/opal-lpc.c b/arch/powerpc/platforms/powernv/opal-lpc.c
index ad4b31d..af918aa 100644
--- a/arch/powerpc/platforms/powernv/opal-lpc.c
+++ b/arch/powerpc/platforms/powernv/opal-lpc.c
@@ -216,14 +216,54 @@ static ssize_t lpc_debug_read(struct file *filp, char __user *ubuf,
 				   &data, len);
 		if (rc)
 			return -ENXIO;
+
+		/*
+		 * Now there is some trickery with the data returned by OPAL
+		 * as it's the desired data right justified in a 32-bit BE
+		 * word.
+		 *
+		 * This is a very bad interface and I'm to blame for it :-(
+		 *
+		 * So we can't just apply a 32-bit swap to what comes from OPAL,
+		 * because user space expects the *bytes* to be in their proper
+		 * respective positions (ie, LPC position).
+		 *
+		 * So what we really want to do here is to shift data right
+		 * appropriately on a LE kernel.
+		 *
+		 * IE. If the LPC transaction has bytes B0, B1, B2 and B3 in that
+		 * order, we have in memory written to by OPAL at the "data"
+		 * pointer:
+		 *
+		 *               Bytes:      OPAL "data"   LE "data"
+		 *   32-bit:   B0 B1 B2 B3   B0B1B2B3      B3B2B1B0
+		 *   16-bit:   B0 B1         0000B0B1      B1B00000
+		 *    8-bit:   B0            000000B0      B0000000
+		 *
+		 * So a BE kernel will have the leftmost of the above in the MSB
+		 * and rightmost in the LSB and can just then "cast" the u32 "data"
+		 * down to the appropriate quantity and write it.
+		 *
+		 * However, an LE kernel can't. It doesn't need to swap because a
+		 * load from data followed by a store to user are going to preserve
+		 * the byte ordering which is the wire byte order which is what the
+		 * user wants, but in order to "crop" to the right size, we need to
+		 * shift right first.
+		 */
 		switch(len) {
 		case 4:
 			rc = __put_user((u32)data, (u32 __user *)ubuf);
 			break;
 		case 2:
+#ifdef __LITTLE_ENDIAN__
+			data >>= 16;
+#endif
 			rc = __put_user((u16)data, (u16 __user *)ubuf);
 			break;
 		default:
+#ifdef __LITTLE_ENDIAN__
+			data >>= 24;
+#endif
 			rc = __put_user((u8)data, (u8 __user *)ubuf);
 			break;
 		}
@@ -263,12 +303,31 @@ static ssize_t lpc_debug_write(struct file *filp, const char __user *ubuf,
 			else if (todo > 1 && (pos & 1) == 0)
 				len = 2;
 		}
+
+		/*
+		 * Similarly to the read case, we have some trickery here but
+		 * it's different to handle. We need to pass the value to OPAL in
+		 * a register whose layout depends on the access size. We want
+		 * to reproduce the memory layout of the user, however we aren't
+		 * doing a load from user and a store to another memory location
+		 * which would achieve that. Here we pass the value to OPAL via
+		 * a register which is expected to contain the "BE" interpretation
+		 * of the byte sequence. IE: for a 32-bit access, byte 0 should be
+		 * in the MSB. So here we *do* need to byteswap on LE.
+		 *
+		 *           User bytes:    LE "data"  OPAL "data"
+		 *  32-bit:  B0 B1 B2 B3    B3B2B1B0   B0B1B2B3
+		 *  16-bit:  B0 B1          0000B1B0   0000B0B1
+		 *   8-bit:  B0             000000B0   000000B0
+		 */
 		switch(len) {
 		case 4:
 			rc = __get_user(data, (u32 __user *)ubuf);
+			data = cpu_to_be32(data);
 			break;
 		case 2:
 			rc = __get_user(data, (u16 __user *)ubuf);
+			data = cpu_to_be16(data);
 			break;
 		default:
 			rc = __get_user(data, (u8 __user *)ubuf);
