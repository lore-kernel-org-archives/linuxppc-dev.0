Return-Path: <hongwoo7@gmail.com>
Received: from mail-vw0-f188.google.com (mail-vw0-f188.google.com
	[209.85.212.188])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 106BFB7B68
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Sep 2009 10:25:35 +1000 (EST)
Received: by vws26 with SMTP id 26so472804vws.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 01 Sep 2009 17:25:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A9D5A99.5030101@am.sony.com>
References: <5e2889710909010358v907022cs708dfc0dd3ed7fd0@mail.gmail.com>
	<4A9D5A99.5030101@am.sony.com>
Date: Wed, 2 Sep 2009 09:25:33 +0900
Message-ID: <5e2889710909011725t275dcdc8oa8be58b6e32e51f4@mail.gmail.com>
Subject: Re: Question about linux boot procedure (head_64.S)
From: Lee HongWoo <hongwoo7@gmail.com>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Content-Type: multipart/alternative; boundary=00c09f8de08f1f952c04728d4e10
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--00c09f8de08f1f952c04728d4e10
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Sep 2, 2009 at 2:32 AM, Geoff Levand <geoffrey.levand@am.sony.com>wrote:

> On 09/01/2009 03:58 AM, Lee HongWoo wrote:
> > __start  (in head_64.S)
> >   ---> __start_initialization_multiplatform (in head_64.S)
> >     ---> __boot_from_prom (in head_64.S)
> >        ---> prom_init ( in prom_init.c)
> >          ---> __start ???
> >
> > And I don't understand where __start is called, because I can find
> __start
> > only in head_64.S.
> > If it calls __start in head_64.S, it's a recursive call.
> >
> > Can anybody explain about this precedure ?
>
> In the general case, __start is the entry point of the kernel.
> It is where the bootloader or boot wrapper program jumps to
> when it transfers control to the kernel.
>
> -Geoff
>
>
Thanks Geoff,

I believe __start is the entry point of the kernel in this case.
And the entry point is __GLOBAL(__start) in the head_64.S.

What I asked is where or what __start is called in the prom_init.c
__start(hdr, KERNELBASE + offset, 0);
Below is the simple function call flow of linux kernel boot procedure.

file : head_64.S

_GLOBAL(__start)
        /* NOP this out unconditionally */
BEGIN_FTR_SECTION
        b       .__start_initialization_multiplatform
END_FTR_SECTION(0, 1)

....

_GLOBAL(__start_initialization_multiplatform)
        /*
         * Are we booted from a PROM Of-type client-interface ?
         */
        cmpldi  cr0,r5,0
        bne     .__boot_from_prom               /* yes -> prom */

....

_STATIC(__boot_from_prom)
        /* Save parameters */
        mr      r31,r3
        mr      r30,r4
        mr      r29,r5
        mr      r28,r6
        mr      r27,r7

        /*
         * Align the stack to 16-byte boundary
         * Depending on the size and layout of the ELF sections in the
initial
         * boot binary, the stack pointer will be unalignet on PowerMac
         */
        rldicr  r1,r1,0,59

        /* Make sure we are running in 64 bits mode */
        bl      .enable_64b_mode

        /* put a relocation offset into r3 */
        bl      .reloc_offset

        LOAD_REG_IMMEDIATE(r2,__toc_start)
        addi    r2,r2,0x4000
        addi    r2,r2,0x4000

        /* Relocate the TOC from a virt addr to a real addr */
        add     r2,r2,r3

        /* Restore parameters */
        mr      r3,r31
        mr      r4,r30
        mr      r5,r29
        mr      r6,r28
        mr      r7,r27

        /* Do all of the interaction with OF client interface */
        bl      .prom_init
        /* We never return */
        trap


file : prom_init.c

unsigned long __init prom_init(unsigned long r3, unsigned long r4,
                               unsigned long pp,
                               unsigned long r6, unsigned long r7)
{
    ...
    ...
        __start(hdr, KERNELBASE + offset, 0);

        return 0;
}


HongWoo.

--00c09f8de08f1f952c04728d4e10
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Wed, Sep 2, 2009 at 2:32 AM, Geoff Levand <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:geoffrey.levand@am.sony.com">geoffrey.=
levand@am.sony.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt =
0.8ex; padding-left: 1ex;">
<div class=3D"im">On 09/01/2009 03:58 AM, Lee HongWoo wrote:<br>
&gt; __start =A0(in head_64.S)<br>
&gt; =A0 ---&gt; __start_initialization_multiplatform (in head_64.S)<br>
&gt; =A0 =A0 ---&gt; __boot_from_prom (in head_64.S)<br>
&gt; =A0 =A0 =A0 =A0---&gt; prom_init ( in prom_init.c)<br>
&gt; =A0 =A0 =A0 =A0 =A0---&gt; __start ???<br>
&gt;<br>
&gt; And I don&#39;t understand where __start is called, because I can find=
 __start<br>
&gt; only in head_64.S.<br>
&gt; If it calls __start in head_64.S, it&#39;s a recursive call.<br>
&gt;<br>
&gt; Can anybody explain about this precedure ?<br>
<br>
</div>In the general case, __start is the entry point of the kernel.<br>
It is where the bootloader or boot wrapper program jumps to<br>
when it transfers control to the kernel.<br>
<font color=3D"#888888"><br>
-Geoff<br>
<br>
</font></blockquote></div><br>Thanks Geoff, <br><br>I believe __start is th=
e entry point of the kernel in this case. <br>And the entry point is __GLOB=
AL(__start) in the head_64.S. <br><br>What I asked is where or what __start=
 is called in the prom_init.c __start(hdr, KERNELBASE + offset, 0); <br>
Below is the simple function call flow of linux kernel boot procedure. <br>=
<br>file : head_64.S <br><br>_GLOBAL(__start)<br>=A0=A0=A0=A0=A0=A0=A0 /* N=
OP this out unconditionally */<br>BEGIN_FTR_SECTION<br>=A0=A0=A0=A0=A0=A0=
=A0 b=A0=A0=A0=A0=A0=A0 .__start_initialization_multiplatform<br>
END_FTR_SECTION(0, 1)<br><br>.... <br><br>_GLOBAL(__start_initialization_mu=
ltiplatform)<br>=A0=A0=A0=A0=A0=A0=A0 /*<br>=A0=A0=A0=A0=A0=A0=A0=A0 * Are =
we booted from a PROM Of-type client-interface ?<br>=A0=A0=A0=A0=A0=A0=A0=
=A0 */<br>=A0=A0=A0=A0=A0=A0=A0 cmpldi=A0 cr0,r5,0<br>=A0=A0=A0=A0=A0=A0=A0=
 bne=A0=A0=A0=A0 .__boot_from_prom=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 /* yes -&gt; prom */<br>
<br>.... <br><br>_STATIC(__boot_from_prom)<br>=A0=A0=A0=A0=A0=A0=A0 /* Save=
 parameters */<br>=A0=A0=A0=A0=A0=A0=A0 mr=A0=A0=A0=A0=A0 r31,r3<br>=A0=A0=
=A0=A0=A0=A0=A0 mr=A0=A0=A0=A0=A0 r30,r4<br>=A0=A0=A0=A0=A0=A0=A0 mr=A0=A0=
=A0=A0=A0 r29,r5<br>=A0=A0=A0=A0=A0=A0=A0 mr=A0=A0=A0=A0=A0 r28,r6<br>=A0=
=A0=A0=A0=A0=A0=A0 mr=A0=A0=A0=A0=A0 r27,r7<br><br>=A0=A0=A0=A0=A0=A0=A0 /*=
<br>
=A0=A0=A0=A0=A0=A0=A0=A0 * Align the stack to 16-byte boundary<br>=A0=A0=A0=
=A0=A0=A0=A0=A0 * Depending on the size and layout of the ELF sections in t=
he initial<br>=A0=A0=A0=A0=A0=A0=A0=A0 * boot binary, the stack pointer wil=
l be unalignet on PowerMac<br>=A0=A0=A0=A0=A0=A0=A0=A0 */<br>
=A0=A0=A0=A0=A0=A0=A0 rldicr=A0 r1,r1,0,59<br><br>=A0=A0=A0=A0=A0=A0=A0 /* =
Make sure we are running in 64 bits mode */<br>=A0=A0=A0=A0=A0=A0=A0 bl=A0=
=A0=A0=A0=A0 .enable_64b_mode<br><br>=A0=A0=A0=A0=A0=A0=A0 /* put a relocat=
ion offset into r3 */<br>=A0=A0=A0=A0=A0=A0=A0 bl=A0=A0=A0=A0=A0 .reloc_off=
set<br><br>=A0=A0=A0=A0=A0=A0=A0 LOAD_REG_IMMEDIATE(r2,__toc_start)<br>
=A0=A0=A0=A0=A0=A0=A0 addi=A0=A0=A0 r2,r2,0x4000<br>=A0=A0=A0=A0=A0=A0=A0 a=
ddi=A0=A0=A0 r2,r2,0x4000<br><br>=A0=A0=A0=A0=A0=A0=A0 /* Relocate the TOC =
from a virt addr to a real addr */<br>=A0=A0=A0=A0=A0=A0=A0 add=A0=A0=A0=A0=
 r2,r2,r3<br><br>=A0=A0=A0=A0=A0=A0=A0 /* Restore parameters */<br>=A0=A0=
=A0=A0=A0=A0=A0 mr=A0=A0=A0=A0=A0 r3,r31<br>
=A0=A0=A0=A0=A0=A0=A0 mr=A0=A0=A0=A0=A0 r4,r30<br>=A0=A0=A0=A0=A0=A0=A0 mr=
=A0=A0=A0=A0=A0 r5,r29<br>=A0=A0=A0=A0=A0=A0=A0 mr=A0=A0=A0=A0=A0 r6,r28<br=
>=A0=A0=A0=A0=A0=A0=A0 mr=A0=A0=A0=A0=A0 r7,r27<br><br>=A0=A0=A0=A0=A0=A0=
=A0 /* Do all of the interaction with OF client interface */<br>=A0=A0=A0=
=A0=A0=A0=A0 bl=A0=A0=A0=A0=A0 .prom_init<br>=A0=A0=A0=A0=A0=A0=A0 /* We ne=
ver return */<br>
=A0=A0=A0=A0=A0=A0=A0 trap<br><br><br>file : prom_init.c <br><br>unsigned l=
ong __init prom_init(unsigned long r3, unsigned long r4,<br>=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 unsigned long pp,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned long r6, unsigned long r7)=
<br>
{<br>=A0=A0=A0 ...<br>=A0=A0=A0 ...<br>=A0=A0=A0=A0=A0=A0=A0 __start(hdr, K=
ERNELBASE + offset, 0);<br><br>=A0=A0=A0=A0=A0=A0=A0 return 0;<br>}<br><br>=
<br>HongWoo. <br><br>

--00c09f8de08f1f952c04728d4e10--
