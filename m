Message-ID: <3906190E.5E7C6215@embeddededge.com>
Date: Tue, 25 Apr 2000 18:15:42 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: "Brown, David (dbrown03)" <DBrown03@harris.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: kgdb and GetDebugChar/PutDebugChar
References: <BE1C564723B3D21191FD0000F840E39801D814D4@rfcmx2.rfc.comm.harris.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Brown, David (dbrown03)" wrote:

> When KGDB is enabled, no GetDebugChar/PutDebugChar functions exist.

If KGDB works in the rest of the kernel, the functions are there.


> Surely, someone here has done that for the ppc8xx, using maybe SMC2?

It exists in the MontaVista 2.2.13 kernel, and in the 2.3.99 kernel.
The latter is better because it starts very early in the boot, and
you can debug almost anything in the kernel (except stepping over
instructions that disable the interrupts).  I will back port the
2.3.xx into the 2.2.14 kernel shortly, or you can do it and send
me the patches.

It uses SMC1 because it is convenient, and it allows debugging
data comm or other features that use SMC2.  When you boot a kernel
that uses KGDB, you provide the initial console input to the Linux
prompt, then disconnect your terminal emulator from the serial port,
and start up GDB on the serial port.

You can also use XMON, which is sometimes more useful that gdb.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
