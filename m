Message-ID: <3E81FA3A.9010306@embeddededge.com>
Date: Wed, 26 Mar 2003 14:06:34 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Till Straumann <strauman@slac.stanford.edu>
Cc: joakim.tjernlund@lumentis.se,
	Tom Rini <trini@kernel.crashing.org>,
	"Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: dcbz works on 862 everywhere!
References: <IGEFJKJNHJDCBKALBJLLGEHAFLAA.joakim.tjernlund@lumentis.se> <3E810DA7.1060605@slac.stanford.edu> <3E81C4B3.2080006@embeddededge.com> <3E81ED56.7050105@slac.stanford.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Till Straumann wrote:

> - TLB Miss, copy EPN to DAR (DAR is semi-correct, i.e. to
>    a page boundary).
> - RFI, dcbz is restarted

The EPN has never been copied to DAR.  Some bits of DAR are copied
to EPN so we can use the hardware assist in the TLB Error exception.

>
> --- here, task switching could occur ---

No, it can't because the TLB Miss rfi is likely to immediately result in
a TLB Error.  The TLB Miss doesn't return through a path that causes
a context switch.

> Under the premise that TLB Miss always sets EPN correctly
> and TLB Error always sets DAR correctly, this should work
> even if a task switch (or IRQ) sneaks in.

The current implementation relies on TLB Miss always setting EPN
(and other hardware assist registers) correctly, and TLB Error
relies on DAR being set correctly.  Everything works fine until
you get a TLB Error on a dcbz/dcbt that doesn't properly update DAR.
In this case EPN isn't set correctly either.

> Again: I thought you said that TLB Error _does_ set DAR?

It does, except in the case of some cache instruction exceptions.

> ... But you gain the huge advantage that you don't
> have to carefully screen any software you intend to port for cache
> instructions.

The instructions that don't work properly are dcbz/dcbt.  We have
corrected this in the kernel and all GNU libraries long ago.  There
are other reasons to need a unique 8xx (and 4xx) set of libraries
other than the use of these cache instructions.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
