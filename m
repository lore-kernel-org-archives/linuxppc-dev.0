MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16148.33584.75625.416464@nanango.paulus.ozlabs.org>
Date: Wed, 16 Jul 2003 08:41:52 +1000 (EST)
From: Paul Mackerras <paulus@samba.org>
To: Steve Boorman <steveb@baydel.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Hangup booting Linux on PPC440GP
In-Reply-To: <3F13FA14.16183.5C9485B@localhost>
References: <3F13FA14.16183.5C9485B@localhost>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steve Boorman writes:

> 2) I would not have thought my simple printf of some text
> would use floating point code.

Since printf can print floating point values, it (or one of its
subroutines) would be likely to have some floating point instructions
in it.  Now, even if those instructions don't get executed with the
particular arguments you use, just the fact that they are present will
very likely cause gcc to put instructions to save some FP regs onto
the stack at the beginning of the function.  It's those FP store
instructions which you would be hitting.

> 3) I expected the kernel to panic with some form of illegal
> instruction trap if floating point instructions were being
> attempted with no emulator code present.

There is a check in the kernel which only allows any given signal to
be delivered to the init process if it has established a handler for
that signal.  That even applies to SIGILL (illegal instruction) and
SIGSEGV (segmentation violation).  So, if init hits an illegal
instruction, it takes an exception, the kernel generates a SIGILL
which then gets dropped, and then we return to the init process at the
same instruction and the cycle repeats.

Yes we should do something more sensible.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
