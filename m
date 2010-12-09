Return-Path: <benh@kernel.crashing.org>
Subject: Re: Run 'usermode-agent' cause kernel panic on Powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: xufeng zhang <xufeng.zhang@windriver.com>
In-Reply-To: <4CFEDD4D.5020205@windriver.com>
References: <4CFDD8C5.70905@windriver.com>
	<1291730683.16003.4.camel@shaggy-w500> <4CFEDD4D.5020205@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 09 Dec 2010 14:26:20 +1100
Message-ID: <1291865180.16694.217.camel@pasglop>
Mime-Version: 1.0
Cc: Linuxppc-dev@ozlabs.org, Dave Kleikamp <shaggy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-12-08 at 09:20 +0800, xufeng zhang wrote:

> > I believe it would have such an impact.  I don't see that user-mode
> > debugging would be enabled at all.
> >
> > Maybe something like this untested patch:
> >
> > diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> > index 84906d3..0e7d1cf 100644
> > --- a/arch/powerpc/kernel/process.c
> > +++ b/arch/powerpc/kernel/process.c
> > @@ -323,6 +323,13 @@ static void set_debug_reg_defaults(struct thread_struct *thread)
> >
> >   static void prime_debug_regs(struct thread_struct *thread)
> >   {
> > +	/*
> > +	 * If we're setting up debug events for user space, make sure they
> > +	 * don't fire in kernel space before we get to user space
> > +	 */
> > +	if (thread->dbcr0&  DBCR0_IDM)
> > +		mtmsr(mfmsr()&  ~MSR_DE);
> > +
> >   	mtspr(SPRN_IAC1, thread->iac1);
> >   	mtspr(SPRN_IAC2, thread->iac2);
> >   #if CONFIG_PPC_ADV_DEBUG_IACS>  2
> >
> >    
> Thanks for your reply, Dave, I know where the problem is.

So is there a kernel bug we need to fix ?

Cheers,
Ben.
