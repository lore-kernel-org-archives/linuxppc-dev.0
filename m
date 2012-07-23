Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6495A2C0299
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 18:21:58 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 23 Jul 2012 18:21:45 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6N8Lql262390486
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 18:21:52 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6N8LqFp017852
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 18:21:52 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH -V3 09/11] arch/powerpc: Use 50 bits of VSID in slbmte
In-Reply-To: <20120723000658.GH17790@bloggs.ozlabs.ibm.com>
References: <1341839621-28332-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1341839621-28332-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20120723000658.GH17790@bloggs.ozlabs.ibm.com>
Date: Mon, 23 Jul 2012 13:51:49 +0530
Message-ID: <87394ij3aa.fsf@skywalker.in.ibm.com>
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

> On Mon, Jul 09, 2012 at 06:43:39PM +0530, Aneesh Kumar K.V wrote:
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> Increase the number of valid VSID bits in slbmte instruction.
>> We will use the new bits when we increase valid VSID bits.
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/mm/slb_low.S |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
>> index c355af6..c1fc81c 100644
>> --- a/arch/powerpc/mm/slb_low.S
>> +++ b/arch/powerpc/mm/slb_low.S
>> @@ -226,7 +226,7 @@ _GLOBAL(slb_allocate_user)
>>   */
>>  slb_finish_load:
>>  	ASM_VSID_SCRAMBLE(r10,r9,256M)
>> -	rldimi	r11,r10,SLB_VSID_SHIFT,16	/* combine VSID and flags */
>> +	rldimi	r11,r10,SLB_VSID_SHIFT,2	/* combine VSID and flags */
>
> You can't do that without either changing ASM_VSID_SCRAMBLE or masking
> the VSID it generates to 36 bits, since the logic in ASM_VSID_SCRAMBLE
> can leave non-zero bits in the high 28 bits of the result.  Similarly
> for the 1T case.
>

How about change ASM_VSID_SCRAMBLE to clear the high bits ? That would
also make it close to vsid_scramble()

diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index d24d484..173bb34 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -420,7 +420,8 @@ extern void slb_set_size(u16 size);
 	 * cases the answer is the low 36 bits of (r3 + ((r3+1) >> 36))*/\
 	addi	rx,rt,1;						\
 	srdi	rx,rx,VSID_BITS_##size;	/* extract 2^VSID_BITS bit */	\
-	add	rt,rt,rx
+	add	rt,rt,rx;						\
+	clrldi   rt,rt,(64 - VSID_BITS_##size);
 
 /* 4 bits per slice and we have one slice per 1TB */
 #if 0 /* We can't directly include pgtable.h hence this hack */
