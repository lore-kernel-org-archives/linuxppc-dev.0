Return-Path: <htejun@gmail.com>
Received: from mail-qg0-x22b.google.com (mail-qg0-x22b.google.com
 [IPv6:2607:f8b0:400d:c04::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D099B1A0246
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Mar 2015 09:13:13 +1100 (AEDT)
Received: by qgdz60 with SMTP id z60so8457306qgd.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Mar 2015 14:13:11 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 5 Mar 2015 17:13:08 -0500
From: Tejun Heo <tj@kernel.org>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH] powerpc/numa: reset node_possible_map to only
 node_online_map
Message-ID: <20150305221308.GG23912@htj.duckdns.org>
References: <20150305180549.GA29601@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150305180549.GA29601@linux.vnet.ibm.com>
Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
 David Rientjes <rientjes@google.com>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 05, 2015 at 10:05:49AM -0800, Nishanth Aravamudan wrote:
> While looking at this, I noticed that nr_node_ids is actually a
> misnomer, it seems. It's not the number, but the maximum_node_id, as
> with sparse NUMA nodes, you might only have two NUMA nodes possible, but
> to make certain loops work, nr_node_ids will be, e.g., 17. Should it be
> changed?

It's the same for nr_cpu_ids.  It's counting the number of valid IDs
during that boot instance.  In the above case, whether the nodes are
sparse or not, there exist 17 node ids - 0 to 16.  Maybe numa_max_id
had been a better name (but would that equal the highest number or
+1?) but nr_node_ids != nr_nodes so I don't think it's a misnomer
either.  Doesn't really matter at this point.  Maybe add comments on
top of both?

Thanks.

-- 
tejun
