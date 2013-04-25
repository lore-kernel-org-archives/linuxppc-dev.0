Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7B41A2C010B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 18:40:00 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 25 Apr 2013 04:39:58 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 9AE0538C801A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 04:39:55 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3P8dtHM300862
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 04:39:55 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3P8dsMQ001469
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 05:39:55 -0300
Date: Thu, 25 Apr 2013 16:39:50 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 5/7] powerpc/powernv: TCE invalidation for PHB3
Message-ID: <20130425083949.GA25244@shangw.(null)>
References: <1366796259-29412-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1366796259-29412-6-git-send-email-shangw@linux.vnet.ibm.com>
 <1366836757.2869.18.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366836757.2869.18.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 25, 2013 at 06:52:37AM +1000, Benjamin Herrenschmidt wrote:
>
>> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
>> index cbfe678..0db308e 100644
>> --- a/arch/powerpc/include/asm/iommu.h
>> +++ b/arch/powerpc/include/asm/iommu.h
>> @@ -76,6 +76,7 @@ struct iommu_table {
>>  	struct iommu_pool large_pool;
>>  	struct iommu_pool pools[IOMMU_NR_POOLS];
>>  	unsigned long *it_map;       /* A simple allocation bitmap for now */
>> +	void *sysdata;
>>  };
>
>You should be able to avoid adding that field by using the container_of
>trick to get to the PE and moving the iommu ops for ioda into pci-ioda.c
>instead of sharing them with the non-ioda stuff.
>

Yep. I will introduce one function pnv_pci_ioda_tce_invalidate() to pci-ioda.c
and jump to IODA1/IODA2 cases there. By the way, I will introduce one addtional
field "struct pnv_phb *phb" to "struct pnv_ioda_pe".

Thanks,
Gavin
