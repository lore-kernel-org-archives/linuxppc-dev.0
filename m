Return-Path: <timur.tabi@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 55E2EDDF2A
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Oct 2008 02:28:55 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so620465ywh.39
	for <linuxppc-dev@ozlabs.org>; Wed, 08 Oct 2008 08:28:53 -0700 (PDT)
Message-ID: <ed82fe3e0810080828r115b3e85laf08e8d1e47faf42@mail.gmail.com>
Date: Wed, 8 Oct 2008 10:28:53 -0500
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org
Subject: Re: [PATCH] powerpc: remove CHRP and PMAC support from defconfigs,
	fix Kconfigs
In-Reply-To: <1222449586-14622-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1222449586-14622-1-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 26, 2008 at 12:19 PM, Timur Tabi <timur@freescale.com> wrote:
> The Kconfig files for PowerPC CHRP and PMAC support had "default=y" for some
> Kconfig options, and this caused support for CHRP and PMAC platforms to be
> enabled incorrectly for several platforms.  Fix the Kconfigs and the
> affected defconfigs.

Ben,

When you applied this patch, you removed the Kconfig changes.  Without
those, doing a "make xxx_defconfig" will just add "CONFIG_PPC_PMAC=y"
and "CONFIG_PPC_CHRP=y" to the .config!

$ make 83xx/mpc834x_itxgp_defconfig
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/basic/docproc
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/kxgettext.o
  SHIPPED scripts/kconfig/zconf.tab.c
  SHIPPED scripts/kconfig/lex.zconf.c
  SHIPPED scripts/kconfig/zconf.hash.c
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
#
# configuration written to .config
#
$ grep CHRP .config
CONFIG_PPC_CHRP=y

So please apply my *original* patch.
-- 
Timur Tabi
Linux kernel developer at Freescale
