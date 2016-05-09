Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r3bD13RKyzDq7j
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 May 2016 07:31:12 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: John Youn <John.Youn@synopsys.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "benh@au1.ibm.com" <benh@au1.ibm.com>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 Christian Lamparter <chunkeey@googlemail.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "a.seppala@gmail.com" <a.seppala@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: usb: dwc2: regression on MyBook Live Duo / Canyonlands since
 4.3.0-rc4
Date: Mon, 09 May 2016 23:30:47 +0200
Message-ID: <8966187.QMuYcJlN9t@wuerfel>
In-Reply-To: <5730FCFB.5050005@synopsys.com>
References: <4231696.iL6nGs74X8@debian64> <18362907.sI27LBpJPE@wuerfel>
 <5730FCFB.5050005@synopsys.com>
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

On Monday 09 May 2016 14:11:23 John Youn wrote:
> On 5/9/2016 1:39 PM, Arnd Bergmann wrote:
>
> > The systems are not a particular endianess, only the current state
> > of the CPU is, and that may change independent of the way the
> > hardware block got synthesized. We don't support swapping endianess
> > at runtime in Linux, but the system normally doesn't care what we
> > run.
> > 
> > The normal behavior is for the register contents to be read as
> > little-endian, and then swapped on big-endian kernel builds to
> > match what the kernel expects.
> > 
> > MIPS is a special case here, because the endianess of the CPU
> > core is fixed in hardware (or using a strapping pin) and is often
> > tied to the endianess of all the IP blocks. There are a couple
> > of other architectures like this (e.g. ARM ixp4xx, but none of the
> > modern ARM systems).
> 
> Ok thanks. What you're saying is clear now.
> 
> Is there a standard way to handle this? Must all drivers either check
> some endianness configuration or do a runtime check?

There are four common approaches:

1 hardcode a particular endianess because an IP block is always
  used the same way

2 pick the right endianess at compile-time because we know
  what we are building for (typically by CPU architecture, but
  there are some other ways)

3 do runtime configuration based on a DT property or platform data

4 do automatic runtime configuration based on well-known register
  contents

Approach 1 is the most common, in particular as most IP blocks
are not configurable and are not used on big-endian MIPS machines.

Approach 4 as implemented by Christian Lamparter's patch is the
most reliable way, and probably makes most sense for DesignWare
IP blocks in general, because they are configurable and may
get used in all kinds of systems.

Approaches 2 and 3 are somewhat inferior because you have to
rely on everyone else doing it the way you planned, but 2
is particularly easy and 3 is used when there is no obvious
way to detect endianess of the device.

The patch I suggested would be approach 2, and as Felipe correctly
mentioned, it is not ideal, but it may be more appropriate for
backports to the 4.4-longterm, 4.5-stable and 4.6-stable kernels
than the more elaborate patch we are now discussing.

	Arnd
