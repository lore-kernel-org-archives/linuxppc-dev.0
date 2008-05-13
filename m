Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 917E8DDF55
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 23:47:12 +1000 (EST)
Message-Id: <E698D68F-573B-422C-A44E-9631DE516E7B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18473.33194.781010.826872@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: how to check for "optional" ppc chip features (MSR_BE)
Date: Tue, 13 May 2008 08:47:04 -0500
References: <20080502012118.96ED926FA07@magilla.localdomain>
	<DC173CDE-FBC4-4EA0-8022-3F993B6466BF@kernel.crashing.org>
	<1209937549.21644.2.camel@pasglop>
	<20080504231207.8377E26FA08@magilla.localdomain>
	<18473.33194.781010.826872@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 13, 2008, at 6:55 AM, Paul Mackerras wrote:

> Roland McGrath writes:
>
>> Yeah, all that stuff I could figure out as needed.  What I really  
>> meant
>> was, where is the big official table of which chips behave which  
>> ways that
>> you base all code that on?  Actually, I don't really care as long  
>> as you
>> all are happy to be responsible for figuring out what matters.   
>> With the
>> patch I posted to use MSR_BE, I took Kumar Gala's word as gospel  
>> that all
>> the chips on which we use MSR_SE also have MSR_BE.  If that's not  
>> right,
>> then I hope you'd like to pick a feature bit, populate the tables,  
>> etc.,
>> and fix the definition of arch_has_block_step() as appropriate.
>
> It turns out that the 601 doesn't support MSR_BE.  It looks like all
> the "classic" 32-bit implementations after that (603, 604, 7xx, 7xxx)
> implemented BE, as do POWER3 and RS64.  I'll check the later 64-bit
> processors -- I think they all implement BE.  4xx and Book E have it
> in a different form.  I'll let Kumar find out about 8xx and 82xx.

it appears 8xx does, and 82xx are just 603 cores so they do.

> So it looks like we need to define a new feature bit to mean "supports
> block-step".  Is this something that userspace will expect to be told
> about via the AT_HWCAP entry in the aux vector?

- k
