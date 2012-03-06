Return-Path: <mla@apm.com>
Received: from exprod5og105.obsmtp.com (exprod5og105.obsmtp.com [64.18.0.180])
 by ozlabs.org (Postfix) with SMTP id AA913B6FA1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 13:57:01 +1100 (EST)
Received: by mail-vw0-f50.google.com with SMTP id l22so5611977vbn.37
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Mar 2012 18:56:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CA+5PVA4UAztYrJPqCqC9=T9brojOg2g=T--+BbMP8Br=xBrxfw@mail.gmail.com>
References: <1330505221-3678-1-git-send-email-mla@apm.com>
 <CA+5PVA4UAztYrJPqCqC9=T9brojOg2g=T--+BbMP8Br=xBrxfw@mail.gmail.com>
From: Mai La <mla@apm.com>
Date: Tue, 6 Mar 2012 09:56:39 +0700
Message-ID: <CAJ0-vuie89tW-qzGNXHcu-Jn+u6qRO0D3m4y2DFy45D82_g3xA@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc/44x: Fix PCI MSI support for APM821xx SoC and
 Bluestone board
To: Josh Boyer <jwboyer@gmail.com>
Content-Type: multipart/alternative; boundary=bcaec54eea6a4ff42604ba8a3245
Cc: open-source-review@apm.com, Tirumala R Marri <tmarri@apm.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--bcaec54eea6a4ff42604ba8a3245
Content-Type: text/plain; charset=ISO-8859-1

Please see my in-line reply.

On Wed, Feb 29, 2012 at 9:18 PM, Josh Boyer <jwboyer@gmail.com> wrote:

> On Wed, Feb 29, 2012 at 3:47 AM, Mai La <mla@apm.com> wrote:
> > This patch consists of:
> > - Enable PCI MSI as default for Bluestone board
> > - Define number of MSI interrupt for Maui APM821xx
>
> What is Maui?  Is that the same thing as Bluestone?
>

=> Bluestone board uses Maui APM821xx SoC. I would make the description
clearer like:
 This patch consists of:
- Enable PCI MSI as default for Bluestone board
- Define number of MSI interrupt for Maui APM821xxx SoC using in Bluestone
board


> > - Fix returning ENODEV as finding MSI node
> > - Fix MSI physical high and low address
> > - Keep MSI data logically
> >
> > Signed-off-by: Mai La <mla@apm.com>
>
> Wow.  So there are a lot of bugfixes here.  I'm surprised this ever worked
> at
> all with some of the things you're fixing.  Nice to see.
>
 > ---
> >  arch/powerpc/platforms/44x/Kconfig |    2 ++
> >  arch/powerpc/sysdev/ppc4xx_msi.c   |   28 ++++++++++++++++++----------
> >  2 files changed, 20 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/powerpc/platforms/44x/Kconfig
> b/arch/powerpc/platforms/44x/Kconfig
> > index fcf6bf2..9f04ce3 100644
> > --- a/arch/powerpc/platforms/44x/Kconfig
> > +++ b/arch/powerpc/platforms/44x/Kconfig
> > @@ -23,6 +23,8 @@ config BLUESTONE
> >        default n
> >        select PPC44x_SIMPLE
> >        select APM821xx
> > +       select PCI_MSI
> > +       select PPC4xx_MSI
> >        select IBM_EMAC_RGMII
> >        help
> >          This option enables support for the APM APM821xx Evaluation
> board.
> > diff --git a/arch/powerpc/sysdev/ppc4xx_msi.c
> b/arch/powerpc/sysdev/ppc4xx_msi.c
> > index 1c2d7af..6103908 100644
> > --- a/arch/powerpc/sysdev/ppc4xx_msi.c
> > +++ b/arch/powerpc/sysdev/ppc4xx_msi.c
> > @@ -31,7 +31,7 @@
> >  #include <asm/prom.h>
> >  #include <asm/hw_irq.h>
> >  #include <asm/ppc-pci.h>
> > -#include <boot/dcr.h>
> > +#include <asm/dcr.h>
> >  #include <asm/dcr-regs.h>
> >  #include <asm/msi_bitmap.h>
> >
> > @@ -43,7 +43,12 @@
> >  #define PEIH_FLUSH0    0x30
> >  #define PEIH_FLUSH1    0x38
> >  #define PEIH_CNTRST    0x48
> > +
> > +#ifdef CONFIG_APM821xx
> > +#define NR_MSI_IRQS    8
> > +#else
> >  #define NR_MSI_IRQS    4
> > +#endif
>
> Hm.  Do you think this is going to change quite a bit depending on which
> SoC
> is being used?  If so, it might be better to introduce a Kconfig variable
> that just defines this instead.  Something like:
>
>        config 4xx_MSI_IRQS
>           int "Number of MSI IRQs"
>           depends on 4xx
>           default "8" if APM821xx
>           default "4" if !APM821xx
>
> If there aren't going to be a wide variety of numbers, then the simple
> ifdef
> you have is probably sufficient.
>

=> So far we don't have a wide variety of numbers. So I think just keep
ifdef is fine.


>  >  struct ppc4xx_msi {
> >        u32 msi_addr_lo;
> > @@ -150,12 +155,11 @@ static int ppc4xx_setup_pcieh_hw(struct
> platform_device *dev,
> >        if (!sdr_addr)
> >                return -1;
> >
> > -       SDR0_WRITE(sdr_addr, (u64)res.start >> 32);      /*HIGH addr */
> > -       SDR0_WRITE(sdr_addr + 1, res.start & 0xFFFFFFFF); /* Low addr */
> > -
> > +       mtdcri(SDR0, *sdr_addr, res.start >> 32);       /*HIGH addr */
> > +       mtdcri(SDR0, *sdr_addr + 1, res.start & 0xFFFFFFFF);/* Low addr
> */
>
> Don't you still want the (u64) cast on res.start?
>

=> Keep (u64) is OK. So I would keep it like:
 mtdcri(SDR0, *sdr_addr, (u64)res.start >> 32);       /*HIGH addr */


> > CONFIDENTIALITY NOTICE: This e-mail message, including any attachments,
> > is for the sole use of the intended recipient(s) and contains information
> > that is confidential and proprietary to AppliedMicro Corporation or its
> subsidiaries.
> > It is to be used solely for the purpose of furthering the parties'
> business relationship.
> > All unauthorized review, use, disclosure or distribution is prohibited.
> > If you are not the intended recipient, please contact the sender by
> reply e-mail
> > and destroy all copies of the original message.
>
> Is there a way you can drop this?  Others from APM seem to have figured out
> how to do that, so hopefully it won't be a big problem.
>
> => Our IT guy help me to remove this!

Thank you! Do you have any further comment? I would send another patch with
the above fix soon.

 josh
>

--bcaec54eea6a4ff42604ba8a3245
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Please see my in-line reply.<br><br><div class=3D"gmail_quote">On Wed, Feb =
29, 2012 at 9:18 PM, Josh Boyer <span dir=3D"ltr">&lt;<a href=3D"mailto:jwb=
oyer@gmail.com" target=3D"_blank">jwboyer@gmail.com</a>&gt;</span> wrote:<b=
r><blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">


<div>On Wed, Feb 29, 2012 at 3:47 AM, Mai La &lt;<a href=3D"mailto:mla@apm.=
com" target=3D"_blank">mla@apm.com</a>&gt; wrote:<br>
&gt; This patch consists of:<br>
&gt; - Enable PCI MSI as default for Bluestone board<br>
&gt; - Define number of MSI interrupt for Maui APM821xx<br>
<br>
</div>What is Maui? =A0Is that the same thing as Bluestone?<br></blockquote=
><div><font color=3D"#000066"><span style=3D"color:rgb(0,0,0)"><br>=3D&gt; =
Bluestone board uses Maui APM821xx SoC. I would make the description cleare=
r like:</span><br style=3D"color:rgb(0,0,0)">

<span style=3D"color:rgb(0,0,0)">=A0This patch consists of:</span><br style=
=3D"color:rgb(0,0,0)"><span style=3D"color:rgb(0,0,0)">
- Enable PCI MSI as default for Bluestone board<br>- Define number of MSI i=
nterrupt for Maui APM821xxx SoC using in Bluestone board<br><br></span></fo=
nt></div><blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">


<div><br>
&gt; - Fix returning ENODEV as finding MSI node<br>
&gt; - Fix MSI physical high and low address<br>
&gt; - Keep MSI data logically<br>
&gt;<br>
&gt; Signed-off-by: Mai La &lt;<a href=3D"mailto:mla@apm.com" target=3D"_bl=
ank">mla@apm.com</a>&gt;<br>
<br>
</div>Wow. =A0So there are a lot of bugfixes here. =A0I&#39;m surprised thi=
s ever worked at<br>
all with some of the things you&#39;re fixing. =A0Nice to see.<br><div><div=
></div></div></blockquote><div></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">

<div><div>
&gt; ---<br>
&gt; =A0arch/powerpc/platforms/44x/Kconfig | =A0 =A02 ++<br>
&gt; =A0arch/powerpc/sysdev/ppc4xx_msi.c =A0 | =A0 28 ++++++++++++++++++---=
-------<br>
&gt; =A02 files changed, 20 insertions(+), 10 deletions(-)<br>
&gt;<br>
&gt; diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platfor=
ms/44x/Kconfig<br>
&gt; index fcf6bf2..9f04ce3 100644<br>
&gt; --- a/arch/powerpc/platforms/44x/Kconfig<br>
&gt; +++ b/arch/powerpc/platforms/44x/Kconfig<br>
&gt; @@ -23,6 +23,8 @@ config BLUESTONE<br>
&gt; =A0 =A0 =A0 =A0default n<br>
&gt; =A0 =A0 =A0 =A0select PPC44x_SIMPLE<br>
&gt; =A0 =A0 =A0 =A0select APM821xx<br>
&gt; + =A0 =A0 =A0 select PCI_MSI<br>
&gt; + =A0 =A0 =A0 select PPC4xx_MSI<br>
&gt; =A0 =A0 =A0 =A0select IBM_EMAC_RGMII<br>
&gt; =A0 =A0 =A0 =A0help<br>
&gt; =A0 =A0 =A0 =A0 =A0This option enables support for the APM APM821xx Ev=
aluation board.<br>
&gt; diff --git a/arch/powerpc/sysdev/ppc4xx_msi.c b/arch/powerpc/sysdev/pp=
c4xx_msi.c<br>
&gt; index 1c2d7af..6103908 100644<br>
&gt; --- a/arch/powerpc/sysdev/ppc4xx_msi.c<br>
&gt; +++ b/arch/powerpc/sysdev/ppc4xx_msi.c<br>
&gt; @@ -31,7 +31,7 @@<br>
&gt; =A0#include &lt;asm/prom.h&gt;<br>
&gt; =A0#include &lt;asm/hw_irq.h&gt;<br>
&gt; =A0#include &lt;asm/ppc-pci.h&gt;<br>
&gt; -#include &lt;boot/dcr.h&gt;<br>
&gt; +#include &lt;asm/dcr.h&gt;<br>
&gt; =A0#include &lt;asm/dcr-regs.h&gt;<br>
&gt; =A0#include &lt;asm/msi_bitmap.h&gt;<br>
&gt;<br>
&gt; @@ -43,7 +43,12 @@<br>
&gt; =A0#define PEIH_FLUSH0 =A0 =A00x30<br>
&gt; =A0#define PEIH_FLUSH1 =A0 =A00x38<br>
&gt; =A0#define PEIH_CNTRST =A0 =A00x48<br>
&gt; +<br>
&gt; +#ifdef CONFIG_APM821xx<br>
&gt; +#define NR_MSI_IRQS =A0 =A08<br>
&gt; +#else<br>
&gt; =A0#define NR_MSI_IRQS =A0 =A04<br>
&gt; +#endif<br>
<br>
</div></div>Hm. =A0Do you think this is going to change quite a bit dependi=
ng on which SoC<br>
is being used? =A0If so, it might be better to introduce a Kconfig variable=
<br>
that just defines this instead. =A0Something like:<br>
<br>
 =A0 =A0 =A0 =A0config 4xx_MSI_IRQS<br>
 =A0 =A0 =A0 =A0 =A0 int &quot;Number of MSI IRQs&quot;<br>
 =A0 =A0 =A0 =A0 =A0 depends on 4xx<br>
 =A0 =A0 =A0 =A0 =A0 default &quot;8&quot; if APM821xx<br>
 =A0 =A0 =A0 =A0 =A0 default &quot;4&quot; if !APM821xx<br>
<br>
If there aren&#39;t going to be a wide variety of numbers, then the simple =
ifdef<br>
you have is probably sufficient.<br><div></div></blockquote><div><br>=3D&gt=
; So far we don&#39;t have a wide variety of numbers. So I think just keep =
ifdef is fine.<br>=A0<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">

<div>
&gt; =A0struct ppc4xx_msi {<br>
&gt; =A0 =A0 =A0 =A0u32 msi_addr_lo;<br>
&gt; @@ -150,12 +155,11 @@ static int ppc4xx_setup_pcieh_hw(struct platform=
_device *dev,<br>
&gt; =A0 =A0 =A0 =A0if (!sdr_addr)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;<br>
&gt;<br>
&gt; - =A0 =A0 =A0 SDR0_WRITE(sdr_addr, (u64)res.start &gt;&gt; 32); =A0 =
=A0 =A0/*HIGH addr */<br>
&gt; - =A0 =A0 =A0 SDR0_WRITE(sdr_addr + 1, res.start &amp; 0xFFFFFFFF); /*=
 Low addr */<br>
&gt; -<br>
&gt; + =A0 =A0 =A0 mtdcri(SDR0, *sdr_addr, res.start &gt;&gt; 32); =A0 =A0 =
=A0 /*HIGH addr */<br>
&gt; + =A0 =A0 =A0 mtdcri(SDR0, *sdr_addr + 1, res.start &amp; 0xFFFFFFFF);=
/* Low addr */<br>
<br>
</div>Don&#39;t you still want the (u64) cast on res.start?<br></blockquote=
><div><br>=3D&gt; Keep (u64) is OK. So I would keep it like:<br>=A0mtdcri(S=
DR0, *sdr_addr, (u64)res.start &gt;&gt; 32); =A0 =A0 =A0 /*HIGH addr */<br>=
<br></div>

<blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; CONFIDENTIALITY NOTICE: This e-mail message, including any attachments=
,<br>
&gt; is for the sole use of the intended recipient(s) and contains informat=
ion<br>
&gt; that is confidential and proprietary to AppliedMicro Corporation or it=
s subsidiaries.<br>
&gt; It is to be used solely for the purpose of furthering the parties&#39;=
 business relationship.<br>
&gt; All unauthorized review, use, disclosure or distribution is prohibited=
.<br>
&gt; If you are not the intended recipient, please contact the sender by re=
ply e-mail<br>
&gt; and destroy all copies of the original message.<br>
<br>
Is there a way you can drop this? =A0Others from APM seem to have figured o=
ut<br>
how to do that, so hopefully it won&#39;t be a big problem.<br>
<span><font color=3D"#888888"><br></font></span></blockquote><div>=3D&gt; O=
ur IT guy help me to remove this! <br><br>Thank you! Do you have any furthe=
r comment? I would send another patch with the above fix soon.<br><br></div=
>

<blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><span><font color=3D"#888=
888">
josh<br>
</font></span></blockquote></div>

--bcaec54eea6a4ff42604ba8a3245--
