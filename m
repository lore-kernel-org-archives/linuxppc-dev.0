Message-ID: <3B7AB861.FF1E13DD@mvista.com>
Date: Wed, 15 Aug 2001 10:58:57 -0700
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: "Wright, David" <dwright@infiniswitch.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Anyone using an IBM RISCWatch ICE?
References: <FF6CF34C346E724596A2FB5CAAB2C49750C3C1@voyager.ops.infiniswitch.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Wright, David" wrote:
>
> Hi,
>
> I've been attempting to use an IBM RISCWatch ICE on a Walnut system
> and I'm having problems.  (Spare me any lectures about how I should
> be using a BDI.  I'm just trying to find out how usable the IBM is,
> since it's already here.)
>
> The specific problem I'm trying to solve is this:  how do I set a
> breakpoint early in kernel startup, say at start_kernel (just as
> the MMU is enabled)?  I've tried booting the Walnut so that it
> comes up into its ROM monitor, then stopping it with the ICE, and
> setting a hardware breakpoint at the start_kernel virtual address.

The disk in the PC that hosts my RISCWatch crashed yesterday so I'm
doing this from memory.

I've done that sort of thing quite often.  OpenBios is sitting
at the menu prompt,

  RW> stop
  RW> bp set ihw 0xc015a644
  RW> run

(0xc015a644 is start_kernel)

Then tell OpenBios to boot the kernel.

> Problem is, when I start the CPU running again, the Walnut is no
> longer responding to the keyboard (serial line).  Can't do anything
> except reset it at that point.  Using the ICE reveals that the CPU
> is still running, but I have no real idea what it's doing.  It sure
> isn't responding to the serial port.

If you stop it with RISCWatch, what is the program counter?


>
> As an alternative, I tried setting a hardware breakpoint at the
> physical address of "start_here".  That doesn't hang, but the
> breakpoint is never hit, either.
>
> Any ideas gratefully accepted.  I've tried this kind of thing with
> a BDI and had no problems.
>
>   -- David Wright, InfiniSwitch Corp.
>

--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
