Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 865CBDDECF
	for <linuxppc-dev@ozlabs.org>; Sat, 31 May 2008 16:05:35 +1000 (EST)
Message-Id: <C07E096A-00D9-4AED-9667-F445C5F1E534@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18496.56427.301039.954088@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH v4] [POWERPC] Move to runtime allocated exception stacks
Date: Sat, 31 May 2008 01:05:00 -0500
References: <1211259767-4796-1-git-send-email-galak@kernel.crashing.org>
	<18496.56427.301039.954088@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 31, 2008, at 12:04 AM, Paul Mackerras wrote:

> Kumar Gala writes:
>
>> For the additonal exception levels (critical, debug, machine check)  
>> on
>> 40x/book-e we were using "static" allocations of the stack in the
>> associated head.S.
>>
>> Move to a runtime allocation to make the code a bit easier to read as
>> we mimic how we handle IRQ stacks.  Its also a bit easier to setup  
>> the
>> stack with a "dummy" thread_info in C code.
>
> Looks fine, with just one very minor comment:
>
>> -	addi	r11,r11,THREAD_SIZE;					     \
>> -1:	subi	r11,r11,INT_FRAME_SIZE;	/* Allocate an exception frame      
>> */\
>> +1:	addi	r11,r11,THREAD_SIZE;					     \
>> +	subi	r11,r11,INT_FRAME_SIZE;	/* Allocate an exception frame     */\
>
> You could make that a single addi r11,r11,THREAD_SIZE-INT_FRAME_SIZE
> now.

I remember noticing that and thinking I should go back in fix.  Will  
look at doing that and add the patches to my powerpc-next tree.

- k
