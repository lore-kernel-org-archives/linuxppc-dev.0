Return-Path: <tommusta@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F24E52C00EB
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Sep 2013 01:13:02 +1000 (EST)
Received: by mail-pa0-f65.google.com with SMTP id fb10so1407908pad.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Sep 2013 08:13:00 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 6 Sep 2013 10:13:00 -0500
Message-ID: <CAJ-hshaxuJBMCFquT7J50rjuDYWer_0i1=2QmnOKGAxx4n=FUw@mail.gmail.com>
Subject: [PATCH] powerpc: OE=1 Form Instructions Not Decoded Correctly
From: Tom Musta <tommusta@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=047d7bacc7966c908e04e5b87917
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--047d7bacc7966c908e04e5b87917
Content-Type: text/plain; charset=ISO-8859-1

To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: OE=1 Form Instructions Not Decoded Correctly
From: Tom Musta <tommusta@gmail.com>

PowerISA uses instruction bit 21 to indicate that the overflow (OV) bit
of the XER is to be set, as well as its corresponding sticky bit (SO).
This patch addresses two defects in the implementation of the PowerISA
single step code for this category of instructions:  (a) the OE=1 case
is not correctly accounted for in the case statement for the extended
opcode handling.  (b) the implementation is not setting XER[OV] and
XER[SO].

Signed-off-by: Tom Musta <tommusta@gmail.com>

---
 arch/powerpc/lib/sstep.c |  208
+++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 185 insertions(+), 23 deletions(-)


diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index d220b88..a4f343d 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -31,6 +31,13 @@ extern char system_call_common[];
 #define XER_OV 0x40000000U
 #define XER_CA 0x20000000U

+#define U32_MSK         0xFFFFFFFF00000000ul
+#define L32_MSK         0x00000000FFFFFFFFul
+#define SGN_32_MSK      0x0000000080000000ul
+#define SGN_64_MSK      0x8000000000000000ul
+#define SGN_EXT_32(x)   (((x) & SGN_32_MSK) ? ((x) | U32_MSK) : ((x) &
L32_MSK))
+#define L32(x)          ((x) & L32_MSK)
+
 #ifdef CONFIG_PPC_FPU
 /*
  * Functions in ldstfp.S
@@ -467,6 +474,13 @@ static int __kprobes do_vsx_store(int rn, int
(*func)(int, unsigned long),
  ".previous" \
  : "=r" (err) \
  : "r" (addr), "i" (-EFAULT), "0" (err))
+static void __kprobes set_xer_ov(struct pt_regs *regs, int ov)
+{
+ if (ov)
+ regs->xer |= (XER_SO | XER_OV);
+ else
+ regs->xer &= ~XER_OV;
+}

 static void __kprobes set_cr0(struct pt_regs *regs, int rd)
 {
@@ -487,7 +501,7 @@ static void __kprobes set_cr0(struct pt_regs *regs, int
rd)

 static void __kprobes add_with_carry(struct pt_regs *regs, int rd,
      unsigned long val1, unsigned long val2,
-     unsigned long carry_in)
+     unsigned long carry_in, int oe)
 {
  unsigned long val = val1 + val2;

@@ -504,6 +518,13 @@ static void __kprobes add_with_carry(struct pt_regs
*regs, int rd,
  regs->xer |= XER_CA;
  else
  regs->xer &= ~XER_CA;
+ if (oe) {
+ unsigned long m = ((regs->msr & MSR_64BIT) == 0) ?
+ SGN_32_MSK : SGN_64_MSK;
+ int ov = ((val1 & m) == (val2 & m)) &&
+ ((val1 & m) != (val & m));
+ set_xer_ov(regs, ov);
+ }
 }

 static void __kprobes do_cmp_signed(struct pt_regs *regs, long v1, long v2,
@@ -552,7 +573,7 @@ static void __kprobes do_cmp_unsigned(struct pt_regs
*regs, unsigned long v1,
 #define DATA32(x) (x)
 #endif
 #define ROTATE(x, n) ((n) ? (((x) << (n)) | ((x) >> (8 * sizeof(long) -
(n)))) : (x))
-
+#define OE(instr)       (((instr) >> (31-21)) & 1)
 /*
  * Emulate instructions that cause a transfer of control,
  * loads and stores, and a few other instructions.
@@ -693,7 +714,7 @@ int __kprobes emulate_step(struct pt_regs *regs,
unsigned int instr)

  case 8: /* subfic */
  imm = (short) instr;
- add_with_carry(regs, rd, ~regs->gpr[ra], imm, 1);
+ add_with_carry(regs, rd, ~regs->gpr[ra], imm, 1, 0);
  goto instr_done;

  case 10: /* cmpli */
@@ -718,12 +739,12 @@ int __kprobes emulate_step(struct pt_regs *regs,
unsigned int instr)

  case 12: /* addic */
  imm = (short) instr;
- add_with_carry(regs, rd, regs->gpr[ra], imm, 0);
+ add_with_carry(regs, rd, regs->gpr[ra], imm, 0, 0);
  goto instr_done;

  case 13: /* addic. */
  imm = (short) instr;
- add_with_carry(regs, rd, regs->gpr[ra], imm, 0);
+ add_with_carry(regs, rd, regs->gpr[ra], imm, 0, 0);
  set_cr0(regs, rd);
  goto instr_done;

@@ -944,8 +965,9 @@ int __kprobes emulate_step(struct pt_regs *regs,
unsigned int instr)
  * Arithmetic instructions
  */
  case 8: /* subfc */
+ case 520: /* subfco */
  add_with_carry(regs, rd, ~regs->gpr[ra],
-       regs->gpr[rb], 1);
+       regs->gpr[rb], 1, OE(instr));
  goto arith_done;
 #ifdef __powerpc64__
  case 9: /* mulhdu */
@@ -954,8 +976,9 @@ int __kprobes emulate_step(struct pt_regs *regs,
unsigned int instr)
  goto arith_done;
 #endif
  case 10: /* addc */
+ case 522:       /* addco */
  add_with_carry(regs, rd, regs->gpr[ra],
-       regs->gpr[rb], 0);
+       regs->gpr[rb], 0, OE(instr));
  goto arith_done;

  case 11: /* mulhwu */
@@ -964,7 +987,19 @@ int __kprobes emulate_step(struct pt_regs *regs,
unsigned int instr)
  goto arith_done;

  case 40: /* subf */
- regs->gpr[rd] = regs->gpr[rb] - regs->gpr[ra];
+ case 552: /* subfo */
+ val = regs->gpr[rb] - regs->gpr[ra];
+ if (OE(instr)) { /* subfo */
+ unsigned long m =
+ ((regs->msr & MSR_64BIT) == 0) ?
+ SGN_32_MSK : SGN_64_MSK;
+ int ov =
+ ((~regs->gpr[ra] & m) ==
+ (regs->gpr[rb] & m)) &&
+ ((regs->gpr[rb] & m) != (val & m));
+ set_xer_ov(regs, ov);
+ }
+ regs->gpr[rd] = val;
  goto arith_done;
 #ifdef __powerpc64__
  case 73: /* mulhd */
@@ -978,69 +1013,196 @@ int __kprobes emulate_step(struct pt_regs *regs,
unsigned int instr)
  goto arith_done;

  case 104: /* neg */
+ case 616: /* nego */
  regs->gpr[rd] = -regs->gpr[ra];
+ if (OE(instr)) { /* nego */
+ int ov = (regs->msr & MSR_64BIT) ?
+ (regs->gpr[rd] == 0x8000000000000000l) :
+ (regs->gpr[rd] == 0x80000000l);
+ set_xer_ov(regs, ov);
+ }
  goto arith_done;

  case 136: /* subfe */
+ case 648: /* subfeo */
  add_with_carry(regs, rd, ~regs->gpr[ra], regs->gpr[rb],
-       regs->xer & XER_CA);
+       regs->xer & XER_CA, OE(instr));
  goto arith_done;

  case 138: /* adde */
+ case 650: /* addeo */
  add_with_carry(regs, rd, regs->gpr[ra], regs->gpr[rb],
-       regs->xer & XER_CA);
+       regs->xer & XER_CA, OE(instr));
  goto arith_done;

  case 200: /* subfze */
+ case 712: /* subfzeo */
  add_with_carry(regs, rd, ~regs->gpr[ra], 0L,
-       regs->xer & XER_CA);
+       regs->xer & XER_CA, OE(instr));
  goto arith_done;

  case 202: /* addze */
+ case 714: /* addzeo */
  add_with_carry(regs, rd, regs->gpr[ra], 0L,
-       regs->xer & XER_CA);
+       regs->xer & XER_CA, OE(instr));
  goto arith_done;

  case 232: /* subfme */
+ case 744: /* subfmeo */
  add_with_carry(regs, rd, ~regs->gpr[ra], -1L,
-       regs->xer & XER_CA);
+       regs->xer & XER_CA, OE(instr));
  goto arith_done;
 #ifdef __powerpc64__
  case 233: /* mulld */
- regs->gpr[rd] = regs->gpr[ra] * regs->gpr[rb];
+ case 745:       /* mulldo */
+ {
+ unsigned long xer_copy;
+ asm("mulldo %0,%2,%3;"
+ "mfxer %1" :
+ "=r" (regs->gpr[rd]), "=r" (xer_copy) :
+ "r" (regs->gpr[ra]), "r" (regs->gpr[rb]));
+ if (OE(instr))
+ set_xer_ov(regs, (xer_copy & XER_OV) != 0);
  goto arith_done;
+ }
 #endif
  case 234: /* addme */
+ case 746: /* addme0 */
  add_with_carry(regs, rd, regs->gpr[ra], -1L,
-       regs->xer & XER_CA);
+       regs->xer & XER_CA, OE(instr));
  goto arith_done;

  case 235: /* mullw */
- regs->gpr[rd] = (unsigned int) regs->gpr[ra] *
- (unsigned int) regs->gpr[rb];
+ case 747: /* mullwo */
+ regs->gpr[rd] = SGN_EXT_32(regs->gpr[ra]) *
+ SGN_EXT_32(regs->gpr[rb]);
+ if (OE(instr)) { /* mullwo */
+ int ov = 0;
+ if ((regs->gpr[rd] & U32_MSK) == 0)
+ ov = (regs->gpr[rd] & SGN_32_MSK) != 0;
+ else if ((regs->gpr[rd] & U32_MSK) == U32_MSK)
+ ov = (regs->gpr[rd] & SGN_32_MSK) == 0;
+ else
+ ov = 1;
+ set_xer_ov(regs, ov);
+ }
  goto arith_done;

  case 266: /* add */
- regs->gpr[rd] = regs->gpr[ra] + regs->gpr[rb];
+ case 778: /* addo */
+ val = regs->gpr[ra] + regs->gpr[rb];
+ if (OE(instr)) { /* addo */
+ unsigned long m = ((regs->msr & MSR_64BIT) == 0)
+ ? SGN_32_MSK : SGN_64_MSK;
+ int ov = ((regs->gpr[ra] & m) ==
+ (regs->gpr[rb] & m)) &&
+ ((regs->gpr[ra] & m) != (val & m));
+ set_xer_ov(regs, ov);
+ }
+ regs->gpr[rd] = val;
+ goto arith_done;
+#ifdef __powerpc64__
+ case 393: /* divdeu */
+ case 905:       /* divdeuo */
+ {
+ unsigned long xer_copy;
+ asm("divdeuo %0,%2,%3;"
+ "mfxer %1" :
+ "=r" (regs->gpr[rd]), "=r" (xer_copy) :
+ "r" (regs->gpr[ra]), "r" (regs->gpr[rb]));
+ if (OE(instr))
+ set_xer_ov(regs, (xer_copy & XER_OV) != 0);
+ goto arith_done;
+ }
+#endif
+ case 395: /* divweu */
+ case 907: /* divweuo */
+ val = (L32(regs->gpr[ra]) << 32) / L32(regs->gpr[rb]);
+ if (OE(instr)) {
+ int ov = (L32(regs->gpr[rb]) == 0) ||
+ ((val & U32_MSK) != 0);
+ set_xer_ov(regs, ov);
+ }
+ regs->gpr[rd] = val;
+ goto arith_done;
+#ifdef __powerpc64__
+ case 425: /* divde */
+ case 937:       /* divdeo */
+ {
+ unsigned long xer_copy;
+ asm("divdeo %0,%2,%3;"
+ " mfxer %1" :
+ "=r" (regs->gpr[rd]), "=r" (xer_copy) :
+ "r" (regs->gpr[ra]), "r" (regs->gpr[rb]));
+ if (OE(instr))
+ set_xer_ov(regs, (xer_copy & XER_OV) != 0);
+ goto arith_done;
+ }
+#endif
+ case 427: /* divwe */
+ case 939: /* divweo */
+ val = ((long int)SGN_EXT_32(regs->gpr[ra]) << 32) /
+ (long int)SGN_EXT_32(regs->gpr[rb]);
+ if (OE(instr)) {
+ int ov = (L32(regs->gpr[rb]) == 0) ||
+ ((L32(regs->gpr[ra]) == SGN_32_MSK) &&
+ (L32(regs->gpr[rb]) == L32_MSK));
+ if ((val & U32_MSK) == 0)
+ ov |= (val & SGN_32_MSK) != 0;
+ else if ((val & U32_MSK) == U32_MSK)
+ ov |= (val & SGN_32_MSK) == 0;
+ else
+ ov = 1;
+ set_xer_ov(regs, ov);
+ }
+ regs->gpr[rd] = val;
  goto arith_done;
 #ifdef __powerpc64__
  case 457: /* divdu */
- regs->gpr[rd] = regs->gpr[ra] / regs->gpr[rb];
+ case 969: /* divduo */
+ val = regs->gpr[ra] / regs->gpr[rb];
+ if (OE(instr)) { /* divduo */
+ int ov = (regs->gpr[rb] == 0);
+ set_xer_ov(regs, ov);
+ }
+ regs->gpr[rd] = val;
  goto arith_done;
 #endif
  case 459: /* divwu */
- regs->gpr[rd] = (unsigned int) regs->gpr[ra] /
+ case 971: /* divwuo */
+ val = (unsigned int) regs->gpr[ra] /
  (unsigned int) regs->gpr[rb];
+ if (OE(instr)) { /* divwuo */
+ int ov = (L32(regs->gpr[rb]) == 0);
+ set_xer_ov(regs, ov);
+ }
+ regs->gpr[rd] = val;
  goto arith_done;
 #ifdef __powerpc64__
  case 489: /* divd */
- regs->gpr[rd] = (long int) regs->gpr[ra] /
+ case 1001: /* divdo */
+ val = (long int) regs->gpr[ra] /
  (long int) regs->gpr[rb];
+ if (OE(instr)) { /* divdo */
+ int ov = (regs->gpr[rb] == 0) ||
+ ((regs->gpr[ra] == SGN_64_MSK) &&
+ (regs->gpr[rb] == -1ul));
+ set_xer_ov(regs, ov);
+ }
+ regs->gpr[rd] = val;
  goto arith_done;
 #endif
  case 491: /* divw */
- regs->gpr[rd] = (int) regs->gpr[ra] /
- (int) regs->gpr[rb];
+ case 1003: /* divwo */
+ val = (long int)SGN_EXT_32(regs->gpr[ra]) /
+ (long int)SGN_EXT_32(regs->gpr[rb]);
+ if (OE(instr)) {
+ int ov = (L32(regs->gpr[rb]) == 0) ||
+ ((L32(regs->gpr[ra]) == SGN_32_MSK) &&
+ (L32(regs->gpr[rb]) == L32_MSK));
+ set_xer_ov(regs, ov);
+ }
+ regs->gpr[rd] = val;
  goto arith_done;

--047d7bacc7966c908e04e5b87917
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">To: <a href=3D"mailto:linuxppc-dev@lists.ozlabs.org">linux=
ppc-dev@lists.ozlabs.org</a><br>Subject: [PATCH] powerpc: OE=3D1 Form Instr=
uctions Not Decoded Correctly <br>From: Tom Musta &lt;<a href=3D"mailto:tom=
musta@gmail.com">tommusta@gmail.com</a>&gt;<br>
<br>PowerISA uses instruction bit 21 to indicate that the overflow (OV) bit=
<br>of the XER is to be set, as well as its corresponding sticky bit (SO).<=
br>This patch addresses two defects in the implementation of the PowerISA <=
br>
single step code for this category of instructions: =A0(a) the OE=3D1 case<=
br>is not correctly accounted for in the case statement for the extended<br=
>opcode handling. =A0(b) the implementation is not setting XER[OV] and<br>X=
ER[SO].<br>
<br>Signed-off-by: Tom Musta &lt;<a href=3D"mailto:tommusta@gmail.com">tomm=
usta@gmail.com</a>&gt;<br><br>---<br>=A0arch/powerpc/lib/sstep.c | =A0208 +=
++++++++++++++++++++++++++++++++++++++++-----<br>=A01 files changed, 185 in=
sertions(+), 23 deletions(-)<br>
<br><br>diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c<br=
>index d220b88..a4f343d 100644<br>--- a/arch/powerpc/lib/sstep.c<br>+++ b/a=
rch/powerpc/lib/sstep.c<br>@@ -31,6 +31,13 @@ extern char system_call_commo=
n[];<br>
=A0#define XER_OV 0x40000000U<br>=A0#define XER_CA 0x20000000U<br>=A0<br>+#=
define U32_MSK =A0 =A0 =A0 =A0 0xFFFFFFFF00000000ul<br>+#define L32_MSK =A0=
 =A0 =A0 =A0 0x00000000FFFFFFFFul<br>+#define SGN_32_MSK =A0 =A0 =A00x00000=
00080000000ul<br>+#define SGN_64_MSK =A0 =A0 =A00x8000000000000000ul<br>
+#define SGN_EXT_32(x) =A0 (((x) &amp; SGN_32_MSK) ? ((x) | U32_MSK) : ((x)=
 &amp; L32_MSK))<br>+#define L32(x) =A0 =A0 =A0 =A0 =A0((x) &amp; L32_MSK)<=
br>+<br>=A0#ifdef CONFIG_PPC_FPU<br>=A0/*<br>=A0 * Functions in ldstfp.S<br=
>@@ -467,6 +474,13 @@ static int __kprobes do_vsx_store(int rn, int (*func)=
(int, unsigned long),<br>
=A0 &quot;.previous&quot; \<br>=A0 : &quot;=3Dr&quot; (err) \<br>=A0 : &quo=
t;r&quot; (addr), &quot;i&quot; (-EFAULT), &quot;0&quot; (err))<br>+static =
void __kprobes set_xer_ov(struct pt_regs *regs, int ov)<br>+{<br>+ if (ov)<=
br>+ regs-&gt;xer |=3D (XER_SO | XER_OV);<br>
+ else<br>+ regs-&gt;xer &amp;=3D ~XER_OV;<br>+}<br>=A0<br>=A0static void _=
_kprobes set_cr0(struct pt_regs *regs, int rd)<br>=A0{<br>@@ -487,7 +501,7 =
@@ static void __kprobes set_cr0(struct pt_regs *regs, int rd)<br>=A0<br>=
=A0static void __kprobes add_with_carry(struct pt_regs *regs, int rd,<br>
=A0 =A0 =A0 unsigned long val1, unsigned long val2,<br>- =A0 =A0 unsigned l=
ong carry_in)<br>+ =A0 =A0 unsigned long carry_in, int oe)<br>=A0{<br>=A0 u=
nsigned long val =3D val1 + val2;<br>=A0<br>@@ -504,6 +518,13 @@ static voi=
d __kprobes add_with_carry(struct pt_regs *regs, int rd,<br>
=A0 regs-&gt;xer |=3D XER_CA;<br>=A0 else<br>=A0 regs-&gt;xer &amp;=3D ~XER=
_CA;<br>+ if (oe) {<br>+ unsigned long m =3D ((regs-&gt;msr &amp; MSR_64BIT=
) =3D=3D 0) ?<br>+ SGN_32_MSK : SGN_64_MSK;<br>+ int ov =3D ((val1 &amp; m)=
 =3D=3D (val2 &amp; m)) &amp;&amp;<br>
+ ((val1 &amp; m) !=3D (val &amp; m));<br>+ set_xer_ov(regs, ov);<br>+ }<br=
>=A0}<br>=A0<br>=A0static void __kprobes do_cmp_signed(struct pt_regs *regs=
, long v1, long v2,<br>@@ -552,7 +573,7 @@ static void __kprobes do_cmp_uns=
igned(struct pt_regs *regs, unsigned long v1,<br>
=A0#define DATA32(x) (x)<br>=A0#endif<br>=A0#define ROTATE(x, n) ((n) ? (((=
x) &lt;&lt; (n)) | ((x) &gt;&gt; (8 * sizeof(long) - (n)))) : (x))<br>-<br>=
+#define OE(instr) =A0 =A0 =A0 (((instr) &gt;&gt; (31-21)) &amp; 1)<br>=A0/=
*<br>=A0 * Emulate instructions that cause a transfer of control,<br>
=A0 * loads and stores, and a few other instructions.<br>@@ -693,7 +714,7 @=
@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)<br>=
=A0<br>=A0 case 8: /* subfic */<br>=A0 imm =3D (short) instr;<br>- add_with=
_carry(regs, rd, ~regs-&gt;gpr[ra], imm, 1);<br>
+ add_with_carry(regs, rd, ~regs-&gt;gpr[ra], imm, 1, 0);<br>=A0 goto instr=
_done;<br>=A0<br>=A0 case 10: /* cmpli */<br>@@ -718,12 +739,12 @@ int __kp=
robes emulate_step(struct pt_regs *regs, unsigned int instr)<br>=A0<br>=A0 =
case 12: /* addic */<br>
=A0 imm =3D (short) instr;<br>- add_with_carry(regs, rd, regs-&gt;gpr[ra], =
imm, 0);<br>+ add_with_carry(regs, rd, regs-&gt;gpr[ra], imm, 0, 0);<br>=A0=
 goto instr_done;<br>=A0<br>=A0 case 13: /* addic. */<br>=A0 imm =3D (short=
) instr;<br>
- add_with_carry(regs, rd, regs-&gt;gpr[ra], imm, 0);<br>+ add_with_carry(r=
egs, rd, regs-&gt;gpr[ra], imm, 0, 0);<br>=A0 set_cr0(regs, rd);<br>=A0 got=
o instr_done;<br>=A0<br>@@ -944,8 +965,9 @@ int __kprobes emulate_step(stru=
ct pt_regs *regs, unsigned int instr)<br>
=A0 * Arithmetic instructions<br>=A0 */<br>=A0 case 8: /* subfc */<br>+ cas=
e 520: /* subfco */<br>=A0 add_with_carry(regs, rd, ~regs-&gt;gpr[ra],<br>-=
 =A0 =A0 =A0 regs-&gt;gpr[rb], 1);<br>+ =A0 =A0 =A0 regs-&gt;gpr[rb], 1, OE=
(instr));<br>=A0 goto arith_done;<br>
=A0#ifdef __powerpc64__<br>=A0 case 9: /* mulhdu */<br>@@ -954,8 +976,9 @@ =
int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)<br>=A0=
 goto arith_done;<br>=A0#endif<br>=A0 case 10: /* addc */<br>+ case 522: =
=A0 =A0 =A0 /* addco */<br>
=A0 add_with_carry(regs, rd, regs-&gt;gpr[ra],<br>- =A0 =A0 =A0 regs-&gt;gp=
r[rb], 0);<br>+ =A0 =A0 =A0 regs-&gt;gpr[rb], 0, OE(instr));<br>=A0 goto ar=
ith_done;<br>=A0<br>=A0 case 11: /* mulhwu */<br>@@ -964,7 +987,19 @@ int _=
_kprobes emulate_step(struct pt_regs *regs, unsigned int instr)<br>
=A0 goto arith_done;<br>=A0<br>=A0 case 40: /* subf */<br>- regs-&gt;gpr[rd=
] =3D regs-&gt;gpr[rb] - regs-&gt;gpr[ra];<br>+ case 552: /* subfo */<br>+ =
val =3D regs-&gt;gpr[rb] - regs-&gt;gpr[ra];<br>+ if (OE(instr)) { /* subfo=
 */<br>
+ unsigned long m =3D<br>+ ((regs-&gt;msr &amp; MSR_64BIT) =3D=3D 0) ?<br>+=
 SGN_32_MSK : SGN_64_MSK;<br>+ int ov =3D<br>+ ((~regs-&gt;gpr[ra] &amp; m)=
 =3D=3D<br>+ (regs-&gt;gpr[rb] &amp; m)) &amp;&amp;<br>+ ((regs-&gt;gpr[rb]=
 &amp; m) !=3D (val &amp; m));<br>
+ set_xer_ov(regs, ov);<br>+ }<br>+ regs-&gt;gpr[rd] =3D val;<br>=A0 goto a=
rith_done;<br>=A0#ifdef __powerpc64__<br>=A0 case 73: /* mulhd */<br>@@ -97=
8,69 +1013,196 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned=
 int instr)<br>
=A0 goto arith_done;<br>=A0<br>=A0 case 104: /* neg */<br>+ case 616: /* ne=
go */<br>=A0 regs-&gt;gpr[rd] =3D -regs-&gt;gpr[ra];<br>+ if (OE(instr)) { =
/* nego */<br>+ int ov =3D (regs-&gt;msr &amp; MSR_64BIT) ?<br>+ (regs-&gt;=
gpr[rd] =3D=3D 0x8000000000000000l) :<br>
+ (regs-&gt;gpr[rd] =3D=3D 0x80000000l);<br>+ set_xer_ov(regs, ov);<br>+ }<=
br>=A0 goto arith_done;<br>=A0<br>=A0 case 136: /* subfe */<br>+ case 648: =
/* subfeo */<br>=A0 add_with_carry(regs, rd, ~regs-&gt;gpr[ra], regs-&gt;gp=
r[rb],<br>
- =A0 =A0 =A0 regs-&gt;xer &amp; XER_CA);<br>+ =A0 =A0 =A0 regs-&gt;xer &am=
p; XER_CA, OE(instr));<br>=A0 goto arith_done;<br>=A0<br>=A0 case 138: /* a=
dde */<br>+ case 650: /* addeo */<br>=A0 add_with_carry(regs, rd, regs-&gt;=
gpr[ra], regs-&gt;gpr[rb],<br>
- =A0 =A0 =A0 regs-&gt;xer &amp; XER_CA);<br>+ =A0 =A0 =A0 regs-&gt;xer &am=
p; XER_CA, OE(instr));<br>=A0 goto arith_done;<br>=A0<br>=A0 case 200: /* s=
ubfze */<br>+ case 712: /* subfzeo */<br>=A0 add_with_carry(regs, rd, ~regs=
-&gt;gpr[ra], 0L,<br>
- =A0 =A0 =A0 regs-&gt;xer &amp; XER_CA);<br>+ =A0 =A0 =A0 regs-&gt;xer &am=
p; XER_CA, OE(instr));<br>=A0 goto arith_done;<br>=A0<br>=A0 case 202: /* a=
ddze */<br>+ case 714: /* addzeo */<br>=A0 add_with_carry(regs, rd, regs-&g=
t;gpr[ra], 0L,<br>
- =A0 =A0 =A0 regs-&gt;xer &amp; XER_CA);<br>+ =A0 =A0 =A0 regs-&gt;xer &am=
p; XER_CA, OE(instr));<br>=A0 goto arith_done;<br>=A0<br>=A0 case 232: /* s=
ubfme */<br>+ case 744: /* subfmeo */<br>=A0 add_with_carry(regs, rd, ~regs=
-&gt;gpr[ra], -1L,<br>
- =A0 =A0 =A0 regs-&gt;xer &amp; XER_CA);<br>+ =A0 =A0 =A0 regs-&gt;xer &am=
p; XER_CA, OE(instr));<br>=A0 goto arith_done;<br>=A0#ifdef __powerpc64__<b=
r>=A0 case 233: /* mulld */<br>- regs-&gt;gpr[rd] =3D regs-&gt;gpr[ra] * re=
gs-&gt;gpr[rb];<br>
+ case 745: =A0 =A0 =A0 /* mulldo */<br>+ {<br>+ unsigned long xer_copy;<br=
>+ asm(&quot;mulldo %0,%2,%3;&quot;<br>+ &quot;mfxer %1&quot; :<br>+ &quot;=
=3Dr&quot; (regs-&gt;gpr[rd]), &quot;=3Dr&quot; (xer_copy) :<br>+ &quot;r&q=
uot; (regs-&gt;gpr[ra]), &quot;r&quot; (regs-&gt;gpr[rb]));<br>
+ if (OE(instr))<br>+ set_xer_ov(regs, (xer_copy &amp; XER_OV) !=3D 0);<br>=
=A0 goto arith_done;<br>+ }<br>=A0#endif<br>=A0 case 234: /* addme */<br>+ =
case 746: /* addme0 */<br>=A0 add_with_carry(regs, rd, regs-&gt;gpr[ra], -1=
L,<br>
- =A0 =A0 =A0 regs-&gt;xer &amp; XER_CA);<br>+ =A0 =A0 =A0 regs-&gt;xer &am=
p; XER_CA, OE(instr));<br>=A0 goto arith_done;<br>=A0<br>=A0 case 235: /* m=
ullw */<br>- regs-&gt;gpr[rd] =3D (unsigned int) regs-&gt;gpr[ra] *<br>- (u=
nsigned int) regs-&gt;gpr[rb];<br>
+ case 747: /* mullwo */<br>+ regs-&gt;gpr[rd] =3D SGN_EXT_32(regs-&gt;gpr[=
ra]) *<br>+ SGN_EXT_32(regs-&gt;gpr[rb]);<br>+ if (OE(instr)) { /* mullwo *=
/<br>+ int ov =3D 0;<br>+ if ((regs-&gt;gpr[rd] &amp; U32_MSK) =3D=3D 0)<br=
>+ ov =3D (regs-&gt;gpr[rd] &amp; SGN_32_MSK) !=3D 0;<br>
+ else if ((regs-&gt;gpr[rd] &amp; U32_MSK) =3D=3D U32_MSK)<br>+ ov =3D (re=
gs-&gt;gpr[rd] &amp; SGN_32_MSK) =3D=3D 0;<br>+ else<br>+ ov =3D 1;<br>+ se=
t_xer_ov(regs, ov);<br>+ }<br>=A0 goto arith_done;<br>=A0<br>=A0 case 266: =
/* add */<br>- regs-&gt;gpr[rd] =3D regs-&gt;gpr[ra] + regs-&gt;gpr[rb];<br=
>
+ case 778: /* addo */<br>+ val =3D regs-&gt;gpr[ra] + regs-&gt;gpr[rb];<br=
>+ if (OE(instr)) { /* addo */<br>+ unsigned long m =3D ((regs-&gt;msr &amp=
; MSR_64BIT) =3D=3D 0)<br>+ ? SGN_32_MSK : SGN_64_MSK;<br>+ int ov =3D ((re=
gs-&gt;gpr[ra] &amp; m) =3D=3D<br>
+ (regs-&gt;gpr[rb] &amp; m)) &amp;&amp;<br>+ ((regs-&gt;gpr[ra] &amp; m) !=
=3D (val &amp; m));<br>+ set_xer_ov(regs, ov);<br>+ }<br>+ regs-&gt;gpr[rd]=
 =3D val;<br>+ goto arith_done;<br>+#ifdef __powerpc64__<br>+ case 393: /* =
divdeu */<br>
+ case 905: =A0 =A0 =A0 /* divdeuo */<br>+ {<br>+ unsigned long xer_copy;<b=
r>+ asm(&quot;divdeuo %0,%2,%3;&quot;<br>+ &quot;mfxer %1&quot; :<br>+ &quo=
t;=3Dr&quot; (regs-&gt;gpr[rd]), &quot;=3Dr&quot; (xer_copy) :<br>+ &quot;r=
&quot; (regs-&gt;gpr[ra]), &quot;r&quot; (regs-&gt;gpr[rb]));<br>
+ if (OE(instr))<br>+ set_xer_ov(regs, (xer_copy &amp; XER_OV) !=3D 0);<br>=
+ goto arith_done;<br>+ }<br>+#endif<br>+ case 395: /* divweu */<br>+ case =
907: /* divweuo */<br>+ val =3D (L32(regs-&gt;gpr[ra]) &lt;&lt; 32) / L32(r=
egs-&gt;gpr[rb]);<br>
+ if (OE(instr)) {<br>+ int ov =3D (L32(regs-&gt;gpr[rb]) =3D=3D 0) ||<br>+=
 ((val &amp; U32_MSK) !=3D 0);<br>+ set_xer_ov(regs, ov);<br>+ }<br>+ regs-=
&gt;gpr[rd] =3D val;<br>+ goto arith_done;<br>+#ifdef __powerpc64__<br>+ ca=
se 425: /* divde */<br>
+ case 937: =A0 =A0 =A0 /* divdeo */<br>+ {<br>+ unsigned long xer_copy;<br=
>+ asm(&quot;divdeo %0,%2,%3;&quot;<br>+ &quot; mfxer %1&quot; :<br>+ &quot=
;=3Dr&quot; (regs-&gt;gpr[rd]), &quot;=3Dr&quot; (xer_copy) :<br>+ &quot;r&=
quot; (regs-&gt;gpr[ra]), &quot;r&quot; (regs-&gt;gpr[rb]));<br>
+ if (OE(instr))<br>+ set_xer_ov(regs, (xer_copy &amp; XER_OV) !=3D 0);<br>=
+ goto arith_done;<br>+ }<br>+#endif<br>+ case 427: /* divwe */<br>+ case 9=
39: /* divweo */<br>+ val =3D ((long int)SGN_EXT_32(regs-&gt;gpr[ra]) &lt;&=
lt; 32) /<br>
+ (long int)SGN_EXT_32(regs-&gt;gpr[rb]);<br>+ if (OE(instr)) {<br>+ int ov=
 =3D (L32(regs-&gt;gpr[rb]) =3D=3D 0) ||<br>+ ((L32(regs-&gt;gpr[ra]) =3D=
=3D SGN_32_MSK) &amp;&amp;<br>+ (L32(regs-&gt;gpr[rb]) =3D=3D L32_MSK));<br=
>+ if ((val &amp; U32_MSK) =3D=3D 0)<br>
+ ov |=3D (val &amp; SGN_32_MSK) !=3D 0;<br>+ else if ((val &amp; U32_MSK) =
=3D=3D U32_MSK)<br>+ ov |=3D (val &amp; SGN_32_MSK) =3D=3D 0;<br>+ else<br>=
+ ov =3D 1;<br>+ set_xer_ov(regs, ov);<br>+ }<br>+ regs-&gt;gpr[rd] =3D val=
;<br>=A0 goto arith_done;<br>
=A0#ifdef __powerpc64__<br>=A0 case 457: /* divdu */<br>- regs-&gt;gpr[rd] =
=3D regs-&gt;gpr[ra] / regs-&gt;gpr[rb];<br>+ case 969: /* divduo */<br>+ v=
al =3D regs-&gt;gpr[ra] / regs-&gt;gpr[rb];<br>+ if (OE(instr)) { /* divduo=
 */<br>
+ int ov =3D (regs-&gt;gpr[rb] =3D=3D 0);<br>+ set_xer_ov(regs, ov);<br>+ }=
<br>+ regs-&gt;gpr[rd] =3D val;<br>=A0 goto arith_done;<br>=A0#endif<br>=A0=
 case 459: /* divwu */<br>- regs-&gt;gpr[rd] =3D (unsigned int) regs-&gt;gp=
r[ra] /<br>+ case 971: /* divwuo */<br>
+ val =3D (unsigned int) regs-&gt;gpr[ra] /<br>=A0 (unsigned int) regs-&gt;=
gpr[rb];<br>+ if (OE(instr)) { /* divwuo */<br>+ int ov =3D (L32(regs-&gt;g=
pr[rb]) =3D=3D 0);<br>+ set_xer_ov(regs, ov);<br>+ }<br>+ regs-&gt;gpr[rd] =
=3D val;<br>
=A0 goto arith_done;<br>=A0#ifdef __powerpc64__<br>=A0 case 489: /* divd */=
<br>- regs-&gt;gpr[rd] =3D (long int) regs-&gt;gpr[ra] /<br>+ case 1001: /*=
 divdo */<br>+ val =3D (long int) regs-&gt;gpr[ra] /<br>=A0 (long int) regs=
-&gt;gpr[rb];<br>
+ if (OE(instr)) { /* divdo */<br>+ int ov =3D (regs-&gt;gpr[rb] =3D=3D 0) =
||<br>+ ((regs-&gt;gpr[ra] =3D=3D SGN_64_MSK) &amp;&amp;<br>+ (regs-&gt;gpr=
[rb] =3D=3D -1ul));<br>+ set_xer_ov(regs, ov);<br>+ }<br>+ regs-&gt;gpr[rd]=
 =3D val;<br>
=A0 goto arith_done;<br>=A0#endif<br>=A0 case 491: /* divw */<br>- regs-&gt=
;gpr[rd] =3D (int) regs-&gt;gpr[ra] /<br>- (int) regs-&gt;gpr[rb];<br>+ cas=
e 1003: /* divwo */<br>+ val =3D (long int)SGN_EXT_32(regs-&gt;gpr[ra]) /<b=
r>+ (long int)SGN_EXT_32(regs-&gt;gpr[rb]);<br>
+ if (OE(instr)) {<br>+ int ov =3D (L32(regs-&gt;gpr[rb]) =3D=3D 0) ||<br>+=
 ((L32(regs-&gt;gpr[ra]) =3D=3D SGN_32_MSK) &amp;&amp;<br>+ (L32(regs-&gt;g=
pr[rb]) =3D=3D L32_MSK));<br>+ set_xer_ov(regs, ov);<br>+ }<br>+ regs-&gt;g=
pr[rd] =3D val;<br>
=A0 goto arith_done;<br>=A0<br>=A0<br></div>

--047d7bacc7966c908e04e5b87917--
