Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 421wrp02clzF37Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2018 20:41:29 +1000 (AEST)
Date: Fri, 31 Aug 2018 12:41:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Mel Gorman <mgorman@techsingularity.net>, Rik van Riel <riel@surriel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Andre Wild <wild@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH] sched/topology: Use Identity node only if required
Message-ID: <20180831104115.GH24124@hirez.programming.kicks-ass.net>
References: <1533712172-11428-1-git-send-email-srikar@linux.vnet.ibm.com>
 <20180808075840.GO2494@hirez.programming.kicks-ass.net>
 <20180810164533.GB42350@linux.vnet.ibm.com>
 <20180829084348.GO24124@hirez.programming.kicks-ass.net>
 <20180831102248.GA8437@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180831102248.GA8437@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 31, 2018 at 03:22:48AM -0700, Srikar Dronamraju wrote:

> At boot: Before topology update.

How does that work; you do SMP bringup _before_ you know the topology !?

> After topology update.
> 
> For CPU 0
> domain-0: span=0-7 level=SMT
>  groups: 0:{ span=0 }, 1:{ span=1 }, 2:{ span=2 }, 3:{ span=3 }, 4:{ span=4 }, 5:{ span=5 }, 6:{ span=6 }, 7:{ span=7 }
>  domain-1: span=0-7,32-39,64-71,96-103,128-135,160-167,192-199,224-231,256-263,288-295 level=DIE
>   groups: 0:{ span=0-7 cap=8192 }, 32:{ span=32-39 cap=8192 }, 64:{ span=64-71 cap=8192 }, 96:{ span=96-103 cap=8192 }, 128:{ span=128-135 cap=8192 }, 160:{ span=160-167 cap=8192 }, 192:{ span=192-199 cap=8192 }, 224:{ span=224-231 cap=8192 }, 256:{ span=256-263 cap=8192 }, 288:{ span=288-295 cap=8192 }
>   domain-2: span=0-303 level=NODE
>    groups: 0:{ span=0-7,32-39,64-71,96-103,128-135,160-167,192-199,224-231,256-263,288-295 cap=81920 }, 8:{ span=8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303 cap=81920 }, 16:{ span=16-23,48-55,80-87,112-119,144-151,176-183,208-215,240-247,272-279 cap=73728 }, 24:{ span=24-31,56-63,88-95,120-127,152-159,184-191,216-223,248-255,280-287 cap=73728 }
> 
> For CPU 1
> domain-0: span=0-7 level=SMT
>  groups: 1:{ span=1 }, 2:{ span=2 }, 3:{ span=3 }, 4:{ span=4 }, 5:{ span=5 }, 6:{ span=6 }, 7:{ span=7 }, 0:{ span=0 }
>  domain-1: span=0-7,32-39,64-71,96-103,128-135,160-167,192-199,224-231,256-263,288-295 level=DIE
>   groups: 0:{ span=0-7 cap=8192 }, 32:{ span=32-39 cap=8192 }, 64:{ span=64-71 cap=8192 }, 96:{ span=96-103 cap=8192 }, 128:{ span=128-135 cap=8192 }, 160:{ span=160-167 cap=8192 }, 192:{ span=192-199 cap=8192 }, 224:{ span=224-231 cap=8192 }, 256:{ span=256-263 cap=8192 }, 288:{ span=288-295 cap=8192 }
>   domain-2: span=0-303 level=NODE
>    groups: 0:{ span=0-7,32-39,64-71,96-103,128-135,160-167,192-199,224-231,256-263,288-295 cap=81920 }, 8:{ span=8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303 cap=81920 }, 16:{ span=16-23,48-55,80-87,112-119,144-151,176-183,208-215,240-247,272-279 cap=73728 }, 24:{ span=24-31,56-63,88-95,120-127,152-159,184-191,216-223,248-255,280-287 cap=73728 }
> 
> 
> For CPU 8
>  domain-0: span=8-15 level=SMT
>   groups: 8:{ span=8 }, 9:{ span=9 }, 10:{ span=10 }, 11:{ span=11 }, 12:{ span=12 }, 13:{ span=13 }, 14:{ span=14 }, 15:{ span=15 }
>   domain-1: span=8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303 level=DIE
>    groups: 8:{ span=8-15 cap=8192 }, 40:{ span=40-47 cap=8192 }, 72:{ span=72-79 cap=8192 }, 104:{ span=104-111 cap=8192 }, 136:{ span=136-143 cap=8192 }, 168:{ span=168-175 cap=8192 }, 200:{ span=200-207 cap=8192 }, 232:{ span=232-239 cap=8192 }, 264:{ span=264-271 cap=8192 }, 296:{ span=296-303 cap=8192 }
>    domain-2: span=8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303 level=NODE
>     groups: 8:{ span=8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303 cap=81920 }
>     domain-3: span=0-303 level=NUMA
>      groups: 8:{ span=8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303 cap=81920 }, 16:{ span=16-23,48-55,80-87,112-119,144-151,176-183,208-215,240-247,272-279 cap=73728 }, 24:{ span=24-31,56-63,88-95,120-127,152-159,184-191,216-223,248-255,280-287 cap=73728 }
> ERROR: groups don't span domain->span
> 
> For CPU 9
>  domain-0: span=8-15 level=SMT
>   groups: 9:{ span=9 }, 10:{ span=10 }, 11:{ span=11 }, 12:{ span=12 }, 13:{ span=13 }, 14:{ span=14 }, 15:{ span=15 }, 8:{ span=8 }
>   domain-1: span=8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303 level=DIE
>    groups: 8:{ span=8-15 cap=8192 }, 40:{ span=40-47 cap=8192 }, 72:{ span=72-79 cap=8192 }, 104:{ span=104-111 cap=8192 }, 136:{ span=136-143 cap=8192 }, 168:{ span=168-175 cap=8192 }, 200:{ span=200-207 cap=8192 }, 232:{ span=232-239 cap=8192 }, 264:{ span=264-271 cap=8192 }, 296:{ span=296-303 cap=8192 }
>    domain-2: span=8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303 level=NODE
>     groups: 8:{ span=8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303 cap=81920 }
>     domain-3: span=0-303 level=NUMA
>      groups: 8:{ span=8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303 cap=81920 }, 16:{ span=16-23,48-55,80-87,112-119,144-151,176-183,208-215,240-247,272-279 cap=73728 }, 24:{ span=24-31,56-63,88-95,120-127,152-159,184-191,216-223,248-255,280-287 cap=73728 }
> ERROR: groups don't span domain->span

This is all very confused... and does not include the error we saw
earlier.

CPU 0 has: SMT, DIE, NODE
CPU 8 has: SMT, DIE, NODE, NUMA

Something is completely buggered in your topology setup.
