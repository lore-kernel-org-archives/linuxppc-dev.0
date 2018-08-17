Return-Path: <luke@dashjr.org>
Received: from zinan.dashjr.org (zinan.dashjr.org [IPv6:2001:470:88ff:2f::1])
 by lists.ozlabs.org (Postfix) with ESMTP id 41sRtY6zKCzDqm6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Aug 2018 01:28:37 +1000 (AEST)
From: Luke Dashjr <luke@dashjr.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc64/ftrace: Include ftrace.h needed for
 enable/disable calls
Date: Fri, 17 Aug 2018 15:16:33 +0000
Cc: Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@ozlabs.org>,
 Steven Rostedt <rostedt@goodmis.org>, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
References: <201808162136.27788.luke@dashjr.org>
 <1534501411.hvsbp9w9ur.naveen@linux.ibm.com>
In-Reply-To: <1534501411.hvsbp9w9ur.naveen@linux.ibm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201808171516.34356.luke@dashjr.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 17 August 2018 10:25:40 Naveen N. Rao wrote:
> Luke Dashjr wrote:
> > this_cpu_disable_ftrace and this_cpu_enable_ftrace are inlines in
> > ftrace.h Without it included, the build fails.
>
> I'm unable to reproduce this. Can you share your .config and the build
> environment?

https://luke.dashjr.org/tmp/code/4.18-config.xz

Gentoo GNU/Linux (mostly stable keywords) on a Raptor Talos II POWER9 system.

> > Fixes: a4bc64d305af ("powerpc64/ftrace: Disable ftrace during kvm
> > entry/exit") Signed-off-by: Luke Dashjr <luke-jr+git@utopios.org>
> > Cc: stable@vger.kernel.org
> > ---
> >  arch/powerpc/kvm/book3s_hv.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> > index ee4a8854985e..15c2c64291f4 100644
> > --- a/arch/powerpc/kvm/book3s_hv.c
> > +++ b/arch/powerpc/kvm/book3s_hv.c
> > @@ -46,6 +46,7 @@
> >  #include <linux/compiler.h>
> >  #include <linux/of.h>
> >
> > +#include <asm/ftrace.h>
> >  #include <asm/reg.h>
> >  #include <asm/ppc-opcode.h>
> >  #include <asm/asm-prototypes.h>
>
> In any case, this change itself looks alright to me. So:
> Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>
>
> Thanks,
> Naveen
