Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9AE361A01AA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 12:40:24 +1100 (AEDT)
Message-ID: <1427679624.4218.5.camel@ellerman.id.au>
Subject: Re: [PATCH v3] powerpc: Use PFN_PHYS() to avoid truncating the
 physical address
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <scottwood@freescale.com>
Date: Mon, 30 Mar 2015 12:40:24 +1100
In-Reply-To: <1427479651.22867.151.camel@freescale.com>
References: <1427291352-31256-1-git-send-email-Emilian.Medve@Freescale.com>
 <FB8A0580-9A76-4F83-BDE7-2EECC0063C1C@kernel.crashing.org>
 <5514264A.6020502@Freescale.com> <1427413505.23142.3.camel@ellerman.id.au>
 <1427479651.22867.151.camel@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Emil Medve <Emilian.Medve@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-03-27 at 13:07 -0500, Scott Wood wrote:
> On Fri, 2015-03-27 at 10:45 +1100, Michael Ellerman wrote:
> > On Thu, 2015-03-26 at 10:31 -0500, Emil Medve wrote:
> > > Hello Kumar,
> > > 
> > > 
> > > On 03/26/2015 10:18 AM, Kumar Gala wrote:
> > > > Why no commit message with what issue this change was trying to fix?
> > > 
> > > A while back, when I attempted to remove bootmem (in favor of just plain
> > > memblock as in powerpc land bootmem was just a wrapper to memblock
> > > anyway) I run at some point into a problem with an intermediate address
> > > value because of this '<< PAGE_SHIFT' on the wrong width variable. Using
> > > PFN_PHYS() took care of it (it has a cast) so I decided to get this
> > > defensive patch applied. Since, I dropped my bootmem/memblock patches in
> > > favor to Anton's (Blanchard) work so my concrete issue example is
> > > somewhat gone
> > 
> > I'm not a big fan of it unless it's actually fixing an issue. It's a lot of
> > churn and the end result is less readable IMHO.
> 
> It is fixing an issue -- the issue is that there are overflow errors in
> the code.  Some of the places Emil fixed are only for platforms that
> don't have physical addresses larger than pointers, or have the needed
> casts, or are known to be dealing with lowmem, but others aren't.  E.g.
> page_is_ram() and devmem_is_allowed() are buggy on 32-bit with 64-bit
> physical.

Right. So obviously I'm fine with all the cases where it fixes an actual bug.
 
> flush_dcache_icache_page() is buggy on mpc86xx with more than 4 GiB RAM
> -- though that would still be buggy even with this change, due to
> __flush_dcache_icache_phys taking unsigned long.  The entire concept of
> that function doesn't work for sizeof(phys_addr_t) > sizeof(void *), so
> in this case 86xx should be using the booke code instead.
> 
> Even in the places where overflow can't happen due to the above
> circumstances (other than having the needed cast), it's setting a bad
> example that can be copied to places where it will break, or the
> circumstances of the code could change (e.g. currently 64-bit-only code
> being used on 32-bit).

I agree with that in principle, but it looks like in a bunch of places this
patch ends up assigning the result to unsigned long anyway.

So those cases are just churn IMHO. The end result doesn't work with 64-bit
phys if the code is ever used there, even though it looks like maybe it should,
and it's also not setting a good example for other code. Those cases should
either be left alone, or fixed properly to use phys_addr_t.

cheers
