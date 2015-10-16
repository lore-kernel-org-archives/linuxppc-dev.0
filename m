Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 96C131A037C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2015 13:24:48 +1100 (AEDT)
Message-ID: <1444962288.28419.2.camel@ellerman.id.au>
Subject: Re: [RFC] powerpc/numa: Use VPHN based node ID information on
 shared processor LPARs
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, nacc@linux.vnet.ibm.com
Date: Fri, 16 Oct 2015 13:24:48 +1100
In-Reply-To: <561E2AB4.3040608@linux.vnet.ibm.com>
References: <1444813335-4009-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1444814360.1843.1.camel@ellerman.id.au>
 <561E2AB4.3040608@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-10-14 at 15:43 +0530, Anshuman Khandual wrote:
> On 10/14/2015 02:49 PM, Michael Ellerman wrote:
> > On Wed, 2015-10-14 at 14:32 +0530, Anshuman Khandual wrote:
> >> On shared processor LPARs, H_HOME_NODE_ASSOCIATIVITY hcall provides the
> >> dynamic virtual-physical mapping for any given processor. Currently we
> >> use VPHN node ID information only after getting either a PRRN or a VPHN
> >> event. But during boot time inside the function numa_setup_cpu, we still
> >> query the OF device tree for the node ID value which might be different
> >> than what can be fetched from the H_HOME_NODE_ASSOCIATIVITY hcall. In a
> >> scenario where there are no PRRN or VPHN event after boot, all node-cpu
> >> mapping will remain incorrect there after.
> >>
> >> With this proposed change, numa_setup_cpu will try to override the OF
> >> device tree fetched node ID information with H_HOME_NODE_ASSOCIATIVITY
> >> hcall fetched node ID value. Right now shared processor property of the
> >> LPAR cannot be queried as VPA inializaion happens after numa_setup_cpu
> >> during boot time. So initmem_init function has been moved after ppc_md.
> >> setup_arch inside setup_arch during boot.
> > 
> > I would be *very* reluctant to change the order of initmem_init() vs
> > setup_arch().
> > 
> > At a minimum you'd need to go through every setup_arch() implementation and
> > carefully determine if the ordering of what it does matters vs initmem_init().
> > And then you'd need to test on every affected platform.
> > 
> > So I suggest you think of a different way to do it if at all possible.
> 
> vpa_init() is being called inside pSeries_setup_arch which is ppc_md
> .setup_arch for the platform. Its called directly for the boot cpu
> and through smp_init_pseries_xics for other cpus on the system. Not
> sure what is the reason behind calling vpa_init() from XICS init
> though.
> 
> If we can move all these vpa_init() calls from pSeries_setup_arch
> to initmem_init just before calling numa_setup_cpu, the VPA area
> would be initialized when we need it during boot. Will look in
> this direction.

Back up a bit. The dependency on vpa_init() is only because you want to call
lppaca_shared_proc() right?

But do you really need to? What happens if you call VPHN on a non-shared proc
machine? Does it 1) give you something sane or 2) give you an error or 3) give
you a junk value?

If it's either of 1 or 2 then you should be OK to just call it. You either use
the value it returned which is sane or you see the error and just fall back to
the device tree nid.

cheers
