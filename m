Return-Path: <chunkeey@googlemail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qtCkN5QXjzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Apr 2016 01:21:32 +1000 (AEST)
Received: by mail-wm0-x241.google.com with SMTP id w143so15113711wmw.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Apr 2016 08:21:32 -0700 (PDT)
From: Christian Lamparter <chunkeey@googlemail.com>
To: Julian Margetson <runaway@candw.ms>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH v1 00/23] ata: sata_dwc_460ex: make it working again
Date: Sun, 24 Apr 2016 17:21:26 +0200
Message-ID: <33998356.WVR1zQ2T7Q@debian64>
In-Reply-To: <571CC4A7.8050808@candw.ms>
References: <1461262544-115408-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <4252844.GfFuvxr01B@debian64> <571CC4A7.8050808@candw.ms>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sunday, April 24, 2016 09:05:43 AM Julian Margetson wrote:
> On 4/23/2016 3:41 PM, Christian Lamparter wrote:
> > There's a known errata for the 460EX, with the CPU lockup upon
> > high AHB traffic:
> > <http://lists.denx.de/pipermail/u-boot/2008-June/036078.html>
> >
> > "This patch implements a fix provided by AMCC so that the lockup upon
> > simultanious traffic on AHB USB OTG, USB 2.0 and SATA doesn't occur
> > anymore:..."
> >
> > This should be fixed by u-boot. However, there's no telling if
> > there's more to this workaround in the dma engine. You could try
> > to do the testing without anything connected to the USB ports
> > and disable/remove all usb hcds modules. As for fixing this:
> > I did a quick search but couldn't find any public information.
> > There's always support@apm.com (contact them!), or maybe someone
> > from the Amiga community knows more?
> >
> >
> 
> Tested with kernel with all USB disabled. No sata error messages 
> during the partition copy but the copying is quite slow.
Ok. The CONFIG_DMADEVICES_DEBUG and CONFIG_DMADEVICES_VDEBUG option
have quite a large overhead, if this fixed the issue for now you
could try to disable them and look if the issue comes back or not.
(also, you can drop the mdelay patch if it's still applied). If
the issue doesn't come back, you could add your "Tested-by" tag
too.

Another thing, the sata dwc driver doesn't yet support NCQ. Do you
know if the driver for the Amiga OS does?

> so this does appear to be the problem.
So, how to fix this? I know, there's an AHB DMA Arbiter. But I can't
get any documentation for it from AMCC/APM. Maybe denx.de or someone
from the Amiga community knows how to deal with it. In theory, we 
could try if limiting the burst length, pending dma request count or
add code to retry failed dma transfers and reinit the usb-cores would
help.

Regards,
Christian
