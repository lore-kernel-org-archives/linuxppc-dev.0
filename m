Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rjfLZ08j4zDr1W
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 17:49:57 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 5/6] powerpc/sparse: Pass endianness to sparse
Date: Mon, 04 Jul 2016 09:52:53 +0200
Message-ID: <16028701.SzybLq93oN@wuerfel>
In-Reply-To: <1467616182-30886-5-git-send-email-dja@axtens.net>
References: <1467616182-30886-1-git-send-email-dja@axtens.net>
 <1467616182-30886-5-git-send-email-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday, July 4, 2016 5:09:41 PM CEST Daniel Axtens wrote:
> ---
>  arch/powerpc/Makefile | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 709a22a3e824..8617c71c3bdb 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -181,6 +181,11 @@ KBUILD_CFLAGS      += -pipe -Iarch/$(ARCH) $(CFLAGS-y)
>  CPP            = $(CC) -E $(KBUILD_CFLAGS)
>  
>  CHECKFLAGS     += -m$(CONFIG_WORD_SIZE) -D__powerpc__ -D__powerpc$(CONFIG_WORD_SIZE)__
> +ifdef CONFIG_CPU_BIG_ENDIAN
> +CHECKFLAGS     += -D__BIG_ENDIAN__
> +else
> +CHECKFLAGS     += -D__LITTLE_ENDIAN__
> +endif
>  
>  KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o

Looks good, thanks!

I've taken a short look at the other patches in the series too and found
a few minor glitches, the rest looks good to me.

	Arnd
