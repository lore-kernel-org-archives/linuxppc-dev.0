Return-Path: <cl@linux.com>
Received: from qmta09.emeryville.ca.mail.comcast.net
 (qmta09.emeryville.ca.mail.comcast.net [IPv6:2001:558:fe2d:43:76:96:30:96])
 by ozlabs.org (Postfix) with ESMTP id 2B7B12C0084
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Feb 2014 07:39:37 +1100 (EST)
Date: Tue, 4 Feb 2014 14:39:32 -0600 (CST)
From: Christoph Lameter <cl@linux.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: [PATCH] slub: Don't throw away partial remote slabs if there is
 no local memory
In-Reply-To: <20140204072630.GB10101@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.10.1402041436150.11222@nuc>
References: <alpine.DEB.2.02.1401241301120.10968@chino.kir.corp.google.com>
 <20140124232902.GB30361@linux.vnet.ibm.com>
 <alpine.DEB.2.02.1401241543100.18620@chino.kir.corp.google.com>
 <20140125001643.GA25344@linux.vnet.ibm.com>
 <alpine.DEB.2.02.1401241618500.20466@chino.kir.corp.google.com>
 <20140125011041.GB25344@linux.vnet.ibm.com> <20140127055805.GA2471@lge.com>
 <20140128182947.GA1591@linux.vnet.ibm.com>
 <20140203230026.GA15383@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1402032138070.17997@nuc>
 <20140204072630.GB10101@linux.vnet.ibm.com>
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Han Pingtian <hanpt@linux.vnet.ibm.com>, mpm@selenic.com,
 penberg@kernel.org, linux-mm@kvack.org, paulus@samba.org,
 Anton Blanchard <anton@samba.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, linuxppc-dev@lists.ozlabs.org,
 Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 3 Feb 2014, Nishanth Aravamudan wrote:

> Yes, sorry for my lack of clarity. I meant Joonsoo's latest patch for
> the $SUBJECT issue.

Hmmm... I am not sure that this is a general solution. The fallback to
other nodes can not only occur because a node has no memory as his patch
assumes.

If the target node allocation fails (for whatever reason) then I would
recommend for simplicities sake to change the target node to NUMA_NO_NODE
and just take whatever is in the current cpu slab. A more complex solution
would be to look through partial lists in increasing distance to find a
partially used slab that is reasonable close to the current node. Slab has
logic like that in fallback_alloc(). Slubs get_any_partial() function does
something close to what you want.
