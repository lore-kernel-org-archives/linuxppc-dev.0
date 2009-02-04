Return-Path: <wli@movementarian.org>
Received: from movementarian.org (movementarian.org [79.99.65.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4F940DDED7
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 08:01:03 +1100 (EST)
Date: Wed, 4 Feb 2009 16:00:37 -0500
From: wli@movementarian.org
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: FW: [PATCH] powerpc/mm: Export HPAGE_SHIFT
Message-ID: <20090204210037.GC10229@movementarian.org>
References: <20090203164930.GA10101@mtls03> <ada8wonnh3t.fsf@cisco.com>
	<1233712248.16867.131.camel@pasglop>
	<20090203211329.d6190a08.akpm@linux-foundation.org>
	<aday6wmn2vr.fsf@cisco.com>
	<20090203222601.747ca8b7.akpm@linux-foundation.org>
	<adad4dym2zp.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <adad4dym2zp.fsf@cisco.com>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Eli Cohen <eli@mellanox.co.il>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 04, 2009 at 11:11:22AM -0800, Roland Dreier wrote:
> Heh.  Looking into the implementation, it seems that I could actually do
> 	PAGE_SIZE << compound_order(page)
> directly (since there's no reason to go from size to hstate and back to
> size.  I don't know all the details of these VM internals, but that
> seems to only work on the first (small) page of a giant page?  Which
> causes problems for what we're trying to do here...

You should be able to find the head of a compound page using the
compound_head() inline, so try

	PAGE_SIZE << compound_order(compound_head(page))


-- wli
