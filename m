Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vq5m627LkzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 12:43:18 +1100 (AEDT)
Message-ID: <1490319797.28113.46.camel@neuling.org>
Subject: [PATCH] powerpc/powernv: Fix XSCOM address mangling for form 1
 indirect
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, mikey@neuling.org,
 benh@kernel.crashing.org
Date: Fri, 24 Mar 2017 12:43:17 +1100
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

POWER9 adds form 1 scoms. The form of the indirection is specified in
the top nibble of the scom address.

Currently we do some (ugly) bit mangling so that we can fit a 64 bit
scom address into the debugfs interface. The current code only shifts
the top bit (indirect bit).

This patch changes it to shift the whole top nibble so that the form
of the indirection is also shifted.

This patch is backwards compatible with older scoms.

(This change isn't required in the
arch/powerpc/platformspowernv/opal-prd.c scom interface as it passes
the whole 64bit scom address without any bit mangling)

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
(resending to correct linuxppc address)

=C2=A0arch/powerpc/platforms/powernv/opal-xscom.c | 27 +++++++++++++++++---=
-------
=C2=A01 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-xscom.c
b/arch/powerpc/platforms/powernv/opal-xscom.c
index d0ac535cf5..28651fb254 100644
--- a/arch/powerpc/platforms/powernv/opal-xscom.c
+++ b/arch/powerpc/platforms/powernv/opal-xscom.c
@@ -73,25 +73,32 @@ static int opal_xscom_err_xlate(int64_t rc)
=C2=A0
=C2=A0static u64 opal_scom_unmangle(u64 addr)
=C2=A0{
+	u64 tmp;
+
=C2=A0	/*
-	=C2=A0* XSCOM indirect addresses have the top bit set. Additionally
-	=C2=A0* the rest of the top 3 nibbles is always 0.
+	=C2=A0* XSCOM addresses use the top nibble to set indirect mode and
+	=C2=A0* its form.=C2=A0=C2=A0Bits 4-11 are always 0.
=C2=A0	=C2=A0*
=C2=A0	=C2=A0* Because the debugfs interface uses signed offsets and shifts
=C2=A0	=C2=A0* the address left by 3, we basically cannot use the top 4 bit=
s
=C2=A0	=C2=A0* of the 64-bit address, and thus cannot use the indirect bit.
=C2=A0	=C2=A0*
-	=C2=A0* To deal with that, we support the indirect bit being in bit
-	=C2=A0* 4 (IBM notation) instead of bit 0 in this API, we do the
-	=C2=A0* conversion here. To leave room for further xscom address
-	=C2=A0* expansion, we only clear out the top byte
+	=C2=A0* To deal with that, we support the indirect bits being in
+	=C2=A0* bits 4-7 (IBM notation) instead of bit 0-3 in this API, we
+	=C2=A0* do the conversion here.
=C2=A0	=C2=A0*
-	=C2=A0* For in-kernel use, we also support the real indirect bit, so
-	=C2=A0* we test for any of the top 5 bits
+	=C2=A0* For in-kernel use, we don't need to do this mangling.=C2=A0=C2=A0=
In
+	=C2=A0* kernel won't have bits 4-7 set.
=C2=A0	=C2=A0*
+	=C2=A0* So:
+	=C2=A0*=C2=A0=C2=A0=C2=A0debugfs will always=C2=A0=C2=A0=C2=A0set 0-3 =3D=
 0 and clear 4-7
+	=C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0kernel will always clear 0-3 =3D 0 and=C2=
=A0=C2=A0=C2=A0set 4-7
=C2=A0	=C2=A0*/
-	if (addr & (0x1full << 59))
-		addr =3D (addr & ~(0xffull << 56)) | (1ull << 63);
+	tmp =3D addr;
+	tmp=C2=A0=C2=A0&=3D 0x0f00000000000000;
+	addr &=3D 0xf0ffffffffffffff;
+	addr |=3D tmp << 4;
+
=C2=A0	return addr;
=C2=A0}
=C2=A0
