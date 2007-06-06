Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 1EE34DDEDF
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 08:18:29 +1000 (EST)
Date: Wed, 6 Jun 2007 17:24:57 -0500
To: Timur Tabi <timur@freescale.com>
Subject: Re: MPC8349ea Random Device Generator driver
Message-ID: <20070606222456.GA28225@lixom.net>
References: <BAY122-F18923A7AA6D3A4D96A360085200@phx.gbl>
	<46672DB4.80504@freescale.com> <20070606220913.GA27820@lixom.net>
	<46673009.6000109@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46673009.6000109@freescale.com>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, sl@powerlinux.fr,
	Philippe Lachenal <philippe.lachenal@hotmail.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 06, 2007 at 05:07:05PM -0500, Timur Tabi wrote:
> Olof Johansson wrote:
> 
> >There's nothing wrong with the way he coded that up. Lots of drivers
> >are written that way (all of mine are). It's at least as clear as any
> >structure, and it doesn't cause temptation to do...
> 
> That vast majority of Freescale SOC device register maps are handled via a 
> structure. He's doing everything via 32-bit operations, even though the 
> registers are 64 bits, and therefore he has twice as much macros as he 
> needs.

I see only one double access back to back, not a big deal. I do however
fail to see how a couple of constructs are working, separate email with
those questions later though.

> >>>+
> >>>+
> >>>+	/* check for things like FIFO underflow */
> >>>+	
> >>>+	u32 v;
> >>>+
> >>>+	v = in_be32(rng_regs + TALITOS_RNGISR_HI);
> >>	u64 v;
> >>	v = rng->rngisr;
> >>
> >>or something like that.  Try to use the built-in support for 64-bit data 
> >>types when possible.
> >
> >...this. NO! Don't reference ioremapped memory from regular code like
> >that. The way he's doing it is the preferred way.
> 
> Can you explain that better?  What is "regular code"?

>From http://kerneltrap.org/node/3848:

---
In the byte-order case, what we have is:

	typedef __u16 __bitwise __le16;
	typedef __u16 __bitwise __be16;
	typedef __u32 __bitwise __le32;
	typedef __u32 __bitwise __be32;
	typedef __u64 __bitwise __le64;
	typedef __u64 __bitwise __be64;

and if you think about the above rules about what is acceptable for 
bitwise types, you'll likely immediately notivce that it automatically 
means

 - you can never assign a __le16 type to any other integer type or any 
   other bitwise type. You'd get a warnign about incompatible types. Makes 
   sense, no?
...
---

Note that rngisr is __be64.  Sparse should complain loudly over your code.


-Olof
