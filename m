Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] Cell and new CPU feature bits
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Rosenberg <alex_rosenberg@playstation.sony.com>
In-Reply-To: <995508C0-6D30-479A-8ED5-C28CC0143DB7@playstation.sony.com>
References: <1148011621.13249.7.camel@localhost.localdomain>
	<20060519081654.GB22952@iram.es>
	<995508C0-6D30-479A-8ED5-C28CC0143DB7@playstation.sony.com>
Content-Type: text/plain
Date: Wed, 24 May 2006 07:52:29 +1000
Message-Id: <1148421149.13249.79.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > Is this bug really going to be exposed in the wild or is it
> > an early silicon bug that will only bite early-testers?
> 
> Is this or any other errata published somewhere? I didn't think they  
> were.

I don't know, but I got approval to publically talk about that one (that
is to get a fix in the kernel, the vDSO, and see with Steve Munroe about
getting one in glibc hptiming as well)

> Our solution back at Apple was to put OF properties on the CPU node  
> for each optional feature. e.g. for fres and frsqrte we put  
> "graphics" since that's the official term for that group of optional  
> instructions. We also put in "data-streams" instead of presuming that  
> dss, etc. were always part of "altivec". These properties nicely fit  
> into our Gestalt() API where "ppcf" had 32 bits to describe these to  
> userland software.

Our firmwares do something similar, at least on pSeries (the cell blade
firmware may need a bit of kicking there). But that's only useful for
the kernel. I'm more interested about what is best to expose those to
userland and we have no such thing as good ol' Gestalt there :) We have
AT_HWCAP which we already use for a combination of things, and I was
wondering about the risk of running out of bits in there. Maybe we'll
have to extend the thing a bit.

I suppose the datastream instructions will mandate their own bits,
though nobody on the field seem to use them on linux at least on open
source code I've seen, and I'll probably add a separate bit for the new
altivec instructions. I was wondering if I should define a bit for those
"graphics" instruction and dcbf X form (at least the later could be just
derived from the uArchitecture bits in there)

Cheers,
Ben.
