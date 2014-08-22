Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9E7B81A011C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Aug 2014 07:52:58 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 22 Aug 2014 15:52:56 -0600
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 411F238C803B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Aug 2014 17:52:55 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s7MLqtMc6881776
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Aug 2014 21:52:55 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7MLqrfb000369
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Aug 2014 17:52:54 -0400
Date: Fri, 22 Aug 2014 14:52:38 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Christoph Lameter <cl@linux.com>
Subject: Re: [RFC PATCH v3 1/4] topology: add support for node_to_mem_node()
 to determine the fallback node
Message-ID: <20140822215238.GH13999@linux.vnet.ibm.com>
References: <20140814001301.GI11121@linux.vnet.ibm.com>
 <20140814001422.GJ11121@linux.vnet.ibm.com>
 <alpine.DEB.2.11.1408140934290.25902@gentwo.org>
 <20140814200656.GP11121@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140814200656.GP11121@linux.vnet.ibm.com>
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

Hi Christoph,

On 14.08.2014 [13:06:56 -0700], Nishanth Aravamudan wrote:
> On 14.08.2014 [09:35:37 -0500], Christoph Lameter wrote:
> > On Wed, 13 Aug 2014, Nishanth Aravamudan wrote:
> > 
> > > +++ b/include/linux/topology.h
> > > @@ -119,11 +119,20 @@ static inline int numa_node_id(void)
> > >   * Use the accessor functions set_numa_mem(), numa_mem_id() and cpu_to_mem().
> > >   */
> > >  DECLARE_PER_CPU(int, _numa_mem_);
> > > +extern int _node_numa_mem_[MAX_NUMNODES];
> > 
> > Why are these variables starting with an _ ?
> > Maybe _numa_mem was defined that way because it is typically not defined.
> > We dont do this in other situations.
> 
> That's how it was in Joonsoo's patch and I was trying to minimize the
> changes from his version (beyond making it compile). I can of course
> update it to not have a prefixing _ if that's preferred.

Upon reflection, did you mean all of these variables? Would you rather I
submitted a follow-on patch that removed the prefix _? Note that
_node_numa_mem_ is also not defined if !MEMORYLESS_NODES.

-Nish
