Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4A655B6F59
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Jul 2011 04:50:36 +1000 (EST)
Subject: Re: [PATCH 2/5] hugetlb: add phys addr to struct huge_bootmem_page
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Becky Bruce <beckyb@kernel.crashing.org>
In-Reply-To: <1309297166.32158.461.camel@pasglop>
Date: Thu, 30 Jun 2011 13:50:24 -0500
Message-Id: <786B027A-4EC8-4175-A18D-9DA57E9549D6@kernel.crashing.org>
References: <1309290888309-git-send-email-beckyb@kernel.crashing.org>
	<13092909493748-git-send-email-beckyb@kernel.crashing.org>
	<13092910103675-git-send-email-beckyb@kernel.crashing.org>
	<1309297166.32158.461.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	"List linux-kernel@vger.kernel.org Mailing" <linux-kernel@vger.kernel.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 28, 2011, at 4:39 PM, Benjamin Herrenschmidt wrote:

> On Tue, 2011-06-28 at 14:54 -0500, Becky Bruce wrote:
>> struct page *alloc_huge_page_node(struct hstate *h, int nid);
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 6402458..2db81ea 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1105,8 +1105,14 @@ static void __init
>> gather_bootmem_prealloc(void)
>>        struct huge_bootmem_page *m;
>>=20
>>        list_for_each_entry(m, &huge_boot_pages, list) {
>> -               struct page *page =3D virt_to_page(m);
>>                struct hstate *h =3D m->hstate;
>> +#ifdef CONFIG_HIGHMEM
>> +               struct page *page =3D pfn_to_page(m->phys >>
>> PAGE_SHIFT);
>> +               free_bootmem_late((unsigned long)m,
>> +                                 sizeof(struct huge_bootmem_page));
>> +#else
>> +               struct page *page =3D virt_to_page(m);
>> +#endif
>>                __ClearPageReserved(page);
>=20
> Why do you add free_bootmem_late() in the highmem case and not the
> normal case ?

Because there was no bootmem allocation in the normal case - the =
non-highmem version stores data structure in the huge page itself.  This =
is perfectly fine as long as you have a mapping.  Since this isn't true =
for HIGHMEM pages, I allocate bootmem to store the early data structure =
that stores information about the hugepage (this happens in =
arch-specific code in alloc_bootmem_huge_page).

-Becky
