Return-Path: <ian.molton@codethink.co.uk>
Message-ID: <5023D577.8090001@codethink.co.uk>
Date: Thu, 09 Aug 2012 16:21:27 +0100
From: Ian Molton <ian.molton@codethink.co.uk>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 0/7] mv643xx.c: Add basic device tree support.
References: <1344350092-24050-1-git-send-email-ian.molton@codethink.co.uk>
 <50226779.6060201@codethink.co.uk> <50239815.6020108@codethink.co.uk>
 <201208091143.32972.arnd@arndb.de>
In-Reply-To: <201208091143.32972.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: thomas.petazzoni@free-electrons.com, andrew@lunn.ch, netdev@vger.kernel.org,
 devicetree-discuss@lists.ozlabs.org, ben.dooks@codethink.co.uk,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/08/12 12:43, Arnd Bergmann wrote:
>  On 08/08/12 14:19, Ian Molton wrote:
>  > On 08/08/12 13:39, Arnd Bergmann wrote:
>  >> On Wednesday 08 August 2012, Ian Molton wrote:
>  >>> This method would require a small amount of rework in the driver to
>  >>> set up <n> ports, rather than just one.
>  >> This looks quite nice, but it is still very much incompatible with the
>  >> existing binding. Obviously we can abandon an existing binding and
>  >> introduce a second one for the same hardware, but that should not
>  >> be taken lightly.
>  > Fair, however the existing users aren't anywhere near as
>  > numerous as the new ones.
>
> Depends on how you count the numbers. I see at least three machines
> supported in the kernel with the old binding and none with the new one
> so far ;-)

I'm curious as to how any of those actually work, given the
apparent total lack of a mv64360-mdio device binding...
>  > As you can see, instead of putting port1 at +0x1700 or so,
>  > marvell have overlapped the register files - in fact, doubly
>  > so, since port1 + 0x1080 is right in the middle of
>  > (port0 + 0x1000) -> (port0 + 0x16ff), so one cant simply map two
>  > sets of regs like 0x0000->0x03ff and 0x1000->0x16ff for port one
>  > either.
>
> This could theoretically be dealt with by having 5 register ranges

I make that three...

> per device, but that would cause extra overhead and also be
> incompatible with the existing binding.

Indeed.

>  I think showing one
> parent device with children at address 0, 1 and 2 is ok.
Is it acceptable for the child devices to directly access the
parents register space? because there would be no other
way for that to work.

>  The driver
> already knows all those offsets and they are always the same
> for all variants of mv643xx, right?
Yes, but its not clean. And no amount of refactoring is
really going to make a nice driver that also fits the ancient
(and badly thought out) OF bindings.

If we have to break things, we can at least go for a nice
clean design, surely?

The ports arent really child devices of the MAC. The MAC
just has 3 ports.

Luckily, it looks like the existing users don't actually use
the device tree to set up the driver at all, preferring to
translate their D-T bindings to calls to
platform_device_register() so all we'd need to do to
support them is completely ignore them.

We're going to have to maintain a legacy
platform_device -> DT bindings hack somewhere anyway,
at least until the remaining other users of the driver
convert to D-T.

-Ian
