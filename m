Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHxHK1r13zDvgf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 16:47:25 +1100 (AEDT)
Message-ID: <1479188830.21746.31.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: David Engraf <david.engraf@sysgo.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Mon, 14 Nov 2016 23:47:10 -0600
In-Reply-To: <992d2bea-019a-3969-e154-10b9b43ab6fc@sysgo.com>
References: <1471877203-29327-1-git-send-email-david.engraf@sysgo.com>
 <20160925062017.GA10754@home.buserror.net>
 <87664de8-7aea-96a8-9906-cf2ce8d325a2@sysgo.com>
 <1474931328.4283.41.camel@buserror.net>
 <992d2bea-019a-3969-e154-10b9b43ab6fc@sysgo.com>
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

On Fri, 2016-10-07 at 11:00 +0200, David Engraf wrote:
> Am 27.09.2016 um 01:08 schrieb Scott Wood:
> > 
> > On Mon, 2016-09-26 at 10:48 +0200, David Engraf wrote:
> > > 
> > > Am 25.09.2016 um 08:20 schrieb Scott Wood:
> > > > 
> > > > 
> > > > On Mon, Aug 22, 2016 at 04:46:43PM +0200, David Engraf wrote:
> > > > > 
> > > > > 
> > > > > The PowerPC e5500/e6500 architecture is based on the e500mc core.
> > > > > Enable
> > > > > CONFIG_E500 and CONFIG_PPC_E500MC when e5500/e6500 is used.
> > > > > 
> > > > > This will also fix using CONFIG_PPC_QEMU_E500 on PPC64.
> > > > > 
> > > > > Signed-off-by: David Engraf <david.engraf@sysgo.com>
> > > > > ---
> > > > >  arch/powerpc/platforms/Kconfig.cputype | 6 ++++--
> > > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/arch/powerpc/platforms/Kconfig.cputype
> > > > > b/arch/powerpc/platforms/Kconfig.cputype
> > > > > index f32edec..0382da7 100644
> > > > > --- a/arch/powerpc/platforms/Kconfig.cputype
> > > > > +++ b/arch/powerpc/platforms/Kconfig.cputype
> > > > > @@ -125,11 +125,13 @@ config POWER8_CPU
> > > > > 
> > > > >  config E5500_CPU
> > > > >  	bool "Freescale e5500"
> > > > > -	depends on E500
> > > > > +	select E500
> > > > > +	select PPC_E500MC
> > > > > 
> > > > >  config E6500_CPU
> > > > >  	bool "Freescale e6500"
> > > > > -	depends on E500
> > > > > +	select E500
> > > > > +	select PPC_E500MC
> > > > These config symbols are for setting -mcpu.  Kernels built with
> > > > CONFIG_GENERIC_CPU should also work on e5500/e6500.
> > > I don't think so.
> > I do think so.  It's what you get when you run "make
> > corenet64_smp_defconfig"
> > and that kernel works on e5500/e6500.
> > 
> > > 
> > >  At least on QEMU it is not working because e5500/e6500
> > > is based on the e500mc core and the option CONFIG_PPC_E500MC also
> > > controls the cpu features (check cputable.h).
> > Again, this is only a problem when you have CONFIG_PPC_QEMU_E500 without
> > CONFIG_CORENET_GENERIC, and the fix for that is to have
> > CONFIG_PPC_QEMU_E500
> > select CONFIG_E500 (and you need to manually turn on CONFIG_PPC_E500MC if
> > applicable, since CONFIG_PPC_QEMU_E500 can also be used with e500v2).
> > 
> > I wouldn't be opposed to also adding "select PPC_E500MC if PPC64" to
> > CONFIG_PPC_QEMU_E500.
> Please find attached the new version, setting E500 and PPC_E500MC on 64 
> bit for review.

Could you send as a standalone patch (not an attachment) with changelog and
signoff so I can apply it?

-Scott
