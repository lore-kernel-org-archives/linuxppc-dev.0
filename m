Return-Path: <sjmunroe@us.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF0501A040B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jun 2014 01:13:46 +1000 (EST)
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B01F914007D
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2014 01:13:45 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sjmunroe@us.ibm.com>;
 Thu, 12 Jun 2014 11:13:41 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id A60976E8041
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2014 11:13:29 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5CFDciB43188358
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2014 15:13:38 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5CFDaex006641
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2014 11:13:37 -0400
In-Reply-To: <1402376680.14780.12.camel@pasglop>
References: <1402376680.14780.12.camel@pasglop>
Subject: Re: [PATCH] powerpc: Add AT_HWCAP2 to indicate V.CRYPTO category
 support
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF26AC1193.59958340-ON85257CF5.00528030-86257CF5.0053A37D@us.ibm.com>
From: Steve Munroe <sjmunroe@us.ibm.com>
Date: Thu, 12 Jun 2014 10:13:33 -0500
MIME-Version: 1.0
Content-type: multipart/related;
 Boundary="0__=0ABBF666DFC106A08f9e8a93df938690918c0ABBF666DFC106A0"
Cc: linuxppc-dev@ozlabs.org, Adhemerval Zanella <azanella@linux.vnet.ibm.com>,
 Michael J Wolf <mjwolf@us.ibm.com>, Hanns-Joachim Uhl <hannsj_uhl@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0__=0ABBF666DFC106A08f9e8a93df938690918c0ABBF666DFC106A0
Content-type: multipart/alternative;
	Boundary="1__=0ABBF666DFC106A08f9e8a93df938690918c0ABBF666DFC106A0"

--1__=0ABBF666DFC106A08f9e8a93df938690918c0ABBF666DFC106A0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable


The precedent we have used is that features that refer to ISA Categorie=
s
include _HAS_ following the PPC_FEATURE[2]. So GLIBC specifies in hwcap=
.h:

/* Feature definitions in AT_HWCAP2.  */
#define PPC_FEATURE2_ARCH_2_07     0x80000000 /* ISA 2.07 */
#define PPC_FEATURE2_HAS_HTM       0x40000000 /* Hardware Transactional=

                                                 Memory */
#define PPC_FEATURE2_HAS_DSCR      0x20000000 /* Data Stream Control
                                                 Register */
#define PPC_FEATURE2_HAS_EBB       0x10000000 /* Event Base Branching *=
/
#define PPC_FEATURE2_HAS_ISEL      0x08000000 /* Integer Select */
#define PPC_FEATURE2_HAS_TAR       0x04000000 /* Target Address Registe=
r */

This was carried from the original AT_HWCAP defines.

$ grep _HAS_ ./sysdeps/powerpc/bits/hwcap.h
#define PPC_FEATURE_HAS_ALTIVEC	    0x10000000 /* SIMD/Vector Unit.  */=

#define PPC_FEATURE_HAS_FPU	    0x08000000 /* Floating Point Unit.  */
#define PPC_FEATURE_HAS_MMU	    0x04000000 /* Memory Management Unit.  =
*/
#define PPC_FEATURE_HAS_4xxMAC	    0x02000000 /* 4xx Multiply
Accumulator.  */
#define PPC_FEATURE_HAS_SPE	    0x00800000 /* Signal Processing ext.  *=
/
#define PPC_FEATURE_HAS_EFP_SINGLE  0x00400000 /* SPE Float.  */
#define PPC_FEATURE_HAS_EFP_DOUBLE  0x00200000 /* SPE Double.  */
#define PPC_FEATURE_HAS_DFP	    0x00000400 /* Decimal FP Unit */
#define PPC_FEATURE_HAS_VSX	    0x00000080 /* P7 Vector Extension.  */

So could we agree on PPC_FEATURE2_HAS_VEC_CRYPTO or the shorter
PPC_FEATURE2_HAS_VCRYPTO?

Steven J. Munroe
Linux on Power Toolchain Architect
IBM Corporation, Linux Technology Center




From:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:	linuxppc-dev@ozlabs.org
Cc:	Steve Munroe/Rochester/IBM@IBMUS, Hanns-Joachim Uhl
            <hannsj_uhl@de.ibm.com>, Diane Brent/Poughkeepsie/IBM@IBMUS=
,
            Jeffrey Scheel/Rochester/IBM@IBMUS, Adhemerval Zanella
            <azanella@linux.vnet.ibm.com>
Date:	06/10/2014 12:05 AM
Subject:	[PATCH] powerpc: Add AT_HWCAP2 to indicate V.CRYPTO category
            support



The Vector Crypto category instructions are supported by current POWER8=

chips, advertise them to userspace using a specific bit to properly
differentiate with chips of the same architecture level that might not
have them.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: <stable@vger.kernel.org> [v3.10+]
--

diff --git a/arch/powerpc/include/uapi/asm/cputable.h
b/arch/powerpc/include/uapi/asm/cputable.h
index 5b76579..de2c0e4 100644
--- a/arch/powerpc/include/uapi/asm/cputable.h
+++ b/arch/powerpc/include/uapi/asm/cputable.h
@@ -41,5 +41,6 @@
 #define PPC_FEATURE2_EBB		 		 0x10000000
 #define PPC_FEATURE2_ISEL		 		 0x08000000
 #define PPC_FEATURE2_TAR		 		 0x04000000
+#define PPC_FEATURE2_VEC_CRYPTO		 		 0x02000000

 #endif /* _UAPI__ASM_POWERPC_CPUTABLE_H */
diff --git a/arch/powerpc/kernel/cputable.c
b/arch/powerpc/kernel/cputable.c
index c1faade..11da04a 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -109,7 +109,8 @@ extern void __restore_cpu_e6500(void);

PPC_FEATURE_PSERIES_PERFMON_COMPAT)
 #define COMMON_USER2_POWER8		 (PPC_FEATURE2_ARCH_2_07 | \
 		 		 		 		  PPC_FEATURE2_HTM_COMP |
PPC_FEATURE2_DSCR | \
-		 		 		 		  PPC_FEATURE2_ISEL |
PPC_FEATURE2_TAR)
+		 		 		 		  PPC_FEATURE2_ISEL |
PPC_FEATURE2_TAR | \
+		 		 		 		  PPC_FEATURE2_VEC_CRYPTO)
 #define COMMON_USER_PA6T		 (COMMON_USER_PPC64 | PPC_FEATURE_PA6T
|\
 		 		 		 		  PPC_FEATURE_TRUE_LE | \

PPC_FEATURE_HAS_ALTIVEC_COMP)


=

--1__=0ABBF666DFC106A08f9e8a93df938690918c0ABBF666DFC106A0
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p><font size=3D"2" face=3D"sans-serif">The precedent we have used is t=
hat features that refer to ISA Categories include _HAS_ following the P=
PC_FEATURE[2]. So GLIBC specifies in hwcap.h:</font><br>
<br>
<font size=3D"2" face=3D"sans-serif">/* Feature definitions in AT_HWCAP=
2. &nbsp;*/</font><br>
<font size=3D"2" face=3D"sans-serif">#define PPC_FEATURE2_ARCH_2_07 &nb=
sp; &nbsp; 0x80000000 /* ISA 2.07 */</font><br>
<font size=3D"2" face=3D"sans-serif">#define PPC_FEATURE2_HAS_HTM &nbsp=
; &nbsp; &nbsp; 0x40000000 /* Hardware Transactional</font><br>
<font size=3D"2" face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Me=
mory */</font><br>
<font size=3D"2" face=3D"sans-serif">#define PPC_FEATURE2_HAS_DSCR &nbs=
p; &nbsp; &nbsp;0x20000000 /* Data Stream Control</font><br>
<font size=3D"2" face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Re=
gister */</font><br>
<font size=3D"2" face=3D"sans-serif">#define PPC_FEATURE2_HAS_EBB &nbsp=
; &nbsp; &nbsp; 0x10000000 /* Event Base Branching */</font><br>
<font size=3D"2" face=3D"sans-serif">#define PPC_FEATURE2_HAS_ISEL &nbs=
p; &nbsp; &nbsp;0x08000000 /* Integer Select */</font><br>
<font size=3D"2" face=3D"sans-serif">#define PPC_FEATURE2_HAS_TAR &nbsp=
; &nbsp; &nbsp; 0x04000000 /* Target Address Register */</font><br>
<br>
<font size=3D"2" face=3D"sans-serif">This was carried from the original=
 AT_HWCAP defines.</font><br>
<br>
<font size=3D"2" face=3D"sans-serif">$ grep _HAS_ ./sysdeps/powerpc/bit=
s/hwcap.h</font><br>
<font size=3D"2" face=3D"sans-serif">#define PPC_FEATURE_HAS_ALTIVEC	 &=
nbsp; &nbsp;0x10000000 /* SIMD/Vector Unit. &nbsp;*/</font><br>
<font size=3D"2" face=3D"sans-serif">#define PPC_FEATURE_HAS_FPU	 &nbsp=
; &nbsp;0x08000000 /* Floating Point Unit. &nbsp;*/</font><br>
<font size=3D"2" face=3D"sans-serif">#define PPC_FEATURE_HAS_MMU	 &nbsp=
; &nbsp;0x04000000 /* Memory Management Unit. &nbsp;*/</font><br>
<font size=3D"2" face=3D"sans-serif">#define PPC_FEATURE_HAS_4xxMAC	 &n=
bsp; &nbsp;0x02000000 /* 4xx Multiply Accumulator. &nbsp;*/</font><br>
<font size=3D"2" face=3D"sans-serif">#define PPC_FEATURE_HAS_SPE	 &nbsp=
; &nbsp;0x00800000 /* Signal Processing ext. &nbsp;*/</font><br>
<font size=3D"2" face=3D"sans-serif">#define PPC_FEATURE_HAS_EFP_SINGLE=
 &nbsp;0x00400000 /* SPE Float. &nbsp;*/</font><br>
<font size=3D"2" face=3D"sans-serif">#define PPC_FEATURE_HAS_EFP_DOUBLE=
 &nbsp;0x00200000 /* SPE Double. &nbsp;*/</font><br>
<font size=3D"2" face=3D"sans-serif">#define PPC_FEATURE_HAS_DFP	 &nbsp=
; &nbsp;0x00000400 /* Decimal FP Unit */</font><br>
<font size=3D"2" face=3D"sans-serif">#define PPC_FEATURE_HAS_VSX	 &nbsp=
; &nbsp;0x00000080 /* P7 Vector Extension. &nbsp;*/</font><br>
<br>
<font size=3D"2" face=3D"sans-serif">So could we agree on PPC_FEATURE2_=
HAS_VEC_CRYPTO or the shorter PPC_FEATURE2_HAS_VCRYPTO?</font><br>
<br>
<font size=3D"2" face=3D"sans-serif">Steven J. Munroe<br>
Linux on Power Toolchain Architect<br>
IBM Corporation, Linux Technology Center<br>
</font><br>
<br>
<img width=3D"16" height=3D"16" src=3D"cid:1__=3D0ABBF666DFC106A08f9e8a=
93df938@us.ibm.com" border=3D"0" alt=3D"Inactive hide details for Benja=
min Herrenschmidt ---06/10/2014 12:05:07 AM---The Vector Crypto categor=
y instructions are suppor"><font size=3D"2" color=3D"#424282" face=3D"s=
ans-serif">Benjamin Herrenschmidt ---06/10/2014 12:05:07 AM---The Vecto=
r Crypto category instructions are supported by current POWER8 chips, a=
dvertise them to use</font><br>
<br>
<font size=3D"1" color=3D"#5F5F5F" face=3D"sans-serif">From:	</font><fo=
nt size=3D"1" face=3D"sans-serif">Benjamin Herrenschmidt &lt;benh@kerne=
l.crashing.org&gt;</font><br>
<font size=3D"1" color=3D"#5F5F5F" face=3D"sans-serif">To:	</font><font=
 size=3D"1" face=3D"sans-serif">linuxppc-dev@ozlabs.org</font><br>
<font size=3D"1" color=3D"#5F5F5F" face=3D"sans-serif">Cc:	</font><font=
 size=3D"1" face=3D"sans-serif">Steve Munroe/Rochester/IBM@IBMUS, Hanns=
-Joachim Uhl &lt;hannsj_uhl@de.ibm.com&gt;, Diane Brent/Poughkeepsie/IB=
M@IBMUS, Jeffrey Scheel/Rochester/IBM@IBMUS, Adhemerval Zanella &lt;aza=
nella@linux.vnet.ibm.com&gt;</font><br>
<font size=3D"1" color=3D"#5F5F5F" face=3D"sans-serif">Date:	</font><fo=
nt size=3D"1" face=3D"sans-serif">06/10/2014 12:05 AM</font><br>
<font size=3D"1" color=3D"#5F5F5F" face=3D"sans-serif">Subject:	</font>=
<font size=3D"1" face=3D"sans-serif">[PATCH] powerpc: Add AT_HWCAP2 to =
indicate V.CRYPTO category support</font><br>
<hr width=3D"100%" size=3D"2" align=3D"left" noshade style=3D"color:#80=
91A5; "><br>
<br>
<br>
<tt><font size=3D"2">The Vector Crypto category instructions are suppor=
ted by current POWER8<br>
chips, advertise them to userspace using a specific bit to properly<br>=

differentiate with chips of the same architecture level that might not<=
br>
have them.<br>
<br>
Signed-off-by: Benjamin Herrenschmidt &lt;benh@kernel.crashing.org&gt;<=
br>
CC: &lt;stable@vger.kernel.org&gt; [v3.10+]<br>
--<br>
<br>
diff --git a/arch/powerpc/include/uapi/asm/cputable.h b/arch/powerpc/in=
clude/uapi/asm/cputable.h<br>
index 5b76579..de2c0e4 100644<br>
--- a/arch/powerpc/include/uapi/asm/cputable.h<br>
+++ b/arch/powerpc/include/uapi/asm/cputable.h<br>
@@ -41,5 +41,6 @@<br>
 #define PPC_FEATURE2_EBB		 		 0x10000000<br>
 #define PPC_FEATURE2_ISEL		 		 0x08000000<br>
 #define PPC_FEATURE2_TAR		 		 0x04000000<br>
+#define PPC_FEATURE2_VEC_CRYPTO		 		 0x02000000<br>
 <br>
 #endif /* _UAPI__ASM_POWERPC_CPUTABLE_H */<br>
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputa=
ble.c<br>
index c1faade..11da04a 100644<br>
--- a/arch/powerpc/kernel/cputable.c<br>
+++ b/arch/powerpc/kernel/cputable.c<br>
@@ -109,7 +109,8 @@ extern void __restore_cpu_e6500(void);<br>
 		 		 		 		 &nbsp;PPC_FEATURE_PSERIES_PERFMON_COMPAT)<br>
 #define COMMON_USER2_POWER8		 (PPC_FEATURE2_ARCH_2_07 | \<br>
 		 		 		 		 &nbsp;PPC_FEATURE2_HTM_COMP | PPC_FEATURE2_DSCR | \<br>
-		 		 		 		 &nbsp;PPC_FEATURE2_ISEL | PPC_FEATURE2_TAR)<br>
+		 		 		 		 &nbsp;PPC_FEATURE2_ISEL | PPC_FEATURE2_TAR | \<br>
+		 		 		 		 &nbsp;PPC_FEATURE2_VEC_CRYPTO)<br>
 #define COMMON_USER_PA6T		 (COMMON_USER_PPC64 | PPC_FEATURE_PA6T |\<br=
>
 		 		 		 		 &nbsp;PPC_FEATURE_TRUE_LE | \<br>
 		 		 		 		 &nbsp;PPC_FEATURE_HAS_ALTIVEC_COMP)<br>
<br>
<br>
</font></tt><br>
</body></html>=


--1__=0ABBF666DFC106A08f9e8a93df938690918c0ABBF666DFC106A0--


--0__=0ABBF666DFC106A08f9e8a93df938690918c0ABBF666DFC106A0
Content-type: image/gif;
	name="graycol.gif"
Content-Disposition: inline; filename="graycol.gif"
Content-ID: <1__=0ABBF666DFC106A08f9e8a93df938@us.ibm.com>
Content-transfer-encoding: base64

R0lGODlhEAAQAKECAMzMzAAAAP///wAAACH5BAEAAAIALAAAAAAQABAAAAIXlI+py+0PopwxUbpu
ZRfKZ2zgSJbmSRYAIf4fT3B0aW1pemVkIGJ5IFVsZWFkIFNtYXJ0U2F2ZXIhAAA7

--0__=0ABBF666DFC106A08f9e8a93df938690918c0ABBF666DFC106A0--
