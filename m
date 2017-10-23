Return-Path: <srs0=2bcd=bw=gmail.com=breno.debian@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLGd25z25zDqhf
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 23:56:54 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yLGd22lc6z8t39
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 23:56:54 +1100 (AEDT)
Received: from mail-qk0-f193.google.com (mail-qk0-f193.google.com
 [209.85.220.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3yLGd01Mttz9tXQ
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Oct 2017 23:56:51 +1100 (AEDT)
Received: by mail-qk0-f193.google.com with SMTP id l194so21743967qke.13
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Oct 2017 05:56:51 -0700 (PDT)
Date: Mon, 23 Oct 2017 10:56:43 -0200
From: Breno Leitao <leitao@debian.org>
To: Michael Neuling <mikey@neuling.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 stewart@linux.vnet.ibm.com, cyrilbur@gmail.com
Subject: Re: [PATCH 1/4] powerpc/tm: Add commandline option to disable
 hardware transactional memory
Message-ID: <20171023125642.r5qzr5u5dpjkiseh@gmail.com>
References: <1507803439-12862-1-git-send-email-mpe@ellerman.id.au>
 <20171020114539.piyh4wmby5gz7qnb@gmail.com>
 <1508547527.23934.4.camel@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1508547527.23934.4.camel@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Oct 21, 2017 at 11:58:47AM +1100, Michael Neuling wrote:
> On Fri, 2017-10-20 at 09:45 -0200, Breno Leitao wrote:
> > Mikey, Cyril,
> > 
> > On Thu, Oct 12, 2017 at 09:17:16PM +1100, Michael Ellerman wrote:
> > > From: Cyril Bur <cyrilbur@gmail.com>
> > > 
> > > Currently the kernel relies on firmware to inform it whether or not the
> > > CPU supports HTM and as long as the kernel was built with
> > > CONFIG_PPC_TRANSACTIONAL_MEM=y then it will allow userspace to make
> > > use of the facility.
> > > 
> > > There may be situations where it would be advantageous for the kernel
> > > to not allow userspace to use HTM, currently the only way to achieve
> > > this is to recompile the kernel with CONFIG_PPC_TRANSACTIONAL_MEM=n.
> > > 
> > > This patch adds a simple commandline option so that HTM can be
> > > disabled at boot time.
> > > 
> > > Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> > > [mpe: Simplify to a bool, move to prom.c, put doco in the right place.
> > >  Always disable, regardless of initial state, to avoid user confusion.]
> > > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > > ---
> > >  Documentation/admin-guide/kernel-parameters.txt |  4 ++++
> > >  arch/powerpc/kernel/prom.c                      | 31
> > > +++++++++++++++++++++++++
> > >  2 files changed, 35 insertions(+)
> > > 
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt
> > > b/Documentation/admin-guide/kernel-parameters.txt
> > > index 05496622b4ef..ef03e6e16bdb 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -3185,6 +3185,10 @@
> > >  			allowed (eg
> > > kernel_enable_fpu()/kernel_disable_fpu()).
> > >  			There is some performance impact when enabling
> > > this.
> > >  
> > > +	ppc_tm=		[PPC]
> > > +			Format: {"off"}
> > > +			Disable Hardware Transactional Memory
> > > +
> > >  	print-fatal-signals=
> > >  			[KNL] debug: print fatal signals
> > >  
> > > diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> > > index f83056297441..d9bd6555f980 100644
> > > --- a/arch/powerpc/kernel/prom.c
> > > +++ b/arch/powerpc/kernel/prom.c
> > > @@ -658,6 +658,35 @@ static void __init early_reserve_mem(void)
> > >  #endif
> > >  }
> > >  
> > > +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> > > +static bool tm_disabled __initdata;
> > 
> > I think the name 'tm_disabled' might cause more confusion on the TM
> > code. Mainly because we already have tm_enable() and tm_enabled()
> > functions which are related to the MSR register and TM bit, and, with
> > your new variable, tm_enabled() and tm_disabled are not going to be
> > exclusionary. Neither tm_enable() with be able to toggle the tm_disabled
> > value.
> 
> Got a proposal for better names?

That is the hardest part, but I thought about something as:

 * tm_disabled_on_boot
 * tm_off
 * tm_explicit_disabled
 * tm_feature_disabled
 * tm_enablement_disabled

I think these names, although a bit longer, might avoid the confusion
with tm_enable/tm_enabled nomenclature.
