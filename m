Return-Path: <leif.lindholm@linaro.org>
Received: from mail-we0-f172.google.com (mail-we0-f172.google.com
 [74.125.82.172])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A4A221400F7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Apr 2014 06:09:53 +1000 (EST)
Received: by mail-we0-f172.google.com with SMTP id t61so1914082wes.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Apr 2014 13:09:47 -0700 (PDT)
Date: Fri, 18 Apr 2014 21:13:13 +0100
From: Leif Lindholm <leif.lindholm@linaro.org>
To: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH 0/3] of: dts: enable memory@0 quirk for PPC32 only
Message-ID: <20140418201313.GG5904@bivouac.eciton.net>
References: <1397756521-29387-1-git-send-email-leif.lindholm@linaro.org>
 <CAL_JsqL8B2ZY7ACXKX3J8VN5ukjKWuycgfDZpp4kYzBxg6BLmQ@mail.gmail.com>
 <20140418124821.GE5904@bivouac.eciton.net>
 <CAL_JsqKdFyhHfkcC1E9QuKjQTrXwoELYG+CFTpgf2-jqDvxGmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAL_JsqKdFyhHfkcC1E9QuKjQTrXwoELYG+CFTpgf2-jqDvxGmA@mail.gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linaro Patches <patches@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 18, 2014 at 10:37:58AM -0500, Rob Herring wrote:
> >> But why do you need this?
> >
> > Apart from the current code permitting recreating a 15+ year old
> > firmware bug into completely new platform ports?
> 
> I would prefer to see a "WARN_ON(!IS_ENABLED(CONFIG_PPC32));" added here.

In addition to, or instead of, the QUIRK ifdef?

> Really, I would like to see quirks like this fixed up out of line from
> the normal flow somewhat like how PCI quirks are handled. So in this
> example, we would just add the missing property to the dtb for the
> broken platform before doing the memory scan. That does then require
> libfdt which is something I'm working on.

Getting rid of all this handling from generic code would clearly be
preferable. Is that code going in in the near future, or could we add
the quirk as a stopgap?

> > Because the UEFI stub for arm/arm64 needs to delete all of the "memory"
> > nodes from the DT. And it would be nice to at least not have to compile
> > the "and also delete anything called memory@0" into the arm64 image. Or
> > any image not including support for affected platforms.
> 
> I don't see why you would handle that in the EFI stub. Given our lack
> of validation, I can see there is a chance this happens but I think it
> is pretty small. Given we only have a ARM board, I'd say we are doing
> surprisingly well.

I'm not too bothered personally, but Mark Rutland handed me a patch to
improve the memory node handling in the stub, and he seemed to really
want this there. You guys can fight it out :)

What would be the effect of the UEFI code adding all its memblocks,
minus the reserved areas, and then the DT code doing a memblock_add
of all RAM (including reserved areas)? Would memblock_reserve()s on
the protected regions suffice to prevent crazy stuff from happening?

/
    Leif
