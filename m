Return-Path: <jakub@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 02E761A015B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Sep 2014 19:10:22 +1000 (EST)
Date: Thu, 4 Sep 2014 11:09:52 +0200
From: Jakub Jelinek <jakub@redhat.com>
To: Mikael Pettersson <mikpelinux@gmail.com>
Subject: Re: bit fields && data tearing
Message-ID: <20140904090952.GW17454@tucnak.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20140712181328.GA8738@redhat.com>
 <54079B70.4050200@hurleysoftware.com>
 <1409785893.30640.118.camel@pasglop>
 <21512.10628.412205.873477@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <21512.10628.412205.873477@gargle.gargle.HOWL>
Cc: linux-arch@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
 linux-ia64@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>,
 Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Miroslav Franc <mfranc@redhat.com>, Richard Henderson <rth@twiddle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 04, 2014 at 10:57:40AM +0200, Mikael Pettersson wrote:
> Benjamin Herrenschmidt writes:
>  > On Wed, 2014-09-03 at 18:51 -0400, Peter Hurley wrote:
>  > 
>  > > Apologies for hijacking this thread but I need to extend this discussion
>  > > somewhat regarding what a compiler might do with adjacent fields in a structure.
>  > > 
>  > > The tty subsystem defines a large aggregate structure, struct tty_struct.
>  > > Importantly, several different locks apply to different fields within that
>  > > structure; ie., a specific spinlock will be claimed before updating or accessing
>  > > certain fields while a different spinlock will be claimed before updating or
>  > > accessing certain _adjacent_ fields.
>  > > 
>  > > What is necessary and sufficient to prevent accidental false-sharing?
>  > > The patch below was flagged as insufficient on ia64, and possibly ARM.
>  > 
>  > We expect native aligned scalar types to be accessed atomically (the
>  > read/modify/write of a larger quantity that gcc does on some bitfield
>  > cases has been flagged as a gcc bug, but shouldn't happen on normal
>  > scalar types).
>  > 
>  > I am not 100% certain of "bool" here, I assume it's treated as a normal
>  > scalar and thus atomic but if unsure, you can always use int.
> 
> Please use an aligned int or long.  Some machines cannot do atomic
> accesses on sub-int/long quantities, so 'bool' may cause unexpected
> rmw cycles on adjacent fields.

Yeah, at least pre-EV56 Alpha performs rmw cycles on char/short accesses
and thus those are not atomic.

	Jakub
