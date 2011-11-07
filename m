Return-Path: <jpoimboe@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e37.co.us.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 9D3521007D4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2011 02:14:44 +1100 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jpoimboe@linux.vnet.ibm.com>;
 Mon, 7 Nov 2011 08:14:39 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pA7FDqhI155468
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2011 08:14:09 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pA7FDhZ2026083
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2011 08:13:44 -0700
Subject: Re: [PATCH v2 1/5] [ppc] Process dynamic relocations for kernel
From: Josh Poimboeuf <jpoimboe@linux.vnet.ibm.com>
To: Suzuki Poulose <suzuki@in.ibm.com>
In-Reply-To: <4EB3A40C.1070802@in.ibm.com>
References: <20111025114829.8183.1725.stgit@suzukikp.in.ibm.com>
 <20111025115354.8183.48237.stgit@suzukikp.in.ibm.com>
 <1320276969.3309.3.camel@treble>  <4EB3A40C.1070802@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 07 Nov 2011 09:13:39 -0600
Message-ID: <1320678819.2750.15.camel@treble>
Mime-Version: 1.0
Cc: Nathan Miller <nathanm2@us.ibm.com>, Josh Poimboeuf <jpoimboe@us.ibm.com>,
 Dave Hansen <dave@linux.vnet.ibm.com>, Alan Modra <amodra@au1.ibm.com>,
 Scott Wood <scottwood@freescale.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-11-04 at 14:06 +0530, Suzuki Poulose wrote:
> On 11/03/11 05:06, Josh Poimboeuf wrote:
> > On Tue, 2011-10-25 at 17:23 +0530, Suzuki K. Poulose wrote:
> > @@ -137,6 +137,9 @@ get_type:
> >   	lwz	r0, 8(r9)	/* r_addend */
> >   	add	r0, r0, r3	/* final addend */
> >   	stwx	r0, r4, r7	/* memory[r4+r7]) = (u32)r0 */
> > +	dcbst	r4,r7		/* flush dcache line to memory */
> > +	sync			/* wait for flush to complete */
> > +	icbi	r4,r7		/* invalidate icache line */
> 
> Doing it this way has two drawbacks :
> 
> 1) Placing it here in relocate would do the flushing for each and every update.

I agree.  My kernel had around 80,000 relocations, which means 80,000
d-cache line flushes (for a 32k d-cache) and 80,000 i-cache line
invalidates (for a 32k i-cache).  Which is obviously a little overkill.
Although I didn't notice a performance hit during boot.


> 2) I would like to keep this code as generic as possible for the PPC32 code.
> 
> Could we move this to the place from relocate is called and flush the d-cache and
> i-cache entirely ?

Why not put the cache flushing code at the end of relocate?  Would some
of the other PPC32 platforms not require the cache flushing?

My PPC32 knowledge is 4xx-centric, so please feel free to rewrite the
patch as needed to accommodate other PPC32 cores.


Thanks,
Josh
