Return-Path: <timur.tabi@gmail.com>
Received: from mail-vw0-f42.google.com (mail-vw0-f42.google.com
	[209.85.212.42]) by ozlabs.org (Postfix) with ESMTP id 198E4B70D1
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Aug 2010 05:31:43 +1000 (EST)
Received: by vws18 with SMTP id 18so271068vws.15
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Aug 2010 12:31:42 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <20100608195557.GC11446@oksana.dev.rtsoft.ru>
References: <20100608195557.GC11446@oksana.dev.rtsoft.ru>
Date: Wed, 18 Aug 2010 14:31:42 -0500
Message-ID: <AANLkTinOz72GNpVD=+f5n7mMaHpoEeJ4QMwAON9nnu2A@mail.gmail.com>
Subject: Re: [PATCH 3/3] powerpc/85xx: Cleanup QE initialization for
	MPC85xxMDS boards
From: Timur Tabi <timur@freescale.com>
To: Anton Vorontsov <avorontsov@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 8, 2010 at 2:55 PM, Anton Vorontsov <avorontsov@mvista.com> wrote:
> The mpc85xx_mds_setup_arch() function is incomprehensible
> and unmaintainable. Factor out all QE specific stuff into
> mpc85xx_mds_qe_init() and mpc85xx_mds_reset_ucc_phys().
>
> Also move QE stuff out of mpc85xx_mds_pic_init().
>
> The diff is unreadable, but only because the code was so. ;-)
> It should be better now, and less indented.
>
> Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
> ---

This patch introduces breaks mpc85xx_smp_defconfig:

  CC      arch/powerpc/platforms/85xx/mpc85xx_mds.o
arch/powerpc/platforms/85xx/mpc85xx_mds.c: In function 'mpc85xx_mds_setup_arch':
arch/powerpc/platforms/85xx/mpc85xx_mds.c:367: error: 'np' undeclared
(first use in this function)
arch/powerpc/platforms/85xx/mpc85xx_mds.c:367: error: (Each undeclared
identifier is reported only once
arch/powerpc/platforms/85xx/mpc85xx_mds.c:367: error: for each
function it appears in.)

Frankly, I've been seeing a lot of build breaks with
mpc85xx_[smp_]defconfig.  I had a patch that added a
p1022_ds_defconfig, but was told instead to update
mpc85xx_[smp_]defconfig.  However, it appears that no one is really
testing mpc85xx_[smp_]defconfig, since there are now *two* failures
(this one, and CONFIG_RAPIDIO) with these defconfig files.

-- 
Timur Tabi
Linux kernel developer at Freescale
