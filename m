Return-Path: <kniht@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 45C3ADDF4E
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 06:22:02 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6MKLpUn017517
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 16:21:51 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6MKLpFr186430
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 16:21:51 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6MKLo6T010637
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 16:21:51 -0400
Message-ID: <4886418C.9050704@linux.vnet.ibm.com>
Date: Tue, 22 Jul 2008 15:22:36 -0500
From: Jon Tollefson <kniht@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>, benh@kernel.crashing.org,
	paulus@samba.org, npiggin@suse.de,
	Jon Tollefson <kniht@linux.vnet.ibm.com>,
	ppc-dev <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: gigantci pages patches
References: <20080711174515.1aacf83b.sfr@canb.auug.org.au>
	<20080722033417.GD14888@yookeroo.seuss>
In-Reply-To: <20080722033417.GD14888@yookeroo.seuss>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Fri, Jul 11, 2008 at 05:45:15PM +1000, Stephen Rothwell wrote:
>   
>> Hi all,
>>
>> Could people take one last look at these patches and if there are no
>> issues, please send Ack-bys to Andrew who will push them to Linus for
>> 2.6.27.
>>
>> [PATCH 1/6 v2] allow arch specific function for allocating gigantic pages
>> http://patchwork.ozlabs.org/linuxppc/patch?&id=18437
>> Patch: [PATCH 2/6 v2] powerpc: function for allocating gigantic pages
>> http://patchwork.ozlabs.org/linuxppc/patch?&id=18438
>> Patch: [PATCH 3/6 v2] powerpc: scan device tree and save gigantic page locations
>> http://patchwork.ozlabs.org/linuxppc/patch?&id=18439
>> Patch: [PATCH 4/6 v2] powerpc: define page support for 16G pages
>> http://patchwork.ozlabs.org/linuxppc/patch?&id=18440
>> Patch: [PATCH 5/6 v2] check for overflow
>> http://patchwork.ozlabs.org/linuxppc/patch?&id=18441
>> Patch: [PATCH 6/6] powerpc: support multiple huge page sizes
>> http://patchwork.ozlabs.org/linuxppc/patch?&id=18442
>>     
>
> Sorry, I should have looked at these properly when they went past in
> May, but obviously I missed them.
>
> They mostly look ok.  I'm a bit confused on 2/6 though - it seems the
> new powerpc alloc_bootmem_huge_page() function is specific to the 16G
> gigantic pages.  But can't that function also get called for the
> normal 16M hugepages depending on how the hugepage pool is
> initialized.
>
> Or am I missing something (wouldn't surprise me given my brain's
> sluggishness today)?
>   
The alloc_bootmem_huge_page() function is only called for pages >=
MAX_ORDER.  The 16M pages are always allocated within the generic
hugetlbfs code with alloc_pages_node().

Jon
