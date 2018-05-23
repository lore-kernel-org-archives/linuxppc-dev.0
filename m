Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rgHG32XwzF1C8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 03:58:34 +1000 (AEST)
Date: Wed, 23 May 2018 19:58:28 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Balbir Singh
 <bsingharora@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, Breno Leitao
 <leitao@debian.org>, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/xmon: really enable xmon when a breakpoint is set
Message-ID: <20180523195828.764f4356@kitsune.suse.cz>
In-Reply-To: <87bmd8xieu.fsf@vajain21.in.ibm.com>
References: <20180521132108.7938-1-msuchanek@suse.de>
 <87bmd8xieu.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 22 May 2018 12:53:53 +0530
Vaibhav Jain <vaibhav@linux.vnet.ibm.com> wrote:

> Thanks for the patch Michal,
> 
> Michal Suchanek <msuchanek@suse.de> writes:
> 
> > When single-stepping kernel code from xmon without a debug hook
> > enabled the kernel crashes. This can happen when kernel starts with
> > xmon on crash disabled but xmon is entered using sysrq.
> >
> > Commit e1368d0c9edb ("powerpc/xmon: Setup debugger hooks when first
> > break-point is set") adds force_enable_xmon function that prints
> > "xmon: Enabling debugger hooks" but does not enable them.  
> Debugger hooks are enabled just befores debugger() is entered from
> sysrq_handle_xmon(). Thats why force_enable_xmon() simply sets sets
> 'xmon_on=1' and exits.
> 
> The problem you are seeing is probably due to sysrq_handle_xmon()
> clearing the debugger hooks on return from debugger() as xmon_on was
> never set for the 's' xmon command.

Indeed, setting xmon_on is sufficient. Will resend the patch.

Thanks

Michal

> 
> > Add the call to xmon_init to install the debugger hooks in
> > force_enable_xmon and also call force_enable_xmon when
> > single-stepping in xmon.  
> Only calling force_enable_xmon() from do_step() should be suffice as
> on exit from the debugger() the value of xmon_on is checked and if
> required the debugger hooks are kept instead of getting cleared.
> 
> 
> >  arch/powerpc/xmon/xmon.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> > index a0842f1ff72c..504bd1c3d8b0 100644
> > --- a/arch/powerpc/xmon/xmon.c
> > +++ b/arch/powerpc/xmon/xmon.c  
> 
> 
> > @@ -1275,6 +1279,7 @@ static inline void force_enable_xmon(void)
> >  	if (!xmon_on) {
> >  		printf("xmon: Enabling debugger hooks\n");
> >  		xmon_on = 1;
> > +		xmon_init(1);
> >  	}
> >  }  
> 
> As mentioned above call to force_enable_xmon() is usually done in
> context of sysrq_handle_xmon() which sets the debugger hooks as soon
> as its entered. So I think that this hunk is not really needed.
> 
> 
