Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C520F2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2012 19:56:31 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 1 Aug 2012 15:26:27 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q719uPqs25821250
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Aug 2012 15:26:25 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q719uOHS012016
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Aug 2012 19:56:25 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH -V5 12/13] arch/powerpc: Replace open coded CONTEXT_BITS
 value
In-Reply-To: <20120801052902.GF24014@drongo>
References: <1343647339-25576-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1343647339-25576-13-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20120801052902.GF24014@drongo>
Date: Wed, 01 Aug 2012 15:26:18 +0530
Message-ID: <87obmvhr5p.fsf@skywalker.in.ibm.com>
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

> On Mon, Jul 30, 2012 at 04:52:18PM +0530, Aneesh Kumar K.V wrote:
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> To clarify the meaning for future readers, replace the open coded
>> 19 with CONTEXT_BITS
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/mm/mmu_context_hash64.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/arch/powerpc/mm/mmu_context_hash64.c b/arch/powerpc/mm/mmu_context_hash64.c
>> index 40677aa..daa076c 100644
>> --- a/arch/powerpc/mm/mmu_context_hash64.c
>> +++ b/arch/powerpc/mm/mmu_context_hash64.c
>> @@ -34,7 +34,7 @@ static DEFINE_IDA(mmu_context_ida);
>>   * Each segment contains 2^28 bytes.  Each context maps 2^44 bytes,
>>   * so we can support 2^19-1 contexts (19 == 35 + 28 - 44).
>>   */
>> -#define MAX_CONTEXT	((1UL << 19) - 1)
>> +#define MAX_CONTEXT	((1UL << CONTEXT_BITS) - 1)
>
> This is a good thing to do, but you should also update the comment.
> Maybe you should put this patch before your number 10/13 and then
> change the comment in the same patch where you add the 64TB support.

Moved this as the first patch and updated the doc the following doc
update patch.

-aneesh
