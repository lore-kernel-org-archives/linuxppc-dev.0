Return-Path: <jcrigby@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id 14DEEDE0DE
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Jul 2007 10:34:36 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so99809anc
	for <linuxppc-dev@ozlabs.org>; Sat, 07 Jul 2007 17:34:35 -0700 (PDT)
Message-ID: <4b73d43f0707071734yeedd7e6g53101d45fbec899e@mail.gmail.com>
Date: Sat, 7 Jul 2007 18:34:35 -0600
From: "John Rigby" <jcrigby@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Add USB support to mpc8349-mitx board port
In-Reply-To: <fa686aa40707062246j71a347acje8559b7b6be9d38b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_163080_15369149.1183854875180"
References: <20070706222909.19943.39455.stgit@trillian.secretlab.ca>
	<200707070148.20526.arnd@arndb.de>
	<fa686aa40707062246j71a347acje8559b7b6be9d38b@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, leoli@freescale.com, paulus@samba.org,
	Timur Tabi <timur@freescale.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_163080_15369149.1183854875180
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 7/6/07, Grant Likely <grant.likely@secretlab.ca> wrote:
>
> On 7/6/07, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Saturday 07 July 2007, Grant Likely wrote:
> > > --- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
> > > +++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
> > > @@ -63,6 +63,8 @@ static void __init mpc834x_itx_setup_arch(void)
> > >
> > > ppc_md.pci_exclude_device = mpc83xx_exclude_device;
> > > #endif
> > > +
> > > +mpc834x_usb_cfg();
> > > }
> >
> > Why is that necessary? Shouldn't there be an of_platform_driver that
> > simply does all the setup automatically if the device is present?
>
> This call is actually for SoC setup stuff.  There are actually 2 USB
> engines on the SoC, and this call figures out what mode the pins are
> supposed to be in.  I think this stuff firmly falls into the platform
> setup arena since it is highly chip specific.
>
> You bring up a good point though.  The current usb support code in
> sysdev/fsl_soc.c uses arch_initcall(fsl_usb_of_init) to go searching
> for USB interfaces in the device tree, which are EHCI (and sometimes
> OTG) compatible.  fsl_usb_of_init calls
> platform_device_register_simple() for each USB device found which is
> kind of a round about way of doing things.  That should probably be
> depreciated and an of_platform_device binding should be added to the
> EHCI driver.
>
> This same comment probably goes for the other arch_initcall functions
> in fsl_soc.c which do exactly the same thing for other devices.


This depends,  some devices in fsl_soc.c may exist on non-powerpc SoCs
that do not have OF.  The USB core in 8349 for example also is in the
arm based mx27 and mx31.  These devices should remain platform devices
and the glue in fls_soc.c will continure to be needed.


Cheers,
> g.
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
> grant.likely@secretlab.ca
> (403) 399-0195
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>

------=_Part_163080_15369149.1183854875180
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">On 7/6/07, <b class="gmail_sendername">Grant Likely</b> &lt;<a href="mailto:grant.likely@secretlab.ca">grant.likely@secretlab.ca</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On 7/6/07, Arnd Bergmann &lt;<a href="mailto:arnd@arndb.de">arnd@arndb.de</a>&gt; wrote:<br>&gt; On Saturday 07 July 2007, Grant Likely wrote:<br>&gt; &gt; --- a/arch/powerpc/platforms/83xx/mpc834x_itx.c<br>&gt; &gt; +++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
<br>&gt; &gt; @@ -63,6 +63,8 @@ static void __init mpc834x_itx_setup_arch(void)<br>&gt; &gt;<br>&gt; &gt; ppc_md.pci_exclude_device = mpc83xx_exclude_device;<br>&gt; &gt; #endif<br>&gt; &gt; +<br>&gt; &gt; +mpc834x_usb_cfg();
<br>&gt; &gt; }<br>&gt;<br>&gt; Why is that necessary? Shouldn&#39;t there be an of_platform_driver that<br>&gt; simply does all the setup automatically if the device is present?<br><br>This call is actually for SoC setup stuff.&nbsp;&nbsp;There are actually 2 USB
<br>engines on the SoC, and this call figures out what mode the pins are<br>supposed to be in.&nbsp;&nbsp;I think this stuff firmly falls into the platform<br>setup arena since it is highly chip specific.<br><br>You bring up a good point though.&nbsp;&nbsp;The current usb support code in
<br>sysdev/fsl_soc.c uses arch_initcall(fsl_usb_of_init) to go searching<br>for USB interfaces in the device tree, which are EHCI (and sometimes<br>OTG) compatible.&nbsp;&nbsp;fsl_usb_of_init calls<br>platform_device_register_simple() for each USB device found which is
<br>kind of a round about way of doing things.&nbsp;&nbsp;That should probably be<br>depreciated and an of_platform_device binding should be added to the<br>EHCI driver.<br><br>This same comment probably goes for the other arch_initcall functions
<br>in fsl_soc.c which do exactly the same thing for other devices.</blockquote><div><br>This depends,&nbsp; some devices in fsl_soc.c may exist on non-powerpc SoCs <br>that do not have OF.&nbsp; The USB core in 8349 for example also is in the
<br>arm based mx27 and mx31.&nbsp; These devices should remain platform devices<br>and the glue in fls_soc.c will continure to be needed.<br><br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Cheers,<br>g.<br><br>--<br>Grant Likely, B.Sc., P.Eng.<br>Secret Lab Technologies Ltd.<br><a href="mailto:grant.likely@secretlab.ca">grant.likely@secretlab.ca</a><br>(403) 399-0195<br>_______________________________________________
<br>Linuxppc-dev mailing list<br><a href="mailto:Linuxppc-dev@ozlabs.org">Linuxppc-dev@ozlabs.org</a><br><a href="https://ozlabs.org/mailman/listinfo/linuxppc-dev">https://ozlabs.org/mailman/listinfo/linuxppc-dev</a><br></blockquote>
</div><br>

------=_Part_163080_15369149.1183854875180--
