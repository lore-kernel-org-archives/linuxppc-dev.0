Return-Path: <rientjes@google.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 91F13B7FFC
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Sep 2009 16:14:46 +1000 (EST)
Received: from smtp-out.google.com (smtp-out.google.com [216.239.45.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E2203DDD04
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Sep 2009 16:14:45 +1000 (EST)
Received: from wpaz1.hot.corp.google.com (wpaz1.hot.corp.google.com
	[172.24.198.65]) by smtp-out.google.com with ESMTP id n8263aUf012234
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Sep 2009 23:03:37 -0700
Received: from pzk4 (pzk4.prod.google.com [10.243.19.132])
	by wpaz1.hot.corp.google.com with ESMTP id n8263Xeo014674
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Sep 2009 23:03:34 -0700
Received: by pzk4 with SMTP id 4so579703pzk.29
	for <linuxppc-dev@ozlabs.org>; Tue, 01 Sep 2009 23:03:33 -0700 (PDT)
Date: Tue, 1 Sep 2009 23:03:32 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Fix fake numa on ppc
In-Reply-To: <1251870823.14675.420.camel@pasglop>
Message-ID: <alpine.DEB.1.00.0909012259050.26930@chino.kir.corp.google.com>
References: <20090901050316.GA4076@in.ibm.com>
	<20090901055753.GB5563@balbir.in.ibm.com>
	<20090901092407.GC4076@in.ibm.com>
	<20090901142729.GA5022@balbir.in.ibm.com>
	<20090902053653.GA3806@in.ibm.com>
	<1251870823.14675.420.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Wed, 2 Sep 2009, Benjamin Herrenschmidt wrote:

> Since I'm pretty sure there could be CPU less nodes just like there
> could be memory-less nodes, it would be good if fake numa could
> simulate them too :-)
> 

You don't want to simulate cpu less nodes since they do have affinity to 
ranges of memory, you want to map each fake node to a cpumask including 
all cpus with affinity to its memory, map each cpu to one fake node (with 
memory) that it has physical affinity to, and then give all fake nodes 
local NUMA distance to those on the same physical node.  Memoryless nodes 
take care of themselves since they rely purely on node_distance(), so the 
index into the slit for all fake nodes to those without memory will be the 
same.
