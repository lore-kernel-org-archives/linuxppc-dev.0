Return-Path: <hollis@penguinppc.org>
Received: from smtpauth02.mail.atl.earthlink.net
	(smtpauth02.mail.atl.earthlink.net [209.86.89.62])
	by ozlabs.org (Postfix) with ESMTP id 0DAC067A04
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Jun 2005 11:03:01 +1000 (EST)
In-Reply-To: <4b474e026a1d6040f1ec24466d8ff6a8@kernel.crashing.org>
References: <42A5B3E6.9030401@nortel.com>
	<4b474e026a1d6040f1ec24466d8ff6a8@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <455acab93dd9ab20cbbc1cff400f84e3@penguinppc.org>
From: Hollis Blanchard <hollis@penguinppc.org>
Date: Tue, 7 Jun 2005 20:02:57 -0500
To: Chris Friesen <cfriesen@nortel.com>
Cc: Linux PPC Dev <linuxppc-dev@ozlabs.org>
Subject: Re: syntax for clobber list with inline assembly
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Jun 7, 2005, at 10:00 AM, Segher Boessenkool wrote:

>> I'm writing some inline assembly for ppc.  To specify that r3 is 
>> used, I know I need to list it in the clobbered list.
>>
>> When doing this, do I specify it as "3" or "r3", or are both valid?
>
> Both work.

But it should be said that much better style is to let the compiler 
choose registers for you, i.e. don't hardcode register numbers at all. 
For example (well, it's contrived, but I hope you get the idea):

	int out;
	asm("mfmsr r3\n"
		"ori %0, r3, 0x1\n"
		: "=r"(out)
		:
		: "r3");

would be better written as

	int out, tmp;
	asm("mfmsr %1\n"
		"ori %0, %1, 0x1\n"
		: "=r"(out),  "=r"(tmp)
		:
		: );

Be careful about using "r" constraints when dealing with instructions 
that treat r0 as a special case, such as addi or lwz (use "b" instead).

Also be careful about gcc arranging outputs and inputs in the same 
register; it looks different when you're writing "%0" and "%1" in your 
assembly, but it's not.

Inline assembly is very subtle. If you mess up your constraints now, 
you might never know until you rebuild with a different compiler 
version and things fall apart.

-Hollis
