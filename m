Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6A4D0DE468
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 02:46:17 +1000 (EST)
Message-Id: <211B96D9-35C6-49BC-93C5-EA0510C91FFA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: "Sulibhavi, Madhvesh" <madhvesh.s@ap.sony.com>
In-Reply-To: <7B7EF7F090B9804A830ACC82F2CDE95D2BB0F2@insardxms01.ap.sony.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [RFC] Kprobes for book-e
Date: Thu, 19 Jun 2008 11:44:44 -0500
References: <7B7EF7F090B9804A830ACC82F2CDE95D2BB0F2@insardxms01.ap.sony.com>
Cc: linuxppc-dev@ozlabs.org, rsmadhvesh@vsnl.net,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 17, 2008, at 8:31 AM, Sulibhavi, Madhvesh wrote:

> Sulibhavi, Madhvesh wrote on Thursday, June 12, 2008 7:59 PM
>>>> static void __kprobes prepare_singlestep(struct kprobe *p, struct
>>>> pt_regs *regs)
>>>> {
>>>> +#ifdef CONFIG_BOOKE
>>>> +	regs->msr &= ~(MSR_EE); /* Turn off 'Externel Interrupt' bits */
>>>> +	regs->msr &= ~(MSR_CE); /* Turn off 'Critical Interrupt' bits */
>>>> +	regs->msr |= MSR_DE;
>>>
>>> can we remove MSR_EE and MSR_CE here?
>>
>> Ah! yes?
>
> No!!, this code cannot be removed. My tests fail
> while doing the probe test for do_gettimeofday and __kmalloc.
> I get Oops and Segfault. I think i had got similar results
> in my initial port using 2.6.26.39. Here is the log...

What is that test.  Can you send it to me.  Its not clear to me why  
this is an issue.

- k
