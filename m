Return-Path: <dgibson@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B6250B707B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 14:47:31 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A5A4FDDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 14:47:31 +1000 (EST)
Date: Fri, 11 Sep 2009 14:47:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mm: Cleanup handling of execute permission v2
Message-ID: <20090911044724.GA11840@yookeroo.seuss>
References: <1250658034.4810.9.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1250658034.4810.9.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 19, 2009 at 03:00:34PM +1000, Benjamin Herrenschmidt wrote:
> This is an attempt at cleaning up a bit the way we handle execute
> permission on powerpc. _PAGE_HWEXEC is gone, _PAGE_EXEC is now only
> defined by CPUs that can do something with it, and the myriad of
> #ifdef's in the I$/D$ coherency code is reduced to 2 cases that
> hopefully should cover everything.
> 
> The logic on BookE is a little bit different than what it was though
> not by much. Since now, _PAGE_EXEC will be set by the generic code
> for executable pages, we need to filter out if they are unclean and
> recover it. However, I don't expect the code to be more bloated than
> it already was in that area due to that change.
> 
> I could boast that this brings proper enforcing of per-page execute
> permissions to all BookE and 40x but in fact, we've had that now for
> some time as a side effect of my previous rework in that area (and
> I didn't even know it :-) We would only enable execute permission if
> the page was cache clean and we would only cache clean it if we took
> and exec fault. Since we now enforce that the later only work if
> VM_EXEC is part of the VMA flags, we de-fact already enforce per-page
> execute permissions... Unless I missed something
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
