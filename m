Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BF82EDDF41
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2007 03:08:22 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l3QH8G5Y004247
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 10:08:16 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l3QH8Fo5018004
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 12:08:15 -0500 (CDT)
Date: Thu, 26 Apr 2007 12:08:13 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH] bootwrapper: Fix array handling in dt_xlate_reg().
Message-ID: <20070426170813.GA13465@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This fixes a few bugs in how dt_xlate_reg() handles address arrays:

1. copy_val() was copying into the wrong end of the array, resulting
in random stack garbage at the other end.
2. dt_xlate_reg() was getting the result from the wrong end of the array.
3. add_reg() and sub_reg() were treating the arrays as
little-endian rather than big-endian.
4. add_reg() only returned an error on a carry out of the entire
array, rather than out of the naddr portion.
5. The requested reg resource was checked to see if it exceeded
the size of the reg property, but not to see if it exceeded the
size of the buffer.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/devtree.c |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/boot/devtree.c b/arch/powerpc/boot/devtree.c
index 23492d7..ac4b5ee 100644
--- a/arch/powerpc/boot/devtree.c
+++ b/arch/powerpc/boot/devtree.c
@@ -123,15 +123,17 @@ static void get_reg_format(void *node, u32 *naddr, u32 *nsize)
 
 static void copy_val(u32 *dest, u32 *src, int naddr)
 {
-	memset(dest, 0, (MAX_ADDR_CELLS - naddr) * 4);
-	memcpy(dest, src, naddr * 4);
+	int pad = MAX_ADDR_CELLS - naddr;
+
+	memset(dest, 0, pad * 4);
+	memcpy(dest + pad, src, naddr * 4);
 }
 
 static int sub_reg(u32 *reg, u32 *sub)
 {
 	int i, borrow = 0;
 
-	for (i = 0; i < MAX_ADDR_CELLS; i++) {
+	for (i = MAX_ADDR_CELLS - 1; i >= 0; i--) {
 		int prev_borrow = borrow;
 		borrow = reg[i] < sub[i] + prev_borrow;
 		reg[i] -= sub[i] + prev_borrow;
@@ -140,11 +142,11 @@ static int sub_reg(u32 *reg, u32 *sub)
 	return !borrow;
 }
 
-static int add_reg(u32 *reg, u32 *add)
+static int add_reg(u32 *reg, u32 *add, int naddr)
 {
 	int i, carry = 0;
 
-	for (i = 0; i < MAX_ADDR_CELLS; i++) {
+	for (i = MAX_ADDR_CELLS - 1; i >= MAX_ADDR_CELLS - naddr; i--) {
 		u64 tmp = (u64)reg[i] + add[i] + carry;
 		carry = tmp >> 32;
 		reg[i] = (u32)tmp;
@@ -228,7 +230,8 @@ int dt_xlate_reg(void *node, int res, unsigned long *addr,
 	buflen = getprop(node, "reg", buf, sizeof(buf)) / 4;
 	offset = (naddr + nsize) * res;
 
-	if (buflen < offset + naddr + nsize)
+	if (buflen < offset + naddr + nsize ||
+	    sizeof(buf) < offset + naddr + nsize)
 		return 0;
 
 	copy_val(last_addr, buf + offset, naddr);
@@ -263,18 +266,14 @@ int dt_xlate_reg(void *node, int res, unsigned long *addr,
 
 		copy_val(this_addr, buf + offset + prev_naddr, naddr);
 
-		if (!add_reg(last_addr, this_addr))
+		if (!add_reg(last_addr, this_addr, naddr))
 			return 0;
 	}
 
 	if (naddr > 2)
 		return 0;
 
-	ret_addr = last_addr[0];
-	if (naddr == 2) {
-		ret_addr <<= 32;
-		ret_addr |= last_addr[1];
-	}
+	ret_addr = ((u64)last_addr[2] << 32) | last_addr[3];
 
 	if (sizeof(void *) == 4 &&
 	    (ret_addr >= 0x100000000ULL || ret_size > 0x100000000ULL ||
-- 
1.5.0.3
