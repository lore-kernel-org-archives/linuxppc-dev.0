Return-Path: <htejun@gmail.com>
Received: from mail-qa0-x22e.google.com (mail-qa0-x22e.google.com
 [IPv6:2607:f8b0:400d:c00::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B10E61A07E0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 21:20:44 +1000 (EST)
Received: by mail-qa0-f46.google.com with SMTP id v10so2911178qac.33
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 04:20:41 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 18 Jul 2014 07:20:39 -0400
From: Tejun Heo <tj@kernel.org>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: [RFC 0/2] Memoryless nodes and kworker
Message-ID: <20140718112039.GA8383@htj.dyndns.org>
References: <20140717230923.GA32660@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140717230923.GA32660@linux.vnet.ibm.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 linuxppc-dev@lists.ozlabs.org, Jiang Liu <jiang.liu@linux.intel.com>,
 Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 17, 2014 at 04:09:23PM -0700, Nishanth Aravamudan wrote:
> [Apologies for the large Cc list, but I believe we have the following
> interested parties:
> 
> x86 (recently posted memoryless node support)
> ia64 (existing memoryless node support)
> ppc (existing memoryless node support)
> previous discussion of how to solve Anton's issue with slab usage
> workqueue contributors/maintainers]

Well, you forgot to cc me.

...
> It turns out we see this large slab usage due to using the wrong NUMA
> information when creating kthreads.
>     
> Two changes are required, one of which is in the workqueue code and one
> of which is in the powerpc initialization. Note that ia64 may want to
> consider something similar.

Wasn't there a thread on this exact subject a few weeks ago?  Was that
someone else?  Memory-less node detail leaking out of allocator proper
isn't a good idea.  Please allow allocator users to specify the nodes
they're on and let the allocator layer deal with mapping that to
whatever is appropriate.  Please don't push that to everybody.

Thanks.

-- 
tejun
