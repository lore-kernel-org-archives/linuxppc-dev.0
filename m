Message-Id: <200404132052.i3DKqJx00738@apron.cesa.opbu.xerox.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: machine checks with MPC107 and read_config?
Date: Tue, 13 Apr 2004 13:52:19 -0700
From: Andrew Klossner <andrew@cesa.opbu.xerox.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm bringing up 2.6 on some embedded boards using G3/G4 CPUs and an
MPC107.  We've been running vxWorks on these boards for years and we
know the chips pretty well.

During startup, the first attempt to read the config space from an
unpopulated devfn causes an oops: machine check.

Looking at arch/ppc/syslib/indirect_pci.c, I see the fundamental
read-config operation, but I don't see it bracketed by writes to
MPC107 registers to temporarily disable master-abort error enable.
Specifically, I would expect bit 1 "PCI master-abort error enable" to
be turned off in register 0xc0 "Error enabling register 1", then
restored at the end of the routine, and I would expect to see a test
of bit 13 "received master-abort" in register 0x06 "PCI status
register" to see whether the config-space access succeeded.

Before I sidestep the code in mpc10x_common.c and indirect_pci.c, let
me ask: does everybody else run with master-abort detection turned
off?  Doesn't that hurt your ability to find bad pointers into
I/O space?  Or am I overlooking something here?

Thanks,
Andrew Klossner

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
