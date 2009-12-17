Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Masami Hiramatsu <mhiramat@redhat.com>
Subject: Re: [PATCH -tip tracing/kprobes] PPC: Powerpc port of the
	kprobe-based event tracer
In-reply-to: <4B29C3E3.3060905@redhat.com>
References: <20091216043619.963539987@mars.in.ibm.com>
	<20091216043933.GA9328@in.ibm.com>
	<13884.1261016575@neuling.org> <4B29C3E3.3060905@redhat.com>
Date: Thu, 17 Dec 2009 20:43:03 +1100
Message-ID: <11626.1261042983@neuling.org>
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In message <4B29C3E3.3060905@redhat.com> you wrote:
> Hi Michael,
> 
> Michael Neuling wrote:
> >> +
> >> +static const struct pt_regs_offset regoffset_table[] = {
> >> +	REG_OFFSET_NAME(gpr[0]),
> >> +	REG_OFFSET_NAME(gpr[1]),
> >> +	REG_OFFSET_NAME(gpr[2]),
> >> +	REG_OFFSET_NAME(gpr[3]),
> >> +	REG_OFFSET_NAME(gpr[4]),
> >> +	REG_OFFSET_NAME(gpr[5]),
> >> +	REG_OFFSET_NAME(gpr[6]),
> >> +	REG_OFFSET_NAME(gpr[7]),
> >> +	REG_OFFSET_NAME(gpr[8]),
> >> +	REG_OFFSET_NAME(gpr[9]),
> >> +	REG_OFFSET_NAME(gpr[10]),
> >> +	REG_OFFSET_NAME(gpr[11]),
> >> +	REG_OFFSET_NAME(gpr[12]),
> >> +	REG_OFFSET_NAME(gpr[13]),
> >> +	REG_OFFSET_NAME(gpr[14]),
> >> +	REG_OFFSET_NAME(gpr[15]),
> >> +	REG_OFFSET_NAME(gpr[16]),
> >> +	REG_OFFSET_NAME(gpr[17]),
> >> +	REG_OFFSET_NAME(gpr[18]),
> >> +	REG_OFFSET_NAME(gpr[19]),
> >> +	REG_OFFSET_NAME(gpr[20]),
> >> +	REG_OFFSET_NAME(gpr[21]),
> >> +	REG_OFFSET_NAME(gpr[22]),
> >> +	REG_OFFSET_NAME(gpr[23]),
> >> +	REG_OFFSET_NAME(gpr[24]),
> >> +	REG_OFFSET_NAME(gpr[25]),
> >> +	REG_OFFSET_NAME(gpr[26]),
> >> +	REG_OFFSET_NAME(gpr[27]),
> >> +	REG_OFFSET_NAME(gpr[28]),
> >> +	REG_OFFSET_NAME(gpr[29]),
> >> +	REG_OFFSET_NAME(gpr[30]),
> >> +	REG_OFFSET_NAME(gpr[31]),
> >> +	REG_OFFSET_NAME(nip),
> >> +	REG_OFFSET_NAME(msr),
> >> +	REG_OFFSET_NAME(orig_gpr3),
> >> +	REG_OFFSET_NAME(ctr),
> >> +	REG_OFFSET_NAME(link),
> >> +	REG_OFFSET_NAME(xer),
> >> +	REG_OFFSET_NAME(ccr),
> >> +#ifdef CONFIG_PPC64
> >> +	REG_OFFSET_NAME(softe),
> >> +#else
> >> +	REG_OFFSET_NAME(mq),
> >> +#endif
> >> +	REG_OFFSET_NAME(trap),
> >> +	REG_OFFSET_NAME(dar),
> >> +	REG_OFFSET_NAME(dsisr),
> >> +	REG_OFFSET_NAME(result),
> >> +	REG_OFFSET_END,
> > 
> > Do we need to add something for FP and VMX registers here?
> 
> Hmm, are FP and VMX registers actually used inside kernel on PPC?

Yes.  Look for enable_kernel_fp/altivec

Mikey

> Actually, the main purpose of this code is to provide accessing method
> of in-kernel pt_regs fields (registers used in kernel) by name.
