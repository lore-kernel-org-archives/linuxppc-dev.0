Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 32DD0DDE2B
	for <linuxppc-dev@ozlabs.org>; Sun, 13 May 2007 16:17:08 +1000 (EST)
Date: Sun, 13 May 2007 01:19:54 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] pasemi: electra IDE/pata_platform glue
Message-ID: <20070513061954.GA16623@lixom.net>
References: <20070512145041.GA13025@lixom.net>
	<200705130111.03153.arnd@arndb.de>
	<20070513005830.38ba8e3b@the-village.bc.nu>
	<200705130248.22844.arnd@arndb.de>
	<1179022810.32247.54.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1179022810.32247.54.camel@localhost.localdomain>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, May 13, 2007 at 12:20:10PM +1000, Benjamin Herrenschmidt wrote:
>
> Then, the plans I have in mind for the future of that stuff are around
> the idea of registering "constructors" based on bus matches and device
> matches respectively.
> 
> The kernel will then walk the whole OF device-tree at boot, and will
> instanciate devices using those constructors, passing them the struct
> device of whatever was the parent.
> 
> Thus we could easily have platforms registers constructors for specific
> devices that build a platform device off an OF node.

Great. That should fit perfectly with the glue I have now, it'll turn
into the constructor instead.

I honestly don't see what the benefit is of this recent obsession
with creating of_platform devices for every new device that's not
PCI, especially when there's an already well-fitting driver in the
traditional platform model. It's not like the code to link the two is
large and complex.

Also, in this particular case, the bindings are not standardized, and
there's a good chance that whatever new platform uses a similar device
will need to do something slightly different.


-Olof
