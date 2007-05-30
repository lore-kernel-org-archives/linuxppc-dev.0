Return-Path: <tmbinc@elitedvb.net>
Received: from mfe2.prod2.dngr.net (unknown [216.220.221.222])
	by ozlabs.org (Postfix) with ESMTP id 084D3DDF19
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 22:52:34 +1000 (EST)
Date: Wed, 30 May 2007 13:52:29 +0200
Subject: Re: Saving to 32 bits of GPRs in signal context
In-Reply-To: <1180524227.19517.256.camel@localhost.localdomain>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Mime-Version: 1.0
References: <1180423456.19517.124.camel@localhost.localdomain>
	<1180524227.19517.256.camel@localhost.localdomain>
From: Felix Domke <tmbinc@elitedvb.net>
Message-Id: <1180525953.1F02B585@fk13.dngr.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: Felix Domke <tmbinc@elitedvb.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>  Anyway, please don't. It is *not* portable.
> What are you talking about ? Really, I mean, I'm not sure I understand
> what you mean :-)
Segher stated that there is no portable way of detecting whether 64bit 
instructions are available, and said that just trying a 64bit insn (and 
catching the SIGILL if thre cpu is 32bit) is probably the most portable 
way to do so. (Or did i got *that* wrong? If so, please ignore.)

Now my objection is that the "SIGILL"-way is not only ugly, but can be 
easily *wrong*, as there are certain possibilities (Book-E 64bit, 
non-64bit-aware OS, ...) when the CPU might not throw an exception.  (My 
"ffmpeg with vmx"-experience shows this is a real world issue, although 
the situation is a bit different there, i agree, since vmx opcodes are 
not exclusively reserved for vmx)

Yes, those hwcap-bits should care for this. Are they portable/usable, 
even on older systems?

Felix
