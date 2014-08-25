Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B817E1A009C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Aug 2014 14:16:19 +1000 (EST)
Message-ID: <1408940178.7941.3.camel@concordia>
Subject: Re: [PATCH] powerpc/pseries: Drop unnecessary continue
From: Michael Ellerman <mpe@ellerman.id.au>
To: Robert Jennings <rcj4747@gmail.com>
Date: Mon, 25 Aug 2014 14:16:18 +1000
In-Reply-To: <53F61586.3000107@gmail.com>
References: <20140813091847.GA3078@himangi-Dell>
 <1408596086.9307.3.camel@concordia> <53F61586.3000107@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>,
 Himangi Saraogi <himangi774@gmail.com>, Brian King <brking@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-08-21 at 10:51 -0500, Robert Jennings wrote:
> On 08/20/2014 11:41 PM, Michael Ellerman wrote:
> > On Wed, 2014-08-13 at 14:48 +0530, Himangi Saraogi wrote:
> >> Continue is not needed at the bottom of a loop.
> > 
> > True.
> > 
> > I wonder though, is the code trying to continue to the outer loop?
> > I stared at it for a minute but it wasn't obvious.
> > 
> > I wonder if Robert still remembers?
> 
> I don't recall what the intent was here.  Can't believe that it's been
> almost 5 years since I wrote this.  I wish I had left a few more
> comments in the code for me to go on.
> 
> Obviously the continue should be removed since it's not doing
> anything.  I don't believe that we'd want a continue statement in
> there to get outer loop.  That would change the current cmm_page_array
> pointer (pa_curr) to the next in the list after it may have just been
> reassigned to pa_last->next.
> 
> It may be the case that an earlier version of the code had statements
> in the inner loop after that continue that I wanted to skip, or I just
> did something silly.

OK, thanks for looking at it. I came to a similar conclusion, but good to have
your review as well.

The CMM regression test suite will catch us if we get it wrong anyway.

cheers
