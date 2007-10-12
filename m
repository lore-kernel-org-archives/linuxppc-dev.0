Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 42854DE02F
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 12:36:19 +1000 (EST)
Date: Thu, 11 Oct 2007 21:41:43 -0500
From: Olof Johansson <olof@lixom.net>
To: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [PATCH 2/2] powerpc: Switch to generic WARN_ON()/BUG_ON()
Message-ID: <20071012024143.GA20475@lixom.net>
References: <20071011171211.GB10877@lixom.net>
	<20071011171413.GC10877@lixom.net>
	<18190.52379.97647.468384@cargo.ozlabs.ibm.com>
	<20071012020419.GB19268@fattire.cabal.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071012020419.GB19268@fattire.cabal.ca>
Cc: grundler@parisc-linux.org, linux-kernel@vger.kernel.org,
	kyle@parisc-linux.org, linuxppc-dev@ozlabs.org,
	lethal@linux-sh.org, Paul Mackerras <paulus@samba.org>,
	akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 11, 2007 at 10:04:19PM -0400, Kyle McMartin wrote:
> On Fri, Oct 12, 2007 at 11:23:39AM +1000, Paul Mackerras wrote:
> > Olof Johansson writes:
> > 
> > > Not using the ppc-specific WARN_ON/BUG_ON constructs actually saves about
> > > 4K text on a ppc64_defconfig. The main reason seems to be that prepping
> > > the arguments to the conditional trap instructions is more work than
> > > just doing a compare and branch.
> > 
> > It might be more instructions but it takes fewer cycles, I would
> > expect.  Do you have the actual instruction sequences to compare?
> > 
> 
> I really hope WARN_ON/BUG_ON aren't hotpaths on powerpc. ;-)

Not the taken branch of them, no. :)  But making it past them as fast
as possible when they're not tripping is always good.


-Olof
