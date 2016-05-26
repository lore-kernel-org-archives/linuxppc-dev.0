Return-Path: <pc.ramachandra@gmail.com>
Received: from mail-io0-x231.google.com (mail-io0-x231.google.com
 [IPv6:2607:f8b0:4001:c06::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rFnmQ4WLBzDqVL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 May 2016 22:01:10 +1000 (AEST)
Received: by mail-io0-x231.google.com with SMTP id f8so51393697ioe.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 May 2016 05:01:10 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 26 May 2016 17:31:08 +0530
Message-ID: <CA+Wf0EH_c3fPO-W9HU8fSoW3MXquFgEDza5jP0DsyR-0a3xd3g@mail.gmail.com>
Subject: how to change bss section address in u-boot.lds file
From: Rama Chandra <pc.ramachandra@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, eldk@lists.denx.de
Content-Type: multipart/alternative; boundary=94eb2c05c030a5de7e0533bd8b5a
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--94eb2c05c030a5de7e0533bd8b5a
Content-Type: text/plain; charset=UTF-8

Hai,
I am using IBM PPC440GX board.In arch/powerpc/cpu/ppc4xx/u-boot.lds i am
changing the values of resetvector and BSS addresses but it is not changing
Presently i am changed


#if (RESET_VECTOR_ADDRESS == 0xfffffff0)
  . |= 44780000;
#endif
#endif /* CONFIG_SPL */

  __bss_start = .;
  .bss (NOLOAD)       :

Actually Below detalis i am using in MULTI. But those  are not changing in
Uboot.
MEMORY {
    Flash_memory  : ORIGIN = 0xfffBC000, LENGTH = 0x7000
    Flash_memory_start : ORIGIN = 0xFFFFF000, LENGTH = 0x0FDF
    reset_init :            ORIGIN = 0xFFFFFFF0, LENGTH = 0x0010
    ram_main  :            ORIGIN = 0x44780000, LENGTH = 1M
}

DEFAULTS {

    heap_reserve = 32k
    stack_reserve = 32K

}
SECTIONS
{
    .PPC.EMB.sdata0                    ABS : > Flash_memory
    .PPC.EMB.sbss0                            CLEAR ABS : > .
    .vectors :> Flash_memory_start
    .control                   : {*(.control)}       > Flash_memory_start
    .prefetch    : {*(.prefetch)} >  .
    .reset_vec               : {*(.reset_vec)} > reset_init
        .text               : > Flash_memory
    .vletext     : > .
    .syscall     : > .
    .secinfo     : > .
    .rodata     : > .
    .textprefetch     : {*(.textprefetch)} > .
    .sdata2     : > ram_main
    .fixaddr   : > .
    .fixtype : > .

    .sdabase              ALIGN(16) : > ram_main
    .sdata : > ram_main
    .sbss : > .
    .data : > .
    .bss   : > .
    .heap                  ALIGN(16) PAD(heap_reserve)  : > .
    .stack                 ALIGN(16) PAD(stack_reserve) : > .

     INTR_VECTOR_START = ADDR(.vectors);
}

-- 
Thanks & Regards,
RamaChandra PC
+918892147159.

--94eb2c05c030a5de7e0533bd8b5a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hai,<div>I am using IBM PPC440GX board.In arch/powerpc/cpu=
/ppc4xx/u-boot.lds i am changing the values of resetvector and BSS addresse=
s but it is not changing Presently i am changed=C2=A0</div><div><div><br></=
div><div><br></div><div>#if (RESET_VECTOR_ADDRESS =3D=3D 0xfffffff0)</div><=
div>=C2=A0 . |=3D 44780000;</div><div>#endif</div><div>#endif /* CONFIG_SPL=
 */</div><div><br></div><div>=C2=A0 __bss_start =3D .;</div><div>=C2=A0 .bs=
s (NOLOAD) =C2=A0 =C2=A0 =C2=A0 :</div><div><br></div><div>Actually Below d=
etalis i am using in MULTI. But those =C2=A0are not changing in Uboot. =C2=
=A0</div><div><div>MEMORY {</div><div>=C2=A0 =C2=A0 Flash_memory =C2=A0: OR=
IGIN =3D 0xfffBC000, <span class=3D"" style=3D"white-space:pre">	</span>LEN=
GTH =3D 0x7000<br></div><div>=C2=A0 =C2=A0 Flash_memory_start : ORIGIN =3D =
0xFFFFF000, <span class=3D"" style=3D"white-space:pre">	</span>LENGTH =3D 0=
x0FDF</div><div>=C2=A0 =C2=A0 reset_init : =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ORIGIN =3D 0xFFFFFFF0, LENGTH =3D 0x0010</div><div>=C2=A0 =C2=A0 =
ram_main =C2=A0: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ORIGIN =3D 0x4478=
0000, LENGTH =3D 1M</div><div>}<br></div><div><br></div><div>DEFAULTS {</di=
v><div><br></div><div>=C2=A0 =C2=A0 heap_reserve =3D 32k</div><div>=C2=A0 =
=C2=A0 stack_reserve =3D 32K</div><div><br></div><div>}</div><div>SECTIONS<=
br></div><div>{</div><div>=C2=A0 =C2=A0 .PPC.EMB.sdata0 <span class=3D"" st=
yle=3D"white-space:pre">	</span> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<=
span class=3D"" style=3D"white-space:pre">	</span> =C2=A0 =C2=A0<span class=
=3D"" style=3D"white-space:pre">	</span> =C2=A0 =C2=A0ABS : &gt; Flash_memo=
ry</div><div>=C2=A0 =C2=A0 .PPC.EMB.sbss0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CLEAR ABS=
 : &gt; .</div><div>=C2=A0 =C2=A0 .vectors<span class=3D"" style=3D"white-s=
pace:pre">						</span>:&gt; Flash_memory_start</div><div>=C2=A0 =C2=A0 .co=
ntrol =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <span =
class=3D"" style=3D"white-space:pre">		</span> : {*(.control)} =C2=A0 =C2=
=A0 =C2=A0 &gt; Flash_memory_start</div><div>=C2=A0 =C2=A0 .prefetch <span =
class=3D"" style=3D"white-space:pre">			</span> =C2=A0 =C2=A0: {*(.prefetch=
)} <span class=3D"" style=3D"white-space:pre">	</span> &gt; =C2=A0.</div><d=
iv>=C2=A0 =C2=A0 .reset_vec =C2=A0 =C2=A0 =C2=A0<span class=3D"" style=3D"w=
hite-space:pre">		</span> =C2=A0 =C2=A0 =C2=A0 =C2=A0 : {*(.reset_vec)} &gt=
; reset_init</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 .text =C2=A0<span class=
=3D"" style=3D"white-space:pre">			</span> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0<span class=3D"" style=3D"white-space:pre">		</span>: &gt; Flash_=
memory</div><div>=C2=A0 =C2=A0 .vletext <span class=3D"" style=3D"white-spa=
ce:pre">				</span> =C2=A0 =C2=A0<span class=3D"" style=3D"white-space:pre"=
>		</span>: &gt; .</div><div>=C2=A0 =C2=A0 .syscall <span class=3D"" style=
=3D"white-space:pre">				</span> =C2=A0 =C2=A0<span class=3D"" style=3D"whi=
te-space:pre">		</span>: &gt; .</div><div>=C2=A0 =C2=A0 .secinfo <span clas=
s=3D"" style=3D"white-space:pre">				</span> =C2=A0 =C2=A0<span class=3D"" =
style=3D"white-space:pre">		</span>: &gt; .</div><div>=C2=A0 =C2=A0 .rodata=
 <span class=3D"" style=3D"white-space:pre">				</span> =C2=A0 =C2=A0<span =
class=3D"" style=3D"white-space:pre">		</span>: &gt; .</div><div>=C2=A0 =C2=
=A0 .textprefetch <span class=3D"" style=3D"white-space:pre">		</span> =C2=
=A0 =C2=A0 : {*(.textprefetch)} &gt; .</div><div>=C2=A0 =C2=A0 .sdata2 <spa=
n class=3D"" style=3D"white-space:pre">				</span> =C2=A0 =C2=A0<span class=
=3D"" style=3D"white-space:pre">		</span>: &gt; ram_main=C2=A0</div><div>=
=C2=A0 =C2=A0 .fixaddr<span class=3D"" style=3D"white-space:pre">			</span>=
 <span class=3D"" style=3D"white-space:pre">	</span> =C2=A0 <span class=3D"=
" style=3D"white-space:pre">		</span>: &gt; .</div><div>=C2=A0 =C2=A0 .fixt=
ype<span class=3D"" style=3D"white-space:pre">						</span>: &gt; .</div><d=
iv><br></div><div>=C2=A0 =C2=A0 .sdabase <span class=3D"" style=3D"white-sp=
ace:pre">		</span> =C2=A0 =C2=A0 =C2=A0 =C2=A0<span class=3D"" style=3D"whi=
te-space:pre">	</span> =C2=A0 =C2=A0 =C2=A0ALIGN(16) : &gt; ram_main <span =
class=3D"" style=3D"white-space:pre">	</span></div><div>=C2=A0 =C2=A0 .sdat=
a <span class=3D"" style=3D"white-space:pre">						</span>: &gt; ram_main=
=C2=A0</div><div>=C2=A0 =C2=A0 .sbss <span class=3D"" style=3D"white-space:=
pre">						</span>: &gt; .</div><div>=C2=A0 =C2=A0 .data <span class=3D"" s=
tyle=3D"white-space:pre">						</span>: &gt; .</div><div>=C2=A0 =C2=A0 .bss=
 <span class=3D"" style=3D"white-space:pre">		</span> =C2=A0<span class=3D"=
" style=3D"white-space:pre">				</span>: &gt; .</div><div>=C2=A0 =C2=A0 .he=
ap =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ALIGN(16) =
PAD(heap_reserve) =C2=A0: &gt; . =C2=A0=C2=A0</div><div>=C2=A0 =C2=A0 .stac=
k =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ALIGN(16) PAD(sta=
ck_reserve) : &gt; .</div><div><br></div><div>=C2=A0 =C2=A0 =C2=A0INTR_VECT=
OR_START =3D ADDR(.vectors);</div><div>}</div><div><br></div></div>-- <br><=
div class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div>T=
hanks &amp; Regards,</div><div dir=3D"ltr">RamaChandra PC</div><div><span s=
tyle=3D"font-size:12.8px">+918892147159.</span><br></div></div></div></div>=
</div>
</div></div>

--94eb2c05c030a5de7e0533bd8b5a--
