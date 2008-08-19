Return-Path: <sebastien.chretien.enseirb@gmail.com>
Message-ID: <319b0ac50808190223y7f378b46o3e485335e619e0cc@mail.gmail.com>
Date: Tue, 19 Aug 2008 11:23:05 +0200
From: "=?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?="
	<sebastien.chretien.enseirb@gmail.com>
To: benh@kernel.crashing.org
Subject: Re: [MPC7448] machdep_calls
In-Reply-To: <1219130863.8062.39.camel@pasglop>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_2909_31295603.1219137785497"
References: <319b0ac50808180145r44a1b64fhd09c038ce45bb206@mail.gmail.com>
	<1219051624.28339.39.camel@pasglop>
	<319b0ac50808180422r504a012djb971bf80e819a6d2@mail.gmail.com>
	<319b0ac50808180435o4a8e5bebr79f86e17ba2fb9af@mail.gmail.com>
	<1219062004.7946.5.camel@localhost>
	<319b0ac50808180717ka6731fdu591798ac0d8b4e82@mail.gmail.com>
	<1219095576.28339.74.camel@pasglop>
	<319b0ac50808190000m211ff885ucbf05a85b43f5c14@mail.gmail.com>
	<1219130863.8062.39.camel@pasglop>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_2909_31295603.1219137785497
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

So I will write .setup_arch of machine_call  structure.
When is ppc_md.setup_arch() called ?

2008/8/19, Benjamin Herrenschmidt <benh@kernel.crashing.org>:
>
> On Tue, 2008-08-19 at 09:00 +0200, S=E9bastien Chr=E9tien wrote:
> > I have no screen that's why I have to use UART. I followed the CPM
> > model in head_32.S :
> > #ifdef CONFIG_PPC_EARLY_DEBUG_CPM
> > setup_cpm_bat:
> >     lis    r8, 0xf000
> >     ori    r8, r8,    0x002a
> >     mtspr    SPRN_DBAT1L, r8
> >
> >     lis    r11, 0xf000
> >     ori    r11, r11, (BL_1M << 2) | 2
> >     mtspr    SPRN_DBAT1U, r11
> >
> >     blr
> > #endif
>
>
> The "EARLY DEBUG" stuff is a pile of hacks to help with bringup,
> it's definitely not a long term solution to your problems.
>
> You may also want to look at Grant Likely's work on doing proper
> early ioremap using BATs.
>
>
> > With this code  I can use udbg.
> >
> > According to you, what is the best way ?
>
>
> The above is fine for early debug console. But that's definitely
> not the only kind of thing you may want to put in your setup_arch()...
> Look at what others do.
>
> Ben.
>
>
> > 2008/8/18, Benjamin Herrenschmidt <benh@kernel.crashing.org>:
> >         On Mon, 2008-08-18 at 16:17 +0200, S=E9bastien Chr=E9tien wrote=
:
> >         > The mpc7448hpc2 uses a tsi108-bridge. My board uses an IP on
> >         a FPGA..
> >         > I read the code of mpc7448_hpc2.c.
> >         > It uses a ioremap in order to iniatilize the tsi108
> >         registers. But I
> >         > have already initialized MMU with my registers in HEAD_32.S.
> >         Do I need
> >         > to use ioremap in setup_arch() ?
> >
> >
> >         Why did you hack head_32.S ? You shouldn't do that... This is
> >         common
> >         code, not platform code.
> >
> >         Ben.
> >
> >         >
> >         >
> >         >
> >         > 2008/8/18, Michael Ellerman <michael@ellerman.id.au>:
> >         >         On Mon, 2008-08-18 at 13:35 +0200, S=E9bastien
> >         Chr=E9tien wrote:
> >         >         > Can somebody explain me the aim of the
> >         >         function  "setup_arch" in the
> >         >         > machine_call structure ?
> >         >
> >         >
> >         >         Is this MPC7448 anything like an mpc7448hpc2 ?
> >         >
> >         >         If so maybe you should start by looking at the code
> >         for it in:
> >         >
> >         >         arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
> >         >
> >         >         Even if it's not related, that will give you some
> >         idea of what
> >         >         the
> >         >         callbacks are for.
> >         >
> >         >         cheers
> >         >
> >         >         --
> >         >         Michael Ellerman
> >         >         OzLabs, IBM Australia Development Lab
> >         >
> >         >         wwweb: http://michael.ellerman.id.au
> >         >         phone: +61 2 6212 1183 (tie line 70 21183)
> >         >
> >         >         We do not inherit the earth from our ancestors,
> >         >         we borrow it from our children. - S.M.A.R.T Person
> >         >
> >         >
> >
> >
>
>

------=_Part_2909_31295603.1219137785497
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

So I will write .setup_arch of machine_call&nbsp; structure.<br>
When is ppc_md.setup_arch() called ?<br><br><div><span class=3D"gmail_quote=
">2008/8/19, Benjamin Herrenschmidt &lt;<a href=3D"mailto:benh@kernel.crash=
ing.org">benh@kernel.crashing.org</a>&gt;:</span><blockquote class=3D"gmail=
_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt=
 0pt 0.8ex; padding-left: 1ex;">
On Tue, 2008-08-19 at 09:00 +0200, S=E9bastien Chr=E9tien wrote:<br> &gt; I=
 have no screen that&#39;s why I have to use UART. I followed the CPM<br> &=
gt; model in head_32.S :<br> &gt; #ifdef CONFIG_PPC_EARLY_DEBUG_CPM<br> &gt=
; setup_cpm_bat:<br>
 &gt;&nbsp;&nbsp;&nbsp;&nbsp; lis&nbsp;&nbsp;&nbsp;&nbsp;r8, 0xf000<br> &gt=
;&nbsp;&nbsp;&nbsp;&nbsp; ori&nbsp;&nbsp;&nbsp;&nbsp;r8, r8,&nbsp;&nbsp;&nb=
sp;&nbsp;0x002a<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp; mtspr&nbsp;&nbsp;&nbsp;&nb=
sp;SPRN_DBAT1L, r8<br> &gt;<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp; lis&nbsp;&nbsp=
;&nbsp;&nbsp;r11, 0xf000<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp; ori&nbsp;&nbsp;&n=
bsp;&nbsp;r11, r11, (BL_1M &lt;&lt; 2) | 2<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;=
 mtspr&nbsp;&nbsp;&nbsp;&nbsp;SPRN_DBAT1U, r11<br>
 &gt;<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp; blr<br> &gt; #endif<br> <br> <br>The=
 &quot;EARLY DEBUG&quot; stuff is a pile of hacks to help with bringup,<br>=
 it&#39;s definitely not a long term solution to your problems.<br> <br> Yo=
u may also want to look at Grant Likely&#39;s work on doing proper<br>
 early ioremap using BATs.<br> <br><br> &gt; With this code&nbsp;&nbsp;I ca=
n use udbg.<br> &gt;<br> &gt; According to you, what is the best way ?<br> =
<br> <br>The above is fine for early debug console. But that&#39;s definite=
ly<br>
 not the only kind of thing you may want to put in your setup_arch()...<br>=
 Look at what others do.<br> <br> Ben.<br> <br><br> &gt; 2008/8/18, Benjami=
n Herrenschmidt &lt;<a href=3D"mailto:benh@kernel.crashing.org">benh@kernel=
.crashing.org</a>&gt;:<br>
 &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; On Mon, 2008-08-18 at=
 16:17 +0200, S=E9bastien Chr=E9tien wrote:<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; &gt; The mpc7448hpc2 uses a tsi108-bridge. My boa=
rd uses an IP on<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a=
 FPGA..<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; I rea=
d the code of mpc7448_hpc2.c.<br>
 &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; It uses a iorema=
p in order to iniatilize the tsi108<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; registers. But I<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; &gt; have already initialized MMU with my registers in HEA=
D_32.S.<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Do I need<=
br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; to use iorema=
p in setup_arch() ?<br>
 &gt;<br> &gt;<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Why=
 did you hack head_32.S ? You shouldn&#39;t do that... This is<br> &gt;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; common<br> &gt;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; code, not platform code.<br> &gt;<br> &gt=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ben.<br> &gt;<br> &gt;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>
 &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br> &gt;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br> &gt;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; 2008/8/18, Michael Ellerman &lt;<a href=3D=
"mailto:michael@ellerman.id.au">michael@ellerman.id.au</a>&gt;:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; On Mon, 2008-08-18
at 13:35 +0200, S=E9bastien<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; Chr=E9tien wrote:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Can somebody
explain me the aim of the<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
function&nbsp;&nbsp;&quot;setup_arch&quot; in the<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; machine_call
structure ?<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<b=
r> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Is this MPC7448
anything like an mpc7448hpc2 ?<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; &gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; If so maybe you
should start by looking at the code<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; for it in:<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; &gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c<br> &gt;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Even if it&#39;s not
related, that will give you some<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; idea of what<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the<br> &gt;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; callbacks are for.<br> &gt;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cheers<=
br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>
 &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Micha=
el Ellerman<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OzLabs, IBM
Australia Development Lab<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; &gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wwweb:
<a href=3D"http://michael.ellerman.id.au">http://michael.ellerman.id.au</a>=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phone: +61 2 6212
1183 (tie line 70 21183)<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; &gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; We do not inherit
the earth from our ancestors,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; we borrow it from
our children. - S.M.A.R.T Person<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; &gt;<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &gt;<br> &gt;<br> &gt;<br> <br> </blockquote></div><br>

------=_Part_2909_31295603.1219137785497--
