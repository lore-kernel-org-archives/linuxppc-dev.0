Return-Path: <pc.ramachandra@gmail.com>
Received: from mail-ig0-x22d.google.com (mail-ig0-x22d.google.com
 [IPv6:2607:f8b0:4001:c05::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rGGdL4wd4zDqD3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 16:41:42 +1000 (AEST)
Received: by mail-ig0-x22d.google.com with SMTP id fh2so60451851igd.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 May 2016 23:41:42 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 27 May 2016 12:11:39 +0530
Message-ID: <CA+Wf0EG4bOs42kP4OiR3wx+xDrq-yuzUu7BPPL_6Fh-0TL8BLA@mail.gmail.com>
Subject: u-boot.lds file
From: Rama Chandra <pc.ramachandra@gmail.com>
To: eldk@lists.denx.de, linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=14dae9340503f691da0533cd323d
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--14dae9340503f691da0533cd323d
Content-Type: text/plain; charset=UTF-8

Hai,
Hai,
I am using IBM PPC440GX board.In arch/powerpc/cpu/ppc4xx/u-boot.lds i am
usig the below details but MEMORY function failure coming. i am adding the
file .
/*
 * Copyright 2007-2009 Freescale Semiconductor, Inc.
 *
 * SPDX-License-Identifier: GPL-2.0+
 */

#include "config.h" /* CONFIG_BOARDDIR */

#ifndef RESET_VECTOR_ADDRESS
#ifdef CONFIG_RESET_VECTOR_ADDRESS
#define RESET_VECTOR_ADDRESS CONFIG_RESET_VECTOR_ADDRESS
#else
#define RESET_VECTOR_ADDRESS 0xfffffff0
#endif
#endif
MEMORY
{
flash_start  : ORIGIN = 0xfffBC000, LENGTH = 0x42F00
    flash_memory_start : ORIGIN = 0xFFFFF000, LENGTH = 0x0FDF
    reset_init :            ORIGIN = 0xFFFFFFF0, LENGTH = 0x0010
    isram  :            ORIGIN = 0x44780000, LENGTH = 1M
}
OUTPUT_ARCH(powerpc)

PHDRS
{
  text PT_LOAD;
  bss PT_LOAD;
}


SECTIONS
{
#ifdef CONFIG_440
.bootpg 0xfffff000 :
{
arch/powerpc/cpu/ppc4xx/start.o (.bootpg)

/*
* PPC440 board need a board specific object with the
* TLB definitions. This needs to get included right after
* start.o, since the first shadow TLB only covers 4k
* of address space.
*/
CONFIG_BOARDDIR/init.o (.bootpg)
} > flash_memory_start
#endif

.resetvec 0xFFFFFFF0 :
{
KEEP(*(.resetvec))
} > flash_start

.text :
{
__start = .;
arch/powerpc/cpu/ppc4xx/start.o (.text)
CONFIG_BOARDDIR/init.o (.text)
*(.text*)
} > flash_start

. = ALIGN(4);
.data : { *(SORT_BY_ALIGNMENT(.data*)) } > flash_start

. = ALIGN(4);
.rodata : { *(SORT_BY_ALIGNMENT(.rodata*)) } > flash_start

.bss :
{
. = ALIGN(4);
__bss_start = .;
*(.bss*)
. = ALIGN(4);
__bss_end = .;
} > isram
}

-- 
Thanks & Regards,
RamaChandra PC
+918892147159.

--14dae9340503f691da0533cd323d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hai,<div><span style=3D"font-size:12.8px">Hai,</span><div =
style=3D"font-size:12.8px">I am using IBM PPC440GX board.In arch/powerpc/cp=
u/ppc4xx/u-boot.lds i am usig the below details but MEMORY function failure=
 coming. i am adding the file .</div><div style=3D""><div style=3D""><span =
style=3D"font-size:12.8px">/*</span></div><div style=3D""><span style=3D"fo=
nt-size:12.8px">=C2=A0* Copyright 2007-2009 Freescale Semiconductor, Inc.</=
span></div><div style=3D""><span style=3D"font-size:12.8px">=C2=A0*</span><=
/div><div style=3D""><span style=3D"font-size:12.8px">=C2=A0* SPDX-License-=
Identifier:<span class=3D"" style=3D"white-space:pre">	</span>GPL-2.0+</spa=
n></div><div style=3D""><span style=3D"font-size:12.8px">=C2=A0*/</span></d=
iv><div style=3D""><span style=3D"font-size:12.8px"><br></span></div><div s=
tyle=3D""><span style=3D"font-size:12.8px">#include &quot;config.h&quot;<sp=
an class=3D"" style=3D"white-space:pre">	</span>/* CONFIG_BOARDDIR */</span=
></div><div style=3D""><span style=3D"font-size:12.8px"><br></span></div><d=
iv style=3D""><span style=3D"font-size:12.8px">#ifndef RESET_VECTOR_ADDRESS=
</span></div><div style=3D""><span style=3D"font-size:12.8px">#ifdef CONFIG=
_RESET_VECTOR_ADDRESS</span></div><div style=3D""><span style=3D"font-size:=
12.8px">#define RESET_VECTOR_ADDRESS<span class=3D"" style=3D"white-space:p=
re">	</span>CONFIG_RESET_VECTOR_ADDRESS</span></div><div style=3D""><span s=
tyle=3D"font-size:12.8px">#else</span></div><div style=3D""><span style=3D"=
font-size:12.8px">#define RESET_VECTOR_ADDRESS<span class=3D"" style=3D"whi=
te-space:pre">	</span>0xfffffff0</span></div><div style=3D""><span style=3D=
"font-size:12.8px">#endif</span></div><div style=3D""><span style=3D"font-s=
ize:12.8px">#endif</span></div><div style=3D""><span style=3D"font-size:12.=
8px">MEMORY</span></div><div style=3D""><span style=3D"font-size:12.8px">{<=
/span></div><div style=3D""><span style=3D"font-size:12.8px"><span class=3D=
"" style=3D"white-space:pre">	</span>flash_start =C2=A0: ORIGIN =3D 0xfffBC=
000, <span class=3D"" style=3D"white-space:pre">	</span>LENGTH =3D 0x42F00<=
/span></div><div style=3D""><span style=3D"font-size:12.8px">=C2=A0 =C2=A0 =
flash_memory_start : ORIGIN =3D 0xFFFFF000, <span class=3D"" style=3D"white=
-space:pre">	</span>LENGTH =3D 0x0FDF</span></div><div style=3D""><span sty=
le=3D"font-size:12.8px">=C2=A0 =C2=A0 reset_init : =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0ORIGIN =3D 0xFFFFFFF0, LENGTH =3D 0x0010</span></div><div =
style=3D""><span style=3D"font-size:12.8px">=C2=A0 =C2=A0 isram =C2=A0: =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ORIGIN =3D 0x44780000, LENGTH =3D 1M<=
/span></div><div style=3D""><span style=3D"font-size:12.8px">}</span></div>=
<div style=3D""><span style=3D"font-size:12.8px">OUTPUT_ARCH(powerpc)</span=
></div><div style=3D""><span style=3D"font-size:12.8px"><br></span></div><d=
iv style=3D""><span style=3D"font-size:12.8px">PHDRS</span></div><div style=
=3D""><span style=3D"font-size:12.8px">{</span></div><div style=3D""><span =
style=3D"font-size:12.8px">=C2=A0 text PT_LOAD;</span></div><div style=3D""=
><span style=3D"font-size:12.8px">=C2=A0 bss PT_LOAD;</span></div><div styl=
e=3D""><span style=3D"font-size:12.8px">}</span></div><div style=3D""><span=
 style=3D"font-size:12.8px"><br></span></div><div style=3D""><br></div><div=
 style=3D""><span style=3D"font-size:12.8px">SECTIONS</span></div><div styl=
e=3D""><span style=3D"font-size:12.8px">{</span></div><div style=3D""><span=
 style=3D"font-size:12.8px">#ifdef CONFIG_440</span></div><div style=3D""><=
span style=3D"font-size:12.8px"><span class=3D"" style=3D"white-space:pre">=
	</span>.bootpg 0xfffff000 :</span></div><div style=3D""><span style=3D"fon=
t-size:12.8px"><span class=3D"" style=3D"white-space:pre">	</span>{</span><=
/div><div style=3D""><span style=3D"font-size:12.8px"><span class=3D"" styl=
e=3D"white-space:pre">		</span>arch/powerpc/cpu/ppc4xx/start.o<span class=
=3D"" style=3D"white-space:pre">	</span>(.bootpg)</span></div><div style=3D=
""><span style=3D"font-size:12.8px"><br></span></div><div style=3D""><span =
style=3D"font-size:12.8px"><span class=3D"" style=3D"white-space:pre">		</s=
pan>/*</span></div><div style=3D""><span style=3D"font-size:12.8px"><span c=
lass=3D"" style=3D"white-space:pre">		</span> * PPC440 board need a board s=
pecific object with the</span></div><div style=3D""><span style=3D"font-siz=
e:12.8px"><span class=3D"" style=3D"white-space:pre">		</span> * TLB defini=
tions. This needs to get included right after</span></div><div style=3D""><=
span style=3D"font-size:12.8px"><span class=3D"" style=3D"white-space:pre">=
		</span> * start.o, since the first shadow TLB only covers 4k</span></div>=
<div style=3D""><span style=3D"font-size:12.8px"><span class=3D"" style=3D"=
white-space:pre">		</span> * of address space.</span></div><div style=3D"">=
<span style=3D"font-size:12.8px"><span class=3D"" style=3D"white-space:pre"=
>		</span> */</span></div><div style=3D""><span style=3D"font-size:12.8px">=
<span class=3D"" style=3D"white-space:pre">		</span>CONFIG_BOARDDIR/init.o<=
span class=3D"" style=3D"white-space:pre">	</span>(.bootpg)</span></div><di=
v style=3D""><span style=3D"font-size:12.8px"><span class=3D"" style=3D"whi=
te-space:pre">	</span>} &gt; flash_memory_start</span></div><div style=3D""=
><span style=3D"font-size:12.8px">#endif</span></div><div style=3D""><span =
style=3D"font-size:12.8px"><br></span></div><div style=3D""><span style=3D"=
font-size:12.8px"><span class=3D"" style=3D"white-space:pre">	</span>.reset=
vec 0xFFFFFFF0 :</span></div><div style=3D""><span style=3D"font-size:12.8p=
x"><span class=3D"" style=3D"white-space:pre">	</span>{</span></div><div st=
yle=3D""><span style=3D"font-size:12.8px"><span class=3D"" style=3D"white-s=
pace:pre">		</span>KEEP(*(.resetvec))</span></div><div style=3D""><span sty=
le=3D"font-size:12.8px"><span class=3D"" style=3D"white-space:pre">	</span>=
} &gt; flash_start</span></div><div style=3D""><span style=3D"font-size:12.=
8px"><br></span></div><div style=3D""><span style=3D"font-size:12.8px"><spa=
n class=3D"" style=3D"white-space:pre">	</span>.text :</span></div><div sty=
le=3D""><span style=3D"font-size:12.8px"><span class=3D"" style=3D"white-sp=
ace:pre">	</span>{</span></div><div style=3D""><span style=3D"font-size:12.=
8px"><span class=3D"" style=3D"white-space:pre">		</span>__start =3D .;</sp=
an></div><div style=3D""><span style=3D"font-size:12.8px"><span class=3D"" =
style=3D"white-space:pre">		</span>arch/powerpc/cpu/ppc4xx/start.o<span cla=
ss=3D"" style=3D"white-space:pre">	</span>(.text)</span></div><div style=3D=
""><span style=3D"font-size:12.8px"><span class=3D"" style=3D"white-space:p=
re">		</span>CONFIG_BOARDDIR/init.o<span class=3D"" style=3D"white-space:pr=
e">	</span>(.text)</span></div><div style=3D""><span style=3D"font-size:12.=
8px"><span class=3D"" style=3D"white-space:pre">		</span>*(.text*)</span></=
div><div style=3D""><span style=3D"font-size:12.8px"><span class=3D"" style=
=3D"white-space:pre">	</span>} &gt; flash_start</span></div><div style=3D""=
><span style=3D"font-size:12.8px"><br></span></div><div style=3D""><span st=
yle=3D"font-size:12.8px"><span class=3D"" style=3D"white-space:pre">	</span=
>. =3D ALIGN(4);</span></div><div style=3D""><span style=3D"font-size:12.8p=
x"><span class=3D"" style=3D"white-space:pre">	</span>.data : { *(SORT_BY_A=
LIGNMENT(.data*)) } &gt; flash_start</span></div><div style=3D""><span styl=
e=3D"font-size:12.8px"><br></span></div><div style=3D""><span style=3D"font=
-size:12.8px"><span class=3D"" style=3D"white-space:pre">	</span>. =3D ALIG=
N(4);</span></div><div style=3D""><span style=3D"font-size:12.8px"><span cl=
ass=3D"" style=3D"white-space:pre">	</span>.rodata : { *(SORT_BY_ALIGNMENT(=
.rodata*)) } &gt; flash_start</span></div><div style=3D""><span style=3D"fo=
nt-size:12.8px"><br></span></div><div style=3D""><span style=3D"font-size:1=
2.8px"><span class=3D"" style=3D"white-space:pre">	</span>.bss :</span></di=
v><div style=3D""><span style=3D"font-size:12.8px"><span class=3D"" style=
=3D"white-space:pre">	</span>{</span></div><div style=3D""><span style=3D"f=
ont-size:12.8px"><span class=3D"" style=3D"white-space:pre">		</span>. =3D =
ALIGN(4);</span></div><div style=3D""><span style=3D"font-size:12.8px"><spa=
n class=3D"" style=3D"white-space:pre">		</span>__bss_start =3D .;</span></=
div><div style=3D""><span style=3D"font-size:12.8px"><span class=3D"" style=
=3D"white-space:pre">		</span>*(.bss*)</span></div><div style=3D""><span st=
yle=3D"font-size:12.8px"><span class=3D"" style=3D"white-space:pre">		</spa=
n>. =3D ALIGN(4);</span></div><div style=3D""><span style=3D"font-size:12.8=
px"><span class=3D"" style=3D"white-space:pre">		</span>__bss_end =3D .;</s=
pan></div><div style=3D""><span style=3D"font-size:12.8px"><span class=3D""=
 style=3D"white-space:pre">	</span>} &gt; isram</span></div><div style=3D""=
><span style=3D"font-size:12.8px">}</span></div><div style=3D"font-size:12.=
8px"><br></div></div>-- <br><div class=3D"gmail_signature" data-smartmail=
=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div>Thanks &am=
p; Regards,</div><div dir=3D"ltr">RamaChandra PC</div><div><span style=3D"f=
ont-size:12.8px">+918892147159.</span><br></div></div></div></div></div>
</div></div>

--14dae9340503f691da0533cd323d--
