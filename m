Return-Path: <robh+dt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by lists.ozlabs.org (Postfix) with ESMTP id 8B3941A03BD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2015 00:45:14 +1100 (AEDT)
Received: from mail.kernel.org (localhost [127.0.0.1])
 by mail.kernel.org (Postfix) with ESMTP id 28D41208B4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 13:45:07 +0000 (UTC)
Received: from mail-yk0-f170.google.com (mail-yk0-f170.google.com
 [209.85.160.170])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 76E8A208E8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 13:45:04 +0000 (UTC)
Received: by yknn9 with SMTP id n9so49188884ykn.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 06:45:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1445406845.701.55.camel@freescale.com>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
 <1442844182-27787-23-git-send-email-tomeu.vizoso@collabora.com>
 <1445406845.701.55.camel@freescale.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 21 Oct 2015 08:44:44 -0500
Message-ID: <CAL_JsqLhZmc8cEC+tFJ25KLe0bQZsWmrRWGBMQake9VN6OjvdQ@mail.gmail.com>
Subject: Re: [PATCH v6 22/22] of/platform: Defer probes of registered devices
To: Scott Wood <scottwood@freescale.com>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>,
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

On Wed, Oct 21, 2015 at 12:54 AM, Scott Wood <scottwood@freescale.com> wrote:
> On Mon, 2015-09-21 at 16:03 +0200, Tomeu Vizoso wrote:
>> Instead of trying to match and probe platform and AMBA devices right
>> after each is registered, delay their probes until device_initcall_sync.
>>
>> This means that devices will start probing once all built-in drivers
>> have registered, and after all platform and AMBA devices from the DT
>> have been registered already.
>>
>> This allows us to prevent deferred probes by probing dependencies on
>> demand.
>>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> ---
>>
>> Changes in v4:
>> - Also defer probes of AMBA devices registered from the DT as they can
>>   also request resources.
>>
>>  drivers/of/platform.c | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> This breaks arch/powerpc/sysdev/fsl_pci.c.  The PCI bus is an OF platform
> device, and it must be probed before pcibios_init() which is a
> subsys_initcall(), or else the PCI bus never gets scanned.

Thanks for the report. This is probably getting dropped, but it could
be disabled for PPC.

Any plans to fix this and make PCI hosts hotplugable? For the scanning
part, generally the host controller drivers are responsible for
scanning their bus now.

Rob
