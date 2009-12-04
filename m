Return-Path: <sachinp@in.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 73924B7BEF
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Dec 2009 23:02:56 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp02.au.ibm.com (8.14.3/8.13.1) with ESMTP id nB4C0FqV019841
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Dec 2009 23:00:15 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nB4BxDTu966830
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Dec 2009 22:59:13 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nB4C2t51007943
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Dec 2009 23:02:55 +1100
Message-ID: <4B18FA6C.90800@in.ibm.com>
Date: Fri, 04 Dec 2009 17:32:52 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: Fix bug in pagetable cache cleanup with CONFIG_PPC_SUBPAGE_PROT
	(v2)
References: <20091124053114.GD2737@yookeroo> <20091127045604.GE3184@yookeroo>
In-Reply-To: <20091127045604.GE3184@yookeroo>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Gibson wrote:
> Oops, stupid compile bug in the !CONFIG_PPC_SUBPAGE_PROT case with the
> last version.  Fixed below.
>
> Fix bug in pagetable cache cleanup with CONFIG_PPC_SUBPAGE_PROT
>
> Commit a0668cdc154e54bf0c85182e0535eea237d53146 cleans up the handling
> of kmem_caches for allocating various levels of pagetables.
> Unfortunately, it conflicts badly with CONFIG_PPC_SUBPAGE_PROT, due to
> the latter's cleverly hidden technique of adding some extra allocation
> space to the top level page directory to store the extra information
> it needs.
>
> Since that extra allocation really doesn't fit into the cleaned up
> page directory allocating scheme, this patch alters
> CONFIG_PPC_SUBPAGE_PROT to instead allocate its struct
> subpage_prot_table as part of the mm_context_t.
>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Ben,

Ping on this patch. It is still missing from linux-next. 

Thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
