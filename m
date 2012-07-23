Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6AFA42C028D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 18:49:41 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 23 Jul 2012 14:19:36 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6N8nXNK11010100
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 14:19:33 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6N8nXgl026465
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 18:49:33 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH -V3 11/11] arch/powerpc: Add 64TB support
In-Reply-To: <20120723001539.GI17790@bloggs.ozlabs.ibm.com>
References: <1341839621-28332-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1341839621-28332-12-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20120723001539.GI17790@bloggs.ozlabs.ibm.com>
Date: Mon, 23 Jul 2012 14:19:32 +0530
Message-ID: <87wr1uhnfn.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> writes:

> On Mon, Jul 09, 2012 at 06:43:41PM +0530, Aneesh Kumar K.V wrote:
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> Increase max addressable range to 64TB. This is not tested on
>> real hardware yet.
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/mmu-hash64.h        |    8 ++++----
>>  arch/powerpc/include/asm/pgtable-ppc64-4k.h  |    2 +-
>>  arch/powerpc/include/asm/pgtable-ppc64-64k.h |    2 +-
>>  arch/powerpc/include/asm/processor.h         |    4 ++--
>>  arch/powerpc/include/asm/sparsemem.h         |    4 ++--
>>  5 files changed, 10 insertions(+), 10 deletions(-)
>> 
>> diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
>> index aa0d560..a227ba7 100644
>> --- a/arch/powerpc/include/asm/mmu-hash64.h
>> +++ b/arch/powerpc/include/asm/mmu-hash64.h
>> @@ -374,16 +374,16 @@ extern void slb_set_size(u16 size);
>>   */
>>  
>>  #define VSID_MULTIPLIER_256M	ASM_CONST(200730139)	/* 28-bit prime */
>> -#define VSID_BITS_256M		36
>> +#define VSID_BITS_256M		38
>>  #define VSID_MODULUS_256M	((1UL<<VSID_BITS_256M)-1)
>
> With these settings, the multiplication in ASM_VSID_SCRAMBLE could
> overflow, leading to incorrect results (which would cause occasional
> corruption of user processes under heavy load).  You will need to
> reduce the multiplier to be less than 2^26, and it will need to be
> co-prime with 2^38 - 1.  (Probably, the same value as we use in the 1T
> case would be OK.)

I ended up using the same value as VSID_MULTIPLIER_1T. 


(gdb) p/d 1ull << 38
$1 = 274877906944
(gdb) p/d 274877906943/12538073
$2 = 21923
(gdb) p/d 12538073ll*21923
$5 = 274872174379
