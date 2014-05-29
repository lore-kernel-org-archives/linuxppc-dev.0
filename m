Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414481A024E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 May 2014 17:45:49 +1000 (EST)
Message-ID: <1401349547.4116.19.camel@ale.ozlabs.ibm.com>
Subject: powerpc/pseries: Use new defines when calling h_set_mode
From: Michael Neuling <mikey@neuling.org>
To: Alexander Graf <agraf@suse.de>
Date: Thu, 29 May 2014 17:45:47 +1000
In-Reply-To: <BD1CF085-FEBC-4208-AD3F-C55DB002097F@suse.de>
References: <1401106626-13130-1-git-send-email-paulus@samba.org>
 <1401106626-13130-4-git-send-email-paulus@samba.org>
 <5385E620.5090703@suse.de> <1401342462.4116.4.camel@ale.ozlabs.ibm.com>
 <1401344549.4116.8.camel@ale.ozlabs.ibm.com>
 <BD1CF085-FEBC-4208-AD3F-C55DB002097F@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > +/* Values for 2nd argument to H_SET_MODE */
> > +#define H_SET_MODE_RESOURCE_SET_CIABR        1
> > +#define H_SET_MODE_RESOURCE_SET_DAWR        2
> > +#define H_SET_MODE_RESOURCE_ADDR_TRANS_MODE    3
> > +#define H_SET_MODE_RESOURCE_LE            4
>=20
>=20
> Much better, but I think you want to make use of these in non-kvm code to=
o,
> no? At least the LE one is definitely already implemented as call :)

Sure but that's a different patch.... below.

Mikey


powerpc/pseries: Use new defines when calling h_set_mode

Now that we define these in the KVM code, use these defines when we call
h_set_mode.  No functional change.

Signed-off-by: Michael Neuling <mikey@neuling.org>
--
This depends on the KVM h_set_mode patches.

diff --git a/arch/powerpc/include/asm/plpar_wrappers.h b/arch/powerpc/inclu=
de/asm/plpar_wrappers.h
index 12c32c5..67859ed 100644
--- a/arch/powerpc/include/asm/plpar_wrappers.h
+++ b/arch/powerpc/include/asm/plpar_wrappers.h
@@ -273,7 +273,7 @@ static inline long plpar_set_mode(unsigned long mflags,=
 unsigned long resource,
 static inline long enable_reloc_on_exceptions(void)
 {
 	/* mflags =3D 3: Exceptions at 0xC000000000004000 */
-	return plpar_set_mode(3, 3, 0, 0);
+	return plpar_set_mode(3, H_SET_MODE_RESOURCE_ADDR_TRANS_MODE, 0, 0);
 }
=20
 /*
@@ -284,7 +284,7 @@ static inline long enable_reloc_on_exceptions(void)
  * returns H_SUCCESS.
  */
 static inline long disable_reloc_on_exceptions(void) {
-	return plpar_set_mode(0, 3, 0, 0);
+	return plpar_set_mode(0, H_SET_MODE_RESOURCE_ADDR_TRANS_MODE, 0, 0);
 }
=20
 /*
@@ -297,7 +297,7 @@ static inline long disable_reloc_on_exceptions(void) {
 static inline long enable_big_endian_exceptions(void)
 {
 	/* mflags =3D 0: big endian exceptions */
-	return plpar_set_mode(0, 4, 0, 0);
+	return plpar_set_mode(0, H_SET_MODE_RESOURCE_LE, 0, 0);
 }
=20
 /*
@@ -310,17 +310,17 @@ static inline long enable_big_endian_exceptions(void)
 static inline long enable_little_endian_exceptions(void)
 {
 	/* mflags =3D 1: little endian exceptions */
-	return plpar_set_mode(1, 4, 0, 0);
+	return plpar_set_mode(1, H_SET_MODE_RESOURCE_LE, 0, 0);
 }
=20
 static inline long plapr_set_ciabr(unsigned long ciabr)
 {
-	return plpar_set_mode(0, 1, ciabr, 0);
+	return plpar_set_mode(0, H_SET_MODE_RESOURCE_SET_CIABR, ciabr, 0);
 }
=20
 static inline long plapr_set_watchpoint0(unsigned long dawr0, unsigned lon=
g dawrx0)
 {
-	return plpar_set_mode(0, 2, dawr0, dawrx0);
+	return plpar_set_mode(0, H_SET_MODE_RESOURCE_SET_DAWR, dawr0, dawrx0);
 }
=20
 #endif /* _ASM_POWERPC_PLPAR_WRAPPERS_H */
