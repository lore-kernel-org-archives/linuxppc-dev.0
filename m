Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sjfmJ24PLzDrLg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 09:09:04 +1000 (AEST)
Message-ID: <1474931328.4283.41.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: David Engraf <david.engraf@sysgo.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Mon, 26 Sep 2016 18:08:48 -0500
In-Reply-To: <87664de8-7aea-96a8-9906-cf2ce8d325a2@sysgo.com>
References: <1471877203-29327-1-git-send-email-david.engraf@sysgo.com>
 <20160925062017.GA10754@home.buserror.net>
 <87664de8-7aea-96a8-9906-cf2ce8d325a2@sysgo.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: powerpc64: Enable CONFIG_E500 and CONFIG_PPC_E500MC for
 e5500/e6500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-09-26 at 10:48 +0200, David Engraf wrote:
> Am 25.09.2016 um 08:20 schrieb Scott Wood:
> > 
> > On Mon, Aug 22, 2016 at 04:46:43PM +0200, David Engraf wrote:
> > > 
> > > The PowerPC e5500/e6500 architecture is based on the e500mc core. Enable
> > > CONFIG_E500 and CONFIG_PPC_E500MC when e5500/e6500 is used.
> > > 
> > > This will also fix using CONFIG_PPC_QEMU_E500 on PPC64.
> > > 
> > > Signed-off-by: David Engraf <david.engraf@sysgo.com>
> > > ---
> > >  arch/powerpc/platforms/Kconfig.cputype | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/powerpc/platforms/Kconfig.cputype
> > > b/arch/powerpc/platforms/Kconfig.cputype
> > > index f32edec..0382da7 100644
> > > --- a/arch/powerpc/platforms/Kconfig.cputype
> > > +++ b/arch/powerpc/platforms/Kconfig.cputype
> > > @@ -125,11 +125,13 @@ config POWER8_CPU
> > > 
> > >  config E5500_CPU
> > >  	bool "Freescale e5500"
> > > -	depends on E500
> > > +	select E500
> > > +	select PPC_E500MC
> > > 
> > >  config E6500_CPU
> > >  	bool "Freescale e6500"
> > > -	depends on E500
> > > +	select E500
> > > +	select PPC_E500MC
> > These config symbols are for setting -mcpu.  Kernels built with
> > CONFIG_GENERIC_CPU should also work on e5500/e6500.
> I don't think so.

I do think so.  It's what you get when you run "make corenet64_smp_defconfig"
and that kernel works on e5500/e6500.

>  At least on QEMU it is not working because e5500/e6500 
> is based on the e500mc core and the option CONFIG_PPC_E500MC also 
> controls the cpu features (check cputable.h).

Again, this is only a problem when you have CONFIG_PPC_QEMU_E500 without
CONFIG_CORENET_GENERIC, and the fix for that is to have CONFIG_PPC_QEMU_E500
select CONFIG_E500 (and you need to manually turn on CONFIG_PPC_E500MC if
applicable, since CONFIG_PPC_QEMU_E500 can also be used with e500v2).

I wouldn't be opposed to also adding "select PPC_E500MC if PPC64" to
CONFIG_PPC_QEMU_E500.

> > 
> > The problem is that CONFIG_PPC_QEMU_E500 doesn't select E500 (I didn't
> > notice it before because usually CORENET_GENERIC is enabled as well).
> I noticed that as well, but I think it makes more sense to select 
> E500/PPC_E500MC within the cputype menu instead of having a dependency 
> which might be not clear for the user.

Again, that breaks CONFIG_GENERIC_CPU.  Unlike 32-bit, all 64-bit book3e
targets are supposed to be supportable with a single kernel image.

-Scott
