MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16381.60160.345637.268859@cargo.ozlabs.ibm.com>
Date: Fri, 9 Jan 2004 10:42:56 +1100
From: Paul Mackerras <paulus@samba.org>
To: Ronald Wahl <rwa@peppercon.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: twi/isync/nop sequence in newer ppc linux kernels
In-Reply-To: <m37k02o0n6.fsf@gandalf.peppercon.de>
References: <m37k02o0n6.fsf@gandalf.peppercon.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ronald Wahl writes:

> I'm programming an embedded device (with PPC405GP/EP) that has to access the
> pci bus and there may be cases that there is no one listening there and a
> timeout occurs which results in a machine check. Until now I used a eieio
> operation with an exception handler after the actual io operation and this
> seems to work. Current kernels contain a twi/isync/nop sequence. What are
> the reasons for this sequence instead of an eieio? Is it only needed on
> some processors? Is there a document that describes this special
> sequence in more detail?

The sequence was determined experimentally.  The 601 was the worst in
terms of containing where the machine check would happen after a bad
access.  The idea is that the twi is intended to create a dependency
on the value read, such that the processor doesn't know if the
instruction will generate an exception until the data comes back (in
fact the particular form of the twi instruction that I use won't ever
generate an exception, but fortunately the 601 isn't smart enough to
recognize that).  The isync is then meant to stop the cpu until all
previous instructions have been executed to the point where the cpu
knows whether they will generate an exception or not.  The nop is
there because the machine check can still occur on the instruction
after the isync on 601 (IIRC).

As I recall, the 604 was better but still needed more than just an
eieio or sync, and the G3 and G4 just needed an eieio or sync.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
