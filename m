Return-Path: <grant.likely@secretlab.ca>
Received: from mail-ee0-f43.google.com (mail-ee0-f43.google.com [74.125.83.43])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9BBFA14011D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Apr 2014 23:15:24 +1000 (EST)
Received: by mail-ee0-f43.google.com with SMTP id e53so781730eek.30
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Apr 2014 06:15:19 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/3] of: dts: enable memory@0 quirk for PPC32 only
To: Leif Lindholm <leif.lindholm@linaro.org>
In-Reply-To: <20140422140526.GK5904@bivouac.eciton.net>
References: <1397756521-29387-1-git-send-email-leif.lindholm@linaro.org>
 <CAL_JsqL8B2ZY7ACXKX3J8VN5ukjKWuycgfDZpp4kYzBxg6BLmQ@mail.gmail.com>
 <20140418124821.GE5904@bivouac.eciton.net>
 <CAL_JsqKdFyhHfkcC1E9QuKjQTrXwoELYG+CFTpgf2-jqDvxGmA@mail.gmail.com>
 <20140422130829.CA29DC4042C@trevor.secretlab.ca>
 <20140422140526.GK5904@bivouac.eciton.net>
Date: Wed, 23 Apr 2014 14:15:08 +0100
Message-Id: <20140423131508.6E53BC408D2@trevor.secretlab.ca>
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Linaro Patches <patches@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Rob Herring <robherring2@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 22 Apr 2014 15:05:26 +0100, Leif Lindholm <leif.lindholm@linaro.org> wrote:
> On Tue, Apr 22, 2014 at 02:08:29PM +0100, Grant Likely wrote:
> > > I would prefer to see a "WARN_ON(!IS_ENABLED(CONFIG_PPC32));" added here.
> > 
> > I completely agree.
> 
> OK. So do we keep this around on unaffected architectures in perpetuity?
> 
> Or can there be some cut-off date when the majority of DT-enabled
> platforms can stop including this workaround which permits new incorrect
> DTs to be implemented so long as they are incorrect in this particular
> way?
> 
> > > Really, I would like to see quirks like this fixed up out of line from
> > > the normal flow somewhat like how PCI quirks are handled. So in this
> > > example, we would just add the missing property to the dtb for the
> > > broken platform before doing the memory scan. That does then require
> > > libfdt which is something I'm working on.
> > 
> > In fact, for Leif's purposes, I would rather have a flag when booting via
> > UEFI, and make the kernel skip the memory node parsing if the UEFI
> > memory map is available. Then the stub doesn't need to do any munging of
> > the DTB at all.
> 
> The reason for me doing that is because we (including you) agreed at
> the discussion held during LCU13 that this was the safest way of
> preventing "mischief" like userland trying to read information from
> /proc/device-tree...

I'm not the most consistent of people. I often change my mind and then
have no recollection of ever thinking differently.

Userland reading from /proc/device-tree isn't so much a problem, but
kernel drivers doing it might be.

But, regardless of whether or not the stub clears out the memory
nodes, it is still I think good practice for the kernel to make the
decision to ignore memory nodes, and not rely on them being cleared
correctly.

g.
