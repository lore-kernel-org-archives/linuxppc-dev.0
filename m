Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D3DECDDE42
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Jan 2008 03:57:50 +1100 (EST)
Date: Mon, 21 Jan 2008 10:40:06 -0600
From: Scott Wood <scottwood@freescale.com>
To: Bruce_Leonard@selinc.com
Subject: Re: Endian problem when accessing internel regs on 8347
Message-ID: <20080121164006.GA3455@ld0162-tx32.am.freescale.net>
References: <478FD442.8060902@freescale.com>
	<OFE90E4633.93F2906B-ON882573D7.002448B6-882573D7.00287256@selinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OFE90E4633.93F2906B-ON882573D7.002448B6-882573D7.00287256@selinc.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, Jan 20, 2008 at 11:21:48PM -0800, Bruce_Leonard@selinc.com wrote:
> Okay, after much digging and experimenting, I'll agree that the memory 
> operand makes sense.  When I first said that I was thinking of direct 
> manipulation of memory, which the PPC doesn't support.  (Don't ask, my 
> brain sometimes goes off into la-la land without me :-> )  Also, update 
> mode is applicable and makes sense.  But I do still have a problem with 
> the index mode, though it could be compiler magic.  Here's why: the index 
> mode of the 'lwz' instruction requires three operands, i.e., 'lwzx 
> rD,rA,rB', and there's only place holders for two operands.  Is the 
> compiler smart enough to add the third operand for the index mode?  If so, 
> what does it put for the third operand?

When the compiler decides to use index mode, the second "operand" is a
string containing "rX, rY", just as when it decides not to, the second
operand is a string containing "offset(rX)".

> Another question is how does the compiler know which mode to pick?

The same way it decides which mode to use for internally generated loads
and stores.  Compiler optimization implementation is beyond the scope of
this list. :-)

> And what is the significance of the trailing number?  Some places in
> the code have %U1%X1 and others have %U2%X2?  I've found documentation
> for the # and ## tokens, but I can't find anything for the %U or %X
> tokens.

The number is an index into the operand list at the end of the asm
statement.

> Now this has all been very interesting to learn but doesn't solve my 
> underlying problem which I've finally drilled down to.  At first I thought 
> in_be32() might be broken because I wasn't getting back the value I knew 
> to be in the internal register.  I knew I had the address and the mapping 
> to kernel space correct because I could use in_le32 and get the right 
> value though it was byte swapped.

Are you absolutely sure that in_le32 to in_be32 is the only thing that
changed?  If you change it back now, does it resume returning a byte-swap
of the correct value?

If that is indeed what is making the difference, then perhaps it's some
subtle timing (or memory corruption) difference caused by different code
generation because the compiler is forced to use index mode for in_le32
(though it appears that the same operand list is given to GCC in either
case -- is GCC smart enough to optimize away preperation of inputs that
aren't actually referenced in the asm statement?).  Is there any
difference in the generated assembly besides the specific load
instruction used?

Alternatively, maybe your chip is just fried. :-)

> I don't want to just arbitrarily point to that %U1%X1 parameter list,

So please don't.

> but I get compiler errors if I try to remove them 

That's why it's there. :-)

> Can't anyone suggest anything I can try?

Beer.

-Scott
