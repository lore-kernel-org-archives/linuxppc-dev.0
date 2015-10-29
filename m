Return-Path: <robh+dt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by lists.ozlabs.org (Postfix) with ESMTP id B9CF41A0C1B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2015 15:18:20 +1100 (AEDT)
Received: from mail.kernel.org (localhost [127.0.0.1])
 by mail.kernel.org (Postfix) with ESMTP id B3C53209D1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2015 04:18:17 +0000 (UTC)
Received: from mail-yk0-f175.google.com (mail-yk0-f175.google.com
 [209.85.160.175])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E25AF209E8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2015 04:18:14 +0000 (UTC)
Received: by ykft191 with SMTP id t191so30653389ykf.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 21:18:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAAObsKDR6pTEDK-G+jw+cr9MD-XoZqU8niqvDFHqFM0ve-+Smw@mail.gmail.com>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
 <1442844182-27787-23-git-send-email-tomeu.vizoso@collabora.com>
 <1445406845.701.55.camel@freescale.com>
 <CAL_JsqLhZmc8cEC+tFJ25KLe0bQZsWmrRWGBMQake9VN6OjvdQ@mail.gmail.com>
 <1445467912.701.90.camel@freescale.com>
 <CAAObsKAfufBe_SycibUN3ZsE3fOkBfUjZRx1SWEMwVtM6t7inQ@mail.gmail.com>
 <1445549230.701.116.camel@freescale.com>
 <CAAObsKDR6pTEDK-G+jw+cr9MD-XoZqU8niqvDFHqFM0ve-+Smw@mail.gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 28 Oct 2015 23:17:54 -0500
Message-ID: <CAL_JsqKrRMtapB9D-WnUgB67S+m09LhcNDUx_Uh7aXzphQUc+Q@mail.gmail.com>
Subject: Re: [PATCH v6 22/22] of/platform: Defer probes of registered devices
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Scott Wood <scottwood@freescale.com>,
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

On Wed, Oct 28, 2015 at 9:40 AM, Tomeu Vizoso
<tomeu.vizoso@collabora.com> wrote:
> On 22 October 2015 at 23:27, Scott Wood <scottwood@freescale.com> wrote:
>> On Thu, 2015-10-22 at 15:04 +0200, Tomeu Vizoso wrote:
>>> On 22 October 2015 at 00:51, Scott Wood <scottwood@freescale.com> wrote:
>>> > On Wed, 2015-10-21 at 08:44 -0500, Rob Herring wrote:
>>> > > On Wed, Oct 21, 2015 at 12:54 AM, Scott Wood <scottwood@freescale.com>
>>> > > wrote:
>>> > > > On Mon, 2015-09-21 at 16:03 +0200, Tomeu Vizoso wrote:
>>> > > > > Instead of trying to match and probe platform and AMBA devices right
>>> > > > > after each is registered, delay their probes until
>>> > > > > device_initcall_sync.
>>> > > > >
>>> > > > > This means that devices will start probing once all built-in drivers
>>> > > > > have registered, and after all platform and AMBA devices from the DT
>>> > > > > have been registered already.
>>> > > > >
>>> > > > > This allows us to prevent deferred probes by probing dependencies on
>>> > > > > demand.
>>> > > > >
>>> > > > > Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>>> > > > > ---
>>> > > > >
>>> > > > > Changes in v4:
>>> > > > > - Also defer probes of AMBA devices registered from the DT as they
>>> > > > > can
>>> > > > >   also request resources.
>>> > > > >
>>> > > > >  drivers/of/platform.c | 11 ++++++++---
>>> > > > >  1 file changed, 8 insertions(+), 3 deletions(-)
>>> > > >
>>> > > > This breaks arch/powerpc/sysdev/fsl_pci.c.  The PCI bus is an OF
>>> > > > platform
>>> > > > device, and it must be probed before pcibios_init() which is a
>>> > > > subsys_initcall(), or else the PCI bus never gets scanned.
>>> > >
>>> > > Thanks for the report. This is probably getting dropped, but it could
>>> > > be disabled for PPC.
>>> >
>>> > I don't think that adding another arbitrary arch difference would be the
>>> > right solution.
>>>
>>> I think Rob meant temporarily disable it while things get fixed. At
>>> least,
>>
>> So, what is the permanent fix for the swiotlb issue (or more generally, the
>> inability to have a late_initcall that runs after non-module, non-hotplug
>> platform devices have been probed)?
>
> If the code in pcibios_init() depends on the PCI bus device having
> probed, then I would recommend making that dependency explicit by
> calling of_device_probe() on the OF node of the PCI controller when
> looking it up.
>
>>> I don't see any reason why PPC wouldn't benefit from this
>>> series.
>>
>> It's not clear to me what the benefit of this is at all, much less for PPC.
>> What is the fundamental problem with deferred probes?  In the cover letter
>> you say this change saves 2.3 seconds, but where is that time being consumed?
>>  Are the drivers taking too long in their probe function trying to initialize
>> and then deferring, rather than checking for dependencies up front?  Or are
>> there really so many devices and such a pessimal ordering that most of the
>> time is spent iterating through and reordering the list, with each defer
>> happening quickly?
>
> The problem is that a device that defers its probe is currently sent
> to the back of the queue, and that's undesired in some use cases in
> which there's a device that should be up as soon as possible during
> boot (and boot takes a long time). So the goal is to change the order
> in which devices with dependencies end up probing.
>
>> Even if something different does need to be done at this level, forcing all
>> OF platform devices to be probed at the late_initcall level seems quite
>> intrusive.  You limited it to OF because people complained that other things
>> will break.  Things still broke.  Surely there's a better way to address the
>> problem.  Can't the delay be requested by drivers that might otherwise need
>> to defer (which could be done incrementally, focusing on the worst
>> performance problems), rather than enabling it for everything?
>
> Yes, given the amount of breakage that's a sensible option. But in any
> case and even if this series is most likely to be dropped, I recommend
> to make explicit as many implicit dependencies as possible.

It is dropped for now, but I expect much of this to still integrate
with Rafael's proposal. However, it will need to be opt-in it seems.
That is somewhat unfortunate because things like async probe are
opt-in and seem to rarely get used. As to how we can make it opt-in, I
think we can make of_platform_populate() callable multiple times at
the root level. This will allow a platform to skip calling it and then
a late call to it can register the devices after drivers have
registered. This late call will then be a nop for platforms that don't
opt-in and call of_platform_populate themselves.

Rob
