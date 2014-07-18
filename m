Return-Path: <htejun@gmail.com>
Received: from mail-qa0-x229.google.com (mail-qa0-x229.google.com
 [IPv6:2607:f8b0:400d:c00::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 17F201A02A8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jul 2014 04:19:54 +1000 (EST)
Received: by mail-qa0-f41.google.com with SMTP id j7so3335725qaq.28
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 11:19:50 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 18 Jul 2014 14:19:47 -0400
From: Tejun Heo <tj@kernel.org>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Subject: Re: [RFC 0/2] Memoryless nodes and kworker
Message-ID: <20140718181947.GE13012@htj.dyndns.org>
References: <20140717230923.GA32660@linux.vnet.ibm.com>
 <20140718112039.GA8383@htj.dyndns.org>
 <CAOhV88PyBK3WxDjG1H0hUbRhRYzPOzV8eim5DuOcgObe-FtFYg@mail.gmail.com>
 <20140718180008.GC13012@htj.dyndns.org>
 <CAOhV88O03zCsv_3eadEKNv1D1RoBmjWRFNhPjEHawF9s71U0JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOhV88O03zCsv_3eadEKNv1D1RoBmjWRFNhPjEHawF9s71U0JA@mail.gmail.com>
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

On Fri, Jul 18, 2014 at 11:12:01AM -0700, Nish Aravamudan wrote:
> why aren't these callers using kthread_create_on_cpu()? That API was

It is using that.  There just are other data structures too.

> already change to use cpu_to_mem() [so one change, rather than of all over
> the kernel source]. We could change it back to cpu_to_node and push down
> the knowledge about the fallback.

And once it's properly solved, please convert back kthread to use
cpu_to_node() too.  We really shouldn't be sprinkling the new subtly
different variant across the kernel.  It's wrong and confusing.

> Yes, this is a good point. But honestly, we're not really even to the point
> of talking about fallback here, at least in my testing, going off-node at
> all causes SLUB-configured slabs to deactivate, which then leads to an
> explosion in the unreclaimable slab.

I don't think moving the logic inside allocator proper is a huge
amount of work and this isn't the first spillage of this subtlety out
of allocator proper.  Fortunately, it hasn't spread too much yet.
Let's please stop it here.  I'm not saying you shouldn't or can't fix
the off-node allocation.

Thanks.

-- 
tejun
