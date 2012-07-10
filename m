Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DD0822C0080
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 16:15:44 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 10 Jul 2012 11:45:40 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6A6Fb8W60620886
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 11:45:38 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6ABkCZW026079
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 21:46:12 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH -V3 03/11] arch/powerpc: Convert virtual address to vpn
In-Reply-To: <20120710090605.03b5887c0dabdf61eb70b68a@canb.auug.org.au>
References: <1341839621-28332-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1341839621-28332-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20120710090605.03b5887c0dabdf61eb70b68a@canb.auug.org.au>
Date: Tue, 10 Jul 2012 11:45:36 +0530
Message-ID: <877guccfav.fsf@skywalker.in.ibm.com>
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
>> diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
>> index 660b8bb..308e29d 100644
>> --- a/arch/powerpc/mm/hash_native_64.c
>> +++ b/arch/powerpc/mm/hash_native_64.c
>> @@ -39,22 +39,33 @@
>>  
>>  DEFINE_RAW_SPINLOCK(native_tlbie_lock);
>>  
>> -static inline void __tlbie(unsigned long va, int psize, int ssize)
>> +static inline void __tlbie(unsigned long vpn, int psize, int ssize)
>>  {
>> +	unsigned long va;
>>  	unsigned int penc;
>>  
>> +	/*
>> +	 * We need 14 to 65 bits of va for a tlibe of 4K page
>> +	 * With vpn we ignore the lower VPN_SHIFT bits already.
>> +	 * And top two bits are already ignored because we can
>> +	 * only accomadate 76 bits in a 64 bit vpn with a VPN_SHIFT
>> +	 * of 12.
>> +	 */
>> +	BUG_ON((77 - 65) > VPN_SHIFT);
>
> BUILD_BUG_ON() ?

Yes. I also found a bug there. It should be updated as below

	BUILD_BUG_ON(VPN_SHIFT > (77 - 65));

We want to make sure we are not ignoring bits above 65th bit. 


>
>> -static inline void __tlbiel(unsigned long va, int psize, int ssize)
>> +static inline void __tlbiel(unsigned long vpn, int psize, int ssize)
>>  {
>> +	unsigned long va;
>>  	unsigned int penc;
>>  
>> +	BUG_ON((77 - 65) > VPN_SHIFT);
>
> BUILD_BUG_ON() ?

-aneesh
