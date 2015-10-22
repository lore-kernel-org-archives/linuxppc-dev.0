Return-Path: <tomeu.vizoso@gmail.com>
Received: from mail-wi0-x234.google.com (mail-wi0-x234.google.com
 [IPv6:2a00:1450:400c:c05::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 078A41A044F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 00:05:23 +1100 (AEDT)
Received: by wicll6 with SMTP id ll6so118138333wic.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2015 06:05:19 -0700 (PDT)
MIME-Version: 1.0
Sender: tomeu.vizoso@gmail.com
In-Reply-To: <1445467912.701.90.camel@freescale.com>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
 <1442844182-27787-23-git-send-email-tomeu.vizoso@collabora.com>
 <1445406845.701.55.camel@freescale.com>
 <CAL_JsqLhZmc8cEC+tFJ25KLe0bQZsWmrRWGBMQake9VN6OjvdQ@mail.gmail.com>
 <1445467912.701.90.camel@freescale.com>
From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date: Thu, 22 Oct 2015 15:04:59 +0200
Message-ID: <CAAObsKAfufBe_SycibUN3ZsE3fOkBfUjZRx1SWEMwVtM6t7inQ@mail.gmail.com>
Subject: Re: [PATCH v6 22/22] of/platform: Defer probes of registered devices
To: Scott Wood <scottwood@freescale.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Javier Martinez Canillas <javier@osg.samsung.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Hu Mingkai-B21284 <Mingkai.Hu@freescale.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 22 October 2015 at 00:51, Scott Wood <scottwood@freescale.com> wrote:
> On Wed, 2015-10-21 at 08:44 -0500, Rob Herring wrote:
>> On Wed, Oct 21, 2015 at 12:54 AM, Scott Wood <scottwood@freescale.com>
>> wrote:
>> > On Mon, 2015-09-21 at 16:03 +0200, Tomeu Vizoso wrote:
>> > > Instead of trying to match and probe platform and AMBA devices right
>> > > after each is registered, delay their probes until device_initcall_sync.
>> > >
>> > > This means that devices will start probing once all built-in drivers
>> > > have registered, and after all platform and AMBA devices from the DT
>> > > have been registered already.
>> > >
>> > > This allows us to prevent deferred probes by probing dependencies on
>> > > demand.
>> > >
>> > > Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> > > ---
>> > >
>> > > Changes in v4:
>> > > - Also defer probes of AMBA devices registered from the DT as they can
>> > >   also request resources.
>> > >
>> > >  drivers/of/platform.c | 11 ++++++++---
>> > >  1 file changed, 8 insertions(+), 3 deletions(-)
>> >
>> > This breaks arch/powerpc/sysdev/fsl_pci.c.  The PCI bus is an OF platform
>> > device, and it must be probed before pcibios_init() which is a
>> > subsys_initcall(), or else the PCI bus never gets scanned.
>>
>> Thanks for the report. This is probably getting dropped, but it could
>> be disabled for PPC.
>
> I don't think that adding another arbitrary arch difference would be the
> right solution.

I think Rob meant temporarily disable it while things get fixed. At
least, I don't see any reason why PPC wouldn't benefit from this
series.

Regards,

Tomeu

>> Any plans to fix this and make PCI hosts hotplugable? For the scanning
>> part, generally the host controller drivers are responsible for
>> scanning their bus now.
>
> Scanning from the host controller driver seems like a reasonable goal, though
>
> it'd take a bit of digging to extract whatever other things fsl_pci may
> depend on from the common PPC PCI code, in particular the various things that
>
> pcibios_resource_survey() does after all PCI buses have been scanned.
>
> There's also check_swiotlb_enabled(), another subsys_initcall, which frees
> the swiotlb memory if ppc_swiotlb_enable hasn't been set.  The PCI host
> controller probe sets ppc_swiotlb_enable if it wasn't able to create an
> inbound mapping for all RAM.  Even if we were to change that to a later
> initcall, there's nothing later than late_initcall that we could use.
>
> -Scott
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
