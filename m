Date: Wed, 8 May 2002 10:52:40 -0700
From: andrew may <acmay@acmay.homeip.net>
To: Armin <akuster@pacbell.net>
Cc: ppc_devel <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 4xx change to core files
Message-ID: <20020508105240.A25070@ecam.san.rr.com>
References: <3CD9560E.9000909@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CD9560E.9000909@pacbell.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, May 08, 2002 at 09:45:02AM -0700, Armin wrote:
> struct ocp_def core_ocp[] = {
> 	{UART, UART0_IO_BASE, UART0_INT},
> 	{UART, UART1_IO_BASE, UART1_INT},
> 	{IIC, IIC0_BASE, IIC0_IRQ},
> 	{GPIO, GPIO0_BASE, OCP_IRQ_NA},
> 	{PCI, PCIL0_BASE, OCP_IRQ_NA},
> 	{OPB, OPB0_BASE, OCP_IRQ_NA},
> 	{EMAC, EMAC0_BASE, OCP_IRQ_NA},
> 	{OCP_NULL_TYPE, 0x0, OCP_IRQ_NA},
>
> };

It would be nice if the global struct ocp_def core_ocp was just a pointer.
Then in a ibm405gp.c and friends could have a static of the entire stucture
and set the global pointer to it.

That should be a pretty straight forward change. The only change to code
that use core_ocp would be maybe a NULL check, but even that could be avoided.

The great thing about these chips is that you can stamp down different OCP's
as needed regaurdless of the actual CPU type.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
