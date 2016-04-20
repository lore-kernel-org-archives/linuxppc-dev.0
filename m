Return-Path: <robh+dt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqzP22hHhzDqb5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 09:58:45 +1000 (AEST)
Received: from mail.kernel.org (localhost [127.0.0.1])
 by mail.kernel.org (Postfix) with ESMTP id 5A4392035D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 23:58:43 +0000 (UTC)
Received: from mail-yw0-f177.google.com (mail-yw0-f177.google.com
 [209.85.161.177])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AF6B42034B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 23:58:41 +0000 (UTC)
Received: by mail-yw0-f177.google.com with SMTP id j74so63528399ywg.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 16:58:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
References: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 20 Apr 2016 18:58:21 -0500
Message-ID: <CAL_Jsq+JO41w2PweW0n1Z78=wPnYh+wfa==Hb8o37L3ynDndkA@mail.gmail.com>
Subject: Re: [PATCH 00/14] DT: Fix spelling of standard properties
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>,
 Zhou Wang <wangzhou1@hisilicon.com>, Tony Lindgren <tony@atomide.com>,
 Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Joe Perches <joe@perches.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, dmaengine@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 20, 2016 at 10:32 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>         Hi all,
>
> This patch series fixes misspellings of various standard DT properties
> in DT binding documentation, DTS files, and error messages.
> While most of these are harmless, some of them may cause hard-to-debug
> failures.
>
> Please apply where appropriate.

I'll happily take the whole series if you like, though I've not
reviewed it all yet.

>
> Thanks!
>
> P.S. I used the following to detect misspellings:
>
>     words="(address|clock|cooling|dma|gpio|index|interrupt|mbox|msi|nvmem|phy|phys|power-domain|pwm|reset|size|sleep|sound-dai|thermal-sensor)"
>
>     git grep -Ew "${words}s-names"
>     git grep -E "[^-]\<${words}-name\>[^-]"
>     git grep -Ew "#${words}s-cells"             # false positive phys-cells
>     git grep -E "#${words}-cell\>[^-]"
>
>     git grep -w adress-cells
>     git grep -Ew "interrupts-(map|parent)"
>
> How can we prevent adding more of these?
>
> One simple option is to add the offenders to scripts/spelling.txt.
> Alternatively, we may want to do something smarter and more DT specific?

At least for #*-cells, we should be able to check most in dtc. When we
find common properties, we can check the node for the phandle has a
cells property. That would also check that the property is in fact a
phandle.

For *-names, we might be able to do a generic check in dtc for the
corresponding property being present when we find a -names property.
Though I suspect we're not consistent enough when/where we use plural.

Rob
