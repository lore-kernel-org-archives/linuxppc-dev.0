Return-Path: <tinamdar@apm.com>
Received: from exprod5og112.obsmtp.com (exprod5og112.obsmtp.com [64.18.0.24])
 by ozlabs.org (Postfix) with SMTP id E30331007D5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2011 23:19:27 +1100 (EST)
Received: by mail-iy0-f177.google.com with SMTP id p10so6166601iap.22
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2011 04:19:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201111231415.51985.arnd@arndb.de>
References: <1322041464-20605-1-git-send-email-tinamdar@apm.com>
 <201111231415.51985.arnd@arndb.de>
Date: Fri, 25 Nov 2011 17:49:24 +0530
Message-ID: <CACoXjcnfCM8Z5qFfrHtxsXkpf492LVbkDA3X=a9dRv9Lcv7Asw@mail.gmail.com>
Subject: Re: [PATCH] powerpc/40x: Add APM8018X SOC support
From: Tanmay Inamdar <tinamdar@apm.com>
To: Arnd Bergmann <arnd@arndb.de>
Content-Type: multipart/alternative; boundary=f46d04479505dd8f0a04b28e29b1
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--f46d04479505dd8f0a04b28e29b1
Content-Type: text/plain; charset=ISO-8859-1

Hello Arnd,

Thanks for the comments. Please see inline replies.

Regards,
Tanmay

On Wed, Nov 23, 2011 at 7:45 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> On Wednesday 23 November 2011, Tanmay Inamdar wrote:
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
>
> Hi Tanmay,
>
> > +#if defined(CONFIG_APM8018X)
> > +#define DCRN_CPR0_ADDR       0xa
> > +#define DCRN_CPR0_DATA       0xb
> > +#else
> >  /* 440EP Clock/Power-on Reset regs */
> >  #define DCRN_CPR0_ADDR       0xc
> >  #define DCRN_CPR0_DATA       0xd
> > +#endif /* CONFIG_APM8018X */
>
> This prevents you from building one kernel that runs on both APM8018X and
> others. Better define a new constant name for the new registers and select
> the right one at run-time.
>
> > diff --git a/arch/powerpc/boot/dts/klondike.dts
> b/arch/powerpc/boot/dts/klondike.dts
> > new file mode 100644
> > index 0000000..9372a52
> > --- /dev/null
> > +++ b/arch/powerpc/boot/dts/klondike.dts
> > @@ -0,0 +1,668 @@
> > +/*
> > + * Device Tree Source for AMCC Klondike (405)
> > + *
>
> The device tree file for the most part describes the chip, but partly also
> the board. Have you considered splitting the soc parts into a .dtsi file
> and moving all the configuration into a separate file?
>

Thanks for suggesting this. I will consider using .dtsi now.

>
>
> > diff --git a/arch/powerpc/configs/40x/klondike_defconfig
> b/arch/powerpc/configs/40x/klondike_defconfig
> > new file mode 100644
> > index 0000000..840f438
> > --- /dev/null
> > +++ b/arch/powerpc/configs/40x/klondike_defconfig
> > @@ -0,0 +1,1353 @@
> > +#
> > +# Automatically generated file; DO NOT EDIT.
> > +# Linux/powerpc 3.2.0-rc2 Kernel Configuration
> > +#
> > +# CONFIG_PPC64 is not set
> > +
>
> Please use 'make savedefconfig' to create a minimal defconfig file instead
> of listing
> the full configuration here.
>

Yes.

>
> > diff --git a/arch/powerpc/include/asm/dcr-regs.h
> b/arch/powerpc/include/asm/dcr-regs.h
> > index 380274d..c900cfd 100644
> > --- a/arch/powerpc/include/asm/dcr-regs.h
> > +++ b/arch/powerpc/include/asm/dcr-regs.h
> > @@ -24,9 +24,18 @@
> >   * of the driver main register set
> >   */
> >
> > +#if defined(CONFIG_APM8018X)
> > +/* CPR */
> > +#define DCRN_CPR0_CONFIG_ADDR        0xa
> > +#define DCRN_CPR1_CONFIG_DATA        0xb
> > +/* AHB */
> > +#define DCRN_SDR1_CONFIG_ADDR        0xc
> > +#define DCRN_SDR1_CONFIG_DATA        0xd
> > +#else
> >  /* CPRs (440GX and 440SP/440SPe) */
> >  #define DCRN_CPR0_CONFIG_ADDR        0xc
> >  #define DCRN_CPR0_CONFIG_DATA        0xd
> > +#endif /* CONFIG_APM8018X */
>
> same comment as above.
>

Some existing drivers use these macros. If I change the names, I will have
to update the
driver code.

>
> > diff --git a/arch/powerpc/kernel/cputable.c
> b/arch/powerpc/kernel/cputable.c
> > index edae5bb..e5c51a6 100644
> > --- a/arch/powerpc/kernel/cputable.c
> > +++ b/arch/powerpc/kernel/cputable.c
> > @@ -1505,6 +1505,58 @@ static struct cpu_spec __initdata cpu_specs[] = {
> >               .machine_check          = machine_check_4xx,
> >               .platform               = "ppc405",
> >       },
> > +     {       /* APM80186-SK */
> > +             .pvr_mask               = 0xffffffff,
> > +             .pvr_value              = 0x7ff11432,
>
> If you mask out the lower bits, you only need a single entry instead of
> four identical ones.
>

You are right. But each PVR represent different version of SOC. If I create
single
entry, then I will have to give generic cpu_name which I don't want.

>
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
>
> Same things as with the register definitions. Please make this
> run-time selectable to allow build-time configurations that
> support both layouts.
>

Yes. I will try to find better solution.

>
>        Arnd
>

CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, 
is for the sole use of the intended recipient(s) and contains information 
that is confidential and proprietary to AppliedMicro Corporation or its subsidiaries. 
It is to be used solely for the purpose of furthering the parties' business relationship. 
All unauthorized review, use, disclosure or distribution is prohibited. 
If you are not the intended recipient, please contact the sender by reply e-mail 
and destroy all copies of the original message.

--f46d04479505dd8f0a04b28e29b1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Arnd,<br><br>Thanks for the comments. Please see inline replies.<br><=
br>Regards,<br>Tanmay<br><br><div class=3D"gmail_quote">On Wed, Nov 23, 201=
1 at 7:45 PM, Arnd Bergmann <span dir=3D"ltr">&lt;<a href=3D"mailto:arnd@ar=
ndb.de" target=3D"_blank">arnd@arndb.de</a>&gt;</span> wrote:<br>


<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div>On Wednesday 23 November 2011, Tanmay I=
namdar wrote:<br>
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
<br>
</div>Hi Tanmay,<br>
<div><br>
&gt; +#if defined(CONFIG_APM8018X)<br>
&gt; +#define DCRN_CPR0_ADDR =A0 =A0 =A0 0xa<br>
&gt; +#define DCRN_CPR0_DATA =A0 =A0 =A0 0xb<br>
&gt; +#else<br>
&gt; =A0/* 440EP Clock/Power-on Reset regs */<br>
&gt; =A0#define DCRN_CPR0_ADDR =A0 =A0 =A0 0xc<br>
&gt; =A0#define DCRN_CPR0_DATA =A0 =A0 =A0 0xd<br>
&gt; +#endif /* CONFIG_APM8018X */<br>
<br>
</div>This prevents you from building one kernel that runs on both APM8018X=
 and<br>
others. Better define a new constant name for the new registers and select<=
br>
the right one at run-time.<br>
<div><br>
&gt; diff --git a/arch/powerpc/boot/dts/klondike.dts b/arch/powerpc/boot/dt=
s/klondike.dts<br>
&gt; new file mode 100644<br>
&gt; index 0000000..9372a52<br>
&gt; --- /dev/null<br>
&gt; +++ b/arch/powerpc/boot/dts/klondike.dts<br>
&gt; @@ -0,0 +1,668 @@<br>
&gt; +/*<br>
&gt; + * Device Tree Source for AMCC Klondike (405)<br>
&gt; + *<br>
<br>
</div>The device tree file for the most part describes the chip, but partly=
 also<br>
the board. Have you considered splitting the soc parts into a .dtsi file<br=
>
and moving all the configuration into a separate file?<br></blockquote><div=
><br>Thanks for suggesting this. I will consider using .dtsi now. <br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">



<div><br>
<br>
&gt; diff --git a/arch/powerpc/configs/40x/klondike_defconfig b/arch/powerp=
c/configs/40x/klondike_defconfig<br>
&gt; new file mode 100644<br>
&gt; index 0000000..840f438<br>
&gt; --- /dev/null<br>
&gt; +++ b/arch/powerpc/configs/40x/klondike_defconfig<br>
&gt; @@ -0,0 +1,1353 @@<br>
&gt; +#<br>
&gt; +# Automatically generated file; DO NOT EDIT.<br>
&gt; +# Linux/powerpc 3.2.0-rc2 Kernel Configuration<br>
&gt; +#<br>
&gt; +# CONFIG_PPC64 is not set<br>
&gt; +<br>
<br>
</div>Please use &#39;make savedefconfig&#39; to create a minimal defconfig=
 file instead of listing<br>
the full configuration here.<br></blockquote><div><br>Yes. <br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
<div><br>
&gt; diff --git a/arch/powerpc/include/asm/dcr-regs.h b/arch/powerpc/includ=
e/asm/dcr-regs.h<br>
&gt; index 380274d..c900cfd 100644<br>
&gt; --- a/arch/powerpc/include/asm/dcr-regs.h<br>
&gt; +++ b/arch/powerpc/include/asm/dcr-regs.h<br>
&gt; @@ -24,9 +24,18 @@<br>
&gt; =A0 * of the driver main register set<br>
&gt; =A0 */<br>
&gt;<br>
&gt; +#if defined(CONFIG_APM8018X)<br>
&gt; +/* CPR */<br>
&gt; +#define DCRN_CPR0_CONFIG_ADDR =A0 =A0 =A0 =A00xa<br>
&gt; +#define DCRN_CPR1_CONFIG_DATA =A0 =A0 =A0 =A00xb<br>
&gt; +/* AHB */<br>
&gt; +#define DCRN_SDR1_CONFIG_ADDR =A0 =A0 =A0 =A00xc<br>
&gt; +#define DCRN_SDR1_CONFIG_DATA =A0 =A0 =A0 =A00xd<br>
&gt; +#else<br>
&gt; =A0/* CPRs (440GX and 440SP/440SPe) */<br>
&gt; =A0#define DCRN_CPR0_CONFIG_ADDR =A0 =A0 =A0 =A00xc<br>
&gt; =A0#define DCRN_CPR0_CONFIG_DATA =A0 =A0 =A0 =A00xd<br>
&gt; +#endif /* CONFIG_APM8018X */<br>
<br>
</div>same comment as above.<br></blockquote><div>=A0</div><div>Some existi=
ng drivers use these macros. If I change the names, I will have to update t=
he<br>driver code.<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">



<div><br>
&gt; diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cput=
able.c<br>
&gt; index edae5bb..e5c51a6 100644<br>
&gt; --- a/arch/powerpc/kernel/cputable.c<br>
&gt; +++ b/arch/powerpc/kernel/cputable.c<br>
&gt; @@ -1505,6 +1505,58 @@ static struct cpu_spec __initdata cpu_specs[] =
=3D {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 .machine_check =A0 =A0 =A0 =A0 =A0=3D mach=
ine_check_4xx,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 .platform =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D =
&quot;ppc405&quot;,<br>
&gt; =A0 =A0 =A0 },<br>
&gt; + =A0 =A0 { =A0 =A0 =A0 /* APM80186-SK */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .pvr_mask =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 0x=
ffffffff,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .pvr_value =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 0x=
7ff11432,<br>
<br>
</div>If you mask out the lower bits, you only need a single entry instead =
of<br>
four identical ones.<br></blockquote><div><br>You are right. But each PVR r=
epresent different version of SOC. If I create single<br>entry, then I will=
 have to give generic cpu_name which I don&#39;t want.<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">



<div><div></div><div><br>
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
<br>
</div></div>Same things as with the register definitions. Please make this<=
br>
run-time selectable to allow build-time configurations that<br>
support both layouts.<br></blockquote><div><br>Yes. I will try to find bett=
er solution. <br></div><blockquote class=3D"gmail_quote" style=3D"margin: 0=
pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: =
1ex;">

<font color=3D"#888888"><br>
 =A0 =A0 =A0 =A0Arnd<br>
</font></blockquote></div><br>

<pre>CONFIDENTIALITY NOTICE: This e-mail message, including any attachmen=
ts, =

is for the sole use of the intended recipient(s) and contains information=
=A0
that is confidential and proprietary to AppliedMicro Corporation or its s=
ubsidiaries. =

It is to be used solely for the purpose of furthering the parties' busine=
ss relationship. =

All unauthorized review, use, disclosure or distribution is prohibited. =

If you are not the intended recipient, please contact the sender by reply=
 e-mail =

and destroy all copies of the original message.
=0D
--f46d04479505dd8f0a04b28e29b1--
