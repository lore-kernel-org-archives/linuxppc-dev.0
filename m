Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F3AF82C02ED
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Mar 2014 03:51:27 +1100 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Thu, 13 Mar 2014 10:51:25 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id C779D3E40045
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Mar 2014 10:51:21 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08025.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2DGpLae10551562
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Mar 2014 17:51:21 +0100
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2DGpKA1011842
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Mar 2014 10:51:20 -0600
Date: Thu, 13 Mar 2014 09:51:00 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Christoph Lameter <cl@linux.com>
Subject: Re: [RFC PATCH 2/3] topology: support node_numa_mem() for
 determining the fallback node
Message-ID: <20140313165100.GD22247@linux.vnet.ibm.com>
References: <20140207054819.GC28952@lge.com>
 <alpine.DEB.2.10.1402071150090.15168@nuc>
 <alpine.DEB.2.10.1402071245040.20246@nuc>
 <20140210191321.GD1558@linux.vnet.ibm.com>
 <20140211074159.GB27870@lge.com>
 <alpine.DEB.2.10.1402121612270.8183@nuc>
 <20140217065257.GD3468@lge.com>
 <alpine.DEB.2.10.1402181033480.28964@nuc>
 <20140224050851.GB14814@lge.com>
 <alpine.DEB.2.10.1402241353070.20839@nuc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.10.1402241353070.20839@nuc>
Cc: Han Pingtian <hanpt@linux.vnet.ibm.com>, Matt Mackall <mpm@selenic.com>,
 Pekka Enberg <penberg@kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 linuxppc-dev@lists.ozlabs.org, Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 24.02.2014 [13:54:35 -0600], Christoph Lameter wrote:
> On Mon, 24 Feb 2014, Joonsoo Kim wrote:
> 
> > > It will not common get there because of the tracking. Instead a per cpu
> > > object will be used.
> > > > get_partial_node() always fails even if there are some partial slab on
> > > > memoryless node's neareast node.
> > >
> > > Correct and that leads to a page allocator action whereupon the node will
> > > be marked as empty.
> >
> > Why do we need to request to a page allocator if there is partial slab?
> > Checking whether node is memoryless or not is really easy, so we don't need
> > to skip this. To skip this is suboptimal solution.
> 
> The page allocator action is also used to determine to which other node we
> should fall back if the node is empty. So we need to call the page
> allocator when the per cpu slab is exhaused with the node of the
> memoryless node to get memory from the proper fallback node.

Where do we stand with these patches? I feel like no resolution was
really found...

Thanks,
Nish
