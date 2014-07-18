Return-Path: <htejun@gmail.com>
Received: from mail-qc0-x233.google.com (mail-qc0-x233.google.com
 [IPv6:2607:f8b0:400d:c01::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 610131A07E8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jul 2014 04:00:15 +1000 (EST)
Received: by mail-qc0-f179.google.com with SMTP id r5so3575119qcx.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 11:00:12 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 18 Jul 2014 14:00:08 -0400
From: Tejun Heo <tj@kernel.org>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Subject: Re: [RFC 0/2] Memoryless nodes and kworker
Message-ID: <20140718180008.GC13012@htj.dyndns.org>
References: <20140717230923.GA32660@linux.vnet.ibm.com>
 <20140718112039.GA8383@htj.dyndns.org>
 <CAOhV88PyBK3WxDjG1H0hUbRhRYzPOzV8eim5DuOcgObe-FtFYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOhV88PyBK3WxDjG1H0hUbRhRYzPOzV8eim5DuOcgObe-FtFYg@mail.gmail.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 linux-ia64@vger.kernel.org, Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
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

Hello,

On Fri, Jul 18, 2014 at 10:42:29AM -0700, Nish Aravamudan wrote:
> So, to be clear, this is not *necessarily* about memoryless nodes. It's
> about the semantics intended. The workqueue code currently calls
> cpu_to_node() in a few places, and passes that node into the core MM as a
> hint about where the memory should come from. However, when memoryless
> nodes are present, that hint is guaranteed to be wrong, as it's the nearest
> NUMA node to the CPU (which happens to be the one its on), not the nearest
> NUMA node with memory. The hint is correctly specified as cpu_to_mem(),

It's telling the allocator the node the CPU is on.  Choosing and
falling back the actual allocation is the allocator's job.

> which does the right thing in the presence or absence of memoryless nodes.
> And I think encapsulates the hint's semantics correctly -- please give me
> memory from where I expect it, which is the closest NUMA node.

I don't think it does.  It loses information at too high a layer.
Workqueue here doesn't care how memory subsystem is structured, it's
just telling the allocator where it's at and expecting it to do the
right thing.  Please consider the following scenario.

	A - B - C - D - E

Let's say C is a memory-less node.  If we map from C to either B or D
from individual users and that node can't serve that memory request,
the allocator would fall back to A or E respectively when the right
thing to do would be falling back to D or B respectively, right?

This isn't a huge issue but it shows that this is the wrong layer to
deal with this issue.  Let the allocators express where they are.
Choosing and falling back belong to the memory allocator.  That's the
only place which has all the information that's necessary and those
details must be contained there.  Please don't leak it to memory
allocator users.

Thanks.

-- 
tejun
