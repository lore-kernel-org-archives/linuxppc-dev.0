Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D2C551A0475
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Sep 2014 19:53:24 +1000 (EST)
Message-ID: <1409824374.4246.62.camel@pasglop>
Subject: Re: bit fields && data tearing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Laight <David.Laight@ACULAB.COM>
Date: Thu, 04 Sep 2014 19:52:54 +1000
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D17487172@AcuExch.aculab.com>
References: <20140712181328.GA8738@redhat.com>
 <54079B70.4050200@hurleysoftware.com> <1409785893.30640.118.camel@pasglop>
 <063D6719AE5E284EB5DD2968C1650D6D17487172@AcuExch.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Jakub Jelinek <jakub@redhat.com>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Tony Luck <tony.luck@intel.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Peter Hurley <peter@hurleysoftware.com>, Oleg Nesterov <oleg@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, "Paul E.
 McKenney" <paulmck@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Miroslav Franc <mfranc@redhat.com>, Richard Henderson <rth@twiddle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-09-04 at 08:43 +0000, David Laight wrote:
> From:  Benjamin Herrenschmidt
> > On Wed, 2014-09-03 at 18:51 -0400, Peter Hurley wrote:
> > 
> > > Apologies for hijacking this thread but I need to extend this discussion
> > > somewhat regarding what a compiler might do with adjacent fields in a structure.
> > >
> > > The tty subsystem defines a large aggregate structure, struct tty_struct.
> > > Importantly, several different locks apply to different fields within that
> > > structure; ie., a specific spinlock will be claimed before updating or accessing
> > > certain fields while a different spinlock will be claimed before updating or
> > > accessing certain _adjacent_ fields.
> > >
> > > What is necessary and sufficient to prevent accidental false-sharing?
> > > The patch below was flagged as insufficient on ia64, and possibly ARM.
> > 
> > We expect native aligned scalar types to be accessed atomically (the
> > read/modify/write of a larger quantity that gcc does on some bitfield
> > cases has been flagged as a gcc bug, but shouldn't happen on normal
> > scalar types).
> 
> That isn't true on all architectures for items smaller than a machine word.
> At least one has to do rmw for byte accesses.

Yeah correct, alpha and bytes right ? Is there any other ? That's why I
suggested int.

> 	David
> 
> > I am not 100% certain of "bool" here, I assume it's treated as a normal
> > scalar and thus atomic but if unsure, you can always use int.
> > 
> > Another option is to use the atomic bitops and make these bits in a
> > bitmask but that is probably unnecessary if you have locks already.
> > 
> > Cheers,
> > Ben.
