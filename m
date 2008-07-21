Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id CEAE9DDE0F
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 19:56:02 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [5/5] include tuning options into Makefile
Date: Mon, 21 Jul 2008 11:55:59 +0200
References: <200807210857.08892.marvin24@gmx.de>
	<200807210900.58839.marvin24@gmx.de>
In-Reply-To: <200807210900.58839.marvin24@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807211156.00312.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 21 July 2008, Marvin wrote:

> +# optimize for specific cpu
> +ifeq ($(CONFIG_TUNE_RS64),y)
> + =A0 =A0KBUILD_CFLAGS +=3D $(call cc-option,-mcpu=3Drs64)
> +else ifeq ($(CONFIG_TUNE_POWER3),y)
> + =A0 =A0KBUILD_CFLAGS +=3D $(call cc-option,-mcpu=3Dpower3)
> +else ifeq ($(CONFIG_TUNE_POWER4),y)
> + =A0 =A0KBUILD_CFLAGS +=3D $(call cc-option,-mcpu=3D$(P4CPU))
> +else ifeq ($(CONFIG_TUNE_CELL),y)
> + =A0 =A0KBUILD_CFLAGS +=3D $(call cc-option,-mcpu=3Dcell,-mtune=3Dcell)
> +else ifeq ($(CONFIG_TUNE_POWER5),y)
> + =A0 =A0KBUILD_CFLAGS +=3D $(call cc-option,-mcpu=3Dpower5,-mtune=3Dpowe=
r5)
> +else ifeq ($(CONFIG_TUNE_POWER6),y)
> + =A0 =A0KBUILD_CFLAGS +=3D $(call cc-option,-mcpu=3Dpower6,-mtune=3Dpowe=
r6)
> =A0endif
> -else
> -LDFLAGS_MODULE=A0+=3D arch/powerpc/lib/crtsavres.o

I think it would be easier to express this logic in Kconfig than in
Makefile.

> +
> +ifneq ($(CONFIG_OPT_EXCLUSIVE),y)
> + =A0 =A0KBUILD_CFLAGS :=3D $(subst mcpu,mtune,$(KBUILD_CFLAGS))
> =A0endif
> =A0

This still doesn't allow the most interesting case where you want to
optimize for a modern CPU but still allow older ones, e.g.
"-mcpu=3Dpower4 -mtune=3Dpower6".

	Arnd <><
