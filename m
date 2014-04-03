Return-Path: <cl@linux.com>
Received: from qmta15.emeryville.ca.mail.comcast.net
 (qmta15.emeryville.ca.mail.comcast.net [IPv6:2001:558:fe2d:44:76:96:27:228])
 by ozlabs.org (Postfix) with ESMTP id 1285D1400E0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Apr 2014 03:49:57 +1100 (EST)
Date: Thu, 3 Apr 2014 11:41:37 -0500 (CDT)
From: Christoph Lameter <cl@linux.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: Bug in reclaim logic with exhausted nodes?
In-Reply-To: <20140401013346.GD5144@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.10.1404031139090.21739@nuc>
References: <20140311210614.GB946@linux.vnet.ibm.com>
 <20140313170127.GE22247@linux.vnet.ibm.com>
 <20140324230550.GB18778@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1403251116490.16557@nuc>
 <20140325162303.GA29977@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1403251152250.16870@nuc>
 <20140325181010.GB29977@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1403251323030.26744@nuc>
 <20140327203354.GA16651@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1403290038200.24286@nuc>
 <20140401013346.GD5144@linux.vnet.ibm.com>
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Mon, 31 Mar 2014, Nishanth Aravamudan wrote:

> Yep. The node exists, it's just fully exhausted at boot (due to the
> presence of 16GB pages reserved at boot-time).

Well if you want us to support that then I guess you need to propose
patches to address this issue.

> I'd appreciate a bit more guidance? I'm suggesting that in this case the
> node functionally has no memory. So the page allocator should not allow
> allocations from it -- except (I need to investigate this still)
> userspace accessing the 16GB pages on that node, but that, I believe,
> doesn't go through the page allocator at all, it's all from hugetlb
> interfaces. It seems to me there is a bug in SLUB that we are noting
> that we have a useless per-node structure for a given nid, but not
> actually preventing requests to that node or reclaim because of those
> allocations.

Well if you can address that without impacting the fastpath then we could
do this. Otherwise we would need a fake structure here to avoid adding
checks to the fastpath

> I think there is a logical bug (even if it only occurs in this
> particular corner case) where if reclaim progresses for a THISNODE
> allocation, we don't check *where* the reclaim is progressing, and thus
> may falsely be indicating that we have done some progress when in fact
> the allocation that is causing reclaim will not possibly make any more
> progress.

Ok maybe we could address this corner case. How would you do this?
