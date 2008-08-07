Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7AE9FDDE0A
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 11:17:51 +1000 (EST)
In-Reply-To: <18586.13766.755344.181525@cargo.ozlabs.ibm.com>
References: <18585.14669.954874.540716@drongo.ozlabs.ibm.com>
	<A1BAD7C8-8459-4D6E-80BA-639D305611DD@kernel.crashing.org>
	<18586.13766.755344.181525@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6AD17EA2-2053-4196-A78D-D4B505095E00@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH] Link the bootwrapper as a position-independent
	executable
Date: Thu, 7 Aug 2008 03:17:33 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +	bl	.+4
>>> +p_base:	mflr	r10		/* r10 now points to runtime addr of p_base */
>>
>> bl p_base  instead?
>
> I went back and forth on that.  I ended up with it that way to
> emphasize that the bl does need to branch to the *next* instruction
> for the idiom to work.

Right, I see.  Make it even more obvious?  Use "bcl 20,31,$+4" instead
(so people will have to look it up before changing this code, not  
because
it is a few cycles faster ;-) ), add an empty line before the label, or
even put an actual comment there?  :-)


>>> +10:	or.	r8,r0,r9	/* skip relocation if we don't have both */
>>>  	beq	3f
>>
>> Either the code or the comment is wrong -- the code says "skip
>> relocation
>> if we don't have either".
>
> Ah, operator precedence rules in English. :)

While I don't think that double (and triple) negations in English are
not overused and confusing...

> I (and I think most
> native English speakers) would parse my comment as "don't (have both)"
> whereas I think you parsed it as "(don't have) both".  Similarly what
> you say the code says parses as "don't (have either)" for me rather
> than "(don't have) either".   IOW, "don't have either" means "both are
> missing".

... that is exactly what I meant: the code skips relocation only if
both are missing.

> Anyway I can change the comment to say "we need both to do
> relocation".  OK?

Please do -- but also change the code to match :-)

>>> +  .dynsym : { *(.dynsym) }
>>> +  .dynstr : { *(.dynstr) }
>>> +  .dynamic :
>>> +  {
>>> +    __dynamic_start = .;
>>> +    *(.dynamic)
>>> +  }
>>> +  .hash : { *(.hash) }
>>> +  .interp : { *(.interp) }
>>> +  .rela.dyn : { *(.rela*) }
>>
>> Do some of these sections need alignment?
>
> I suppose they should ideally be 4-byte aligned.

Ideally, yes; I was questioning whether the ABI requires it.  It will
only cost a few bytes of object size so let's just do it?

> We don't actually
> use .dynsym, .dynstr, .hash or .interp, but I couldn't find any way to
> make the linker omit them.

Assign those input sections to the /DISCARD/ output section (and do
that early enough in the linker script so they aren't picked up by
some other wildcard).  Something like

	/DISCARD/ : { *(.dynstr .dynsym .hash .interp) }


Segher
