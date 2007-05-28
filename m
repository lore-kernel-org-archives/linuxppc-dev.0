Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3F3EDDDF90
	for <linuxppc-dev@ozlabs.org>; Mon, 28 May 2007 21:34:33 +1000 (EST)
In-Reply-To: <jesl9hgql9.fsf@sykes.suse.de>
References: <Pine.LNX.4.64.0705270856560.4113@gate.crashing.org>
	<jesl9hgql9.fsf@sykes.suse.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e460825e91e0abfc55f8dd777dcc248b@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Please pull powerpc.git for_paulus branch (fwd)
Date: Mon, 28 May 2007 13:34:20 +0200
To: Andreas Schwab <schwab@suse.de>
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> -	.comm	fee_restarts,4
>> +	.section .bss
>> +	.align	2
>> +fee_restarts:
>> +	.space	4
>> +	.previous
>
> This is equivalent to .lcomm.

Oh nice!  So this should become

	.lcomm fee_restarts,4,4

for the local symbols, and

	.globl fee_restarts
	.lcomm fee_restarts,4,4

for the global ones.  Kumar: the parameters here are size,align;
and it takes an alignment in bytes, not in power-of-two like
.align does on powerpc.  Which is a good thing, considering that
you messed up the log-alignment for global_dcbr0 in the original
patch ;-)


Segher
