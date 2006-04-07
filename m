Return-Path: <arnd.bergmann@de.ibm.com>
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [PATCH 4/5] powerpc: export symbols for page size
	selection
Date: Fri, 7 Apr 2006 18:03:01 +0200
References: <20060407150124.422051000@dyn-9-152-242-103.boeblingen.de.ibm.com>
	<20060407152813.GA382@lst.de> <20060407154247.GJ952@pb15.lixom.net>
In-Reply-To: <20060407154247.GJ952@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200604071803.01836.arnd.bergmann@de.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 07 April 2006 17:42, Olof Johansson wrote:
> Yeah, what's the need for that, really? It needs to know so much of
> kernel internals that it's getting silly to allow it to be a module.
> 
It's still quite handy to have the actual file system as a module,
because

a) the module is rather bloated atm, it's about 200kb including the
   embedded spu code that it runs for context switch. I don't want
   to burden the generic distros with that
b) It simplifies development a bit to not have to reload the whole
   kernel when making changes. Booting with all the HW debugger stuff
   enabled takes quite a bit of time, especially when you have to
   tunnel the binaries through our internal network ;-).

We currently have two modules, and the base module has most of the
stuff that has dependencies on exported symbols. The binary is
25k on my system (with some debugging options enabled).

How about if I do a patch that always includes the base but not
the actual file system?

	Arnd <><
