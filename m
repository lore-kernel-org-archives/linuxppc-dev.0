Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CCEC7DDF50
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Apr 2008 05:47:21 +1100 (EST)
In-Reply-To: <835D8B13-CF90-4013-A172-8243BF93DE52@pobox.com>
References: <afed3e5de82ab6c0ac8d.1207292794@thinkpadL>
	<835D8B13-CF90-4013-A172-8243BF93DE52@pobox.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <851f4822aac18c820ac2b5755ad3c364@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [kvm-ppc-devel] [PATCH] [v2] Add idle wait support for 44x
	platforms
Date: Fri, 4 Apr 2008 20:47:04 +0200
To: Jimi Xenidis <jimix@pobox.com>
Cc: kvm-ppc-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> +	msr_save = mfmsr();
>> +	/* set wait state MSR */
>> +	mtmsr(msr_save|MSR_WE|MSR_EE|MSR_CE);
>
> Did we decide to drop MSR_DE?
>
>> +	/* return to initial state */
>> +	mtmsr(msr_save);
>
> It may be my paranoia but I'm pretty sure you need the isync() after
> _both_ mtmsr()s
> Certainly can't hurt.

It hurts because it spreads the paranoia.  Cargo cult.

Please add a comment that explains _why_ you need a context 
synchronising
instruction here.  The POWER ISA 2.05 says that the requirements for
changing the WE bit are implementation dependent, both before and after
the mtmsr, so the safe thing to do would be to use the "big hammer" 
isync
both before and after each of these mtmsrs.  A sync before entering wait
state might be needed as well, dunno.  Either way, comment please :-)


Segher
