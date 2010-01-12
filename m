Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5946B1007F8
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2010 18:12:46 +1100 (EST)
In-Reply-To: <20100112022150.GE12666@kryten>
References: <20100112022150.GE12666@kryten>
Subject: Re: [PATCH]: powerpc: Fix build breakage due to incorrect location of
	autoconf.h
To: Anton Blanchard <anton@samba.org>
Message-ID: <OFA2E48A7D.85AD548E-ONC12576A9.002747D1-C12576A9.00277ABD@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 12 Jan 2010 08:11:13 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Roel Kluin <roel.kluin@gmail.com>, linuxppc-dev@ozlabs.org,
	Richard Purdie <rpurdie@rpsys.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Blanchard <anton@samba.org> wrote on 12/01/2010 03:21:51:
>
>
> commit ac4c2a3bbe5db5fc570b1d0ee1e474db7cb22585 (zlib: optimize inffast when
> copying direct from output) referenced include/linux/autoconf.h which
> is now called include/generated/autoconf.h.
>
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>
> Index: linux-cpumask/arch/powerpc/boot/Makefile
> ===================================================================
> --- linux-cpumask.orig/arch/powerpc/boot/Makefile   2010-01-12 13:15:26.266724762 +1100
> +++ linux-cpumask/arch/powerpc/boot/Makefile   2010-01-12 13:15:33.532974469 +1100
> @@ -34,7 +34,7 @@ BOOTCFLAGS   += -fno-stack-protector
>  endif
>
>  BOOTCFLAGS   += -I$(obj) -I$(srctree)/$(obj)
> -BOOTCFLAGS   += -include include/linux/autoconf.h -Iarch/powerpc/include
> +BOOTCFLAGS   += -include include/generated/autoconf.h -Iarch/powerpc/include
>  BOOTCFLAGS   += -Iinclude

Try making that:
-BOOTCFLAGS   += -include include/linux/autoconf.h -Iarch/powerpc/include
-BOOTCFLAGS   += -Iinclude
+BOOTCFLAGS   += -include include/generated/autoconf.h -I$(srctree)/arch/powerpc/include
+BOOTCFLAGS   += -I$(srctree)/include

 Jocke
