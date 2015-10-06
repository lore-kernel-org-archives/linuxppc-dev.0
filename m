Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id AF0D01A0017
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 01:02:59 +1100 (AEDT)
Subject: Re: [PATCH v2 07/25] powerpc32: refactor x_mapped_by_bats() and
 x_mapped_by_tlbcam() together
To: Scott Wood <scottwood@freescale.com>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
 <a5b89d1db195031679775bfe7c32f903e9403bb3.1442939410.git.christophe.leroy@c-s.fr>
 <20150928234702.GD6161@home.buserror.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <5613D490.9060704@c-s.fr>
Date: Tue, 6 Oct 2015 16:02:56 +0200
MIME-Version: 1.0
In-Reply-To: <20150928234702.GD6161@home.buserror.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 29/09/2015 01:47, Scott Wood a écrit :
> On Tue, Sep 22, 2015 at 06:50:42PM +0200, Christophe Leroy wrote:
>> x_mapped_by_bats() and x_mapped_by_tlbcam() serve the same kind of
>> purpose, so lets group them into a single function.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>> No change in v2
>>
>>   arch/powerpc/mm/pgtable_32.c | 33 ++++++++++++++++++++++++++-------
>>   1 file changed, 26 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
>> index 03a073a..3fd9083 100644
>> --- a/arch/powerpc/mm/pgtable_32.c
>> +++ b/arch/powerpc/mm/pgtable_32.c
>> @@ -67,6 +67,28 @@ extern unsigned long p_mapped_by_tlbcam(phys_addr_t pa);
>>   #define p_mapped_by_tlbcam(x)	(0UL)
>>   #endif /* HAVE_TLBCAM */
>>   
>> +static inline unsigned long p_mapped_by_other(phys_addr_t pa)
>> +{
>> +	unsigned long v;
>> +
>> +	v = p_mapped_by_bats(pa);
>> +	if (v /*&& p_mapped_by_bats(p+size-1)*/)
>> +		return v;
>> +
>> +	return p_mapped_by_tlbcam(pa);
>> +}
> Did you forget to remove that comment?
>
>
No I didn't, I though it was there for a reason, it has been there since 
2005.
Do you think I should remove it ?

Christophe
