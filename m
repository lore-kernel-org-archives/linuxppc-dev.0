Return-Path: <dwg@au1.ibm.com>
Date: Fri, 11 Dec 2009 11:44:34 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Subject: Re: [RFC:PATCH 01/03] powerpc: Extended ptrace interface
Message-ID: <20091211004434.GA8852@yookeroo>
References: <20091210155709.6697.4635.sendpatchset@norville.austin.ibm.com>
	<20091210155715.6697.92627.sendpatchset@norville.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091210155715.6697.92627.sendpatchset@norville.austin.ibm.com>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>,
	Sergio Durigan Junior <sergiodj@br.ibm.com>,
	Torez Smith <torez@us.ibm.com>, Thiago Jung Bauermann <bauerman@br.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 10, 2009 at 01:57:15PM -0200, Dave Kleikamp wrote:
> powerpc: Extended ptrace interface
> 
> From: Torez Smith <lnxtorez@linux.vnet.ibm.com>
> 
> Add a new extended ptrace interface so that user-space has a single
> interface for powerpc, without having to know the specific layout
> of the debug registers.


> Implement:
> PPC_PTRACE_GETHWDEBUGINFO
> PPC_PTRACE_SETHWDEBUG
> PPC_PTRACE_DELHWDEBUG
> 
> Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
> Signed-off-by: Torez Smith  <lnxtorez@linux.vnet.ibm.com>

Apart from the data breakpoint alignment for 32-bit systems, all the
comments below are trivial nits, so:

Acked-by: David Gibson <dwg@au1.ibm.com>

[snip]
> +/*
> + * Trigger Type
> + */
> +#define PPC_BREAKPOINT_TRIGGER_EXECUTE	0x1
> +#define PPC_BREAKPOINT_TRIGGER_READ	0x2
> +#define PPC_BREAKPOINT_TRIGGER_WRITE	0x4
> +#define PPC_BREAKPOINT_TRIGGER_RW	0x6

For a little extra safety, I'd tend towards defining the RW constant
in terms of the READ and WRITE constants.

> +
> +/*
> + * Address Mode
> + */
> +#define PPC_BREAKPOINT_MODE_EXACT		0x0
> +#define PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE	0x1
> +#define PPC_BREAKPOINT_MODE_RANGE_EXCLUSIVE	0x2
> +#define PPC_BREAKPOINT_MODE_MASK		0x3
> +
> +/*
> + * Condition Mode
> + */
> +#define PPC_BREAKPOINT_CONDITION_NONE	0x0
> +#define PPC_BREAKPOINT_CONDITION_AND	0x1
> +#define PPC_BREAKPOINT_CONDITION_EXACT	0x1

And likewuse define EXACT in terms of AND.

> +#define PPC_BREAKPOINT_CONDITION_OR	0x2
> +#define PPC_BREAKPOINT_CONDITION_AND_OR	0x3
> +#define PPC_BREAKPOINT_CONDITION_BE_ALL	0x00ff0000
> +#define PPC_BREAKPOINT_CONDITION_BE_SHIFT	16
> +#define PPC_BREAKPOINT_CONDITION_BE(n)	\
> +	(1<<((n)+PPC_BREAKPOINT_CONDITION_BE_SHIFT))

[snip]
> +	case PPC_PTRACE_GETHWDBGINFO: {
> +		struct ppc_debug_info dbginfo;
> +
> +		dbginfo.version = 1;
> +		dbginfo.num_instruction_bps = 0;
> +		dbginfo.num_data_bps = 1;
> +		dbginfo.num_condition_regs = 0;
> +#ifdef CONFIG_PPC64
> +		dbginfo.data_bp_alignment = 8;
> +#else
> +		dbginfo.data_bp_alignment = 0;

Uh.. this looks wrong.  Surely it should be 4.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
