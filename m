Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5ED9614007E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 May 2014 04:47:03 +1000 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Mon, 12 May 2014 12:46:59 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 0FFDC19D8040
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 May 2014 12:46:52 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07029.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4CGhi2n5243324
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 May 2014 18:43:44 +0200
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4CIkvH1029877
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 May 2014 12:46:57 -0600
Date: Mon, 12 May 2014 11:46:54 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Christoph Lameter <cl@linux.com>
Subject: Re: Bug in reclaim logic with exhausted nodes?
Message-ID: <20140512184654.GC8941@linux.vnet.ibm.com>
References: <20140324230550.GB18778@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1403251116490.16557@nuc>
 <20140325162303.GA29977@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1403251152250.16870@nuc>
 <20140325181010.GB29977@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1403251323030.26744@nuc>
 <20140327203354.GA16651@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1403290038200.24286@nuc>
 <20140401013346.GD5144@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1404031139090.21739@nuc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.10.1404031139090.21739@nuc>
Cc: linux-mm@kvack.org, mgorman@suse.de, linuxppc-dev@lists.ozlabs.org,
 anton@samba.org, rientjes@google.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Christoph,

Sorry for the delay in my response!

On 03.04.2014 [11:41:37 -0500], Christoph Lameter wrote:
> On Mon, 31 Mar 2014, Nishanth Aravamudan wrote:
> 
> > Yep. The node exists, it's just fully exhausted at boot (due to the
> > presence of 16GB pages reserved at boot-time).
> 
> Well if you want us to support that then I guess you need to propose
> patches to address this issue.

Yep, that's my plan, I was hoping to get input from developers/experts
such as yourself first. Obviously, code speaks louder though...

> > I'd appreciate a bit more guidance? I'm suggesting that in this case
> > the node functionally has no memory. So the page allocator should
> > not allow allocations from it -- except (I need to investigate this
> > still) userspace accessing the 16GB pages on that node, but that, I
> > believe, doesn't go through the page allocator at all, it's all from
> > hugetlb interfaces. It seems to me there is a bug in SLUB that we
> > are noting that we have a useless per-node structure for a given
> > nid, but not actually preventing requests to that node or reclaim
> > because of those allocations.
> 
> Well if you can address that without impacting the fastpath then we
> could do this. Otherwise we would need a fake structure here to avoid
> adding checks to the fastpath

Ok, I'll keep thinking about what makes the most sense.

> > I think there is a logical bug (even if it only occurs in this
> > particular corner case) where if reclaim progresses for a THISNODE
> > allocation, we don't check *where* the reclaim is progressing, and thus
> > may falsely be indicating that we have done some progress when in fact
> > the allocation that is causing reclaim will not possibly make any more
> > progress.
> 
> Ok maybe we could address this corner case. How would you do this?

This is where I started to get stumped. It seems like did_some_progress
is only checking that any progress is made. It would be more expensive
in the reclaim path to check what nodes we made progress on and verify
it was on the intended one (if we are reclaiming due to THISNODE). I
will try and look at this case specifically more, I apologize it's
taking me quite a bit of time to get up-to-speed on the code and design.

Thanks,
Nish
