Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F20C4B6EE9
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 Nov 2009 07:53:26 +1100 (EST)
In-Reply-To: <4B0C1A25.8030401@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<CE435D2F-8C67-4045-942D-4AA08BF784D0@kernel.crashing.org>
	<4B0C1A25.8030401@yahoo.es>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CC1D5EB1-27C2-47A1-96D8-D007D86C4881@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 03/19] powerpc: gamecube: bootwrapper bits
Date: Tue, 24 Nov 2009 22:00:08 +0100
To: Albert Herranz <albert_herranz@yahoo.es>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> +asm ("\n\
>>
>>
>> A file scope asm?!  Please don't.
>>
> So what's your proposal then? Placing it within a fake func?
> That asm snippet is the entry point. I took as an example how  
> prpmc2800.c deals with that, providing an own version of the (weak)  
> _zImage_start.

Use an assembler source file.  You'll get much nicer syntax as well
(none of that \n stuff).

>>> +    /* IBAT3,DBAT3 for first 16Mbytes */\n\
>>> +    li    8, 0x01ff    /* 16MB */\n\
>>> +    li      9, 0x0002    /* rw */\n\
>>> +    mtspr   0x216, 8    /* IBAT3U */\n\
>>> +    mtspr   0x217, 9    /* IBAT3L */\n\
>>> +    mtspr   0x21e, 8    /* DBAT3U */\n\
>>> +    mtspr   0x21f, 9    /* DBAT3L */\n\
>>
>> WIMG=0000, are you sure?  Not M=1?
>
> To be honest, I don't recall the details now.
> But it was tested in the very early days, the result was not the  
> expected one and, in the end, manual cache coherency management was  
> still needed.

Sure, the memory controllers don't do coherency.  I'm slightly worried
about two things:
1) Will the generic code use M=0 as well?  Is it a problem if it  
doesn't?
2) Do lwarx. etc. work in M=0?

And a question: does M=0 actually give better performance (lower bus
utilisation, and maybe saves a few cycles)?


Segher
