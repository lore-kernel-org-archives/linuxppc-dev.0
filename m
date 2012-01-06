Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
 by ozlabs.org (Postfix) with ESMTP id 69C8CB6F68
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Jan 2012 10:26:50 +1100 (EST)
Date: Fri, 6 Jan 2012 15:26:48 -0800
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: fix kernel log of oops/panic instruction dump
Message-ID: <20120106232648.GG10470@ovro.caltech.edu>
References: <1325889247-17205-1-git-send-email-iws@ovro.caltech.edu>
 <1325890210.23910.29.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1325890210.23910.29.camel@pasglop>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jan 07, 2012 at 09:50:10AM +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2012-01-06 at 14:34 -0800, Ira W. Snyder wrote:
> > A kernel oops/panic prints an instruction dump showing several
> > instructions before and after the instruction which caused the
> > oops/panic.
> > 
> > The code intended that the faulting instruction be enclosed in angle
> > brackets, however a bug caused the faulting instruction to be
> > interpreted by printk() as the message log level.
> > 
> > To fix this, the KERN_CONT log level is added before the actualy text of

If you could fix the text above to say 'actual' (instead of 'actualy')
when you commit this, that would be great. Darn typos. :)

> > the printed message.
> 
> Nice one, thanks.
> 
> Cheers,
> Ben.
> 
> > === Before the patch ===
> > 
> > [ 1081.587266] Instruction dump:
> > [ 1081.590236] 7c000110 7c0000f8 5400077c 552907f6 7d290378 992b0003 4e800020 38000001
> > [ 1081.598034] 3d20c03a 9009a114 7c0004ac 39200000
> > [ 1081.602500]  4e800020 3803ffd0 2b800009
> > 
> > <4>[ 1081.587266] Instruction dump:
> > <4>[ 1081.590236] 7c000110 7c0000f8 5400077c 552907f6 7d290378 992b0003 4e800020 38000001
> > <4>[ 1081.598034] 3d20c03a 9009a114 7c0004ac 39200000
> > <98090000>[ 1081.602500]  4e800020 3803ffd0 2b800009
> > 
> > === After the patch ===
> > 
> > [   51.385216] Instruction dump:
> > [   51.388186] 7c000110 7c0000f8 5400077c 552907f6 7d290378 992b0003 4e800020 38000001
> > [   51.395986] 3d20c03a 9009a114 7c0004ac 39200000 <98090000> 4e800020 3803ffd0 2b800009
> > 
> > <4>[   51.385216] Instruction dump:
> > <4>[   51.388186] 7c000110 7c0000f8 5400077c 552907f6 7d290378 992b0003 4e800020 38000001
> > <4>[   51.395986] 3d20c03a 9009a114 7c0004ac 39200000 <98090000> 4e800020 3803ffd0 2b800009
> > 
> > Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > ---
> > 
> > In the above examples, the first block is what is shown on the serial
> > console as the machine dies. The second block is the dump as captured by
> > mtdoops.
> > 
> >  arch/powerpc/kernel/process.c |    6 +++---
> >  1 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> > index 6457574..271f809 100644
> > --- a/arch/powerpc/kernel/process.c
> > +++ b/arch/powerpc/kernel/process.c
> > @@ -566,12 +566,12 @@ static void show_instructions(struct pt_regs *regs)
> >  		 */
> >  		if (!__kernel_text_address(pc) ||
> >  		     __get_user(instr, (unsigned int __user *)pc)) {
> > -			printk("XXXXXXXX ");
> > +			printk(KERN_CONT "XXXXXXXX ");
> >  		} else {
> >  			if (regs->nip == pc)
> > -				printk("<%08x> ", instr);
> > +				printk(KERN_CONT "<%08x> ", instr);
> >  			else
> > -				printk("%08x ", instr);
> > +				printk(KERN_CONT "%08x ", instr);
> >  		}
> >  
> >  		pc += sizeof(int);
> 
> 
