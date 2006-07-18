Return-Path: <horms@betty.vergenet.net>
Received: from betty.vergenet.net (betty.vergenet.net [64.85.198.114])
	by ozlabs.org (Postfix) with ESMTP id B5086679A6
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jul 2006 05:57:07 +1000 (EST)
Date: Tue, 18 Jul 2006 15:15:00 -0400
From: Horms <horms@verge.net.au>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] panic_on_oops: remove ssleep()
Message-ID: <20060718191456.GF20141@verge.net.au>
References: <200607172126_MC3-1-C544-E35A@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200607172126_MC3-1-C544-E35A@compuserve.com>
Cc: Andrew Morton <akpm@osdl.org>, Chris Zankel <chris@zankel.net>,
	Tony Luck <tony.luck@intel.com>,
	linux-ia64 <linux-ia64@vger.kernel.org>, discuss@x86-64.org,
	Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, Russell King <rmk@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 17, 2006 at 09:22:17PM -0400, Chuck Ebbert wrote:
> In-Reply-To: <31687.FP.7244@verge.net.au>
> 
> On Mon, 17 Jul 2006 12:17:20 -0400, Horms wrote:
> 
> > This patch is part of an effort to unify the panic_on_oops behaviour
> > across all architectures that implement it.
> > 
> > It was pointed out to me by Andi Kleen that if an oops has occured
> > in interrupt context, then calling sleep() in the oops path will only cause
> > a panic, and that it would be really better for it not to be in the path at
> > all. 
> 
> i386 already checks in_interrupt() and panics immediately:

Very good point. I guess that needs to be moved to after
panic_on_oops() if the change that Andi suggests works out.

-- 
Horms                                           
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/
