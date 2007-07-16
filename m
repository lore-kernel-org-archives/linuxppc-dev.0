Return-Path: <becky.bruce@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A55F7DDE30
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Jul 2007 06:45:34 +1000 (EST)
In-Reply-To: <11629480.post@talk.nabble.com>
References: <11574529.post@talk.nabble.com> <11588451.post@talk.nabble.com>
	<0C6B2DC2-7621-4798-B3F7-7F1962A1D1A9@freescale.com>
	<11629480.post@talk.nabble.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F81B60DC-AC55-401C-812D-824C77BDD502@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: boottime kernel relocation, what I missed?
Date: Mon, 16 Jul 2007 15:51:31 -0500
To: meerkat <yiming@windriver.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jul 16, 2007, at 2:36 PM, meerkat wrote:

> So are you saying linker does all the relative reference, that the  
> bl  foo
> is always relative even though the foo is defined in a different  
> module? (In
> my case, bl call is made in head.S, early_init() is defined in  
> another file
> setup.c).

If you see "bl foo", it's relative.  It has to be, because that's how  
the instruction works.   Also, it's not really in a different module,  
it's just a different file, but it's all linked into a single  
executable image.

Cheers,
-Becky

>
> Regards,
>
> Jim
>
>
>
>
> Becky Bruce wrote:
>>
>>
>> On Jul 13, 2007, at 5:07 PM, meerkat wrote:
>>
>>>
>>> Figure that out, the bootstrap actually mapped the first 16M from
>>> C000000 to
>>> the physicall address,
>>> so calling a c routine, as long as it is in the first 16M, is OK
>>>
>>
>> I think you're still not understanding the fact that "bl" is a
>> *relative* branch - the branch target in the instruction encoding is
>> just an offset from the current address, not an effective address.
>> The bl should work correctly whether the code is actually running at
>> the link address reported by nm (0xcxxxxxxx in this case), or if it
>> has been loaded and executed elsewhere.
>>
>> Refer to the 32-bit Programming Environments Manual for PowerPC, or
>> in the EREF (if you're using a BookE part - e500/e200) for more
>> details.  If you're just learning PowerPC assembler, you should
>> really give this book a good thourough read.
>>
>>>
>>> meerkat wrote:
>>>>
>>>> Good day all,
>>>>
>>>> For the first time I begin working on PPC, and on low level, and
>>>> right
>>>> start from boot sequence, one issue puzzled me.
>>>>
>>>> After bootstrap code (zImage) uncompressed the kernel vmLinux to
>>>> physical
>>>> memory (say from addr 0),
>>>> it jumps to the kernel entry point, _start, using physically  
>>>> address.
>>
>> If you read the book specified above, you will see that branch
>> instructions always specify an effective address, not a physical
>> address.  You can disable translation or map the address so EA=PA,
>> but that's a different issue.
>>
>> -Becky
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
>>
>
> -- 
> View this message in context: http://www.nabble.com/boottime-kernel- 
> relocation%2C-what-I-missed--tf4072673.html#a11629480
> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
