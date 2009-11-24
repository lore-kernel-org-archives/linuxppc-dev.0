Return-Path: <sachinp@in.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp07.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2F99BB6EEC
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Nov 2009 17:58:36 +1100 (EST)
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp07.in.ibm.com (8.14.3/8.13.1) with ESMTP id nAO6wYUF010373
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Nov 2009 12:28:34 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAO6wYZb3739766
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Nov 2009 12:28:34 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nAO6wXVE023659
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Nov 2009 17:58:33 +1100
Message-ID: <4B0B8418.4040808@in.ibm.com>
Date: Tue, 24 Nov 2009 12:28:32 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: Fix bug in pagetable cache cleanup with CONFIG_PPC_SUBPAGE_PROT
References: <20091124053114.GD2737@yookeroo>
In-Reply-To: <20091124053114.GD2737@yookeroo>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Gibson wrote:
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
Thanks David for the patch. With this patch on top of next-20091123
my test machine boots fine. 

Regards
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
