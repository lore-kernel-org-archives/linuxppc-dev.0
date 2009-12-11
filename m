Return-Path: <galak@kernel.crashing.org>
Subject: Re: [RFC:PATCH 00/03] powerpc: Expose BookE debug registers through
	extended ptrace interface
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20091210155709.6697.4635.sendpatchset@norville.austin.ibm.com>
Date: Thu, 10 Dec 2009 20:24:07 -0600
Message-Id: <D925FFC0-EF2B-4ED4-8481-38BC743E9770@kernel.crashing.org>
References: <20091210155709.6697.4635.sendpatchset@norville.austin.ibm.com>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>,
	Sergio Durigan Junior <sergiodj@br.ibm.com>,
	Torez Smith <torez@us.ibm.com>,
	Thiago Jung Bauermann <bauerman@br.ibm.com>, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 10, 2009, at 9:57 AM, Dave Kleikamp wrote:

> These patches implement an extention to the ptrace interface proposed =
by
> Thiago Bauermann and the the PowerPC gdb team.
>=20
> GDB intends to support the following hardware debug features of BookE
> processors:
>=20
> 4 hardware breakpoints (IAC)
> 2 hardware watchpoints (read, write and read-write) (DAC)
> 2 value conditions for the hardware watchpoints (DVC)
>=20
> For that, we need to extend ptrace so that GDB can query and set these
> resources. Since we're extending, we're trying to create an interface
> that's extendable and that covers both BookE and server processors, so
> that GDB doesn't need to special-case each of them. We propose the
> following 3 new ptrace requests described below.
>=20
> There have been discussions of a generic hardware debug interface for =
the
> kernel which would hopefully contemplate all the functionality below =
and
> supersede it.  But we need something that works now, and which enables =
GDB
> to be simpler and work with both Server and Embedded processors =
without
> special cases.
>=20
> 1. PTRACE_PPC_GETHWDEBUGINFO
>=20
> Query for GDB to discover the hardware debug features. The main info =
to
> be returned here is the minimum alignment for the hardware =
watchpoints.
> BookE processors don't have restrictions here, but server processors =
have
> an 8-byte alignment restriction for hardware watchpoints. We'd like to =
avoid
> adding special cases to GDB based on what it sees in AUXV.
>=20
> Since we're at it, we added other useful info that the kernel can =
return to
> GDB: this query will return the number of hardware breakpoints, =
hardware
> watchpoints and whether it supports a range of addresses and a =
condition.
> The query will fill the following structure provided by the requesting =
process:
>=20
> struct ppc_debug_info {
>       unit32_t version;
>       unit32_t num_instruction_bps;
>       unit32_t num_data_bps;
>       unit32_t num_condition_regs;
>       unit32_t data_bp_alignment;
>       unit32_t sizeof_condition; /* size of the DVC register */
>       uint64_t features; /* bitmask of the individual flags */
> };
>=20
> features will have bits indicating whether there is support for:
>=20
> #define PPC_DEBUG_FEATURE_INSN_BP_RANGE		0x1
> #define PPC_DEBUG_FEATURE_INSN_BP_MASK		0x2
> #define PPC_DEBUG_FEATURE_DATA_BP_RANGE		0x4
> #define PPC_DEBUG_FEATURE_DATA_BP_MASK		0x8
>=20
> 2. PTRACE_SETHWDEBUG
>=20
> Sets a hardware breakpoint or watchpoint, according to the provided =
structure:
>=20
> struct ppc_hw_breakpoint {
>        uint32_t version;
> #define PPC_BREAKPOINT_TRIGGER_EXECUTE  0x1
> #define PPC_BREAKPOINT_TRIGGER_READ     0x2
> #define PPC_BREAKPOINT_TRIGGER_WRITE    0x4
>        uint32_t trigger_type;       /* only some combinations allowed =
*/
> #define PPC_BREAKPOINT_MODE_EXACT               0x0
> #define PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE     0x1
> #define PPC_BREAKPOINT_MODE_RANGE_EXCLUSIVE     0x2
> #define PPC_BREAKPOINT_MODE_MASK                0x3
>        uint32_t addr_mode;          /* address match mode */
>=20
> #define PPC_BREAKPOINT_CONDITION_NONE   0x0
> #define PPC_BREAKPOINT_CONDITION_AND    0x1
> #define PPC_BREAKPOINT_CONDITION_EXACT  0x1	/* different name for =
the same thing as above */
> #define PPC_BREAKPOINT_CONDITION_OR     0x2
> #define PPC_BREAKPOINT_CONDITION_AND_OR 0x3
> #define PPC_BREAKPOINT_CONDITION_BE_ALL 0x00ff0000	/* byte enable =
bits */
> #define PPC_BREAKPOINT_CONDITION_BE(n)  (1<<((n)+16))
>        uint32_t condition_mode;     /* break/watchpoint condition =
flags */
>=20
>        uint64_t addr;
>        uint64_t addr2;
>        uint64_t condition_value;
> };
>=20
> A request specifies one event, not necessarily just one register to be =
set.
> For instance, if the request is for a watchpoint with a condition, =
both the
> DAC and DVC registers will be set in the same request.
>=20
> With this GDB can ask for all kinds of hardware breakpoints and =
watchpoints
> that the BookE supports. COMEFROM breakpoints available in server =
processors
> are not contemplated, but that is out of the scope of this work.
>=20
> ptrace will return an integer (handle) uniquely identifying the =
breakpoint or
> watchpoint just created. This integer will be used in the =
PTRACE_DELHWDEBUG
> request to ask for its removal. Return -ENOSPC if the requested =
breakpoint
> can't be allocated on the registers.
>=20
> Some examples of using the structure to:
>=20
> - set a breakpoint in the first breakpoint register
>=20
>  p.version         =3D PPC_DEBUG_CURRENT_VERSION;
>  p.trigger_type    =3D PPC_BREAKPOINT_TRIGGER_EXECUTE;
>  p.addr_mode       =3D PPC_BREAKPOINT_MODE_EXACT;
>  p.condition_mode  =3D PPC_BREAKPOINT_CONDITION_NONE;
>  p.addr            =3D (uint64_t) address;
>  p.addr2           =3D 0;
>  p.condition_value =3D 0;
>=20
> - set a watchpoint which triggers on reads in the second watchpoint =
register
>=20
>  p.version         =3D PPC_DEBUG_CURRENT_VERSION;
>  p.trigger_type    =3D PPC_BREAKPOINT_TRIGGER_READ;
>  p.addr_mode       =3D PPC_BREAKPOINT_MODE_EXACT;
>  p.condition_mode  =3D PPC_BREAKPOINT_CONDITION_NONE;
>  p.addr            =3D (uint64_t) address;
>  p.addr2           =3D 0;
>  p.condition_value =3D 0;
>=20
> - set a watchpoint which triggers only with a specific value
>=20
>  p.version         =3D PPC_DEBUG_CURRENT_VERSION;
>  p.trigger_type    =3D PPC_BREAKPOINT_TRIGGER_READ;
>  p.addr_mode       =3D PPC_BREAKPOINT_MODE_EXACT;
>  p.condition_mode  =3D PPC_BREAKPOINT_CONDITION_AND | =
PPC_BREAKPOINT_CONDITION_BE_ALL;
>  p.addr            =3D (uint64_t) address;
>  p.addr2           =3D 0;
>  p.condition_value =3D (uint64_t) condition;
>=20
> - set a ranged hardware breakpoint
>=20
>  p.version         =3D PPC_DEBUG_CURRENT_VERSION;
>  p.trigger_type    =3D PPC_BREAKPOINT_TRIGGER_EXECUTE;
>  p.addr_mode       =3D PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE;
>  p.condition_mode  =3D PPC_BREAKPOINT_CONDITION_NONE;
>  p.addr            =3D (uint64_t) begin_range;
>  p.addr2           =3D (uint64_t) end_range;
>  p.condition_value =3D 0;
>=20
> 3. PTRACE_DELHWDEBUG
>=20
> Takes an integer which identifies an existing breakpoint or watchpoint
> (i.e., the value returned from PTRACE_SETHWDEBUG), and deletes the
> corresponding breakpoint or watchpoint..

This is a good write up.  We should have it as a commit message for the =
first patch.

- k
