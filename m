Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 6A4481A0BEF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 05:07:56 +1000 (AEST)
Message-ID: <553FDA87.3010104@c-s.fr>
Date: Tue, 28 Apr 2015 21:07:51 +0200
From: christophe leroy <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: powerpc32: rearrange instructions order in ip_fast_csum()
References: <20150203113927.B909E1A5F15@localhost.localdomain>
 <20150325012248.GA7270@home.buserror.net>
In-Reply-To: <20150325012248.GA7270@home.buserror.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
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



Le 25/03/2015 02:22, Scott Wood a écrit :
> On Tue, Feb 03, 2015 at 12:39:27PM +0100, LEROY Christophe wrote:
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/lib/checksum_32.S | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/lib/checksum_32.S b/arch/powerpc/lib/checksum_32.S
>> index 6d67e05..5500704 100644
>> --- a/arch/powerpc/lib/checksum_32.S
>> +++ b/arch/powerpc/lib/checksum_32.S
>> @@ -26,13 +26,17 @@
>>   _GLOBAL(ip_fast_csum)
>>   	lwz	r0,0(r3)
>>   	lwzu	r5,4(r3)
>> -	addic.	r4,r4,-2
>> +	addic.	r4,r4,-4
>>   	addc	r0,r0,r5
>>   	mtctr	r4
>>   	blelr-
>> -1:	lwzu	r4,4(r3)
>> -	adde	r0,r0,r4
>> +	lwzu	r5,4(r3)
>> +	lwzu	r4,4(r3)
> The blelr is pointless since len is guaranteed to be >= 5 (assuming that
> comment is accurate), but now it's both pointless and in the wrong place,
> since you haven't yet finished the four words that you subtracted from
> r4.
The blelr is just there to protect the function against negative value 
of r4 hence ctr.
In any case, the returned result in that case in not correct, has we do 
not touch r3.
>
> How about keeping the blelr, without the -, moving it after the initial
> words, and changing the number of inital words to 5?
We can't just do blelr, we would need to fold the result first.
But indeed, this would be useless because I quickly checked and it seems 
that all functions calling ip_fast_csum()
check that the length is not lower than 5.
So I will just remove the blelr
> Also maybe do all
> the loads up front, since many PPC chips have a three cycle load latency
> rather than two.
ok

Christophe

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
http://www.avast.com
