Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B27951A035D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jun 2014 03:41:21 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Thu, 19 Jun 2014 13:41:11 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 3B309C90040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jun 2014 13:41:03 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23032.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5JHf8dI7930300
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jun 2014 17:41:09 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5JHf6ED006243
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jun 2014 13:41:08 -0400
Date: Thu, 19 Jun 2014 10:40:47 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Tejun Heo <htejun@gmail.com>
Subject: Re: Node 0 not necessary for powerpc?
Message-ID: <20140619174047.GV16644@linux.vnet.ibm.com>
References: <20140311195632.GA946@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1403120839110.6865@nuc>
 <20140313164949.GC22247@linux.vnet.ibm.com>
 <20140519182400.GM8941@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1405210915170.7859@gentwo.org>
 <20140521185812.GA5259@htj.dyndns.org>
 <20140521195743.GA5755@linux.vnet.ibm.com>
 <alpine.DEB.2.02.1406091447240.5271@chino.kir.corp.google.com>
 <20140610233157.GB24463@linux.vnet.ibm.com>
 <20140619145950.GG26904@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140619145950.GG26904@htj.dyndns.org>
Cc: tony.luck@intel.com, linux-mm@kvack.org, anton@samba.org,
 David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 19.06.2014 [10:59:50 -0400], Tejun Heo wrote:
> On Tue, Jun 10, 2014 at 04:31:57PM -0700, Nishanth Aravamudan wrote:
> > > I think what this really wants to do is NODE_DATA(cpu_to_mem(cpu)) and I 
> > > thought ppc had the cpu-to-local-memory-node mappings correct?
> > 
> > Except cpu_to_mem relies on the mapping being defined, but early in
> > boot, specifically, it isn't yet (at least not necessarily).
> 
> Can't ppc NODE_DATA simply return dummy generic node_data during early
> boot?  Populating it with just enough to make early boot work
> shouldn't be too hard, right?

So the problem is this, whether we use cpu_to_mem() or cpu_to_node()
here, neither is setup yet because of the ordering between percpu setup
and the actual writing of the percpu data (that is actually storing what
node/local memory is relative to a given CPU).

The NODE_DATA is all correct, but since we are calling cpu_to_{mem,node}
before it really holds valid data, it falsely says 0, which is not
necessarily even an online node.

So, I think we need to do the same thing as x86 and have an early
mapping setup and configured before the percpu areas are.

Thanks,
Nish
