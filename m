Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r3cqp14Z2zDq7j
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 May 2016 08:43:49 +1000 (AEST)
Message-ID: <1462833791.20290.134.camel@kernel.crashing.org>
Subject: Re: usb: dwc2: regression on MyBook Live Duo / Canyonlands since
 4.3.0-rc4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Lamparter <chunkeey@googlemail.com>, Arnd Bergmann
 <arnd@arndb.de>
Cc: linux-mips@linux-mips.org, Felipe Balbi <felipe.balbi@linux.intel.com>,
 johnyoun@synopsys.com, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 a.seppala@gmail.com, linuxppc-dev@lists.ozlabs.org
Date: Tue, 10 May 2016 08:43:11 +1000
In-Reply-To: <2764525.eheC8xZt4u@debian64>
References: <4231696.iL6nGs74X8@debian64> <8737prikg9.fsf@intel.com>
 <4908563.V9YuKsSrTJ@wuerfel> <2764525.eheC8xZt4u@debian64>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-05-09 at 21:06 +0200, Christian Lamparter via Linuxppc-dev wrote:
> 
> I ran into the following issues:
>         - gadget.c uses ioread32_rep [0] & iowrite32_rep [1].
>           This is interesting because both of these functions actually use
>           the __raw_io* on powerpc. This is because powerpc uses the default
>           defines of include/asm-generic/io.h [2].
> 
>           Ideally, this should be done by sth like a writesl_be or writesl(e)
>           function. But I found none so for now: Let's make a ugly hack:
>           to_correct_endian that will work for testing, but will be replaced.

No. The _rep variants always must use native endian. If for some reason
your device requires something different then the device is more broken
than I thought. IE. even with a BE core and an LE device, we use non-
byeswap _rep versions, this isn't just because we use "defaults" on
powerpc for example, it's necessary to work.

Here too, I could suggest you google for my talk on the subject :-) But
if you think closely about it, you'll figure out that FIFOs don't have
an endian per-se, thus what matters is which byte is first in ascending
address order, and that byte must land in memory in the first address
as well.

Interpreting the resulting data might require endian swaps, but
actually transferring to/from the fifo doesn't.

>    - dwc2_readl, dwc2_writel. I have no insight in the craziness that's
>           going on with MIPS and the memory barrier. But it got me thinking
>           rather than CONFIG_MIPS, isn't there a umbrella
>           "ARCH_HAS_NEED_MEMORY_BARRIER_FOR_MMIO" config symbol?
> 
>         - is_little_endian (do we want a separate is_big_endian?)
>           Also, do we want to be able to overwrite the detection code
>           if the endian setting was set in the device tree?. For now
>           it always does auto detection (see dwc2_detect_endiannes() ).

If auto-detect always work, no need to bother with the device-tree. A
single flag is enough, either is_big or is_little, doesn't matter.

"readl" should always be little, readl_be should always be big, though
the latter isn't supported on all archs. However the new accessors in
iomap.h should provide a "be" variant on all archs so switching to
these might be a good idea.

>         ( - 80 character per line issues, is it possible to drop the
>                  hsotg->reg + REGISTER from the dwc2_readl/writel since we
>                  pass the hsotg now anyway and do the reg + REGISTER
>                  calculation in the accessor? I played around with macros
>                  as most functions calling the accessors have the hsotg
>                  variable anyway )

Or just use a temp variable, the compiler should deal with it the same
way.

Ben.
 
> Regards,
> Christian
