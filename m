Return-Path: <andi@firstfloor.org>
Received: from one.firstfloor.org (one.firstfloor.org [213.235.205.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 324AFB7CF6
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Mar 2010 06:33:23 +1100 (EST)
To: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH 2/4] panic: Allow taint flag for warnings to be changed
	from TAINT_WARN
From: Andi Kleen <andi@firstfloor.org>
References: <1269126097.18314.111.camel@localhost>
	<1269126340.18314.115.camel@localhost>
Date: Sun, 21 Mar 2010 20:10:43 +0100
In-Reply-To: <1269126340.18314.115.camel@localhost> (Ben Hutchings's message
	of "Sat, 20 Mar 2010 23:05:40 +0000")
Message-ID: <87y6hlebik.fsf@basil.nowhere.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-s390@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>, linuxppc-dev@ozlabs.org,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben Hutchings <ben@decadent.org.uk> writes:

> WARN() is used in some places to report firmware or hardware bugs that
> are then worked-around.  These bugs do not affect the stability of the
> kernel and should not set the usual TAINT_WARN flag.  To allow for
> this, add WARN_TAINT() and WARN_TAINT_ONCE() macros that take a taint
> flag as argument.
>
> Architectures that implement warnings using trap instructions instead
> of calls to warn_slowpath_*() must now implement __WARN_TAINT(taint)
> instead of __WARN().

I guess this should enforce that at least some taint flag is set?
(e.g. with a BUILD_BUG_ON)

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
