Message-ID: <407C7D27.9000601@mvista.com>
Date: Tue, 13 Apr 2004 16:52:07 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Andrew Klossner <andrew@cesa.opbu.xerox.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: machine checks with MPC107 and read_config?
References: <200404132052.i3DKqJx00738@apron.cesa.opbu.xerox.com>
In-Reply-To: <200404132052.i3DKqJx00738@apron.cesa.opbu.xerox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Andrew Klossner wrote:

>I'm bringing up 2.6 on some embedded boards using G3/G4 CPUs and an
>MPC107.  We've been running vxWorks on these boards for years and we
>know the chips pretty well.
>
>During startup, the first attempt to read the config space from an
>unpopulated devfn causes an oops: machine check.
>
Do you have the bridge's regs mapped into virtual memory?  Use an
existing platform that uses the mpc107 like the sandpoint as an
example.  Pay special attention to the use of the 'set_bat' and
'io_block_mapping' routines.

>Looking at arch/ppc/syslib/indirect_pci.c, I see the fundamental
>read-config operation, but I don't see it bracketed by writes to
>MPC107 registers to temporarily disable master-abort error enable.
>Specifically, I would expect bit 1 "PCI master-abort error enable" to
>be turned off in register 0xc0 "Error enabling register 1", then
>restored at the end of the routine, and I would expect to see a test
>of bit 13 "received master-abort" in register 0x06 "PCI status
>register" to see whether the config-space access succeeded.
>
You are correct.  The mpc10x_common.c code is basic and more concerned
with getting the bridge to use the proper address map than anything
else.  The level of detection and, presumably, handling just isn't
there.  If you need it, I'm afraid you're going to have to implement it.

>Before I sidestep the code in mpc10x_common.c and indirect_pci.c, let
>me ask: does everybody else run with master-abort detection turned
>off?
>
Maybe the MAC guys worry about it but AFAIK, most other platforms don't.

>  Doesn't that hurt your ability to find bad pointers into
>I/O space?
>
Maybe but you're probably going to notice other symptoms of bad I/O
space pointers anyway, so is it worth it?

> Or am I overlooking something here?

Maybe I am?


Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
