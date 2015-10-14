Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401FB1A0272
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 20:19:21 +1100 (AEDT)
Message-ID: <1444814360.1843.1.camel@ellerman.id.au>
Subject: Re: [RFC] powerpc/numa: Use VPHN based node ID information on
 shared processor LPARs
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, nacc@linux.vnet.ibm.com
Date: Wed, 14 Oct 2015 20:19:20 +1100
In-Reply-To: <1444813335-4009-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1444813335-4009-1-git-send-email-khandual@linux.vnet.ibm.com>
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

On Wed, 2015-10-14 at 14:32 +0530, Anshuman Khandual wrote:
> On shared processor LPARs, H_HOME_NODE_ASSOCIATIVITY hcall provides the
> dynamic virtual-physical mapping for any given processor. Currently we
> use VPHN node ID information only after getting either a PRRN or a VPHN
> event. But during boot time inside the function numa_setup_cpu, we still
> query the OF device tree for the node ID value which might be different
> than what can be fetched from the H_HOME_NODE_ASSOCIATIVITY hcall. In a
> scenario where there are no PRRN or VPHN event after boot, all node-cpu
> mapping will remain incorrect there after.
> 
> With this proposed change, numa_setup_cpu will try to override the OF
> device tree fetched node ID information with H_HOME_NODE_ASSOCIATIVITY
> hcall fetched node ID value. Right now shared processor property of the
> LPAR cannot be queried as VPA inializaion happens after numa_setup_cpu
> during boot time. So initmem_init function has been moved after ppc_md.
> setup_arch inside setup_arch during boot.

I would be *very* reluctant to change the order of initmem_init() vs
setup_arch().

At a minimum you'd need to go through every setup_arch() implementation and
carefully determine if the ordering of what it does matters vs initmem_init().
And then you'd need to test on every affected platform.

So I suggest you think of a different way to do it if at all possible.

cheers
