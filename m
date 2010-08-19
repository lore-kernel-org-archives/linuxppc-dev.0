Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
	[209.85.215.170]) by ozlabs.org (Postfix) with ESMTP id B5AF2B70CB
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Aug 2010 16:45:49 +1000 (EST)
Received: by eyb6 with SMTP id 6so699922eyb.15
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Aug 2010 23:45:47 -0700 (PDT)
Date: Thu, 19 Aug 2010 10:45:43 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 3/3] powerpc/85xx: Cleanup QE initialization for
	MPC85xxMDS boards
Message-ID: <20100819064543.GA15558@oksana.dev.rtsoft.ru>
References: <20100608195557.GC11446@oksana.dev.rtsoft.ru>
	<AANLkTinOz72GNpVD=+f5n7mMaHpoEeJ4QMwAON9nnu2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <AANLkTinOz72GNpVD=+f5n7mMaHpoEeJ4QMwAON9nnu2A@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 18, 2010 at 02:31:42PM -0500, Timur Tabi wrote:
> On Tue, Jun 8, 2010 at 2:55 PM, Anton Vorontsov <avorontsov@mvista.com> wrote:
> > The mpc85xx_mds_setup_arch() function is incomprehensible
> > and unmaintainable. Factor out all QE specific stuff into
> > mpc85xx_mds_qe_init() and mpc85xx_mds_reset_ucc_phys().
> >
> > Also move QE stuff out of mpc85xx_mds_pic_init().
> >
> > The diff is unreadable, but only because the code was so. ;-)
> > It should be better now, and less indented.
> >
> > Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
> > ---
> 
> This patch introduces breaks mpc85xx_smp_defconfig:
> 
>   CC      arch/powerpc/platforms/85xx/mpc85xx_mds.o
> arch/powerpc/platforms/85xx/mpc85xx_mds.c: In function 'mpc85xx_mds_setup_arch':
> arch/powerpc/platforms/85xx/mpc85xx_mds.c:367: error: 'np' undeclared
> (first use in this function)
> arch/powerpc/platforms/85xx/mpc85xx_mds.c:367: error: (Each undeclared
> identifier is reported only once
> arch/powerpc/platforms/85xx/mpc85xx_mds.c:367: error: for each
> function it appears in.)

Thanks for the report, apparently I tested my patch without
CONFIG_PCI... But the issue should be already fixed by

  powerpc/85xx: Fix compile error in mpc85xx_mds.c
  http://patchwork.ozlabs.org/patch/60933/

(Though, not in Linus' tree yet.)

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
