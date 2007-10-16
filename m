Return-Path: <vitb@kernel.crashing.org>
Received: from vitb.dev.rtsoft.ru (unknown [85.21.88.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 541C9DDF04
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 04:42:11 +1000 (EST)
Date: Tue, 16 Oct 2007 21:53:08 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [UNTESTED PATCH v2] 8xx: Convert mpc866ads to the new device
	binding.
Message-ID: <20071016215308.764d9922@vitb.ru.mvista.com>
In-Reply-To: <20071008224847.GA4053@loki.buserror.net>
References: <20071008224847.GA4053@loki.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Scott,

orig one does not build (not your issue apparently):

  CC      drivers/net/fs_enet/fs_enet-main.o
drivers/net/fs_enet/fs_enet-main.c: In function `fs_enet_probe':
drivers/net/fs_enet/fs_enet-main.c:1252: error: implicit declaration of 
function `SET_MODULE_OWNER'
drivers/net/fs_enet/fs_enet-main.c:1292: error: structure has no member 
named `poll'
drivers/net/fs_enet/fs_enet-main.c:1293: error: structure has no member 
named `weight'
make[3]: *** [drivers/net/fs_enet/fs_enet-main.o] Error 1
make[2]: *** [drivers/net/fs_enet] Error 2
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2

because net_device does not have 'poll' and 'weight' anymore.

Moreover, with the patch, it does not seem to boot(with upper lines commented out to get it build). I'm investigating the reason right now.

On Mon, 8 Oct 2007 17:48:47 -0500
Scott Wood <scottwood@freescale.com> wrote:

> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> Whoops, forgot the localbus node last time.
> 
>  arch/powerpc/boot/dts/mpc866ads.dts          |  137 +++++++------
>  arch/powerpc/platforms/8xx/Kconfig           |    1 +
>  arch/powerpc/platforms/8xx/mpc86xads.h       |   44 ----
>  arch/powerpc/platforms/8xx/mpc86xads_setup.c |  289 +++++++-------------------
>  4 files changed, 156 insertions(+), 315 deletions(-)
> 
[...]
-- 
Sincerely, 
Vitaly
