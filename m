Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ADA72DDFCA
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 01:23:47 +1000 (EST)
Message-Id: <0C054AA3-9900-4DF0-BD38-6E82EFC327A6@kernel.crashing.org>
From: Becky Bruce <beckyb@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <D90E22E0-F97C-4531-9732-F8489D8BA7AD@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 1/5] powerpc: Use sg->dma_length in sg_dma_len() macro on
	32-bit
Date: Tue, 21 Apr 2009 10:23:39 -0500
References: <1240244810-32193-1-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-2-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-3-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-4-git-send-email-beckyb@kernel.crashing.org>
	<D90E22E0-F97C-4531-9732-F8489D8BA7AD@kernel.crashing.org>
Cc: fujita.tomonori@lab.ntt.co.jp, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 20, 2009, at 3:06 PM, Kumar Gala wrote:

>
> On Apr 20, 2009, at 11:26 AM, Becky Bruce wrote:
>
>> Currently, the 32-bit code uses sg->length instead of sg->dma_lentgh
>> to report sg_dma_len.  However, since the default dma code for 32-bit
>> (the dma_direct case) sets dma_length and length to the same thing,
>> we should be able to use dma_length there as well.  This gets rid of
>> some 32-vs-64-bit ifdefs, and is needed by the swiotlb code which
>> actually distinguishes between dma_length and length.
>>
>> Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
>> ---
>> arch/powerpc/include/asm/scatterlist.h |    6 +-----
>> 1 files changed, 1 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/scatterlist.h b/arch/powerpc/ 
>> include/asm/scatterlist.h
>> index fcf7d55..912bf59 100644
>> --- a/arch/powerpc/include/asm/scatterlist.h
>> +++ b/arch/powerpc/include/asm/scatterlist.h
>> @@ -21,7 +21,7 @@ struct scatterlist {
>> 	unsigned int offset;
>> 	unsigned int length;
>
> can we get rid of length?

No - they're both used by the iotlb code and are conceptually  
different.  "dma_length" can get set to less than "length" to indicate  
that something went wrong with a dma request - the iotlb code sets it  
to 0 if we can't allocate a bounce buffer, for example.  It probably  
has other uses as well - this is just the one I'm familiar with.  In  
most cases they are equal.

Cheers,
B
