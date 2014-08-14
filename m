Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 197171A00C7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Aug 2014 06:07:12 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Thu, 14 Aug 2014 14:07:10 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 0B17F1FF003E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Aug 2014 14:07:07 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s7EI3Gnc8520114
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Aug 2014 20:03:16 +0200
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7EK74C5013515
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Aug 2014 14:07:07 -0600
Date: Thu, 14 Aug 2014 13:06:56 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Christoph Lameter <cl@linux.com>
Subject: Re: [RFC PATCH v3 1/4] topology: add support for node_to_mem_node()
 to determine the fallback node
Message-ID: <20140814200656.GP11121@linux.vnet.ibm.com>
References: <20140814001301.GI11121@linux.vnet.ibm.com>
 <20140814001422.GJ11121@linux.vnet.ibm.com>
 <alpine.DEB.2.11.1408140934290.25902@gentwo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.11.1408140934290.25902@gentwo.org>
Cc: Han Pingtian <hanpt@linux.vnet.ibm.com>, Matt Mackall <mpm@selenic.com>,
 Pekka Enberg <penberg@kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>, David Rientjes <rientjes@google.com>,
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Wanpeng Li <liwanp@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14.08.2014 [09:35:37 -0500], Christoph Lameter wrote:
> On Wed, 13 Aug 2014, Nishanth Aravamudan wrote:
> 
> > +++ b/include/linux/topology.h
> > @@ -119,11 +119,20 @@ static inline int numa_node_id(void)
> >   * Use the accessor functions set_numa_mem(), numa_mem_id() and cpu_to_mem().
> >   */
> >  DECLARE_PER_CPU(int, _numa_mem_);
> > +extern int _node_numa_mem_[MAX_NUMNODES];
> 
> Why are these variables starting with an _ ?
> Maybe _numa_mem was defined that way because it is typically not defined.
> We dont do this in other situations.

That's how it was in Joonsoo's patch and I was trying to minimize the
changes from his version (beyond making it compile). I can of course
update it to not have a prefixing _ if that's preferred.

Thanks,
Nish
