Return-Path: <aik@ozlabs.ru>
Received: from mail-pb0-f49.google.com (mail-pb0-f49.google.com
 [209.85.160.49])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3C45C2C029B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jul 2013 17:31:59 +1000 (EST)
Received: by mail-pb0-f49.google.com with SMTP id jt11so3977340pbb.36
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jul 2013 00:31:57 -0700 (PDT)
Message-ID: <51DA6AE6.9040201@ozlabs.ru>
Date: Mon, 08 Jul 2013 17:31:50 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: add real mode support for dma operations
 on powernv
References: <1373123227-22969-6-git-send-email-aik@ozlabs.ru>
 <1373258669-3130-1-git-send-email-aik@ozlabs.ru>
 <1373268055.4446.31.camel@pasglop>
In-Reply-To: <1373268055.4446.31.camel@pasglop>
Content-Type: text/plain; charset=KOI8-R
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/08/2013 05:20 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2013-07-08 at 14:44 +1000, Alexey Kardashevskiy wrote:
> 
>> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
>> index 25d76c4..7ea82c1 100644
>> --- a/arch/powerpc/platforms/powernv/pci.h
>> +++ b/arch/powerpc/platforms/powernv/pci.h
>> @@ -52,6 +52,7 @@ struct pnv_ioda_pe {
>>  	int			tce32_seg;
>>  	int			tce32_segcount;
>>  	struct iommu_table	tce32_table;
>> +	phys_addr_t		it_index_rm;
> 
> Please ....
> 
> The fact that we hijack the it_index field of the iommu table
> for the virtual address is bad enough, but really don't need
> to perpetuate this :-)
> 
> Call the field something decent such as "tce_inval_reg_phys"


Yes we can. I just find it veeeeeeery attractive when I can grep "\<it_"
and get all users of iommu_table.

btw is phys_addr_t correct here?


-- 
Alexey
