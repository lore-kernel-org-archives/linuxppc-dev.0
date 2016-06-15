Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rV6Rg4wspzDqcl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 23:14:23 +1000 (AEST)
Date: Wed, 15 Jun 2016 15:14:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <htejun@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] workqueue:Fix affinity of an unbound worker of a
 node with 1 online CPU
Message-ID: <20160615131415.GI30909@twins.programming.kicks-ass.net>
References: <cover.1465311052.git.ego@linux.vnet.ibm.com>
 <c284ee977a3d52ddd5c01638be391e24b7a59b3d.1465311052.git.ego@linux.vnet.ibm.com>
 <20160614112234.GF30154@twins.programming.kicks-ass.net>
 <20160615101936.GA31671@in.ibm.com>
 <20160615113249.GH30909@twins.programming.kicks-ass.net>
 <20160615125033.GB31671@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160615125033.GB31671@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 15, 2016 at 06:20:33PM +0530, Gautham R Shenoy wrote:
> We will no longer have the optimization in
> restore_unbound_workers_cpumask() but I suppose we don't lose much by
> resetting the affinity every time a CPU in the pool->attr->cpumask
> comes online.

Right; optimizing hotplug really isn't worth it. The code needs to be
simple and robust (ha! funny).

In any case, Tejun, does this work for you?
