Message-ID: <3A8DC5A9.C52D3028@opersys.com>
From: Karim Yaghmour <karym@opersys.com>
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ltrace for ppc
References: <20010217000718.759BDDBA1B@atlas.valhalla.net>
Content-Type: text/plain; charset=us-ascii
Date: Fri, 16 Feb 2001 19:22:39 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


LTT doesn't need DProbes although it can interact with it.
The custom-event facility is proper to LTT, DProbes uses
it to log its events, but the information gathered by
LTT isn't gathered by means of DProbes. LTT can get the
information it has because the kernel is patched accordingly
to call on LTT upon the occurrence of crucial events.

Here's an excerpt from the exception handler on the PPC:
void
_exception(int signr, struct pt_regs *regs)
{
	if (!user_mode(regs))
	{
		show_regs(regs);
#if defined(CONFIG_XMON) || defined(CONFIG_KGDB)
		debugger(regs);
#endif
		print_backtrace((unsigned long *)regs->gpr[1]);
		panic("Exception in kernel pc %lx signal %d",regs->nip,signr);
	}
	TRACE_TRAP_ENTRY(regs->trap, instruction_pointer(regs));
	force_sig(signr, current);
	TRACE_EVENT(TRACE_EV_TRAP_EXIT, NULL);
}

Notice the TRACE_TRAP_ENTRY statement. It is in fact a macro.
If you compile the kernel with trace support, then this will
result in a call to trace_event() which is a kernel-global entry
point for all events. Even then, the event may be ignored. This
will depend on whether a trace driver (provided with LTT) is
loaded or not. If it is loaded and registered with the
kernel trace facility, then events will be forwarded onto it.
Still, the events may be ignored by the trace driver if the
trace daemon hasn't opened the device and is waiting for a
signal from it. All this is to minimize intrusion on the kernel's
operation. If the kernel is compiled without trace support
then the macro results in no code at all.

Hence, you are correct, DProbes is for "i386 only" (although you
may be interested to know that I've spoken with the project
manager and they don't intend to keep this a ix86-specific thing.)
DProbes is interesting if you want to add tracepoints _dynamically_,
this LTT can't do. For LTT to operate, the tracepoints have to
be applied to the kernel's sources. (No need to say that I'd like
LTT to be part of the standard kernel sources as it isn't a
kernel debugger and is non-intrusive as to the normal behavior of
the kernel).

Note that PPC support is available in the 0.9.4preX series of LTT,
not in 0.9.3.

Best regards,

Karim

Iain Sandoe wrote:
>
> > It runs fine on my PowerBook. Give a try and let me know what you think.
>
> I'm missing something here... ibm's DProbe page says "i386 only" and their
> patch doesn't appear to have any ppc code...
>
> Iain.

--
===================================================
                 Karim Yaghmour
               karym@opersys.com
          Operating System Consultant
 (Linux kernel, real-time and distributed systems)
===================================================

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
