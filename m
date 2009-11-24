Return-Path: <albert_herranz@yahoo.es>
Received: from smtp129.mail.ukl.yahoo.com (smtp129.mail.ukl.yahoo.com
	[77.238.184.60]) by ozlabs.org (Postfix) with SMTP id 923531007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 Nov 2009 04:38:48 +1100 (EST)
Message-ID: <4B0C1A25.8030401@yahoo.es>
Date: Tue, 24 Nov 2009 18:38:45 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 03/19] powerpc: gamecube: bootwrapper bits
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<CE435D2F-8C67-4045-942D-4AA08BF784D0@kernel.crashing.org>
In-Reply-To: <CE435D2F-8C67-4045-942D-4AA08BF784D0@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
> Hi Albert,
> 
>> +asm ("\n\
> 
> 
> A file scope asm?!  Please don't.
> 

So what's your proposal then? Placing it within a fake func?
That asm snippet is the entry point. I took as an example how prpmc2800.c deals with that, providing an own version of the (weak) _zImage_start.

>> + * We enter with the cache enabled, the MMU enabled and some known
>> legacy
>> + * memory mappings active. xBAT3 is unused
> 
> It would be good if you could depend as little as possible on these things;
> that makes writing another bootloader a lot easier.
> 

Ok. I'll do a similar approach as done on the wii bootwrapper.

>> +    /* IBAT3,DBAT3 for first 16Mbytes */\n\
>> +    li    8, 0x01ff    /* 16MB */\n\
>> +    li      9, 0x0002    /* rw */\n\
>> +    mtspr   0x216, 8    /* IBAT3U */\n\
>> +    mtspr   0x217, 9    /* IBAT3L */\n\
>> +    mtspr   0x21e, 8    /* DBAT3U */\n\
>> +    mtspr   0x21f, 9    /* DBAT3L */\n\
> 
> WIMG=0000, are you sure?  Not M=1?
> 

To be honest, I don't recall the details now.
But it was tested in the very early days, the result was not the expected one and, in the end, manual cache coherency management was still needed.

So everything is designed and working assuming M=0.
This can be re-checked again later if needed.

>> +    bcl-    20,4*cr7+so,1f\n\
> 
> Just write  bcl 20,31,1f .

Ok, I used two variants for this and I know which one you like now ;).

> 
> 
> Segher
> 
> 

Thanks,
Albert
