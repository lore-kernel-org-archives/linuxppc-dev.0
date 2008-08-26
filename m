Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from WA4EHSOBE002.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16]) by ozlabs.org (Postfix) with ESMTP id 7058DDE450
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Aug 2008 02:41:10 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9079A.86DC7B11"
Subject: RE: PPC405EP errata CPU 213 (Incorrect data may be flushed from
	thedata cache)
Date: Tue, 26 Aug 2008 09:41:02 -0700
References: <1219766507.26004.92.camel@localhost>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: "Darcy Watkins" <dwatkins@tranzeo.com>,
	"linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
Message-ID: <20080826164104.A31DA818052@mail1-wa4.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------_=_NextPart_001_01C9079A.86DC7B11
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


arch/powerpc/boot/virtex405-head.S has:

#include "ppc_asm.h"

        .text
        .global _zimage_start
_zimage_start:

        /* PPC errata 213: needed by Virtex-4 FX */
        mfccr0  0
        oris    0,0,0x50000000@h
        mtccr0  0

So, this happens first before anything else.
Without this, the boards that I've used crash pretty quickly, so it may be =
obvious that the status register is set properly.
As a result, you probably need to do it in the boot loader and not in the k=
ernel proper.

Steve

-----Original Message-----
From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org on b=
ehalf of Darcy Watkins
Sent: Tue 8/26/2008 9:01 AM
To: linuxppc-embedded
Subject: PPC405EP errata CPU 213 (Incorrect data may be flushed from thedat=
a cache)
 =

Hello,

The IBM/AMCC errata document recommends setting reserved bits 1 & 3 in
CCR0 as a workaround to PPC405EP errata CPU 213 (Incorrect data may be
flushed from the data cache).  For a start, I just tried hacking in a
few lines of assembly code into...

  arch/powerpc/kernel/head_40x.S

---

Around line #839 ...

	bl	early_init	/* We have to do this with MMU on */

/*
 * Decide what sort of machine this is and initialize the MMU.
 */
	mr	r3,r31
	mr	r4,r30
	mr	r5,r29
	mr	r6,r28
	mr	r7,r27
	bl	machine_init
	bl	MMU_init
/* DLW hack!! - for PPC405EP errata CPU 213 */
	mfspr	r4,SPRN_CCR0
	oris	r4,r4,0x5000
	mtspr	SPRN_CCR0,r4
	isync

/* Go back to running unmapped so we can load up new values
 * and change to using our exception vectors.
 * On the 4xx, all we have to do is invalidate the TLB to clear
 * the old 16M byte TLB mappings.
 */
	lis	r4,2f@h
...

Since I am not a PowerPC assembler guru, does this appear right?

I think that eventually I'd want to create a cpu_setup_40x.S with the
fixup code as part of a setup_cpu_405ep function and then hook this into
cputable.c, but first I want to make sure that the errata workaround is
actually taking effect (and also not being undone by later startup
code).

-- =



Regards,

Darcy

--------------
Darcy L. Watkins - Senior Software Developer
Tranzeo Wireless Technologies, Inc.
19273 Fraser Way, Pitt Meadows, BC, Canada V3Y 2V4
T:604-460-6002 ext:410
http://www.tranzeo.com


_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded




This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.


------_=_NextPart_001_01C9079A.86DC7B11
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Diso-8859-=
1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 6.5.7652.24"=
>
<TITLE>RE: PPC405EP errata CPU 213 (Incorrect data may be flushed from thed=
ata cache)</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>arch/powerpc/boot/virtex405-head.S has:<BR>
<BR>
#include &quot;ppc_asm.h&quot;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .text<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .global _zimage_start<BR>
_zimage_start:<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* PPC errata 213: needed by Vir=
tex-4 FX */<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mfccr0&nbsp; 0<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; oris&nbsp;&nbsp;&nbsp; 0,0,0x500=
00000@h<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mtccr0&nbsp; 0<BR>
<BR>
So, this happens first before anything else.<BR>
Without this, the boards that I've used crash pretty quickly, so it may be =
obvious that the status register is set properly.<BR>
As a result, you probably need to do it in the boot loader and not in the k=
ernel proper.<BR>
<BR>
Steve<BR>
<BR>
-----Original Message-----<BR>
From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org on b=
ehalf of Darcy Watkins<BR>
Sent: Tue 8/26/2008 9:01 AM<BR>
To: linuxppc-embedded<BR>
Subject: PPC405EP errata CPU 213 (Incorrect data may be flushed from thedat=
a cache)<BR>
<BR>
Hello,<BR>
<BR>
The IBM/AMCC errata document recommends setting reserved bits 1 &amp; 3 in<=
BR>
CCR0 as a workaround to PPC405EP errata CPU 213 (Incorrect data may be<BR>
flushed from the data cache).&nbsp; For a start, I just tried hacking in a<=
BR>
few lines of assembly code into...<BR>
<BR>
&nbsp; arch/powerpc/kernel/head_40x.S<BR>
<BR>
---<BR>
<BR>
Around line #839 ...<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 early_init&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* We have to do this with MMU on=
 */<BR>
<BR>
/*<BR>
&nbsp;* Decide what sort of machine this is and initialize the MMU.<BR>
&nbsp;*/<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 r3,r31<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 r4,r30<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 r5,r29<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 r6,r28<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 r7,r27<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 machine_init<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 MMU_init<BR>
/* DLW hack!! - for PPC405EP errata CPU 213 */<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mfspr&nbsp;&nbsp; r4,SPRN_CCR0<B=
R>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; oris&nbsp;&nbsp;&nbsp; r4,r4,0x5=
000<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mtspr&nbsp;&nbsp; SPRN_CCR0,r4<B=
R>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; isync<BR>
<BR>
/* Go back to running unmapped so we can load up new values<BR>
&nbsp;* and change to using our exception vectors.<BR>
&nbsp;* On the 4xx, all we have to do is invalidate the TLB to clear<BR>
&nbsp;* the old 16M byte TLB mappings.<BR>
&nbsp;*/<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lis&nbsp;&nbsp;&nbsp;&nbsp; r4,2=
f@h<BR>
...<BR>
<BR>
Since I am not a PowerPC assembler guru, does this appear right?<BR>
<BR>
I think that eventually I'd want to create a cpu_setup_40x.S with the<BR>
fixup code as part of a setup_cpu_405ep function and then hook this into<BR=
>
cputable.c, but first I want to make sure that the errata workaround is<BR>=

actually taking effect (and also not being undone by later startup<BR>
code).<BR>
<BR>
--<BR>
<BR>
<BR>
Regards,<BR>
<BR>
Darcy<BR>
<BR>
--------------<BR>
Darcy L. Watkins - Senior Software Developer<BR>
Tranzeo Wireless Technologies, Inc.<BR>
19273 Fraser Way, Pitt Meadows, BC, Canada V3Y 2V4<BR>
T:604-460-6002 ext:410<BR>
<A HREF=3D"http://www.tranzeo.com">http://www.tranzeo.com</A><BR>
<BR>
<BR>
_______________________________________________<BR>
Linuxppc-embedded mailing list<BR>
Linuxppc-embedded@ozlabs.org<BR>
<A HREF=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://o=
zlabs.org/mailman/listinfo/linuxppc-embedded</A><BR>
<BR>
<BR>
</FONT>
</P>

<br clear=3Dall> This email and any attachments are intended for the sole u=
se of the named recipient(s) and contain(s) confidential information that m=
ay be proprietary, privileged or copyrighted under applicable law. If you a=
re not the intended recipient, do not read, copy, or forward this email mes=
sage or any attachments. Delete this email message and any attachments imme=
diately.
</BODY>
</HTML>


------_=_NextPart_001_01C9079A.86DC7B11--
