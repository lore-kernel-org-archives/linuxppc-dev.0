From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15722.56799.290632.720143@argo.ozlabs.ibm.com>
Date: Tue, 27 Aug 2002 12:03:11 +1000 (EST)
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: pcspkr.c
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Vojtech,

I like the way that the code for doing the beeps via the PC speaker
has been pulled out into its own little module.

We have a situation on PPC where we would want the PC speaker input
device to be compiled in to the kernel but only registered and
initialized on some machines but not on others.  We can run the same
kernel binary on powermac, CHRP and PReP machines.  The CHRP and PReP
machines have a PC-style southbridge, including the ISA timer/counter
that pcspkr.c uses.  On powermacs there is no ISA bus, and to make a
beep it is necessary to push a suitable waveform out through the
audio.

So what we want is some way to decide at runtime whether to register
the pc-speaker input device or not.

Suggestions?

Thanks,
Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
