Return-Path: <mmeswani@utep.edu>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C672CA.7FE452AA"
Subject: Information for setting up SMT related parameters on linux 2.6.16 on
	POWER5
Date: Mon, 8 May 2006 12:09:08 -0600
Message-ID: <C26C730943E01145B4F89E37FE0A022002BBC74B@itdsrvmail02.utep.edu>
References: <17498.60066.92373.6527@cargo.ozlabs.ibm.com>
	<445BE729.80903@am.sony.com>
From: "Meswani, Mitesh" <mmeswani@utep.edu>
To: <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>,
	cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C672CA.7FE452AA
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

=20
Hello=20
=20
I am looking to use the SMT related parameters like Snooze delay, HMT =
thread priorities, SMT ON/Off and wanted to know how to invoke and set =
them. I am running Open Suse 10 with 2.6.16.rc4-3-ppc64 kernel on =
eServer p590 2-way POWER5 partition.=20
=20
I noticed the parameters in /sys/devices/system/cpu/cpu#   with the =
following :
=20
mmcr0  online       pmc2  pmc5  smt_snooze_delay
mmcr1  physical_id  pmc3  pmc6  topology
crash_notes  mmcra  pmc1         pmc4  purr

setting the value in online to 0 seems to turn off the logical =
processor, but I am not sure what the others are for and the meaning of =
their hex values?=20
It seems that there is include/asm-ppc64/processor.h  with macros like =
HMT_very_low()  ,  wonder if these can be set on command line since I am =
running unmodified app binaries.=20
=20
=20
=20
Thanks,=20
Mitesh
=20
=20

Mitesh R. Meswani=20
Ph.D. Candidate=20
Research Associate, PLS2 Group
Room 106 F, Department of Computer Science
The University of Texas at El Paso,=20
El Paso, Texas 79968
Tel: 915 747 8012 (O)
Email: mmeswani@utep.edu

________________________________

From: linuxppc-dev-bounces+mmeswani=3Dutep.edu@ozlabs.org on behalf of =
Geoff Levand
Sent: Fri 5/5/2006 6:00 PM
To: Paul Mackerras
Cc: Arnd Bergmann; Levand,Geoffrey; linux-kernel@vger.kernel.org; =
linuxppc-dev@ozlabs.org; Arnd Bergmann; cbe-oss-dev@ozlabs.org
Subject: Re: [PATCH 04/13] cell: remove broken __setup_cpu_be function



Paul Mackerras wrote:
> Arnd Bergmann writes:
>
>>  From: Geoff Levand <geoffrey.levand@am.sony.com>
>>
>> This patch removes the incorrect Cell processor setup routine
>> __setup_cpu_be.  This routine improperly accesses the hypervisor
>> page size configuration at SPR HID6.  The correct behavior is for
>> firmware, or if needed, platform setup code, to set the correct
>> page size.
>
>> -            .cpu_setup              =3D __setup_cpu_be,
>> +            .cpu_setup              =3D __setup_cpu_power4,
>
> That looks a bit dodgy.  Either just remove the contents of
> __setup_cpu_be (leaving only the blr), or define a __setup_cpu_null
> that does nothing, or make the identify_cpu not call the cpu setup
> function if the pointer is NULL.


OK, I set it up with __setup_cpu_null.  An updated patch follows.

It falls out from this that we can replace the do-nothing routines
__setup_cpu_power3 and __setup_cpu_power4 with __setup_cpu_null also.
I'll post a separate patch for consideration.

-Geoff


Replaced the Cell processor specific routine __setup_cpu_be with
a new generic routine __setup_cpu_null.  __setup_cpu_be improperly
accessed the hypervisor page size configuration at SPR HID6.  Correct
behavior is for firmware, or if needed, platform setup code, to set
the correct page size.


Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>


Index: cell--alp--3/arch/powerpc/kernel/cpu_setup_power4.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- cell--alp--3.orig/arch/powerpc/kernel/cpu_setup_power4.S    =
2006-04-26 19:19:25.000000000 -0700
+++ cell--alp--3/arch/powerpc/kernel/cpu_setup_power4.S 2006-05-05 =
15:59:58.000000000 -0700
@@ -76,20 +76,6 @@
 _GLOBAL(__setup_cpu_power4)
        blr

-_GLOBAL(__setup_cpu_be)
-        /* Set large page sizes LP=3D0: 16MB, LP=3D1: 64KB */
-        addi    r3, 0,  0
-        ori     r3, r3, HID6_LB
-        sldi    r3, r3, 32
-        nor     r3, r3, r3
-        mfspr   r4, SPRN_HID6
-        and     r4, r4, r3
-        addi    r3, 0, 0x02000
-        sldi    r3, r3, 32
-        or      r4, r4, r3
-        mtspr   SPRN_HID6, r4
-       blr
-
 _GLOBAL(__setup_cpu_ppc970)
        mfspr   r0,SPRN_HID0
        li      r11,5                   /* clear DOZE and SLEEP */
Index: cell--alp--3/arch/powerpc/kernel/cputable.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- cell--alp--3.orig/arch/powerpc/kernel/cputable.c    2006-04-26 =
19:19:25.000000000 -0700
+++ cell--alp--3/arch/powerpc/kernel/cputable.c 2006-05-05 =
16:29:06.000000000 -0700
@@ -31,9 +31,9 @@
  * and ppc64
  */
 #ifdef CONFIG_PPC64
+extern void __setup_cpu_null(unsigned long offset, struct cpu_spec* =
spec);
 extern void __setup_cpu_power3(unsigned long offset, struct cpu_spec* =
spec);
 extern void __setup_cpu_power4(unsigned long offset, struct cpu_spec* =
spec);
-extern void __setup_cpu_be(unsigned long offset, struct cpu_spec* =
spec);
 #else
 extern void __setup_cpu_603(unsigned long offset, struct cpu_spec* =
spec);
 extern void __setup_cpu_604(unsigned long offset, struct cpu_spec* =
spec);
@@ -273,7 +273,7 @@
                        PPC_FEATURE_SMT,
                .icache_bsize           =3D 128,
                .dcache_bsize           =3D 128,
-               .cpu_setup              =3D __setup_cpu_be,
+               .cpu_setup              =3D __setup_cpu_null,
                .platform               =3D "ppc-cell-be",
        },
        {       /* default match */
Index: cell--alp--3/arch/powerpc/kernel/misc_64.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- cell--alp--3.orig/arch/powerpc/kernel/misc_64.S     2006-04-26 =
19:19:25.000000000 -0700
+++ cell--alp--3/arch/powerpc/kernel/misc_64.S  2006-05-05 =
16:04:59.000000000 -0700
@@ -768,6 +768,9 @@

 #endif /* CONFIG_ALTIVEC */

+_GLOBAL(__setup_cpu_null)
+       blr
+
 _GLOBAL(__setup_cpu_power3)
        blr

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev



------_=_NextPart_001_01C672CA.7FE452AA
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">=0A=
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">=0A=
<HTML>=0A=
<HEAD>=0A=
=0A=
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">=0A=
<TITLE>Re: [PATCH 04/13] cell: remove broken __setup_cpu_be =
function</TITLE>=0A=
</HEAD>=0A=
<BODY>=0A=
<DIV id=3DidOWAReplyText4852 dir=3Dltr>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 =
size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2>Hello =
</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>I am looking to use the SMT =
related =0A=
parameters like Snooze delay, HMT thread priorities, SMT ON/Off and =
wanted to =0A=
know how to invoke and set them. I am running Open Suse 10 with =0A=
2.6.16.rc4-3-ppc64 kernel on eServer p590 2-way POWER5 partition. =
</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>I noticed the parameters in =0A=
/sys/devices/system/cpu/cpu#&nbsp;&nbsp; with the following =
:</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr>mmcr0&nbsp; online&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
pmc2&nbsp; =0A=
pmc5&nbsp; smt_snooze_delay<BR>mmcr1&nbsp; physical_id&nbsp; pmc3&nbsp; =0A=
pmc6&nbsp; topology<BR>crash_notes&nbsp; mmcra&nbsp; =0A=
pmc1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pmc4&nbsp; =0A=
purr<BR></DIV></DIV>=0A=
<DIV id=3DidSignature26272 dir=3Dltr><FONT face=3DArial color=3D#000000 =
size=3D2>=0A=
<DIV>setting the value in online to 0 seems to turn off the logical =
processor, =0A=
but I am not sure what the others are for and the meaning of their hex =
values? =0A=
</DIV>=0A=
<DIV>It seems that there is include/asm-ppc64/processor.h&nbsp; with =
macros =0A=
like&nbsp;HMT_very_low()&nbsp;&nbsp;, &nbsp;wonder if these can be set =
on =0A=
command line since I am running unmodified app binaries. </DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV>Thanks, </DIV>=0A=
<DIV>Mitesh</DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV><BR>Mitesh R.&nbsp;Meswani <BR>Ph.D. Candidate </DIV>=0A=
<DIV>Research Associate, PLS2 Group</DIV>=0A=
<DIV>Room 106 F, Department of Computer Science</DIV>=0A=
<DIV>The University of Texas at El Paso, </DIV>=0A=
<DIV>El Paso, Texas 79968<BR>Tel: 915 747 8012 (O)</DIV>=0A=
<DIV>Email: mmeswani@utep.edu</FONT></DIV></DIV>=0A=
<DIV dir=3Dltr><BR>=0A=
<HR tabIndex=3D-1>=0A=
<FONT face=3DTahoma size=3D2><B>From:</B> =0A=
linuxppc-dev-bounces+mmeswani=3Dutep.edu@ozlabs.org on behalf of Geoff =0A=
Levand<BR><B>Sent:</B> Fri 5/5/2006 6:00 PM<BR><B>To:</B> Paul =0A=
Mackerras<BR><B>Cc:</B> Arnd Bergmann; Levand,Geoffrey; =0A=
linux-kernel@vger.kernel.org; linuxppc-dev@ozlabs.org; Arnd Bergmann; =0A=
cbe-oss-dev@ozlabs.org<BR><B>Subject:</B> Re: [PATCH 04/13] cell: remove =
broken =0A=
__setup_cpu_be function<BR></FONT><BR></DIV>=0A=
<DIV>=0A=
<P><FONT size=3D2>Paul Mackerras wrote:<BR>&gt; Arnd Bergmann =0A=
writes:<BR>&gt;<BR>&gt;&gt;&nbsp; From: Geoff Levand =0A=
&lt;geoffrey.levand@am.sony.com&gt;<BR>&gt;&gt;<BR>&gt;&gt; This patch =
removes =0A=
the incorrect Cell processor setup routine<BR>&gt;&gt; =
__setup_cpu_be.&nbsp; =0A=
This routine improperly accesses the hypervisor<BR>&gt;&gt; page size =0A=
configuration at SPR HID6.&nbsp; The correct behavior is for<BR>&gt;&gt; =0A=
firmware, or if needed, platform setup code, to set the =
correct<BR>&gt;&gt; page =0A=
size.<BR>&gt;<BR>&gt;&gt; -&nbsp;&nbsp;&nbsp; =0A=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
.cpu_setup&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D =
__setup_cpu_be,<BR>&gt;&gt; =0A=
+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
.cpu_setup&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D =
__setup_cpu_power4,<BR>&gt;<BR>&gt; =0A=
That looks a bit dodgy.&nbsp; Either just remove the contents of<BR>&gt; =0A=
__setup_cpu_be (leaving only the blr), or define a =
__setup_cpu_null<BR>&gt; that =0A=
does nothing, or make the identify_cpu not call the cpu setup<BR>&gt; =
function =0A=
if the pointer is NULL.<BR><BR><BR>OK, I set it up with =
__setup_cpu_null.&nbsp; =0A=
An updated patch follows.<BR><BR>It falls out from this that we can =
replace the =0A=
do-nothing routines<BR>__setup_cpu_power3 and __setup_cpu_power4 with =0A=
__setup_cpu_null also.<BR>I'll post a separate patch for =0A=
consideration.<BR><BR>-Geoff<BR><BR><BR>Replaced the Cell processor =
specific =0A=
routine __setup_cpu_be with<BR>a new generic routine =
__setup_cpu_null.&nbsp; =0A=
__setup_cpu_be improperly<BR>accessed the hypervisor page size =
configuration at =0A=
SPR HID6.&nbsp; Correct<BR>behavior is for firmware, or if needed, =
platform =0A=
setup code, to set<BR>the correct page size.<BR><BR><BR>Signed-off-by: =
Geoff =0A=
Levand &lt;geoffrey.levand@am.sony.com&gt;<BR><BR><BR>Index: =0A=
cell--alp--3/arch/powerpc/kernel/cpu_setup_power4.S<BR>=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<BR>--- =0A=
cell--alp--3.orig/arch/powerpc/kernel/cpu_setup_power4.S&nbsp;&nbsp;&nbsp=
; =0A=
2006-04-26 19:19:25.000000000 -0700<BR>+++ =0A=
cell--alp--3/arch/powerpc/kernel/cpu_setup_power4.S 2006-05-05 =0A=
15:59:58.000000000 -0700<BR>@@ -76,20 +76,6 =0A=
@@<BR>&nbsp;_GLOBAL(__setup_cpu_power4)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; =0A=
blr<BR><BR>-_GLOBAL(__setup_cpu_be)<BR>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; =0A=
/* Set large page sizes LP=3D0: 16MB, LP=3D1: 64KB =0A=
*/<BR>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addi&nbsp;&nbsp;&nbsp; =
r3, =0A=
0,&nbsp; 0<BR>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
ori&nbsp;&nbsp;&nbsp;&nbsp; r3, r3, =0A=
HID6_LB<BR>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
sldi&nbsp;&nbsp;&nbsp; =0A=
r3, r3, 32<BR>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
nor&nbsp;&nbsp;&nbsp;&nbsp; r3, r3, =0A=
r3<BR>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mfspr&nbsp;&nbsp; r4, =0A=
SPRN_HID6<BR>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
and&nbsp;&nbsp;&nbsp;&nbsp; r4, r4, =0A=
r3<BR>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addi&nbsp;&nbsp;&nbsp; =
r3, 0, =0A=
0x02000<BR>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
sldi&nbsp;&nbsp;&nbsp; =0A=
r3, r3, 32<BR>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
or&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r4, r4, =0A=
r3<BR>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mtspr&nbsp;&nbsp; =
SPRN_HID6, =0A=
r4<BR>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
blr<BR>-<BR>&nbsp;_GLOBAL(__setup_cpu_ppc970)<BR>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =0A=
mfspr&nbsp;&nbsp; =
r0,SPRN_HID0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
li&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r11,5&nbsp;&nbsp; =0A=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* clear DOZE and SLEEP =
*/<BR>Index: =0A=
cell--alp--3/arch/powerpc/kernel/cputable.c<BR>=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<BR>--- =0A=
cell--alp--3.orig/arch/powerpc/kernel/cputable.c&nbsp;&nbsp;&nbsp; =
2006-04-26 =0A=
19:19:25.000000000 -0700<BR>+++ =
cell--alp--3/arch/powerpc/kernel/cputable.c =0A=
2006-05-05 16:29:06.000000000 -0700<BR>@@ -31,9 +31,9 @@<BR>&nbsp; * and =0A=
ppc64<BR>&nbsp; */<BR>&nbsp;#ifdef CONFIG_PPC64<BR>+extern void =0A=
__setup_cpu_null(unsigned long offset, struct cpu_spec* =
spec);<BR>&nbsp;extern =0A=
void __setup_cpu_power3(unsigned long offset, struct cpu_spec* =0A=
spec);<BR>&nbsp;extern void __setup_cpu_power4(unsigned long offset, =
struct =0A=
cpu_spec* spec);<BR>-extern void __setup_cpu_be(unsigned long offset, =
struct =0A=
cpu_spec* spec);<BR>&nbsp;#else<BR>&nbsp;extern void =
__setup_cpu_603(unsigned =0A=
long offset, struct cpu_spec* spec);<BR>&nbsp;extern void =0A=
__setup_cpu_604(unsigned long offset, struct cpu_spec* spec);<BR>@@ =
-273,7 =0A=
+273,7 @@<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
PPC_FEATURE_SMT,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .icache_bsize&nbsp;&nbsp; =0A=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D =0A=
128,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dcache_bsize&nbsp;&nbsp; =0A=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D =0A=
128,<BR>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
.cpu_setup&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D =0A=
__setup_cpu_be,<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
.cpu_setup&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D =0A=
__setup_cpu_null,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
.platform&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D =0A=
"ppc-cell-be",<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
},<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
{&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* default match */<BR>Index: =0A=
cell--alp--3/arch/powerpc/kernel/misc_64.S<BR>=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<BR>--- =0A=
cell--alp--3.orig/arch/powerpc/kernel/misc_64.S&nbsp;&nbsp;&nbsp;&nbsp; =0A=
2006-04-26 19:19:25.000000000 -0700<BR>+++ =0A=
cell--alp--3/arch/powerpc/kernel/misc_64.S&nbsp; 2006-05-05 =
16:04:59.000000000 =0A=
-0700<BR>@@ -768,6 +768,9 @@<BR><BR>&nbsp;#endif /* CONFIG_ALTIVEC =0A=
*/<BR><BR>+_GLOBAL(__setup_cpu_null)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =0A=
blr<BR>+<BR>&nbsp;_GLOBAL(__setup_cpu_power3)<BR>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =0A=
blr<BR><BR>_______________________________________________<BR>Linuxppc-de=
v =0A=
mailing list<BR>Linuxppc-dev@ozlabs.org<BR><A =0A=
href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-dev">https://ozlabs.=
org/mailman/listinfo/linuxppc-dev</A><BR></FONT></P></DIV>=0A=
=0A=
</BODY>=0A=
</HTML>
------_=_NextPart_001_01C672CA.7FE452AA--
