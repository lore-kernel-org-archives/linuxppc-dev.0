From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: ppcboot compile issues
Date: Sat, 13 Jan 2001 09:29:45 +0100
Message-Id: <19341208020129.22479@smtp.wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi !

I've just ported ppcboot to a custom 860T based board and noticed a few
issues with it while tracing with GDB via BDM.

Basically, it looks like a lot of the IOs to internal registers are
happily re-ordered by GCC. I didn't yet checked all the various
combinations, but I'm not sure using volatile actually helped (and it's
not used everywhere in ppcboot anyway). Also, I noticed eieio is only
rarely used. I beleive 8xx CPUs don't have the same execution ordering
issues than 6x/7xx/7xxx CPUs, do they ?

For now, I'm compiling ppcboot with -O0, and the result is fine. However,
to avoid any potential problem, especially with future cores that may
more agressively re-order execution, shouldn't we wrap all IOs in some
macros like we do in the 6xx/7xx/7xxx kernel ? (The macro beeing a load/
store instruction marked volatile with the appripriate constraints, and
eventually eieio).

The same is probably true for the 8xx kernel.

What do you people think ?

Ben.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
