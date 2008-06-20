Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 0/9] powerpc: Add kernel support for POWER7 VSX. 
In-reply-to: <B353EBCF-A080-41C7-B331-61D29C6F5C02@kernel.crashing.org> 
References: <1213935232.194904.168421502953.qpush@coopers>
	<B353EBCF-A080-41C7-B331-61D29C6F5C02@kernel.crashing.org>
Date: Fri, 20 Jun 2008 18:15:54 +1000
Message-ID: <11045.1213949754@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



In message <B353EBCF-A080-41C7-B331-61D29C6F5C02@kernel.crashing.org> you wrote
:
> 
> On Jun 19, 2008, at 11:13 PM, Michael Neuling wrote:
> 
> > The following set of patches adds Vector Scalar Extentions (VSX)
> > support for POWER7.  Includes context switch, ptrace and signals  
> > support.
> >
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
> > ---
> > Paulus: please consider for your 2.6.27 tree.
> >
> > Updated with comments from Kumar, Milton, Dave Woodhouse and Mark
> > 'NKOTB' Nelson.
> > - Changed thread_struct array definition to be cleaner
> > - Updated CPU_FTRS_POSSIBLE
> > - Updated Kconfig typo and dupilicate
> > - Added comment to clarify ibm,vmx = 2 really means VSX.
> 
> One question I was wondering about is the "user space" view of VSX.   
> Is the intent to have it seem like there is a unique register set for  
> VSX separate from FP or AltiVec?

For userspace it's not a unique register set.  So if you execute FP code
in the middle of your VSX code, you change VSX registers 0-31.

Userspace will see the same as if it was running natively on the CPU.  

> (This gets into what the ABI changes look like).

Signals and ptrace interfaces have been kept backwards compatible.

Mikey
