Return-Path: <tanmayinamdar@gmail.com>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
 [209.85.213.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id B4E581007DF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 16:48:00 +1100 (EST)
Received: by ywp27 with SMTP id 27so2290492ywp.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2011 21:47:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1322043831.1753.49.camel@x61.thuisdomein>
References: <1322041464-20605-1-git-send-email-tinamdar@apm.com>
 <1322043831.1753.49.camel@x61.thuisdomein>
Date: Thu, 24 Nov 2011 11:17:50 +0530
Message-ID: <CANqaTJ1NJ0OvqXW9=J5xjtRJuP7ZRDhQDU5cGCAZwz9J=bR4CQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/40x: Add APM8018X SOC support
From: Tanmay <tanmayinamdar@gmail.com>
To: Paul Bolle <pebolle@tiscali.nl>
Content-Type: multipart/alternative; boundary=f46d04462bcaaea87904b2749382
Cc: linuxppc-dev@lists.ozlabs.org, Tanmay Inamdar <tinamdar@apm.com>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--f46d04462bcaaea87904b2749382
Content-Type: text/plain; charset=ISO-8859-1

Hello,

Thanks for the comments. Please see inline.

Regards,
Tanmay

On Wed, Nov 23, 2011 at 3:53 PM, Paul Bolle <pebolle@tiscali.nl> wrote:

> Tanmay,
>
> (Some minor Kconfig related comments follow.)
>
> On Wed, 2011-11-23 at 15:14 +0530, Tanmay Inamdar wrote:
> > The AppliedMicro APM8018X embedded processor targets embedded
> applications that
> > require low power and a small footprint. It features a PowerPC 405
> processor
> > core built in a 65nm low-power CMOS process with a five-stage pipeline
> executing
> > up to one instruction per cycle. The family has 128-kbytes of on-chip
> memory,
> > a 128-bit local bus and on-chip DDR2 SDRAM controller with 16-bit
> interface.
> >
> >[...]
> >
> > Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
> > ---
> >  arch/powerpc/Kconfig                        |    6 +
> >  arch/powerpc/boot/dcr.h                     |    6 +
> >  arch/powerpc/boot/dts/klondike.dts          |  668 +++++++++++++
> >  arch/powerpc/configs/40x/klondike_defconfig | 1353
> +++++++++++++++++++++++++++
> >  arch/powerpc/include/asm/dcr-regs.h         |   20 +
> >  arch/powerpc/kernel/cputable.c              |   52 +
> >  arch/powerpc/kernel/udbg_16550.c            |   22 +
> >  arch/powerpc/platforms/40x/Kconfig          |   11 +
> >  arch/powerpc/platforms/40x/ppc40x_simple.c  |    4 +-
> >  9 files changed, 2141 insertions(+), 1 deletions(-)
> >  create mode 100644 arch/powerpc/boot/dts/klondike.dts
> >  create mode 100644 arch/powerpc/configs/40x/klondike_defconfig
> >
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index b177caa..3f2cc36 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -978,3 +978,9 @@ config PPC_LIB_RHEAP
> >       bool
> >
> >  source "arch/powerpc/kvm/Kconfig"
> > +
> > +config UART_16550_WORD_ADDRESSABLE
> > +     bool
> > +     default n
> > +     help
> > +        Enable this if your UART 16550 is word addressable.
>
> This is only relevant for this SOC isn't it? If so, it might be better
> to add it to arch/powerpc/platforms/40x/Kconfig.
>
> The help line can be dropped (there's no prompt, so the help won't be
> user visible).
>
> Some people would suggest to use
>        def_bool n
>
> here. (I don't really care.)
>
Agreed. As Kumar Gala suggested in his comment, I will move this and make a
separate patch for UART changes.

>
> > [...]
>
> > diff --git a/arch/powerpc/kernel/udbg_16550.c
> b/arch/powerpc/kernel/udbg_16550.c
> > index 6837f83..dd3bce9 100644
> > --- a/arch/powerpc/kernel/udbg_16550.c
> > +++ b/arch/powerpc/kernel/udbg_16550.c
> > @@ -18,6 +18,19 @@ extern void real_writeb(u8 data, volatile u8 __iomem
> *addr);
> >  extern u8 real_205_readb(volatile u8 __iomem  *addr);
> >  extern void real_205_writeb(u8 data, volatile u8 __iomem *addr);
> >
> > +#ifdef CONFIG_UART_16550_WORD_ADDRESSABLE
> > +struct NS16550 {
> > +     /* this struct must be packed */
> > +     unsigned char rbr;  /* 0 */ u8 s0[3];
> > +     unsigned char ier;  /* 1 */ u8 s1[3];
> > +     unsigned char fcr;  /* 2 */ u8 s2[3];
> > +     unsigned char lcr;  /* 3 */ u8 s3[3];
> > +     unsigned char mcr;  /* 4 */ u8 s4[3];
> > +     unsigned char lsr;  /* 5 */ u8 s5[3];
> > +     unsigned char msr;  /* 6 */ u8 s6[3];
> > +     unsigned char scr;  /* 7 */ u8 s7[3];
> > +};
> > +#else
> >  struct NS16550 {
> >       /* this struct must be packed */
> >       unsigned char rbr;  /* 0 */
> > @@ -29,6 +42,7 @@ struct NS16550 {
> >       unsigned char msr;  /* 6 */
> >       unsigned char scr;  /* 7 */
> >  };
> > +#endif /* CONFIG_UART_16550_WORD_ADDRESSABLE */
> >
> >  #define thr rbr
> >  #define iir fcr
> > [...]
> > diff --git a/arch/powerpc/platforms/40x/Kconfig
> b/arch/powerpc/platforms/40x/Kconfig
> > index 1530229..3d0d1d9 100644
> > --- a/arch/powerpc/platforms/40x/Kconfig
> > +++ b/arch/powerpc/platforms/40x/Kconfig
> > @@ -186,3 +186,14 @@ config IBM405_ERR51
> >  #    bool
> >  #    depends on !STB03xxx && PPC4xx_DMA
> >  #    default y
> > +#
> > +
> > +config APM8018X
> > +     bool "APM8018X"
> > +     depends on 40x
> > +     default y
>
> Why is this "default y"? All other "selectors" of PPC40x_SIMPLE default
> to n.
>
> Yes. This is a mistake. This should be 'n'.


> > +     select PPC40x_SIMPLE
>
> There was recently some powerpc related discussion on using "select" on
> symbols that are themselves user selectable (see
> https://lkml.org/lkml/2011/11/9/426 ). But other symbols already select
> this symbol so this is not specific to this patch.
>
> > +     select UART_16550_WORD_ADDRESSABLE
> > +     help
> > +       This option enables support for the AppliedMicro Klondike board.
> > +
>
> Since you're selecting it here it's good that you made
> UART_16550_WORD_ADDRESSABLE hidden (as it has no prompt). But perhaps
> you could even drop it and in the code just test for CONFIG_APM8018X. Or
> are you expecting more users of UART_16550_WORD_ADDRESSABLE?
>
At this moment, it is only APM8018X SOC expects this. I am not sure about
more users of  UART_16550_WORD_ADDRESSABLE.  I will try to eliminate it or
make it as a run time selection.

>
> > [...]
>
>
> Paul Bolle
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>

--f46d04462bcaaea87904b2749382
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



<p class=3D"MsoPlainText">Hello,</p>

<p class=3D"MsoPlainText">Thanks for the comments. Please see inline.</p>

<p class=3D"MsoPlainText">Regards,</p>Tanmay

<br><br><div class=3D"gmail_quote">On Wed, Nov 23, 2011 at 3:53 PM, Paul Bo=
lle <span dir=3D"ltr">&lt;<a href=3D"mailto:pebolle@tiscali.nl">pebolle@tis=
cali.nl</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
Tanmay,<br>
<br>
(Some minor Kconfig related comments follow.)<br>
<div class=3D"im"><br>
On Wed, 2011-11-23 at 15:14 +0530, Tanmay Inamdar wrote:<br>
&gt; The AppliedMicro APM8018X embedded processor targets embedded applicat=
ions that<br>
&gt; require low power and a small footprint. It features a PowerPC 405 pro=
cessor<br>
&gt; core built in a 65nm low-power CMOS process with a five-stage pipeline=
 executing<br>
&gt; up to one instruction per cycle. The family has 128-kbytes of on-chip =
memory,<br>
&gt; a 128-bit local bus and on-chip DDR2 SDRAM controller with 16-bit inte=
rface.<br>
&gt;<br>
</div>&gt;[...]<br>
<div><div class=3D"h5">&gt;<br>
&gt; Signed-off-by: Tanmay Inamdar &lt;<a href=3D"mailto:tinamdar@apm.com">=
tinamdar@apm.com</a>&gt;<br>
&gt; ---<br>
&gt; =A0arch/powerpc/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A06 +<br>
&gt; =A0arch/powerpc/boot/dcr.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A06 +<br>
&gt; =A0arch/powerpc/boot/dts/klondike.dts =A0 =A0 =A0 =A0 =A0| =A0668 ++++=
+++++++++<br>
&gt; =A0arch/powerpc/configs/40x/klondike_defconfig | 1353 ++++++++++++++++=
+++++++++++<br>
&gt; =A0arch/powerpc/include/asm/dcr-regs.h =A0 =A0 =A0 =A0 | =A0 20 +<br>
&gt; =A0arch/powerpc/kernel/cputable.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 52 =
+<br>
&gt; =A0arch/powerpc/kernel/udbg_16550.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 22 +<=
br>
&gt; =A0arch/powerpc/platforms/40x/Kconfig =A0 =A0 =A0 =A0 =A0| =A0 11 +<br=
>
&gt; =A0arch/powerpc/platforms/40x/ppc40x_simple.c =A0| =A0 =A04 +-<br>
&gt; =A09 files changed, 2141 insertions(+), 1 deletions(-)<br>
&gt; =A0create mode 100644 arch/powerpc/boot/dts/klondike.dts<br>
&gt; =A0create mode 100644 arch/powerpc/configs/40x/klondike_defconfig<br>
&gt;<br>
&gt; diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig<br>
&gt; index b177caa..3f2cc36 100644<br>
&gt; --- a/arch/powerpc/Kconfig<br>
&gt; +++ b/arch/powerpc/Kconfig<br>
&gt; @@ -978,3 +978,9 @@ config PPC_LIB_RHEAP<br>
&gt; =A0 =A0 =A0 bool<br>
&gt;<br>
&gt; =A0source &quot;arch/powerpc/kvm/Kconfig&quot;<br>
&gt; +<br>
&gt; +config UART_16550_WORD_ADDRESSABLE<br>
&gt; + =A0 =A0 bool<br>
&gt; + =A0 =A0 default n<br>
&gt; + =A0 =A0 help<br>
&gt; + =A0 =A0 =A0 =A0Enable this if your UART 16550 is word addressable.<b=
r>
<br>
</div></div>This is only relevant for this SOC isn&#39;t it? If so, it migh=
t be better<br>
to add it to arch/powerpc/platforms/40x/Kconfig.<br>
<br>
The help line can be dropped (there&#39;s no prompt, so the help won&#39;t =
be<br>
user visible).<br>
<br>
Some people would suggest to use<br>
 =A0 =A0 =A0 =A0def_bool n<br>
<br>
here. (I don&#39;t really care.)<br></blockquote><div>

<p class=3D"MsoPlainText">Agreed. As Kumar Gala suggested in his comment, I=
 will
move this and make a separate patch for UART changes.=A0

<br></p></div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0p=
t 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<br>
&gt; [...]<br>
<div><div class=3D"h5"><br>
&gt; diff --git a/arch/powerpc/kernel/udbg_16550.c b/arch/powerpc/kernel/ud=
bg_16550.c<br>
&gt; index 6837f83..dd3bce9 100644<br>
&gt; --- a/arch/powerpc/kernel/udbg_16550.c<br>
&gt; +++ b/arch/powerpc/kernel/udbg_16550.c<br>
&gt; @@ -18,6 +18,19 @@ extern void real_writeb(u8 data, volatile u8 __iome=
m *addr);<br>
&gt; =A0extern u8 real_205_readb(volatile u8 __iomem =A0*addr);<br>
&gt; =A0extern void real_205_writeb(u8 data, volatile u8 __iomem *addr);<br=
>
&gt;<br>
&gt; +#ifdef CONFIG_UART_16550_WORD_ADDRESSABLE<br>
&gt; +struct NS16550 {<br>
&gt; + =A0 =A0 /* this struct must be packed */<br>
&gt; + =A0 =A0 unsigned char rbr; =A0/* 0 */ u8 s0[3];<br>
&gt; + =A0 =A0 unsigned char ier; =A0/* 1 */ u8 s1[3];<br>
&gt; + =A0 =A0 unsigned char fcr; =A0/* 2 */ u8 s2[3];<br>
&gt; + =A0 =A0 unsigned char lcr; =A0/* 3 */ u8 s3[3];<br>
&gt; + =A0 =A0 unsigned char mcr; =A0/* 4 */ u8 s4[3];<br>
&gt; + =A0 =A0 unsigned char lsr; =A0/* 5 */ u8 s5[3];<br>
&gt; + =A0 =A0 unsigned char msr; =A0/* 6 */ u8 s6[3];<br>
&gt; + =A0 =A0 unsigned char scr; =A0/* 7 */ u8 s7[3];<br>
&gt; +};<br>
&gt; +#else<br>
&gt; =A0struct NS16550 {<br>
&gt; =A0 =A0 =A0 /* this struct must be packed */<br>
&gt; =A0 =A0 =A0 unsigned char rbr; =A0/* 0 */<br>
&gt; @@ -29,6 +42,7 @@ struct NS16550 {<br>
&gt; =A0 =A0 =A0 unsigned char msr; =A0/* 6 */<br>
&gt; =A0 =A0 =A0 unsigned char scr; =A0/* 7 */<br>
&gt; =A0};<br>
&gt; +#endif /* CONFIG_UART_16550_WORD_ADDRESSABLE */<br>
&gt;<br>
&gt; =A0#define thr rbr<br>
&gt; =A0#define iir fcr<br>
</div></div>&gt; [...]<br>
<div class=3D"im">&gt; diff --git a/arch/powerpc/platforms/40x/Kconfig b/ar=
ch/powerpc/platforms/40x/Kconfig<br>
&gt; index 1530229..3d0d1d9 100644<br>
&gt; --- a/arch/powerpc/platforms/40x/Kconfig<br>
&gt; +++ b/arch/powerpc/platforms/40x/Kconfig<br>
&gt; @@ -186,3 +186,14 @@ config IBM405_ERR51<br>
&gt; =A0# =A0 =A0bool<br>
&gt; =A0# =A0 =A0depends on !STB03xxx &amp;&amp; PPC4xx_DMA<br>
&gt; =A0# =A0 =A0default y<br>
&gt; +#<br>
&gt; +<br>
&gt; +config APM8018X<br>
&gt; + =A0 =A0 bool &quot;APM8018X&quot;<br>
&gt; + =A0 =A0 depends on 40x<br>
&gt; + =A0 =A0 default y<br>
<br>
</div>Why is this &quot;default y&quot;? All other &quot;selectors&quot; of=
 PPC40x_SIMPLE default<br>
to n.<br>
<br></blockquote><div><span style=3D"font-size:11.0pt;font-family:&quot;Cal=
ibri&quot;,&quot;sans-serif&quot;;
mso-ascii-theme-font:minor-latin;mso-fareast-font-family:Calibri;mso-fareas=
t-theme-font:
minor-latin;mso-hansi-theme-font:minor-latin;mso-bidi-font-family:&quot;Tim=
es New Roman&quot;;
mso-bidi-theme-font:minor-bidi;mso-ansi-language:EN-US;mso-fareast-language=
:
EN-US;mso-bidi-language:AR-SA">Yes. This is a mistake. This should be &#39;=
n&#39;.<br></span>=A0<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); paddin=
g-left: 1ex;">

&gt; + =A0 =A0 select PPC40x_SIMPLE<br>
<br>
There was recently some powerpc related discussion on using &quot;select&qu=
ot; on<br>
symbols that are themselves user selectable (see<br>
<a href=3D"https://lkml.org/lkml/2011/11/9/426" target=3D"_blank">https://l=
kml.org/lkml/2011/11/9/426</a> ). But other symbols already select<br>
this symbol so this is not specific to this patch.<br>
<div class=3D"im"><br>
&gt; + =A0 =A0 select UART_16550_WORD_ADDRESSABLE<br>
&gt; + =A0 =A0 help<br>
&gt; + =A0 =A0 =A0 This option enables support for the AppliedMicro Klondik=
e board.<br>
&gt; +<br>
<br>
</div>Since you&#39;re selecting it here it&#39;s good that you made<br>
UART_16550_WORD_ADDRESSABLE hidden (as it has no prompt). But perhaps<br>
you could even drop it and in the code just test for CONFIG_APM8018X. Or<br=
>
are you expecting more users of UART_16550_WORD_ADDRESSABLE?<br></blockquot=
e><div>

<p class=3D"MsoPlainText">At this moment, it is only APM8018X SOC expects t=
his. I
am not sure<span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,=
&quot;sans-serif&quot;;mso-ascii-theme-font:
minor-latin;mso-fareast-font-family:Calibri;mso-fareast-theme-font:minor-la=
tin;
mso-hansi-theme-font:minor-latin;mso-bidi-font-family:&quot;Times New Roman=
&quot;;
mso-bidi-theme-font:minor-bidi;mso-ansi-language:EN-US;mso-fareast-language=
:
EN-US;mso-bidi-language:AR-SA"> about more users of=A0 UART_16550_WORD_ADDR=
ESSABLE.</span>=A0 I will try to eliminate it or make it as a run time sele=
ction.<br></p></div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt =
0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex=
;">

<br>
&gt; [...]<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
Paul Bolle<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
_______________________________________________<br>
Linuxppc-dev mailing list<br>
<a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.=
org</a><br>
<a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev" target=3D"_blank=
">https://lists.ozlabs.org/listinfo/linuxppc-dev</a><br>
</div></div></blockquote></div><br>

--f46d04462bcaaea87904b2749382--
