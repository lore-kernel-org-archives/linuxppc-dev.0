Return-Path: <leif.lindholm@linaro.org>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
 [209.85.212.174])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 35ED8140105
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Apr 2014 00:01:58 +1000 (EST)
Received: by mail-wi0-f174.google.com with SMTP id d1so3320790wiv.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Apr 2014 07:01:53 -0700 (PDT)
Date: Tue, 22 Apr 2014 15:05:26 +0100
From: Leif Lindholm <leif.lindholm@linaro.org>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/3] of: dts: enable memory@0 quirk for PPC32 only
Message-ID: <20140422140526.GK5904@bivouac.eciton.net>
References: <1397756521-29387-1-git-send-email-leif.lindholm@linaro.org>
 <CAL_JsqL8B2ZY7ACXKX3J8VN5ukjKWuycgfDZpp4kYzBxg6BLmQ@mail.gmail.com>
 <20140418124821.GE5904@bivouac.eciton.net>
 <CAL_JsqKdFyhHfkcC1E9QuKjQTrXwoELYG+CFTpgf2-jqDvxGmA@mail.gmail.com>
 <20140422130829.CA29DC4042C@trevor.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140422130829.CA29DC4042C@trevor.secretlab.ca>
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

On Tue, Apr 22, 2014 at 02:08:29PM +0100, Grant Likely wrote:
> > I would prefer to see a "WARN_ON(!IS_ENABLED(CONFIG_PPC32));" added here.
> 
> I completely agree.

OK. So do we keep this around on unaffected architectures in perpetuity?

Or can there be some cut-off date when the majority of DT-enabled
platforms can stop including this workaround which permits new incorrect
DTs to be implemented so long as they are incorrect in this particular
way?

> > Really, I would like to see quirks like this fixed up out of line from
> > the normal flow somewhat like how PCI quirks are handled. So in this
> > example, we would just add the missing property to the dtb for the
> > broken platform before doing the memory scan. That does then require
> > libfdt which is something I'm working on.
> 
> In fact, for Leif's purposes, I would rather have a flag when booting via
> UEFI, and make the kernel skip the memory node parsing if the UEFI
> memory map is available. Then the stub doesn't need to do any munging of
> the DTB at all.

The reason for me doing that is because we (including you) agreed at
the discussion held during LCU13 that this was the safest way of
preventing "mischief" like userland trying to read information from
/proc/device-tree...

/
    Leif
