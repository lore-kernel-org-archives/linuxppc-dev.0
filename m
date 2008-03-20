Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18401.58282.992971.923754@cargo.ozlabs.ibm.com>
Date: Thu, 20 Mar 2008 15:10:18 +1100
From: Paul Mackerras <paulus@samba.org>
To: Roland McGrath <roland@redhat.com>
Subject: Re: unprivileged use of MSR_SE
In-Reply-To: <20080320002407.D911C26F995@magilla.localdomain>
References: <20080320002407.D911C26F995@magilla.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Roland McGrath writes:

> Are there any powerpc instructions that can read or change the MSR
> explicitly from user mode?  Any that can see or affect the MSR_SE bit?

No and no.

> e.g. x86 has pushf/popf unprivileged instructions, with which a user
> program can both see the single-step flag set, and enable single-step for
> its own next instruction (presumably when it has a handler for SIGTRAP).
> This actually gets used in arcane places.

On ppc32 there is a sys_debug_setcontext system call that is there to
allow a process to debug itself.  It does a setcontext and optionally
sets the MSR_SE or MSR_BE bit.  We don't have it on ppc64 for some
reason (we should add it).

> I recall being told before there's no unprivileged way to see or touch
> MSR_SE.  But it looks to me like a user program can set the bit in a
> sigcontext and sigreturn to set it.  Is that intentionally supported?

The only MSR bit that sigreturn copies from the signal frame back into
the MSR is the MSR_LE (little-endian) bit.  I just checked the various
forms (rt/non-rt, 32/64 bit) and they all do that as far as I can
see.  If you see a path where we restore more than that let me know.
We do also use the MSR_VEC and MSR_SPE bits in the MSR image in the
signal frame to indicate whether the frame contains altivec or SPE
bits, but those bits don't get put back into the MSR on signal return.

> Or could sigreturn ignore the MSR_SE bit without breaking any strange user?

It already does AFAICS.

> On x86 do we some machinations so that PTRACE_GETREGS et al show the
> single-step bit set if user-mode itself had set it, but not if
> PTRACE_SINGLESTEP set it.  If you use PTRACE_SETREGS et al to set the
> single-step bit, then it stays set even if you use PTRACE_CONT.
> 
> I'd like to clean this up for powerpc too.  If there is no way at all for
> user-mode to set MSR_SE, then it doesn't much matter whether it shows up
> when ptrace reads it--ptrace just needs to ignore attempts to set it.  So
> if there's no reason not to, what I would do is remove MSR_SE from the
> MSR_DEBUGCHANGE mask and make sigreturn always clear MSR_SE.

MSR_DEBUGCHANGE is already gone.  I don't mind making sigreturn clear
MSR_SE (should setcontext do so too?), but please give me a nice
detailed explanation why we should do that, and why we don't want to
do what we do at present, which is that sigreturn doesn't affect the
process's MSR at all (well, just the LE bit).

Paul.
