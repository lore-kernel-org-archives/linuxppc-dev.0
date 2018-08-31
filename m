Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 421xs93hCCzF38S
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2018 21:26:53 +1000 (AEST)
Date: Fri, 31 Aug 2018 13:26:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Mel Gorman <mgorman@techsingularity.net>, Rik van Riel <riel@surriel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH 2/2] sched/topology: Expose numa_mask set/clear functions
 to arch
Message-ID: <20180831112639.GA24142@hirez.programming.kicks-ass.net>
References: <20180808081942.GA37418@linux.vnet.ibm.com>
 <1533920419-17410-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1533920419-17410-2-git-send-email-srikar@linux.vnet.ibm.com>
 <20180829080219.GN24124@hirez.programming.kicks-ass.net>
 <20180831102724.GB8437@linux.vnet.ibm.com>
 <20180831111253.GJ24124@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180831111253.GJ24124@hirez.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 31, 2018 at 01:12:53PM +0200, Peter Zijlstra wrote:
> NAK, not until you've fixed every cpu_to_node() user in the kernel to
> deal with that mask changing.

Also, what happens if userspace reads that information; uses libnuma and
then you go and shift the world underneath their feet?

> This is absolutely insane.
