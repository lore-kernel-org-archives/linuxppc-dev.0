Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D8F9D2C0083
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 16:13:26 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 10 Jul 2012 05:53:20 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6A64pGS66453584
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 16:04:51 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6A6CnJX018226
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 16:12:50 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH -V3 03/11] arch/powerpc: Convert virtual address to vpn
In-Reply-To: <20120710084128.6fe4a4347719f4445dd12b4f@canb.auug.org.au>
References: <1341839621-28332-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1341839621-28332-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20120710084128.6fe4a4347719f4445dd12b4f@canb.auug.org.au>
Date: Tue, 10 Jul 2012 11:42:47 +0530
Message-ID: <87a9z8cffk.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi Aneesh,
>
> On Mon,  9 Jul 2012 18:43:33 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:
>>
>> diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
>> index 1c65a59..1c984a6 100644
>> --- a/arch/powerpc/include/asm/mmu-hash64.h
>> +++ b/arch/powerpc/include/asm/mmu-hash64.h
>> @@ -154,9 +155,25 @@ struct mmu_psize_def
>>  #define MMU_SEGSIZE_256M	0
>>  #define MMU_SEGSIZE_1T		1
>>  
>> +/*
>> + * encode page number shift.
>> + * Inorder to fit the 78 bit va in a 64 bit variable we shift the va by
>> + * 12 bits. This enable us to address upto 76 bit va.
>> + * For hpt hash from a va we can ignore the page size bits of va and for
>> + * hpte encoding we ignore upto 23 bits of va. So ignoring lower 12 bits ensure
>> + * we work in all cases including 4k page size.
>> + */
>> +#define VPN_SHIFT	12
>>  
>> +static inline unsigned long hpte_encode_avpn(unsigned long vpn, int psize,
>> +					     int ssize)
>> +{
>> +	unsigned long v;
>> +	/*
>> +	 * The AVA field omits the low-order 23 bits of the 78 bits VA.
>> +	 * These bits are not needed in the PTE, because the
>> +	 * low-order b of these bits are part of the byte offset
>> +	 * into the virtual page and, if b < 23, the high-order
>> +	 * 23-b of these bits are always used in selecting the
>> +	 * PTEGs to be searched
>> +	 */
>> +	BUG_ON(VPN_SHIFT > 23);
>
> Could/should this be BUILD_BUG_ON()?
>

Yes. Will update.

-aneesh
