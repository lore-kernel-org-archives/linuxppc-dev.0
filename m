Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9405D1A06C9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2015 11:34:49 +1100 (AEDT)
Message-ID: <1445474088.30295.5.camel@ellerman.id.au>
Subject: Re: [PATCH v6 22/22] of/platform: Defer probes of registered devices
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <scottwood@freescale.com>, Tomeu Vizoso
 <tomeu.vizoso@collabora.com>
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, Arnd Bergmann
 <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>,  linux-kernel@vger.kernel.org, Rob Herring
 <robh+dt@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>,
 Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Alan Stern <stern@rowland.harvard.edu>, Hu Mingkai-B21284
 <Mingkai.Hu@freescale.com>,  linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Date: Thu, 22 Oct 2015 11:34:48 +1100
In-Reply-To: <1445406845.701.55.camel@freescale.com>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
 <1442844182-27787-23-git-send-email-tomeu.vizoso@collabora.com>
 <1445406845.701.55.camel@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-10-21 at 00:54 -0500, Scott Wood wrote:

> On Mon, 2015-09-21 at 16:03 +0200, Tomeu Vizoso wrote:

> > Instead of trying to match and probe platform and AMBA devices right
> > after each is registered, delay their probes until device_initcall_sync.
> > 
> > This means that devices will start probing once all built-in drivers
> > have registered, and after all platform and AMBA devices from the DT
> > have been registered already.
> > 
> > This allows us to prevent deferred probes by probing dependencies on
> > demand.
> > 
> > Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> > ---
> > 
> > Changes in v4:
> > - Also defer probes of AMBA devices registered from the DT as they can
> >   also request resources.
> > 
> >  drivers/of/platform.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> This breaks arch/powerpc/sysdev/fsl_pci.c.  The PCI bus is an OF platform 
> device, and it must be probed before pcibios_init() which is a 
> subsys_initcall(), or else the PCI bus never gets scanned.

Ah right. This is presumably why I'm not seeing any PCI devices on my p5020ds
with linux-next.

cheers
