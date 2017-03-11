Return-Path: <me@tobin.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vgdpx68g9zDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Mar 2017 09:19:52 +1100 (AEDT)
Date: Sun, 12 Mar 2017 09:19:45 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Daniel Axtens <dja@axtens.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: fix sparse warning, include kernel header
Message-ID: <20170311221945.GB14736@eros>
References: <1488788731-2537-1-git-send-email-me@tobin.cc>
 <87k27y3qx4.fsf@possimpible.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87k27y3qx4.fsf@possimpible.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 10, 2017 at 11:40:23AM +1100, Daniel Axtens wrote:
> Hi Tobin,
> 
> I have built the kernel with the ppc6xx_defconfig with and without your
> patch.
> 
> Using my smart-sparse-diff tool[1], I have confirmed the warning
> disappears:
> 
> -/scratch/dja/linux/arch/powerpc/kernel/swsusp.c:17:6: warning: symbol 'save_processor_state' was not declared. Should it be static?
> -/scratch/dja/linux/arch/powerpc/kernel/swsusp.c:31:6: warning: symbol 'restore_processor_state' was not declared. Should it be static?
> 
> As such, this patch is:
> 
> Reviewed-by: Daniel Axtens <dja@axtens.net>

Awesome, thanks Daniel

> 
> Thanks for fixing this!
> 
> Regards,
> Daniel
> 
> [1] https://github.com/daxtens/smart-sparse-diff
> 
> "Tobin C. Harding" <me@tobin.cc> writes:
> 
> > Spares emits two symbol not declared warnings. The two functions in
> > question are declared already in a kernel header.
> >
> > Add include directive to include kernel header.
> >
> > Signed-off-by: Tobin C. Harding <me@tobin.cc>
> > ---
> >
> > github issue: #37 Fix sparse errors
> >
> >  arch/powerpc/kernel/swsusp.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/powerpc/kernel/swsusp.c b/arch/powerpc/kernel/swsusp.c
> > index 6ae9bd5..0050b2d 100644
> > --- a/arch/powerpc/kernel/swsusp.c
> > +++ b/arch/powerpc/kernel/swsusp.c
> > @@ -10,6 +10,7 @@
> >   */
> >  
> >  #include <linux/sched.h>
> > +#include <linux/suspend.h>
> >  #include <asm/current.h>
> >  #include <asm/mmu_context.h>
> >  #include <asm/switch_to.h>
> > -- 
> > 2.7.4

-- 
Tobin Harding
http://tobin.cc
