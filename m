Return-Path: <liwanp@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 884542C009F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 13:20:52 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <liwanp@linux.vnet.ibm.com>;
 Tue, 21 Jan 2014 07:50:47 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 416F53940057
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 07:50:45 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0L2KVHv4129158
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 07:50:31 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0L2KhRm025879
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 07:50:44 +0530
Date: Tue, 21 Jan 2014 10:20:42 +0800
From: Wanpeng Li <liwanp@linux.vnet.ibm.com>
To: Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH] slub: Don't throw away partial remote slabs if there is
 no local memory
Message-ID: <20140121022042.GA27525@hacker.(null)>
References: <20140107132100.5b5ad198@kryten> <20140107074136.GA4011@lge.com>
 <52dce7fe.e5e6420a.5ff6.ffff84a0SMTPIN_ADDED_BROKEN@mx.google.com>
 <alpine.DEB.2.10.1401201612340.28048@nuc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.10.1401201612340.28048@nuc>
Cc: nacc@linux.vnet.ibm.com, penberg@kernel.org, linux-mm@kvack.org,
 Han Pingtian <hanpt@linux.vnet.ibm.com>, paulus@samba.org,
 Anton Blanchard <anton@samba.org>, mpm@selenic.com,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, linuxppc-dev@lists.ozlabs.org
Reply-To: Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 20, 2014 at 04:13:30PM -0600, Christoph Lameter wrote:
>On Mon, 20 Jan 2014, Wanpeng Li wrote:
>
>> >+       enum zone_type high_zoneidx = gfp_zone(flags);
>> >
>> >+       if (!node_present_pages(searchnode)) {
>> >+               zonelist = node_zonelist(searchnode, flags);
>> >+               for_each_zone_zonelist(zone, z, zonelist, high_zoneidx) {
>> >+                       searchnode = zone_to_nid(zone);
>> >+                       if (node_present_pages(searchnode))
>> >+                               break;
>> >+               }
>> >+       }
>> >        object = get_partial_node(s, get_node(s, searchnode), c, flags);
>> >        if (object || node != NUMA_NO_NODE)
>> >                return object;
>> >
>>
>> The patch fix the bug. However, the kernel crashed very quickly after running
>> stress tests for a short while:
>
>This is not a good way of fixing it. How about not asking for memory from
>nodes that are memoryless? Use numa_mem_id() which gives you the next node
>that has memory instead of numa_node_id() (gives you the current node
>regardless if it has memory or not).

Thanks for your pointing out, I will do it and retest it later.

Regards,
Wanpeng Li 
