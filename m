Return-Path: <sachinp@in.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2949DB7B88
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 13 Oct 2009 19:23:12 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp03.au.ibm.com (8.14.3/8.13.1) with ESMTP id n9D8Kcg2015622
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2009 19:20:38 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9D8KYWO1515542
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2009 19:20:35 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n9D8NA3L019715
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2009 19:23:10 +1100
Message-ID: <4AD438EA.9050602@in.ibm.com>
Date: Tue, 13 Oct 2009 13:53:06 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mm: Fix hang accessing top of vmalloc space
References: <1255416227.2192.184.camel@pasglop>
In-Reply-To: <1255416227.2192.184.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Tejun Heo <tj@kernel.org>, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On pSeries, we always force the IO space to be mapped using 4K
> pages even with a 64K base page size to cope with some limitations
> in the HV interface to some devices.
>
> However, the SLB miss handler code to discriminate between vmalloc
> and ioremap space uses a CPU feature section such that the code
> is nop'ed out when the processor support large pages non-cachable
> mappings.
>
> Thus, we end up always using the ioremap page size for vmalloc
> segments on such processors, causing a discrepency between the
> segment and the hash table, and thus a hang continously hashing
> the page.
>
> It works for the first segment of the vmalloc space since that
> segment is "bolted" in by C code correctly, and thankfully we
> almost never use the vmalloc space beyond the first segment,
> but the new percpu code made the bug happen.
>
> This fixes it by removing the feature section from the assembly,
> we now always do the comparison between vmalloc and ioremap.
>
> Signed-off-by; Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>
> Sachin, can you verify that works for you ?
Works great. Thanks Ben.

Tested by: Sachin Sant <sachinp@in.ibm.com>

Regards
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
