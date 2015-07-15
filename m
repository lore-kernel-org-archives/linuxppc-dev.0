Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3A8171A06C7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 08:44:00 +1000 (AEST)
Received: from /spool/local
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Wed, 15 Jul 2015 18:43:57 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id B9AB26E803C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 18:35:40 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6FMhs8a60293324
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 22:43:54 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6FMhqwf004979
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 18:43:53 -0400
Date: Wed, 15 Jul 2015 15:43:51 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Tejun Heo <tj@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 David Rientjes <rientjes@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] powerpc/numa: fix cpu_to_node() usage during boot
Message-ID: <20150715224351.GH38815@linux.vnet.ibm.com>
References: <20150702230202.GA2807@linux.vnet.ibm.com>
 <20150715203516.GI15934@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150715203516.GI15934@mtj.duckdns.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 15.07.2015 [16:35:16 -0400], Tejun Heo wrote:
> Hello,
> 
> On Thu, Jul 02, 2015 at 04:02:02PM -0700, Nishanth Aravamudan wrote:
> > we currently emit at boot:
> > 
> > [    0.000000] pcpu-alloc: [0] 0 1 2 3 [0] 4 5 6 7 
> > 
> > After this commit, we correctly emit:
> > 
> > [    0.000000] pcpu-alloc: [0] 0 1 2 3 [1] 4 5 6 7 
> 
> JFYI, the numbers in the brackets aren't NUMA node numbers but percpu
> allocation group numbers and they're not split according to nodes but
> percpu allocation units.  In both cases, there are two units each
> serving 0-3 and 4-7.  In the above case, because it wasn't being fed
> the correct NUMA information, both got assigned to the same group.  In
> the latter, they got assigned to different ones but even then if the
> group numbers match NUMA node numbers, that's just a coincidence.

Ok, thank you for clarifying! From a correctness perspective, even if
the numbers don't match NUMA nodes, should we expect the grouping to be
split along NUMA topology?

-Nish
