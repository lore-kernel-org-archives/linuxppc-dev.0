Return-Path: <paulus@ozlabs.org>
Date: Wed, 11 Sep 2013 09:52:28 +1000
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 1/6] powerpc: Put FP/VSX and VR state into structures
Message-ID: <20130910235228.GC4455@iris.ozlabs.ibm.com>
References: <20130910102000.GA28145@iris.ozlabs.ibm.com>
 <20130910102041.GB28145@iris.ozlabs.ibm.com>
 <992F9967-6DA8-4BDF-A6BC-A8F9E8F4FF7D@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <992F9967-6DA8-4BDF-A6BC-A8F9E8F4FF7D@suse.de>
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 10, 2013 at 12:07:46PM -0500, Alexander Graf wrote:
> 
> On 10.09.2013, at 05:20, Paul Mackerras wrote:
> > @@ -897,7 +897,7 @@ int fix_alignment(struct pt_regs *regs)
> > 				return -EFAULT;
> > 		}
> > 	} else if (flags & F) {
> > -		data.dd = current->thread.TS_FPR(reg);
> > +		data.ll = current->thread.TS_FPR(reg);
> 
> I don't understand this change. Could you please explain?

It's simply that the type which we use to store the FPR values is now
an unsigned integer type rather than a floating-point type.  If I
didn't make this change, the compiler would try to convert that
unsigned integer value into a floating-point value, which we don't
want.

> > --- a/arch/powerpc/kernel/tm.S
> > +++ b/arch/powerpc/kernel/tm.S
> > @@ -12,16 +12,15 @@
> > #include <asm/reg.h>
> > 
> > #ifdef CONFIG_VSX
> > -/* See fpu.S, this is very similar but to save/restore checkpointed FPRs/VSRs */
> > -#define __SAVE_32FPRS_VSRS_TRANSACT(n,c,base)	\
> > +/* See fpu.S, this is borrowed from there */
> > +#define __SAVE_32FPRS_VSRS(n,c,base)		\
> 
> Should this really be in tm.S with its new name?

Do you mean, could I merge it with __SAVE_32FPVSRS from fpu.S, put it
in ppc_asm.h and avoid having two very similar macros defined in
different places?  Yes I could, and that's a good idea.

Paul.
