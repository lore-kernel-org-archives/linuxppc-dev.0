Return-Path: <stephen.neuendorffer@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.228])
	by ozlabs.org (Postfix) with ESMTP id CCE62DE0DC
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Apr 2009 12:42:01 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f9so1238215rvb.9
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 19:41:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fa686aa40904172249m5e261492w48c8d9d8446600e0@mail.gmail.com>
References: <764365e7af2e476e43cd674738e51f13b306979b.1239874968.git.monstr@monstr.eu>
	<74c0088dfda1816c21914c0a8da0c42908526c5e.1239874968.git.monstr@monstr.eu>
	<20090417170707.B6C95C4004F@mail150-wa4.bigfish.com>
	<fa686aa40904172249m5e261492w48c8d9d8446600e0@mail.gmail.com>
Date: Sat, 18 Apr 2009 19:41:59 -0700
Message-ID: <495563870904181941o5a66126dgb59d8cad2b7a66f2@mail.gmail.com>
Subject: Re: [microblaze-uclinux] [PATCH 11/11] microblaze: Kconfig: Enable
	drivers for Microblaze
From: Stephen Neuendorffer <stephen.neuendorffer@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: multipart/alternative; boundary=001636e1fd829f0b0e0467df5b64
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, John Linn <john.linn@xilinx.com>,
	linux-kernel@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--001636e1fd829f0b0e0467df5b64
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Fri, Apr 17, 2009 at 10:49 PM, Grant Likely <grant.likely@secretlab.ca>wrote:

> On Fri, Apr 17, 2009 at 11:06 AM, Stephen Neuendorffer
> <stephen.neuendorffer@xilinx.com> wrote:
> >
> > Can we have XILINX_DRIVERS, please?  That way this can also be enabled
> > on any architecture that has FPGA peripherals.
>
> I've thought about this more, and I'd really rather not.  The list of
> affected drivers is short and is not a large maintenance burden.  I
> don't think a list of 2 or 3 architecture selects for each driver is
> unreasonable.  A "XILINX_DRIVERS" config item doesn't really help much
> anyway.  At any given time one of these drivers may be needed on
> another platform.  ie. the SystemACE device is present on at least one
> non-virtex, non-spartan platform.


Which is exactly why having it architecture dependent isn't right...  All of
these drivers
could be needed and used on any OF-based platform.  If you have a platform
(for instance, a processor connected to an FPGA which has these peripherals
in the FPGA) then you should be able to enable these drivers.  Just my 2
cents...

Steve


>
> g.
>
> >
> > Steve
> >
> >> -----Original Message-----
> >> From: owner-microblaze-uclinux@itee.uq.edu.au
> > [mailto:owner-microblaze-uclinux@itee.uq.edu.au] On
> >> Behalf Of monstr@monstr.eu
> >> Sent: Thursday, April 16, 2009 2:57 AM
> >> To: linux-kernel@vger.kernel.org
> >> Cc: microblaze-uclinux@itee.uq.edu.au; Michal Simek
> >> Subject: [microblaze-uclinux] [PATCH 11/11] microblaze: Kconfig:
> > Enable drivers for Microblaze
> >>
> >> From: Michal Simek <monstr@monstr.eu>
> >>
> >> Signed-off-by: Michal Simek <monstr@monstr.eu>
> >> ---
> >>  drivers/block/Kconfig |    2 +-
> >>  drivers/char/Kconfig  |    2 +-
> >>  drivers/gpio/Kconfig  |    2 +-
> >>  drivers/usb/Kconfig   |    1 +
> >>  4 files changed, 4 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> >> index ddea8e4..9f1665f 100644
> >> --- a/drivers/block/Kconfig
> >> +++ b/drivers/block/Kconfig
> >> @@ -438,7 +438,7 @@ source "drivers/s390/block/Kconfig"
> >>
> >>  config XILINX_SYSACE
> >>       tristate "Xilinx SystemACE support"
> >> -     depends on 4xx
> >> +     depends on 4xx || MICROBLAZE
> >>       help
> >>         Include support for the Xilinx SystemACE CompactFlash
> > interface
> >>
> >> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> >> index 735bbe2..bb1a071 100644
> >> --- a/drivers/char/Kconfig
> >> +++ b/drivers/char/Kconfig
> >> @@ -893,7 +893,7 @@ config DTLK
> >>
> >>  config XILINX_HWICAP
> >>       tristate "Xilinx HWICAP Support"
> >> -     depends on XILINX_VIRTEX
> >> +     depends on XILINX_VIRTEX || MICROBLAZE
> >>       help
> >>         This option enables support for Xilinx Internal Configuration
> >>         Access Port (ICAP) driver.  The ICAP is used on Xilinx Virtex
> >> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> >> index edb0253..11f3739 100644
> >> --- a/drivers/gpio/Kconfig
> >> +++ b/drivers/gpio/Kconfig
> >> @@ -69,7 +69,7 @@ comment "Memory mapped GPIO expanders:"
> >>
> >>  config GPIO_XILINX
> >>       bool "Xilinx GPIO support"
> >> -     depends on PPC_OF
> >> +     depends on PPC_OF || MICROBLAZE
> >>       help
> >>         Say yes here to support the Xilinx FPGA GPIO device
> >>
> >> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> >> index c6c816b..5eee3f8 100644
> >> --- a/drivers/usb/Kconfig
> >> +++ b/drivers/usb/Kconfig
> >> @@ -22,6 +22,7 @@ config USB_ARCH_HAS_HCD
> >>       default y if PCMCIA && !M32R                    # sl811_cs
> >>       default y if ARM                                # SL-811
> >>       default y if SUPERH                             # r8a66597-hcd
> >> +     default y if MICROBLAZE
> >>       default PCI
> >>
> >>  # many non-PCI SOC chips embed OHCI
> >> --
> >> 1.5.5.1
> >>
> >> ___________________________
> >> microblaze-uclinux mailing list
> >> microblaze-uclinux@itee.uq.edu.au
> >> Project Home Page :
> > http://www.itee.uq.edu.au/~jwilliams/mblaze-uclinux<http://www.itee.uq.edu.au/%7Ejwilliams/mblaze-uclinux>
> >> Mailing List Archive :
> > http://www.itee.uq.edu.au/~listarch/microblaze-uclinux/<http://www.itee.uq.edu.au/%7Elistarch/microblaze-uclinux/>
> >>
> >
> >
> > This email and any attachments are intended for the sole use of the named
> recipient(s) and contain(s) confidential information that may be
> proprietary, privileged or copyrighted under applicable law. If you are not
> the intended recipient, do not read, copy, or forward this email message or
> any attachments. Delete this email message and any attachments immediately.
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>

--001636e1fd829f0b0e0467df5b64
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Fri, Apr 17, 2009 at 10:49 PM, Grant =
Likely <span dir=3D"ltr">&lt;<a href=3D"mailto:grant.likely@secretlab.ca">g=
rant.likely@secretlab.ca</a>&gt;</span> wrote:<br><blockquote class=3D"gmai=
l_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0p=
t 0pt 0.8ex; padding-left: 1ex;">
On Fri, Apr 17, 2009 at 11:06 AM, Stephen Neuendorffer<br>
&lt;<a href=3D"mailto:stephen.neuendorffer@xilinx.com">stephen.neuendorffer=
@xilinx.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Can we have XILINX_DRIVERS, please? =A0That way this can also be enabl=
ed<br>
&gt; on any architecture that has FPGA peripherals.<br>
<br>
I&#39;ve thought about this more, and I&#39;d really rather not. =A0The lis=
t of<br>
affected drivers is short and is not a large maintenance burden. =A0I<br>
don&#39;t think a list of 2 or 3 architecture selects for each driver is<br=
>
unreasonable. =A0A &quot;XILINX_DRIVERS&quot; config item doesn&#39;t reall=
y help much<br>
anyway. =A0At any given time one of these drivers may be needed on<br>
another platform. =A0ie. the SystemACE device is present on at least one<br=
>
non-virtex, non-spartan platform.=A0</blockquote><div><br>Which is exactly =
why having it architecture dependent isn&#39;t right...=A0 All of these dri=
vers<br>could be needed and used on any OF-based platform.=A0 If you have a=
 platform (for instance, a processor connected to an FPGA which has these p=
eripherals in the FPGA) then you should be able to enable these drivers.=A0=
 Just my 2 cents...<br>
<br>Steve<br><br></div><blockquote class=3D"gmail_quote" style=3D"border-le=
ft: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: =
1ex;"><br>
<br>
g.<br>
<br>
&gt;<br>
&gt; Steve<br>
&gt;<br>
&gt;&gt; -----Original Message-----<br>
&gt;&gt; From: <a href=3D"mailto:owner-microblaze-uclinux@itee.uq.edu.au">o=
wner-microblaze-uclinux@itee.uq.edu.au</a><br>
&gt; [mailto:<a href=3D"mailto:owner-microblaze-uclinux@itee.uq.edu.au">own=
er-microblaze-uclinux@itee.uq.edu.au</a>] On<br>
&gt;&gt; Behalf Of monstr@monstr.eu<br>
&gt;&gt; Sent: Thursday, April 16, 2009 2:57 AM<br>
&gt;&gt; To: <a href=3D"mailto:linux-kernel@vger.kernel.org">linux-kernel@v=
ger.kernel.org</a><br>
&gt;&gt; Cc: <a href=3D"mailto:microblaze-uclinux@itee.uq.edu.au">microblaz=
e-uclinux@itee.uq.edu.au</a>; Michal Simek<br>
&gt;&gt; Subject: [microblaze-uclinux] [PATCH 11/11] microblaze: Kconfig:<b=
r>
&gt; Enable drivers for Microblaze<br>
&gt;&gt;<br>
&gt;&gt; From: Michal Simek &lt;monstr@monstr.eu&gt;<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Michal Simek &lt;monstr@monstr.eu&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; =A0drivers/block/Kconfig | =A0 =A02 +-<br>
&gt;&gt; =A0drivers/char/Kconfig =A0| =A0 =A02 +-<br>
&gt;&gt; =A0drivers/gpio/Kconfig =A0| =A0 =A02 +-<br>
&gt;&gt; =A0drivers/usb/Kconfig =A0 | =A0 =A01 +<br>
&gt;&gt; =A04 files changed, 4 insertions(+), 3 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig<br>
&gt;&gt; index ddea8e4..9f1665f 100644<br>
&gt;&gt; --- a/drivers/block/Kconfig<br>
&gt;&gt; +++ b/drivers/block/Kconfig<br>
&gt;&gt; @@ -438,7 +438,7 @@ source &quot;drivers/s390/block/Kconfig&quot;<=
br>
&gt;&gt;<br>
&gt;&gt; =A0config XILINX_SYSACE<br>
&gt;&gt; =A0 =A0 =A0 tristate &quot;Xilinx SystemACE support&quot;<br>
&gt;&gt; - =A0 =A0 depends on 4xx<br>
&gt;&gt; + =A0 =A0 depends on 4xx || MICROBLAZE<br>
&gt;&gt; =A0 =A0 =A0 help<br>
&gt;&gt; =A0 =A0 =A0 =A0 Include support for the Xilinx SystemACE CompactFl=
ash<br>
&gt; interface<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig<br>
&gt;&gt; index 735bbe2..bb1a071 100644<br>
&gt;&gt; --- a/drivers/char/Kconfig<br>
&gt;&gt; +++ b/drivers/char/Kconfig<br>
&gt;&gt; @@ -893,7 +893,7 @@ config DTLK<br>
&gt;&gt;<br>
&gt;&gt; =A0config XILINX_HWICAP<br>
&gt;&gt; =A0 =A0 =A0 tristate &quot;Xilinx HWICAP Support&quot;<br>
&gt;&gt; - =A0 =A0 depends on XILINX_VIRTEX<br>
&gt;&gt; + =A0 =A0 depends on XILINX_VIRTEX || MICROBLAZE<br>
&gt;&gt; =A0 =A0 =A0 help<br>
&gt;&gt; =A0 =A0 =A0 =A0 This option enables support for Xilinx Internal Co=
nfiguration<br>
&gt;&gt; =A0 =A0 =A0 =A0 Access Port (ICAP) driver. =A0The ICAP is used on =
Xilinx Virtex<br>
&gt;&gt; diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig<br>
&gt;&gt; index edb0253..11f3739 100644<br>
&gt;&gt; --- a/drivers/gpio/Kconfig<br>
&gt;&gt; +++ b/drivers/gpio/Kconfig<br>
&gt;&gt; @@ -69,7 +69,7 @@ comment &quot;Memory mapped GPIO expanders:&quot=
;<br>
&gt;&gt;<br>
&gt;&gt; =A0config GPIO_XILINX<br>
&gt;&gt; =A0 =A0 =A0 bool &quot;Xilinx GPIO support&quot;<br>
&gt;&gt; - =A0 =A0 depends on PPC_OF<br>
&gt;&gt; + =A0 =A0 depends on PPC_OF || MICROBLAZE<br>
&gt;&gt; =A0 =A0 =A0 help<br>
&gt;&gt; =A0 =A0 =A0 =A0 Say yes here to support the Xilinx FPGA GPIO devic=
e<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig<br>
&gt;&gt; index c6c816b..5eee3f8 100644<br>
&gt;&gt; --- a/drivers/usb/Kconfig<br>
&gt;&gt; +++ b/drivers/usb/Kconfig<br>
&gt;&gt; @@ -22,6 +22,7 @@ config USB_ARCH_HAS_HCD<br>
&gt;&gt; =A0 =A0 =A0 default y if PCMCIA &amp;&amp; !M32R =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0# sl811_cs<br>
&gt;&gt; =A0 =A0 =A0 default y if ARM =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0# SL-811<br>
&gt;&gt; =A0 =A0 =A0 default y if SUPERH =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 # r8a66597-hcd<br>
&gt;&gt; + =A0 =A0 default y if MICROBLAZE<br>
&gt;&gt; =A0 =A0 =A0 default PCI<br>
&gt;&gt;<br>
&gt;&gt; =A0# many non-PCI SOC chips embed OHCI<br>
&gt;&gt; --<br>
&gt;&gt; 1.5.5.1<br>
&gt;&gt;<br>
&gt;&gt; ___________________________<br>
&gt;&gt; microblaze-uclinux mailing list<br>
&gt;&gt; <a href=3D"mailto:microblaze-uclinux@itee.uq.edu.au">microblaze-uc=
linux@itee.uq.edu.au</a><br>
&gt;&gt; Project Home Page :<br>
&gt; <a href=3D"http://www.itee.uq.edu.au/%7Ejwilliams/mblaze-uclinux" targ=
et=3D"_blank">http://www.itee.uq.edu.au/~jwilliams/mblaze-uclinux</a><br>
&gt;&gt; Mailing List Archive :<br>
&gt; <a href=3D"http://www.itee.uq.edu.au/%7Elistarch/microblaze-uclinux/" =
target=3D"_blank">http://www.itee.uq.edu.au/~listarch/microblaze-uclinux/</=
a><br>
&gt;&gt;<br>
&gt;<br>
&gt;<br>
&gt; This email and any attachments are intended for the sole use of the na=
med recipient(s) and contain(s) confidential information that may be propri=
etary, privileged or copyrighted under applicable law. If you are not the i=
ntended recipient, do not read, copy, or forward this email message or any =
attachments. Delete this email message and any attachments immediately.<br>

&gt;<br>
&gt;<br>
&gt; --<br>
&gt; To unsubscribe from this list: send the line &quot;unsubscribe linux-k=
ernel&quot; in<br>
&gt; the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">=
majordomo@vger.kernel.org</a><br>
&gt; More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-=
info.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a>=
<br>
&gt; Please read the FAQ at =A0<a href=3D"http://www.tux.org/lkml/" target=
=3D"_blank">http://www.tux.org/lkml/</a><br>
&gt;<br>
<font color=3D"#888888"><br>
<br>
<br>
--<br>
Grant Likely, B.Sc., P.Eng.<br>
Secret Lab Technologies Ltd.<br>
_______________________________________________<br>
Linuxppc-dev mailing list<br>
<a href=3D"mailto:Linuxppc-dev@ozlabs.org">Linuxppc-dev@ozlabs.org</a><br>
<a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-dev" target=3D"_bla=
nk">https://ozlabs.org/mailman/listinfo/linuxppc-dev</a><br>
</font></blockquote></div><br>

--001636e1fd829f0b0e0467df5b64--
