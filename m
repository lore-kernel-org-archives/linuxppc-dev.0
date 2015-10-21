Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0134.outbound.protection.outlook.com [157.56.111.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 539711A03CA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 16:54:30 +1100 (AEDT)
Message-ID: <1445406845.701.55.camel@freescale.com>
Subject: Re: [PATCH v6 22/22] of/platform: Defer probes of registered devices
From: Scott Wood <scottwood@freescale.com>
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
CC: <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "Stephen
 Warren" <swarren@wwwdotorg.org>, Javier Martinez Canillas
 <javier@osg.samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>, <linux-arm-kernel@lists.infradead.org>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, <devicetree@vger.kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, <linux-acpi@vger.kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, <linuxppc-dev@lists.ozlabs.org>, Hu Mingkai-B21284
 <Mingkai.Hu@freescale.com>
Date: Wed, 21 Oct 2015 00:54:05 -0500
In-Reply-To: <1442844182-27787-23-git-send-email-tomeu.vizoso@collabora.com>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
 <1442844182-27787-23-git-send-email-tomeu.vizoso@collabora.com>
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

On Mon, 2015-09-21 at 16:03 +0200, Tomeu Vizoso wrote:
> Instead of trying to match and probe platform and AMBA devices right
> after each is registered, delay their probes until device_initcall_sync.
> 
> This means that devices will start probing once all built-in drivers
> have registered, and after all platform and AMBA devices from the DT
> have been registered already.
> 
> This allows us to prevent deferred probes by probing dependencies on
> demand.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
> 
> Changes in v4:
> - Also defer probes of AMBA devices registered from the DT as they can
>   also request resources.
> 
>  drivers/of/platform.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

This breaks arch/powerpc/sysdev/fsl_pci.c.  The PCI bus is an OF platform 
device, and it must be probed before pcibios_init() which is a 
subsys_initcall(), or else the PCI bus never gets scanned.

-Scott
