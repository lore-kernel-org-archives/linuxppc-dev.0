Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <1113272915.5388.37.camel@gaston>
References: <1113272915.5388.37.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <f54dd3f8af3f508dc7774fb841a8877a@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 12 Apr 2005 00:42:36 -0500
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Jason McMullan <jason.mcmullan@timesys.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Kumar Gala <galak@freescale.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] ppc32: refactor FPU exception handling
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben,

Sorry about that, we have had some back and forth on this on the ppc=20
embedded list.

Not sure I understand your concern about the duplication of the fast=20
exception return path?  Jason's patch pretty much just moved code out=20
of head.S into fpu.S so we dont duplicate it between head.S and=20
head_44x.S & head_fsl_booke.S

- kumar

On Apr 11, 2005, at 9:28 PM, Benjamin Herrenschmidt wrote:

> On Mon, 2005-04-11 at 17:02 -0500, Kumar Gala wrote:
>  > Andrew,
>  >
> > Moved common FPU exception handling code out of head.S so it can be=20=

> used
> > by several of the sub-architectures that might of a full PowerPC=20
> FPU.=A0
> >
> > Also, uses new CONFIG_PPC_FPU define to fix alignment exception
> > handling for floating point load/store instructions to only occur if=20=

> we
> > have a hardware FPU.
> >
> > Signed-off-by: Jason McMullan <jason.mcmullan@timesys.com>
> > Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
>
>
>
> Andrew, please hold on this patch, it hasn't been properly discussed
>  with the relevant maintainer, that is Paul Mackerras.
>
> I can see matter for debate in there, like the whole duplication of =
the
>  fast exception return path...
>
> It's also touching quite sensitive bits of kernel code (head.S) that
>  needs careful auditing and testing before beeing pushed upstream.
>
> Ben.
