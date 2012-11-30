Return-Path: <aik@ozlabs.ru>
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com
 [209.85.223.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BED502C0092
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2012 17:16:54 +1100 (EST)
Received: by mail-ie0-f179.google.com with SMTP id k14so149447iea.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2012 22:16:51 -0800 (PST)
Message-ID: <50B84F4E.20809@ozlabs.ru>
Date: Fri, 30 Nov 2012 17:16:46 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] vfio powerpc: enabled on powernv platform
References: <1354138245.1809.226.camel@bling.home>
 <1354161225-23118-1-git-send-email-aik@ozlabs.ru>
 <1354162826.1809.241.camel@bling.home>
In-Reply-To: <1354162826.1809.241.camel@bling.home>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 29/11/12 15:20, Alex Williamson wrote:

>> +	/* Put tces to the table */
>> +	for (i = 0; (i < pages) && !ret; ++i, tce += IOMMU_PAGE_SIZE) {
>> +		ret = put_tce(tbl, entry + i, tce, direction);
>> +		/*
>> +		 * As IOMMU page size is always 4K, the system page size
>> +		 * can be 64K and there is no special tracking for IOMMU pages,
>> +		 * we only do rlimit check/update for the very first
>> +		 * 4K IOMMUpage within 64K system page.
>> +		 */
>> +		if (!(tce & ~PAGE_MASK))
>> +			++retpages;
>
> Ah, here's the comment I was looking for, though I'm still not sure
> about the read/write bits.
>
> Isn't there an exploit here that a user can lock pages beyond their
> limits if they just skip mapping the first 4k of each page?  Thanks,


Heh. True. Posted another patch with 4K pages per system page usage tracking.



-- 
Alexey
