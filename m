Return-Path: <flar@cynthia.pants.nu>
Received: from cynthia.pants.nu (unknown [76.245.85.235])
	by ozlabs.org (Postfix) with ESMTP id C61FFDE325
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 09:40:52 +1000 (EST)
Date: Wed, 6 Aug 2008 15:55:47 -0700
From: Brad Boyer <flar@allandria.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH 1/3] powerpc: add ioremap_bat() function for setting
	up BAT translated IO regions.
Message-ID: <20080806225547.GB27245@cynthia.pants.nu>
References: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>
	<20080806060223.30717.35175.stgit@trillian.secretlab.ca>
	<CD66FAA8-BC99-4630-9FFF-E2C651E5DE9A@kernel.crashing.org>
	<fa686aa40808061454t14737278h3fd15fb0ccdbf251@mail.gmail.com>
	<75A0A752-FF2C-41B6-A6D3-E510E8FD4E91@kernel.crashing.org>
	<1218061709.24157.249.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1218061709.24157.249.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 07, 2008 at 08:28:29AM +1000, Benjamin Herrenschmidt wrote:
> 
> > there is a bunch of error checking and difference in semantics that  
> > you need to fix.  I think introduce a new API for this is silly,  
> > especially since we expect there to only be one actual invocation of  
> > the API for serial console access.
> 
> Not necessarily....
> 
> There's another aspect to BAT mappings here. First, they should be
> permanent (ie, not unmappable). That way, we have ioremap just use
> an existing BAT mapping when asked for a device that is covered
> by a BAT. This allows to have platform code do something like setup
> a BAT over a bunch of SOC registers or over a device, to automagically
> get drivers doing ioremap to that area benefit from it.

The m68k arch code does something similar with TT registers and ioremap,
but it's a little hackish currently. If there was a more generic way
to handle it, that would make things a little cleaner. In the m68k
implementation, there are just exceptions in the ioremap code that are
hard wired to know about the ranges that are normally set earlier. Since
the ranges end up being in multiple files, it's more fragile to change
what is mapped in these blocks.

	Brad Boyer
	flar@allandria.com
