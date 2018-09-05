Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 424vBK5PSTzF31s
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 16:36:57 +1000 (AEST)
Date: Wed, 5 Sep 2018 16:36:33 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Sandipan Das <sandipan@linux.ibm.com>, mpe@ellerman.id.au,
 naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 anton@samba.org, ravi.bangoria@linux.ibm.com
Subject: Re: [PATCH 3/6] powerpc sstep: Add cnttzw, cnttzd instruction
 emulation
Message-ID: <20180905063633.GA10965@fergus>
References: <cover.1535609090.git.sandipan@linux.ibm.com>
 <f989c31bcf4bd8a80a50fa6899bcd239ed1bec69.1535609090.git.sandipan@linux.ibm.com>
 <20180904211207.GO24439@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180904211207.GO24439@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 04, 2018 at 04:12:07PM -0500, Segher Boessenkool wrote:
> On Mon, Sep 03, 2018 at 08:49:35PM +0530, Sandipan Das wrote:
> > +		case 538:	/* cnttzw */
> > +			if (!cpu_has_feature(CPU_FTR_ARCH_300))
> > +				return -1;
> > +			val = (unsigned int) regs->gpr[rd];
> > +			op->val = ( val ? __builtin_ctz(val) : 32 );
> > +			goto logical_done;
> > +#ifdef __powerpc64__
> > +		case 570:	/* cnttzd */
> > +			if (!cpu_has_feature(CPU_FTR_ARCH_300))
> > +				return -1;
> > +			val = regs->gpr[rd];
> > +			op->val = ( val ? __builtin_ctzl(val) : 64 );
> > +			goto logical_done;
> 
> __builtin_ctz(val) is undefined for val == 0.

Which would be why he only calls it when val != 0, presumably, and
uses 64 when val == 0.  Apart from idiosyncratic whitespace his code
looks correct to me.

Are you saying there is a bug in his code, or that his patch
description is incomplete, or what?

Paul.
