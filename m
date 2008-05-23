Return-Path: <npiggin@suse.de>
Received: from mx2.suse.de (ns2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2409FDE093
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 15:48:53 +1000 (EST)
Date: Fri, 23 May 2008 07:48:47 +0200
From: Nick Piggin <npiggin@suse.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 1/2] powerpc: rmb fix
Message-ID: <20080523054846.GA4520@wotan.suse.de>
References: <20080521141056.GC8897@wotan.suse.de>
	<1211383623.8297.197.camel@pasglop>
	<20080521153247.GF8897@wotan.suse.de>
	<18486.10385.934128.122054@cargo.ozlabs.ibm.com>
	<20080523044052.GA13071@wotan.suse.de>
	<18486.19905.421960.700640@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18486.19905.421960.700640@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 23, 2008 at 02:53:21PM +1000, Paul Mackerras wrote:
> Nick Piggin writes:
> 
> > There don't seem to actually be read*_relaxed calls that also use rmb
> > in the same file (although there is no reason why they might not appear).
> > But I must be thinking of are the raw_read accessors. They aren't ordered
> > on powerpc, and a few drivers appear to hope rmb() will order them.
> 
> Which drivers?

net/macb.c, net/sfc/falcon_io.c... hmm, I thought there was a couple
more but maybe I was thinking of write side.

Anyway, even if there were zero, then the point is still that you
implement that API, so you should either strongly order your
__raw_ and _relaxed then you can weaken your rmb, or you have to
strengthen your rmb to match your weak read ops.

Saying it doesn't matter because there are no drivers is likely to
cause more headaches in future...
