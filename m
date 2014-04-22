Return-Path: <grant.likely@secretlab.ca>
Received: from mail-ee0-f53.google.com (mail-ee0-f53.google.com [74.125.83.53])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 78BE514007A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Apr 2014 23:08:44 +1000 (EST)
Received: by mail-ee0-f53.google.com with SMTP id b57so4579178eek.26
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Apr 2014 06:08:38 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/3] of: dts: enable memory@0 quirk for PPC32 only
To: Rob Herring <robherring2@gmail.com>, Leif Lindholm
 <leif.lindholm@linaro.org>
In-Reply-To: <CAL_JsqKdFyhHfkcC1E9QuKjQTrXwoELYG+CFTpgf2-jqDvxGmA@mail.gmail.com>
References: <1397756521-29387-1-git-send-email-leif.lindholm@linaro.org>
 <CAL_JsqL8B2ZY7ACXKX3J8VN5ukjKWuycgfDZpp4kYzBxg6BLmQ@mail.gmail.com>
 <20140418124821.GE5904@bivouac.eciton.net>
 <CAL_JsqKdFyhHfkcC1E9QuKjQTrXwoELYG+CFTpgf2-jqDvxGmA@mail.gmail.com>
Date: Tue, 22 Apr 2014 14:08:29 +0100
Message-Id: <20140422130829.CA29DC4042C@trevor.secretlab.ca>
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

On Fri, 18 Apr 2014 10:37:58 -0500, Rob Herring <robherring2@gmail.com> wrote:
> On Fri, Apr 18, 2014 at 7:48 AM, Leif Lindholm <leif.lindholm@linaro.org> wrote:
> > On Thu, Apr 17, 2014 at 07:43:13PM -0500, Rob Herring wrote:
> >> On Thu, Apr 17, 2014 at 12:41 PM, Leif Lindholm
> >> <leif.lindholm@linaro.org> wrote:
> >> > drivers/of/fdt.c contains a workaround for a missing memory type
> >> > entry on longtrail firmware. Make that quirk PPC32 only, and while
> >> > at it - fix up the .dts files in the tree currently working only
> >> > because of that quirk.
> >>
> >> But why do you need this?
> >
> > Apart from the current code permitting recreating a 15+ year old
> > firmware bug into completely new platform ports?
> 
> I would prefer to see a "WARN_ON(!IS_ENABLED(CONFIG_PPC32));" added here.

I completely agree.

> Really, I would like to see quirks like this fixed up out of line from
> the normal flow somewhat like how PCI quirks are handled. So in this
> example, we would just add the missing property to the dtb for the
> broken platform before doing the memory scan. That does then require
> libfdt which is something I'm working on.

In fact, for Leif's purposes, I would rather have a flag when booting via
UEFI, and make the kernel skip the memory node parsing if the UEFI
memory map is available. Then the stub doesn't need to do any munging of
the DTB at all.

g.
