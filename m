Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 51EAD1A0054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 14:39:39 +1100 (AEDT)
Message-ID: <1453952378.4108.3.camel@ellerman.id.au>
Subject: Re: [PATCH v6 1/9] ppc64 (le): prepare for -mprofile-kernel
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alan Modra <amodra@gmail.com>
Cc: Torsten Duwe <duwe@lst.de>, Steven Rostedt <rostedt@goodmis.org>, Anton
 Blanchard <anton@samba.org>, Jiri Kosina <jkosina@suse.cz>,
 linuxppc-dev@lists.ozlabs.org,  linux-kernel@vger.kernel.org,
 live-patching@vger.kernel.org
Date: Thu, 28 Jan 2016 14:39:38 +1100
In-Reply-To: <20160127125809.GN17028@bubble.grove.modra.org>
References: <20160125170459.14DB7692CE@newverein.lst.de>
 <20160125170723.D2CCE692CE@newverein.lst.de>
 <1453889967.10839.2.camel@ellerman.id.au>
 <20160127125809.GN17028@bubble.grove.modra.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-01-27 at 23:28 +1030, Alan Modra wrote:
> On Wed, Jan 27, 2016 at 09:19:27PM +1100, Michael Ellerman wrote:
> > Hi Torsten,
> > 
> > On Mon, 2016-01-25 at 16:26 +0100, Torsten Duwe wrote:
> > > The gcc switch -mprofile-kernel, available for ppc64 on gcc > 4.8.5,
> > > allows to call _mcount very early in the function, which low-level
> > > ASM code and code patching functions need to consider.
> > > Especially the link register and the parameter registers are still
> > > alive and not yet saved into a new stack frame.
> > > 
> > > Signed-off-by: Torsten Duwe <duwe@suse.de>
> > > ---
> > >  arch/powerpc/kernel/entry_64.S  | 45 +++++++++++++++++++++++++++++++++++++++--
> > >  arch/powerpc/kernel/ftrace.c    | 12 +++++++++--
> > >  arch/powerpc/kernel/module_64.c | 14 +++++++++++++
> > >  3 files changed, 67 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> > > index a94f155..e7cd043 100644
> > > --- a/arch/powerpc/kernel/entry_64.S
> > > +++ b/arch/powerpc/kernel/entry_64.S
> > > @@ -1206,7 +1206,12 @@ _GLOBAL(enter_prom)
> > >  #ifdef CONFIG_DYNAMIC_FTRACE
> > >  _GLOBAL(mcount)
> > >  _GLOBAL(_mcount)
> > > -	blr
> > > +	std	r0,LRSAVE(r1) /* gcc6 does this _after_ this call _only_ */
> > > +	mflr	r0
> > > +	mtctr	r0
> > > +	ld	r0,LRSAVE(r1)
> > > +	mtlr	r0
> > > +	bctr
> > 
> > Can we use r11 instead? eg:
> > 
> > _GLOBAL(_mcount)
> > 	mflr	r11
> > 	mtctr	r11
> > 	mtlr	r0
> > 	bctr
> 
> Depends on what you need to support.  As Torsten says, the code to
> call _mcount when -mprofile-kernel is emitted before the prologue of a
> function (similar to -m32), but after the ELFv2 global entry point
> code.  If you trash r11 here you're killing the static chain pointer,
> used by C nested functions or other languages that use a static chain,
> eg. Pascal.  r11 has *not* been saved for ELFv2.

OK, thanks for clarfiying. Pascal is not a big concern :D. But although I
don't think we use nested functions anywhere, someone somewhere could be, or at
least might one day.

> r12 might be a better choice for a temp reg.

Even better.

cheers
