Return-Path: <shaggy@linux.vnet.ibm.com>
Subject: Re: [RFC:PATCH 00/03] powerpc: Expose BookE debug registers
	through extended ptrace interface
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <F0B42818-1EE1-47EE-B2F3-B7529B2E13C8@kernel.crashing.org>
References: <20091210155709.6697.4635.sendpatchset@norville.austin.ibm.com>
	<F0B42818-1EE1-47EE-B2F3-B7529B2E13C8@kernel.crashing.org>
Content-Type: text/plain
Date: Mon, 18 Jan 2010 16:34:32 -0600
Message-Id: <1263854072.27291.47.camel@norville.austin.ibm.com>
Mime-Version: 1.0
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

On Thu, 2009-12-10 at 20:23 -0600, Kumar Gala wrote:
> On Dec 10, 2009, at 9:57 AM, Dave Kleikamp wrote:
> 
> > These patches implement an extention to the ptrace interface proposed by
> > Thiago Bauermann and the the PowerPC gdb team.
> > 
> > GDB intends to support the following hardware debug features of BookE
> > processors:
> > 
> > 4 hardware breakpoints (IAC)
> > 2 hardware watchpoints (read, write and read-write) (DAC)
> > 2 value conditions for the hardware watchpoints (DVC)
> > 
> > For that, we need to extend ptrace so that GDB can query and set these
> > resources. Since we're extending, we're trying to create an interface
> > that's extendable and that covers both BookE and server processors, so
> > that GDB doesn't need to special-case each of them. We propose the
> > following 3 new ptrace requests described below.
> > 
> > There have been discussions of a generic hardware debug interface for the
> > kernel which would hopefully contemplate all the functionality below and
> > supersede it.  But we need something that works now, and which enables GDB
> > to be simpler and work with both Server and Embedded processors without
> > special cases.
> > 
> > 1. PTRACE_PPC_GETHWDEBUGINFO
> > 
> > Query for GDB to discover the hardware debug features. The main info to
> > be returned here is the minimum alignment for the hardware watchpoints.
> > BookE processors don't have restrictions here, but server processors have
> > an 8-byte alignment restriction for hardware watchpoints. We'd like to avoid
> > adding special cases to GDB based on what it sees in AUXV.
> > 
> > Since we're at it, we added other useful info that the kernel can return to
> > GDB: this query will return the number of hardware breakpoints, hardware
> > watchpoints and whether it supports a range of addresses and a condition.
> > The query will fill the following structure provided by the requesting process:
> > 
> > struct ppc_debug_info {
> >       unit32_t version;
> >       unit32_t num_instruction_bps;
> >       unit32_t num_data_bps;
> >       unit32_t num_condition_regs;
> >       unit32_t data_bp_alignment;
> >       unit32_t sizeof_condition; /* size of the DVC register */
> >       uint64_t features; /* bitmask of the individual flags */
> > };
> > 
> > features will have bits indicating whether there is support for:
> > 
> > #define PPC_DEBUG_FEATURE_INSN_BP_RANGE		0x1
> > #define PPC_DEBUG_FEATURE_INSN_BP_MASK		0x2
> > #define PPC_DEBUG_FEATURE_DATA_BP_RANGE		0x4
> > #define PPC_DEBUG_FEATURE_DATA_BP_MASK		0x8
> 
> Is GDB smart enough to deal w/no condition_regs?  On some Book-E
> devices we have 2 IACs, 2 DACs, and 0 DVCs.  Does it need to be in the
> features?

I wasn't aware that the bookE devices had varying numbers of these
registers.  I guess I will have to make it a runtime option.

Shaggy
-- 
David Kleikamp
IBM Linux Technology Center
