Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 5F56A67C1C
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 05:49:35 +1100 (EST)
Date: Tue, 12 Dec 2006 21:49:42 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 4/4] [POWERPC] Fix kernel build errors for mpc8272ads
	and mpc8560ads.
Message-ID: <20061212214942.41bc2369@vitb.ru.mvista.com>
In-Reply-To: <9EC45741-28F3-49C7-9F0A-8EA3DA6A6290@kernel.crashing.org>
References: <20061212012641.5ef493f7@localhost.localdomain>
	<20061211223709.20169.93595.stgit@localhost.localdomain>
	<9EC45741-28F3-49C7-9F0A-8EA3DA6A6290@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 11 Dec 2006 20:28:38 -0600
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Dec 11, 2006, at 4:37 PM, Vitaly Bordug wrote:
> 
> >
> > Recent update of asm-powerpc/io.h caused cpm-related stuff to break  
> > in the
> > current kernel. Current patch fixes it, and includes other overhaul  
> > and
> > improvements (incomplete list is below). Required for proper  
> > functioning of
> > the 8xx stuff as well.
> >
> > - Updated dts with a chosen node with interrupt controller,
> > - fixed messed device IDs among CPM2 SoC devices,
> > - corrected odd header name and fixed type in defines,
> > - Added 82xx subdir to the powerpc/platforms Makefile, new
> >   solely-powerpc header for 8260 family (was using one from arch/ 
> > ppc, this
> >   one cleaned up from the extra stuff).
> >
> > Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
> > ---
> [snip]
> >
> > diff --git a/include/asm-powerpc/fs_pd.h b/include/asm-powerpc/fs_pd.h
> > index 4c3af35..c624915 100644
> > --- a/include/asm-powerpc/fs_pd.h
> > +++ b/include/asm-powerpc/fs_pd.h
> > @@ -17,6 +17,12 @@ #include <asm/time.h>
> >  #ifdef CONFIG_CPM2
> >  #include <asm/cpm2.h>
> >
> > +#if defined(CONFIG_8260)
> > +#include <asm/mpc8260.h>
> > +#elif defined(CONFIG_85xx)
> > +#include <asm/mpc85xx.h>
> > +#endif
> > +
> 
> Why does this need to include these files?

To produce exact answer, I have to build kernel which became temporary trouble after git-pull :)
I can say this is mainly for CPM_MAP_ADDR (where CPM immap residing) so that to reset cpm early,
and a few other BSP defines(like BCSR), that are delivered with #defines for now.

In fact, upper header sequence used to reside in some common ppc/powerpc header until recent cleanup,
and CPM-related stuff were not buildable after that. So, "clean-n-proper" solution is under construction
now (to get rid of CPM_MAP_ADDR/IMMAP defines usage at all) but we'd better avoid having "build broken" stuff meanwhile.

> 
> >  #define cpm2_map(member)						\
> >  ({									\
> >  	u32 offset = offsetof(cpm2_map_t, member);			\
> > @@ -37,6 +43,7 @@ #endif
> >
> >  #ifdef CONFIG_8xx
> >  #include <asm/8xx_immap.h>
> > +#include <asm/mpc8xx.h>
> >
[...]
> > --- /dev/null
> > +++ b/include/asm-powerpc/mpc8260.h
> 
> Who needs this header?  Is this just for the board code under  
> platforms/82xx?
> 
This header it to triage across 82xx boards and include proper BSP .h file.
The process is ongoing to minimize such header-residing stuff though. I found it missing from 
initial 8272 addition, it is required for proper build/operation (so far, but anyway).

-- 
Sincerely, 
Vitaly
