Date: Sat, 7 Sep 2002 13:45:50 -0500
Subject: Re: ELDK Compiler
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v543)
Cc: Aman <aman@mistralsoftware.com>,
	linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
To: Matt Porter <porter@cox.net>
From: Kumar Gala <kumar.gala@motorola.com>
In-Reply-To: <20020906103908.A30038@home.com>
Message-Id: <0780DA16-C292-11D6-9618-003065BFB10E@motorola.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Nobody has provided PPC440-specific support for binutils.  Right now,
> everybody is using mcpu=[403|405] since they define an identical
> set of instructions. The -mbooke support in current binutils will
> not work on 440 since it is e500 specific.
>

This is not exactly true, the -mbooke option does NOT produce an e500
specific set of instructions that the assembler knows about but as
close to a generic booke set.  Unfortunately, Book-E leaves remove for
a few instructions to have implementation specific operands (for
example tlbwe/tlbre).  The e500 & 440 differ in the number of operands
these instructions require (e500 - 0, 440 - 3).  The currently binutils
treats these instructions as having no operands.

I am not aware of any other cases in which the current binutils would
not work for 440 code (possibly use of simplified mtspr/mfspr
instructions would not work with the -mbooke flag).

- kumar


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
