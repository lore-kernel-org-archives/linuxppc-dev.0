Return-Path: <leif.lindholm@linaro.org>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0729F14007F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Apr 2014 22:45:03 +1000 (EST)
Received: by mail-wg0-f41.google.com with SMTP id n12so475668wgh.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Apr 2014 05:44:58 -0700 (PDT)
Date: Fri, 18 Apr 2014 13:48:22 +0100
From: Leif Lindholm <leif.lindholm@linaro.org>
To: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH 0/3] of: dts: enable memory@0 quirk for PPC32 only
Message-ID: <20140418124821.GE5904@bivouac.eciton.net>
References: <1397756521-29387-1-git-send-email-leif.lindholm@linaro.org>
 <CAL_JsqL8B2ZY7ACXKX3J8VN5ukjKWuycgfDZpp4kYzBxg6BLmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAL_JsqL8B2ZY7ACXKX3J8VN5ukjKWuycgfDZpp4kYzBxg6BLmQ@mail.gmail.com>
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

On Thu, Apr 17, 2014 at 07:43:13PM -0500, Rob Herring wrote:
> On Thu, Apr 17, 2014 at 12:41 PM, Leif Lindholm
> <leif.lindholm@linaro.org> wrote:
> > drivers/of/fdt.c contains a workaround for a missing memory type
> > entry on longtrail firmware. Make that quirk PPC32 only, and while
> > at it - fix up the .dts files in the tree currently working only
> > because of that quirk.
> 
> But why do you need this?

Apart from the current code permitting recreating a 15+ year old
firmware bug into completely new platform ports?

Because the UEFI stub for arm/arm64 needs to delete all of the "memory"
nodes from the DT. And it would be nice to at least not have to compile
the "and also delete anything called memory@0" into the arm64 image. Or
any image not including support for affected platforms.

> >  arch/arm/boot/dts/ste-ccu8540.dts     |    1 +
> >  arch/mips/lantiq/dts/easy50712.dts    |    1 +
> >  arch/mips/ralink/dts/mt7620a_eval.dts |    1 +
> >  arch/mips/ralink/dts/rt2880_eval.dts  |    1 +
> >  arch/mips/ralink/dts/rt3052_eval.dts  |    1 +
> >  arch/mips/ralink/dts/rt3883_eval.dts  |    1 +
> 
> I'm not worried about these MIPS dts files because they are all
> built-in, but you are breaking compatibility with old dtbs for this
> ARM board.

Yeah, sorry. Sending out a v2 of part 3 shortly.

/
    Leif
