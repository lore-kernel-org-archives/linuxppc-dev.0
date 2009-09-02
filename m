Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8BA5EB7B7C
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Sep 2009 18:52:02 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E3CACDDD01
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Sep 2009 18:52:01 +1000 (EST)
Subject: Re: [PATCH] Fix fake numa on ppc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Rientjes <rientjes@google.com>
In-Reply-To: <alpine.DEB.1.00.0909012259050.26930@chino.kir.corp.google.com>
References: <20090901050316.GA4076@in.ibm.com>
	<20090901055753.GB5563@balbir.in.ibm.com>
	<20090901092407.GC4076@in.ibm.com>
	<20090901142729.GA5022@balbir.in.ibm.com>
	<20090902053653.GA3806@in.ibm.com> <1251870823.14675.420.camel@pasglop>
	<alpine.DEB.1.00.0909012259050.26930@chino.kir.corp.google.com>
Content-Type: text/plain
Date: Wed, 02 Sep 2009 18:51:39 +1000
Message-Id: <1251881499.14675.453.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Ankita Garg <ankita@in.ibm.com>,
	linux-kernel@vger.kernel.org, Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-09-01 at 23:03 -0700, David Rientjes wrote:
> On Wed, 2 Sep 2009, Benjamin Herrenschmidt wrote:
> 
> > Since I'm pretty sure there could be CPU less nodes just like there
> > could be memory-less nodes, it would be good if fake numa could
> > simulate them too :-)
> > 
> 
> You don't want to simulate cpu less nodes since they do have affinity to 
> ranges of memory, you want to map each fake node to a cpumask including 
> all cpus with affinity to its memory, map each cpu to one fake node (with 
> memory) that it has physical affinity to, and then give all fake nodes 
> local NUMA distance to those on the same physical node.  Memoryless nodes 
> take care of themselves since they rely purely on node_distance(), so the 
> index into the slit for all fake nodes to those without memory will be the 
> same.

Ok, makes sense, thanks.

Cheers,
Ben.
