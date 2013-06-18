Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A943B2C029B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 11:29:24 +1000 (EST)
Message-ID: <1371518949.21896.162.camel@pasglop>
Subject: Re: [PATCH 1/2] powerpc: add Book E support to 64-bit hibernation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Tue, 18 Jun 2013 11:29:09 +1000
In-Reply-To: <1371514923.9073.14@snotra>
References: <1371513683.9073.6@snotra> <1371514650.21896.160.camel@pasglop>
 <1371514923.9073.14@snotra>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "anton@enomsg.org" <anton@enomsg.org>,
 Wang Dongsheng-B40534 <B40534@freescale.com>,
 "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-06-17 at 19:22 -0500, Scott Wood wrote:
> On 06/17/2013 07:17:30 PM, Benjamin Herrenschmidt wrote:
> > On Mon, 2013-06-17 at 19:01 -0500, Scott Wood wrote:
> > > I really doubt the exception scratch registers need to be saved --
> > > we're not trying to restore into the middle of an exception
> > > prolog/epilog.
> > >
> > > book3s has the PACA as well and they don't save it.  Don't we rely  
> > on
> > > things like boot-time memory allocations happening in the same place
> > > when we resume?  extlb is part of the PACA, so the same applies.
> > 
> > I doubt we seriously tested hibernation :-) The PACA SPR should
> > definitely be saved/restored.
> 
> OK.  It's not obvious to me how much the entire mechanism depends on  
> things like boot time allocations being the same each time -- if we do  
> depend on that in general, then the PACA shouldn't change on a  
> particular CPU, right?

No we shouldn't be depending on that stuff.

> Is it possible to restore on a different CPU than we saved on?  If so,  
> could restoring the PACA leave us pointing to a different CPU's PACA?

Today on your code no, but of course this needs to be handled, the PACA
should be restored along with other thing, but for the right
processor :-)

Cheers,
Ben.
