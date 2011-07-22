Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 26F99B6F68
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 23 Jul 2011 07:09:04 +1000 (EST)
Subject: Re: [PATCH 2/5] hugetlb: add phys addr to struct huge_bootmem_page
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Becky Bruce <beckyb@kernel.crashing.org>
In-Reply-To: <20110721154427.53e8fd5b.akpm@linux-foundation.org>
Date: Fri, 22 Jul 2011 16:08:58 -0500
Message-Id: <A8DD821C-06F9-462C-8037-28AC17C00F7B@kernel.crashing.org>
References: <1309290888309-git-send-email-beckyb@kernel.crashing.org>
	<13092909493748-git-send-email-beckyb@kernel.crashing.org>
	<13092910103675-git-send-email-beckyb@kernel.crashing.org>
	<20110721154427.53e8fd5b.akpm@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 21, 2011, at 5:44 PM, Andrew Morton wrote:

> On Tue, 28 Jun 2011 14:54:45 -0500
> Becky Bruce <beckyb@kernel.crashing.org> wrote:
>=20
>> From: Becky Bruce <beckyb@kernel.crashing.org>
>>=20
>> This is needed on HIGHMEM systems - we don't always have a virtual
>> address so store the physical address and map it in as needed.
>>=20
>> Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
>> ---
>> include/linux/hugetlb.h |    3 +++
>> mm/hugetlb.c            |    8 +++++++-
>> 2 files changed, 10 insertions(+), 1 deletions(-)
>>=20
>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>> index 59225ef..19644e0 100644
>> --- a/include/linux/hugetlb.h
>> +++ b/include/linux/hugetlb.h
>> @@ -231,6 +231,9 @@ struct hstate {
>> struct huge_bootmem_page {
>> 	struct list_head list;
>> 	struct hstate *hstate;
>> +#ifdef CONFIG_HIGHMEM
>> +	phys_addr_t phys;
>> +#endif
>> };
>>=20
>> struct page *alloc_huge_page_node(struct hstate *h, int nid);
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 6402458..2db81ea 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1105,8 +1105,14 @@ static void __init =
gather_bootmem_prealloc(void)
>> 	struct huge_bootmem_page *m;
>>=20
>> 	list_for_each_entry(m, &huge_boot_pages, list) {
>> -		struct page *page =3D virt_to_page(m);
>> 		struct hstate *h =3D m->hstate;
>> +#ifdef CONFIG_HIGHMEM
>> +		struct page *page =3D pfn_to_page(m->phys >> =
PAGE_SHIFT);
>> +		free_bootmem_late((unsigned long)m,
>> +				  sizeof(struct huge_bootmem_page));
>> +#else
>> +		struct page *page =3D virt_to_page(m);
>> +#endif
>> 		__ClearPageReserved(page);
>> 		WARN_ON(page_count(page) !=3D 1);
>> 		prep_compound_huge_page(page, h->order);
>=20
> nit: wrapping both definitions and statements in an ifdef like this is
> a bit nasty from a readability and maintainability point of view - =
it's
> inviting people to later make changes which fail to compile when the
> config option is flipped.
>=20
> This is better:
>=20
> --- =
a/mm/hugetlb.c~hugetlb-add-phys-addr-to-struct-huge_bootmem_page-fix
> +++ a/mm/hugetlb.c
> @@ -1106,12 +1106,14 @@ static void __init gather_bootmem_preall
>=20
> 	list_for_each_entry(m, &huge_boot_pages, list) {
> 		struct hstate *h =3D m->hstate;
> +		struct page *page;
> +
> #ifdef CONFIG_HIGHMEM
> -		struct page *page =3D pfn_to_page(m->phys >> =
PAGE_SHIFT);
> +		page =3D pfn_to_page(m->phys >> PAGE_SHIFT);
> 		free_bootmem_late((unsigned long)m,
> 				  sizeof(struct huge_bootmem_page));
> #else
> -		struct page *page =3D virt_to_page(m);
> +		page =3D virt_to_page(m);
> #endif
> 		__ClearPageReserved(page);
> 		WARN_ON(page_count(page) !=3D 1);

Andrew,

I totally agree, this is better, thanks.   I see you've put my original =
patch and your fix into -mm;  I'd like it to percolate there for a bit =
before it goes to Linus to be sure I haven't broken anything.  It should =
be safe, as I don't think this particular function was ever expected to =
work on highmem platforms, but it's possible I'm overlooking something.

Cheers,
-Becky
