Return-Path: <balbir@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BE782DDDF8
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Dec 2007 18:35:54 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lBS7ZmwA013750
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Dec 2007 02:35:48 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lBS7Zmoo491436
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Dec 2007 02:35:48 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lBS7ZmLB031207
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Dec 2007 02:35:48 -0500
Message-ID: <4774A74B.3000105@linux.vnet.ibm.com>
Date: Fri, 28 Dec 2007 13:05:39 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
MIME-Version: 1.0
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: SCSI errors on powerpc with 2.6.24-rc6-mm1
References: <47732C41.7000003@linux.vnet.ibm.com>
	<20071227134335O.fujita.tomonori@lab.ntt.co.jp>
	<47733C01.1080002@linux.vnet.ibm.com>
	<20071228143043U.fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20071228143043U.fujita.tomonori@lab.ntt.co.jp>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Reply-To: balbir@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

FUJITA Tomonori wrote:
[snip]
> Thanks,
> 
> Can you try this?
> 
> 
> diff --git a/lib/iommu-helper.c b/lib/iommu-helper.c
> index e7d8544..495575a 100644
> --- a/lib/iommu-helper.c
> +++ b/lib/iommu-helper.c
> @@ -8,15 +8,20 @@
>  static unsigned long find_next_zero_area(unsigned long *map,
>  					 unsigned long size,
>  					 unsigned long start,
> -					 unsigned int nr)
> +					 unsigned int nr,
> +					 unsigned long align_mask)
>  {
>  	unsigned long index, end, i;
>  again:
>  	index = find_next_zero_bit(map, size, start);
> +
> +	/* Align allocation */
> +	index = (index + align_mask) & ~align_mask;
> +
>  	end = index + nr;
> -	if (end > size)
> +	if (end >= size)
>  		return -1;
> -	for (i = index + 1; i < end; i++) {
> +	for (i = index; i < end; i++) {
>  		if (test_bit(i, map)) {
>  			start = i+1;
>  			goto again;
> @@ -50,9 +55,8 @@ unsigned long iommu_area_alloc(unsigned long *map, unsigned long size,
>  {
>  	unsigned long index;
>  again:
> -	index = find_next_zero_area(map, size, start, nr);
> +	index = find_next_zero_area(map, size, start, nr, align_mask);
>  	if (index != -1) {
> -		index = (index + align_mask) & ~align_mask;
>  		if (is_span_boundary(index, nr, shift, boundary_size)) {
>  			/* we could do more effectively */
>  			start = index + 1;

This on top of -mm? Or on top of the reverted iommu patch.


-- 
	Warm Regards,
	Balbir Singh
	Linux Technology Center
	IBM, ISTL
