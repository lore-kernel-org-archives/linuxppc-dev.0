Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0105.outbound.protection.outlook.com [207.46.100.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E33831A0BA3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 03:06:38 +1100 (AEDT)
Message-ID: <1446134778.701.374.camel@freescale.com>
Subject: Re: [PATCH v6 22/22] of/platform: Defer probes of registered devices
From: Scott Wood <scottwood@freescale.com>
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
CC: Rob Herring <robh+dt@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>,
 Javier Martinez Canillas <javier@osg.samsung.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, "Thierry
 Reding" <thierry.reding@gmail.com>, Alan Stern <stern@rowland.harvard.edu>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "Hu
 Mingkai-B21284" <Mingkai.Hu@freescale.com>
Date: Thu, 29 Oct 2015 11:06:18 -0500
In-Reply-To: <CAAObsKDR6pTEDK-G+jw+cr9MD-XoZqU8niqvDFHqFM0ve-+Smw@mail.gmail.com>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
 <1442844182-27787-23-git-send-email-tomeu.vizoso@collabora.com>
 <1445406845.701.55.camel@freescale.com>
 <CAL_JsqLhZmc8cEC+tFJ25KLe0bQZsWmrRWGBMQake9VN6OjvdQ@mail.gmail.com>
 <1445467912.701.90.camel@freescale.com>
 <CAAObsKAfufBe_SycibUN3ZsE3fOkBfUjZRx1SWEMwVtM6t7inQ@mail.gmail.com>
 <1445549230.701.116.camel@freescale.com>
 <CAAObsKDR6pTEDK-G+jw+cr9MD-XoZqU8niqvDFHqFM0ve-+Smw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-10-28 at 15:40 +0100, Tomeu Vizoso wrote:
> On 22 October 2015 at 23:27, Scott Wood <scottwood@freescale.com> wrote:
> > On Thu, 2015-10-22 at 15:04 +0200, Tomeu Vizoso wrote:
> > > On 22 October 2015 at 00:51, Scott Wood <scottwood@freescale.com> wrote:
> > > > On Wed, 2015-10-21 at 08:44 -0500, Rob Herring wrote:
> > > > > On Wed, Oct 21, 2015 at 12:54 AM, Scott Wood <
> > > > > scottwood@freescale.com>
> > > > > wrote:
> > > > > > On Mon, 2015-09-21 at 16:03 +0200, Tomeu Vizoso wrote:
> > > > > > > Instead of trying to match and probe platform and AMBA devices 
> > > > > > > right
> > > > > > > after each is registered, delay their probes until
> > > > > > > device_initcall_sync.
> > > > > > > 
> > > > > > > This means that devices will start probing once all built-in 
> > > > > > > drivers
> > > > > > > have registered, and after all platform and AMBA devices from 
> > > > > > > the DT
> > > > > > > have been registered already.
> > > > > > > 
> > > > > > > This allows us to prevent deferred probes by probing 
> > > > > > > dependencies on
> > > > > > > demand.
> > > > > > > 
> > > > > > > Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> > > > > > > ---
> > > > > > > 
> > > > > > > Changes in v4:
> > > > > > > - Also defer probes of AMBA devices registered from the DT as 
> > > > > > > they
> > > > > > > can
> > > > > > >   also request resources.
> > > > > > > 
> > > > > > >  drivers/of/platform.c | 11 ++++++++---
> > > > > > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > > > > > 
> > > > > > This breaks arch/powerpc/sysdev/fsl_pci.c.  The PCI bus is an OF
> > > > > > platform
> > > > > > device, and it must be probed before pcibios_init() which is a
> > > > > > subsys_initcall(), or else the PCI bus never gets scanned.
> > > > > 
> > > > > Thanks for the report. This is probably getting dropped, but it 
> > > > > could
> > > > > be disabled for PPC.
> > > > 
> > > > I don't think that adding another arbitrary arch difference would be 
> > > > the
> > > > right solution.
> > > 
> > > I think Rob meant temporarily disable it while things get fixed. At
> > > least,
> > 
> > So, what is the permanent fix for the swiotlb issue (or more generally, 
> > the
> > inability to have a late_initcall that runs after non-module, non-hotplug
> > platform devices have been probed)?
> 
> If the code in pcibios_init() depends on the PCI bus device having
> probed, then I would recommend making that dependency explicit by
> calling of_device_probe() on the OF node of the PCI controller when
> looking it up.

"when looking it up"?  pcibios_init() doesn't do anything with the OF node or 
know any details about the particular PCI bus host implementation.

> > > I don't see any reason why PPC wouldn't benefit from this
> > > series.
> > 
> > It's not clear to me what the benefit of this is at all, much less for 
> > PPC.
> > What is the fundamental problem with deferred probes?  In the cover letter
> > you say this change saves 2.3 seconds, but where is that time being 
> > consumed?
> >  Are the drivers taking too long in their probe function trying to 
> > initialize
> > and then deferring, rather than checking for dependencies up front?  Or 
> > are
> > there really so many devices and such a pessimal ordering that most of the
> > time is spent iterating through and reordering the list, with each defer
> > happening quickly?
> 
> The problem is that a device that defers its probe is currently sent
> to the back of the queue, and that's undesired in some use cases in
> which there's a device that should be up as soon as possible during
> boot (and boot takes a long time). So the goal is to change the order
> in which devices with dependencies end up probing.

That doesn't answer my question about where the time is being spent.  Did you 
profile?

-Scott
