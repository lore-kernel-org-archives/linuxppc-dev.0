Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3F8011A0075
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2015 12:26:45 +1000 (AEST)
Message-ID: <1441765604.7854.6.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Kconfig: remove BE-only platforms from LE
 kernel build
From: Michael Ellerman <mpe@ellerman.id.au>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Arnd
 Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Olof
 Johansson <olof@lixom.net>, Geoff Levand <geoff@infradead.org>
Date: Wed, 09 Sep 2015 12:26:44 +1000
In-Reply-To: <1441583880-17824-1-git-send-email-boqun.feng@gmail.com>
References: <1441583880-17824-1-git-send-email-boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-09-07 at 07:58 +0800, Boqun Feng wrote:
> diff --git a/arch/powerpc/platforms/cell/Kconfig b/arch/powerpc/platforms/cell/Kconfig
> index 2f23133..808a904 100644
> --- a/arch/powerpc/platforms/cell/Kconfig
> +++ b/arch/powerpc/platforms/cell/Kconfig
> @@ -25,7 +25,7 @@ config PPC_CELL_NATIVE
>  
>  config PPC_IBM_CELL_BLADE
>  	bool "IBM Cell Blade"
> -	depends on PPC64 && PPC_BOOK3S
> +	depends on PPC64 && PPC_BOOK3S && CPU_BIG_ENDIAN

We end up saying this five times.

We already have PPC_BOOK3S_64 which captures the first two conditions, should
we add a PPC_BOOK3S_64_BE which expresses it all?

cheers
