Return-Path: <biggerbadderben@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id F13CFDDDF3
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Jan 2008 02:16:06 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so482743anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Jan 2008 07:16:05 -0800 (PST)
Message-ID: <4794B732.1080207@gmail.com>
Date: Mon, 21 Jan 2008 10:16:02 -0500
From: Ben Warren <biggerbadderben@gmail.com>
MIME-Version: 1.0
To: Bruce_Leonard@selinc.com
Subject: Re: Endian problem when accessing internel regs on 8347
References: <OFE90E4633.93F2906B-ON882573D7.002448B6-882573D7.00287256@selinc.com>
In-Reply-To: <OFE90E4633.93F2906B-ON882573D7.002448B6-882573D7.00287256@selinc.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hey Bruce,

Bruce_Leonard@selinc.com wrote:
>>>>> __asm__ __volatile__("lwz%U1%X1 %0,%1; twi 0,%0,0; isync" : "=r" 
>>>>>           
> (ret) 
>   
>>> : 
>>>       
>>>>> "m" (*addr));
>>>>>           
>>>> They allow the compiler to use update and/or index mode for the 
>>>>         
> memory 
>   
>>>> operand.
>>>>         
>>> Well that makes sense, U for update and X for index, but I'm not sure 
>>> they're applicable to this particular instruction and I'm not sure 
>>>       
> that 
>   
>>> the memory operand makes sense for PowerPC.
>>>       
>> Why not?
>>     
>
> Okay, after much digging and experimenting, I'll agree that the memory 
> operand makes sense.  When I first said that I was thinking of direct 
> manipulation of memory, which the PPC doesn't support.  (Don't ask, my 
> brain sometimes goes off into la-la land without me :-> )  Also, update 
> mode is applicable and makes sense.  But I do still have a problem with 
> the index mode, though it could be compiler magic.  Here's why: the index 
> mode of the 'lwz' instruction requires three operands, i.e., 'lwzx 
> rD,rA,rB', and there's only place holders for two operands.  Is the 
> compiler smart enough to add the third operand for the index mode?  If so, 
> what does it put for the third operand?
>
> Another question is how does the compiler know which mode to pick?  And 
> what is the significance of the trailing number?  Some places in the code 
> have %U1%X1 and others have %U2%X2?  I've found documentation for the # 
> and ## tokens, but I can't find anything for the %U or %X tokens.
>
> Now this has all been very interesting to learn but doesn't solve my 
> underlying problem which I've finally drilled down to.  At first I thought 
> in_be32() might be broken because I wasn't getting back the value I knew 
> to be in the internal register.  I knew I had the address and the mapping 
> to kernel space correct because I could use in_le32 and get the right 
> value though it was byte swapped.  The value in the register was 
> 0xFFFFFFE7 but what I was getting from in_be32 was 0xFFFFFFFF.  Then I 
> started playing and here's what I found:
>
> Register value  in_be32 value
> 0x12345678              0x1234567
> 0xff345678              0xff345678
> 0xffff5678              0xffff5678
> 0xfffff678              0xfffff678
> 0xfffffe78              0xffffffff
> 0xffffff78              0xffffffff
>
> This isn't an exhastive list but I tried about twenty values and pretty 
> much what I found was that if bits 0 through 22 are set to 1 then in_be32 
> reads 0xffffffff.  I've also tried it at a variety of addresses and the 
> behaviour is the same.  in_le32 works fine as does in_be16.  I've got no 
> ideas as to what may be wrong.  I don't want to just arbitrarily point to 
> that %U1%X1 parameter list, but I get compiler errors if I try to remove 
> them so I can't prove or disprove it and I can't find any documentation on 
> it I can't even form a theroy.  Has anyone ever seen anything like this? 
> Can't anyone suggest anything I can try?
>   
Are you sure that all the bits are configured as GPIO? Almost every 
peripheral pin on these chips is muxed at least two ways. Maybe some of 
the bits that you think are GPIO are configured as some other bus, 
possibly explaining goofy behavior and perceived volatility of data. 
This is pretty well-vetted code on a reasonably mature product, and in 
my experience it's very rarely the tools ...

Just a thought.

regards,
Ben
