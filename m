Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A24612C0089
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Feb 2014 10:00:55 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Mon, 3 Feb 2014 18:00:52 -0500
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id D80DF38C803B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Feb 2014 18:00:49 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s13N0nB54391316
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Feb 2014 23:00:49 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s13N0lVI023497
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Feb 2014 18:00:49 -0500
Date: Mon, 3 Feb 2014 15:00:26 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH] slub: Don't throw away partial remote slabs if there is
 no local memory
Message-ID: <20140203230026.GA15383@linux.vnet.ibm.com>
References: <52e1da8f.86f7440a.120f.25f3SMTPIN_ADDED_BROKEN@mx.google.com>
 <alpine.DEB.2.10.1401240946530.12886@nuc>
 <alpine.DEB.2.02.1401241301120.10968@chino.kir.corp.google.com>
 <20140124232902.GB30361@linux.vnet.ibm.com>
 <alpine.DEB.2.02.1401241543100.18620@chino.kir.corp.google.com>
 <20140125001643.GA25344@linux.vnet.ibm.com>
 <alpine.DEB.2.02.1401241618500.20466@chino.kir.corp.google.com>
 <20140125011041.GB25344@linux.vnet.ibm.com>
 <20140127055805.GA2471@lge.com>
 <20140128182947.GA1591@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140128182947.GA1591@linux.vnet.ibm.com>
Cc: Han Pingtian <hanpt@linux.vnet.ibm.com>, mpm@selenic.com,
 penberg@kernel.org, linux-mm@kvack.org, paulus@samba.org,
 Anton Blanchard <anton@samba.org>, David Rientjes <rientjes@google.com>,
 Christoph Lameter <cl@linux.com>, linuxppc-dev@lists.ozlabs.org,
 Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 28.01.2014 [10:29:47 -0800], Nishanth Aravamudan wrote:
> On 27.01.2014 [14:58:05 +0900], Joonsoo Kim wrote:
> > On Fri, Jan 24, 2014 at 05:10:42PM -0800, Nishanth Aravamudan wrote:
> > > On 24.01.2014 [16:25:58 -0800], David Rientjes wrote:
> > > > On Fri, 24 Jan 2014, Nishanth Aravamudan wrote:
> > > > 
> > > > > Thank you for clarifying and providing  a test patch. I ran with this on
> > > > > the system showing the original problem, configured to have 15GB of
> > > > > memory.
> > > > > 
> > > > > With your patch after boot:
> > > > > 
> > > > > MemTotal:       15604736 kB
> > > > > MemFree:         8768192 kB
> > > > > Slab:            3882560 kB
> > > > > SReclaimable:     105408 kB
> > > > > SUnreclaim:      3777152 kB
> > > > > 
> > > > > With Anton's patch after boot:
> > > > > 
> > > > > MemTotal:       15604736 kB
> > > > > MemFree:        11195008 kB
> > > > > Slab:            1427968 kB
> > > > > SReclaimable:     109184 kB
> > > > > SUnreclaim:      1318784 kB
> > > > > 
> > > > > 
> > > > > I know that's fairly unscientific, but the numbers are reproducible. 
> > > > > 
> > 
> > Hello,
> > 
> > I think that there is one mistake on David's patch although I'm not sure
> > that it is the reason for this result.
> > 
> > With David's patch, get_partial() in new_slab_objects() doesn't work
> > properly, because we only change node id in !node_match() case. If we
> > meet just !freelist case, we pass node id directly to
> > new_slab_objects(), so we always try to allocate new slab page
> > regardless existence of partial pages. We should solve it.
> > 
> > Could you try this one?
> 
> This helps about the same as David's patch -- but I found the reason
> why! ppc64 doesn't set CONFIG_HAVE_MEMORYLESS_NODES :) Expect a patch
> shortly for that and one other case I found.
> 
> This patch on its own seems to help on our test system by saving around
> 1.5GB of slab.
> 
> Tested-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> Acked-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> 
> with the caveat below.

So what's the status of this patch? Christoph, do you think this is fine
as it is?

Thanks,
Nish
