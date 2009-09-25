Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 206D5B7B91
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2009 13:41:15 +1000 (EST)
Subject: Re: 2.6.31-git5 kernel boot hangs on powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tejun Heo <tj@kernel.org>
In-Reply-To: <4ABC376D.1020704@kernel.org>
References: <4AB0D947.8010301@in.ibm.com> <4AB214C3.4040109@in.ibm.com>
	<1253185994.8375.352.camel@pasglop>	<4AB25B61.9020609@kernel.org>
	<4AB266AF.9080705@in.ibm.com> <4AB49C37.6020003@in.ibm.com>
	<4AB9DAEC.3060309@in.ibm.com> <4AB9DD8F.1040305@kernel.org>
	<4ABA2DE2.6000601@kernel.org> <4ABB269F.6020309@in.ibm.com>
	<4ABB6D33.6060706@kernel.org>  <4ABB72BD.9050905@in.ibm.com>
	<1253826309.7103.461.camel@pasglop>  <4ABC376D.1020704@kernel.org>
Content-Type: text/plain
Date: Fri, 25 Sep 2009 13:40:06 +1000
Message-Id: <1253850006.7103.505.camel@pasglop>
Mime-Version: 1.0
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-09-25 at 12:22 +0900, Tejun Heo wrote:
> Benjamin Herrenschmidt wrote:
> >> --- Exception: 301 at .memset+0x60/0xfc
> >>     LR = .pcpu_alloc+0x718/0x8fc
> > 
> > So it's memsetting something that causes it to hash_page(), ie, faulting
> > in pages (vmalloc space ?) so far nothing obviously wrong....
> 
> It's probably memset() call near the end of pcpu_populate_chunk()
> where percpu allocator clears the allocated areas before returning to
> user.  I don't think the first chunk is causing the problem as they're
> all in the linear mapped area.  From the second chunk on, they're on
> vmalloc area and very near to the top of it, so that might be exposing
> a hidden problem in paging code?  BTW, for some reason, the problem is
> not reproducible on my powerstation.

That's indeed a possibility, though it would be strange...

Definitely worth looking at your logs, and I'll check with Sachin
about getting on the machine after that if I need to dig more.

Cheers,
Ben.
