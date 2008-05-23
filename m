Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18486.26325.220602.226442@cargo.ozlabs.ibm.com>
Date: Fri, 23 May 2008 16:40:21 +1000
From: Paul Mackerras <paulus@samba.org>
To: Nick Piggin <npiggin@suse.de>
Subject: Re: [patch 1/2] powerpc: rmb fix
In-Reply-To: <20080523054846.GA4520@wotan.suse.de>
References: <20080521141056.GC8897@wotan.suse.de>
	<1211383623.8297.197.camel@pasglop>
	<20080521153247.GF8897@wotan.suse.de>
	<18486.10385.934128.122054@cargo.ozlabs.ibm.com>
	<20080523044052.GA13071@wotan.suse.de>
	<18486.19905.421960.700640@cargo.ozlabs.ibm.com>
	<20080523054846.GA4520@wotan.suse.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nick Piggin writes:

> Anyway, even if there were zero, then the point is still that you
> implement that API, so you should either strongly order your
> __raw_ and _relaxed then you can weaken your rmb, or you have to
> strengthen your rmb to match your weak read ops.
> 
> Saying it doesn't matter because there are no drivers is likely to
> cause more headaches in future...

Well, it seems that rmb is used in several ways:

(1) to order reads from normal memory w.r.t. each other
(2) to order readl et al. w.r.t. reads from normal memory
(3) to order readl_relaxed et al. w.r.t. reads from normal memory

and I want to get a feeling for how prevalent each type of use is.

Now, the instances of (1) can presumably be converted to smb_rmb().
The instances of (2) aren't necessary on powerpc because readl
etc. are fully synchronous -- but that mightn't be true on other
platforms.  And for the instances of (3), powerpc needs to use sync,
as you say.

If the instances of (2) have to stay, then I would rather try to work
out some way that rmb doesn't have to be a sync, or at least doesn't
always have to be a sync.  And that might mean redefining the meaning
of rmb so that the instances of (3) have to be changed to something
else.  Since (3) seems to be rarer than (2), it would presumably be
(3) that we would change rather than (2).

Paul.
