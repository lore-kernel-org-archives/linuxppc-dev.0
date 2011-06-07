Return-Path: <cmetcalf@tilera.com>
Received: from USMAMAIL.TILERA.COM (usmamail.tilera.com [206.83.70.75])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "usmamail.tilera.com",
	Issuer "Go Daddy Secure Certification Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 38717B6FA9
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  8 Jun 2011 02:49:14 +1000 (EST)
Message-ID: <4DEE567E.7080102@tilera.com>
Date: Tue, 7 Jun 2011 12:49:02 -0400
From: Chris Metcalf <cmetcalf@tilera.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 7/7] [v2] drivers/misc: introduce Freescale hypervisor
	management driver
References: <1306953337-15698-1-git-send-email-timur@freescale.com>
	<20110606212356.GA20112@dumpdata.com> <4DED5D08.3070704@tilera.com>
	<201106070908.16301.arnd@arndb.de>
In-Reply-To: <201106070908.16301.arnd@arndb.de>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, greg@kroah.com,
	kumar.gala@freescale.com, linux-kernel@vger.kernel.org,
	akpm@kernel.org, Deepak Saxena <dsaxena@linaro.org>,
	linux-console@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 6/7/2011 3:08 AM, Arnd Bergmann wrote:
> On Tuesday 07 June 2011 01:04:40 Chris Metcalf wrote:
>> There is certainly precedent for drivers that don't fit cleanly into an
>> existing category to go in drivers/<arch>, e.g. drivers/s390,
>> drivers/parisc, etc.  There is also drivers/platform/x86, though that seems
>> to be for the bus "platform drivers" rather than just a random character
>> driver like the one in question.
> The drivers/s390 and drivers/parisc directories are from a distant past,
> we should not add new ones like them. drivers/platform is controversial,
> but I think it's ok for stuff that manages platform specific quirks.
> The main problem with that is that it doesn't work for embedded systems,
> by extension every ARM specific driver could go into drivers/platform/...
> and we don't want that.
>
> You can probably argue that the tile drivers do fit in here as long as
> they are specific to the hypervisor and not to some SOC specific hardware.

Can you clarify that?   I think you're contrasting something like an ARM
core that was licensed and put in a SoC by some random vendor, and you
could have an endless stream of drivers for that case.  The Tilera core
isn't being licensed; it's sold more like an Intel chip with a fixed set of
interfaces available only from Tilera.  The particular interface in
question here is SPI, and the core itself knows how to boot the chip over
SPI by finding an SPI ROM and reading the boot stream out of it directly
after power-up.

So does that match with your model of "drivers/platform/tile"?  Maybe we
have a winner!  :-)

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
