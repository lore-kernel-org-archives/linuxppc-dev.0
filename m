Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 50004DDE10
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 20:12:03 +1000 (EST)
In-Reply-To: <1190861310.6502.10.camel@concordia>
References: <46F88896.50706@au1.ibm.com>
	<E4CA12E1-888D-4A8B-B687-02F9D2850E1F@kernel.crashing.org>
	<46F9B454.8010004@au1.ibm.com>
	<1B211071-5D55-4DBC-A109-7A66EC17A810@kernel.crashing.org>
	<46F9E67C.4070209@au1.ibm.com>
	<8FC0C4ED-3268-467C-A3EF-0336082062E1@kernel.crashing.org>
	<1190861310.6502.10.camel@concordia>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1D8E59FD-E8B1-446C-ABEE-D41F5496B518@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] add Altivec/VMX state to coredumps
Date: Thu, 27 Sep 2007 05:10:47 -0500
To: Michael Ellerman <michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Carlos Eduardo Seo <eduseo@br.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> You're probably right :)
>>>
>>> What cores have SPE at the moment? Also, perhaps more importantly,
>>> are there any plans to have Altivec and SPE in the same core?
>>
>> The e500 cores's from Freescale.
>>
>> No, they are pretty much mutually exclusive.
>>
>>> I've been working with Carlos Eduardo Seo (Cc'ed on this mail) on
>>> the GDB side of this.
>>
>>  From comments it looks like the expectation is that the combination
>> of note type and name which is expected to be unique.
>>
>> I'm wondering if we should handle this via
>> elf_coredump_extra_notes_size() & elf_coredump_extra_notes_write().
>> Does GDB care about the order it sees the various sections in?
>
> I don't think those callbacks will work in this case, they're only
> called for the primary thread that's doing the coredump, not for each
> thread. Perhaps there's a way to adapt it though.
>
> I think the easiest solution for now is just to make the note type a
> #define and create a new value for Altivec.

Oh, well.  It shouldn't be too difficult to abstract vector handler  
similar to how we do GPRs today to the core dump code.

- k
