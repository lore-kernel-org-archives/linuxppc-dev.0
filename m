Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id B8C8A1A0017
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 00:50:14 +1100 (AEDT)
Subject: Re: [PATCH v2 06/25] powerpc32: iounmap() cannot vunmap() area mapped
 by TLBCAMs either
To: Scott Wood <scottwood@freescale.com>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
 <2b94a5b931daa6aa2f32ddad88175d932da4d573.1442939410.git.christophe.leroy@c-s.fr>
 <20150928234116.GC6161@home.buserror.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <5613D193.7050104@c-s.fr>
Date: Tue, 6 Oct 2015 15:50:11 +0200
MIME-Version: 1.0
In-Reply-To: <20150928234116.GC6161@home.buserror.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Le 29/09/2015 01:41, Scott Wood a écrit :
> On Tue, Sep 22, 2015 at 06:50:40PM +0200, Christophe Leroy wrote:
>> iounmap() cannot vunmap() area mapped by TLBCAMs either
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>> No change in v2
>>
>>   arch/powerpc/mm/pgtable_32.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
>> index 7692d1b..03a073a 100644
>> --- a/arch/powerpc/mm/pgtable_32.c
>> +++ b/arch/powerpc/mm/pgtable_32.c
>> @@ -278,7 +278,9 @@ void iounmap(volatile void __iomem *addr)
>>   	 * If mapped by BATs then there is nothing to do.
>>   	 * Calling vfree() generates a benign warning.
>>   	 */
>> -	if (v_mapped_by_bats((unsigned long)addr)) return;
>> +	if (v_mapped_by_bats((unsigned long)addr) ||
>> +	    v_mapped_by_tlbcam((unsigned long)addr))
>> +		return;
> This is pretty pointless given that the next patch replaces both with
> v_mapped_by_other().
>
>
I thought it was cleaner to first fix the bug, in order to make the 
following patch straight through, but I can skip it, no problem.

Christophe
