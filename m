Return-Path: <htejun@gmail.com>
Received: from mail-qa0-x22f.google.com (mail-qa0-x22f.google.com
 [IPv6:2607:f8b0:400d:c00::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF5E51A002E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 07:49:19 +1000 (EST)
Received: by mail-qa0-f47.google.com with SMTP id i13so327219qae.20
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jul 2014 14:49:15 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 22 Jul 2014 17:49:11 -0400
From: Tejun Heo <tj@kernel.org>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 2/3] topology: support node_numa_mem() for
 determining the fallback node
Message-ID: <20140722214911.GO13851@htj.dyndns.org>
References: <1391674026-20092-2-git-send-email-iamjoonsoo.kim@lge.com>
 <alpine.DEB.2.02.1402060041040.21148@chino.kir.corp.google.com>
 <CAAmzW4PXkdpNi5pZ=4BzdXNvqTEAhcuw-x0pWidqrxzdePxXxA@mail.gmail.com>
 <alpine.DEB.2.02.1402061248450.9567@chino.kir.corp.google.com>
 <20140207054819.GC28952@lge.com>
 <alpine.DEB.2.02.1402080154140.9668@chino.kir.corp.google.com>
 <20140210010936.GA12574@lge.com>
 <20140722010305.GJ4156@linux.vnet.ibm.com>
 <alpine.DEB.2.02.1407211809140.9778@chino.kir.corp.google.com>
 <20140722214311.GM4156@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140722214311.GM4156@linux.vnet.ibm.com>
Cc: Han Pingtian <hanpt@linux.vnet.ibm.com>, Matt Mackall <mpm@selenic.com>,
 Pekka Enberg <penberg@kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 linuxppc-dev@lists.ozlabs.org, Christoph Lameter <cl@linux.com>,
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

On Tue, Jul 22, 2014 at 02:43:11PM -0700, Nishanth Aravamudan wrote:
...
> "    There is an issue currently where NUMA information is used on powerpc
>     (and possibly ia64) before it has been read from the device-tree, which
>     leads to large slab consumption with CONFIG_SLUB and memoryless nodes.
>     
>     NUMA powerpc non-boot CPU's cpu_to_node/cpu_to_mem is only accurate
>     after start_secondary(), similar to ia64, which is invoked via
>     smp_init().
>     
>     Commit 6ee0578b4daae ("workqueue: mark init_workqueues() as
>     early_initcall()") made init_workqueues() be invoked via
>     do_pre_smp_initcalls(), which is obviously before the secondary
>     processors are online.
>     ...
>     Therefore, when init_workqueues() runs, it sees all CPUs as being on
>     Node 0. On LPARs or KVM guests where Node 0 is memoryless, this leads to
>     a high number of slab deactivations
>     (http://www.spinics.net/lists/linux-mm/msg67489.html)."
> 
> Christoph/Tejun, do you see the issue I'm referring to? Is my analysis
> correct? It seems like regardless of CONFIG_USE_PERCPU_NUMA_NODE_ID, we
> have to be especially careful that users of cpu_to_{node,mem} and
> related APIs run *after* correct values are stored for all used CPUs?

Without delving into the code, yes, NUMA info should be set up as soon
as possible before major allocations happen.  All allocations which
happen beforehand would naturally be done with bogus NUMA information.

Thanks.

-- 
tejun
