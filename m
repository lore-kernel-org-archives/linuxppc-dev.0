Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.9])
	by ozlabs.org (Postfix) with ESMTP id 48A4C1007D8
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 09:21:03 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 07/19] powerpc: gamecube/wii: declare as non-coherent
	platforms
Date: Sun, 22 Nov 2009 23:20:56 +0100
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200911222320.56871.arnd@arndb.de>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sunday 22 November 2009, Albert Herranz wrote:
>  config NOT_COHERENT_CACHE
>         bool
> -       depends on 4xx || 8xx || E200 || PPC_MPC512x
> +       depends on 4xx || 8xx || E200 || PPC_MPC512x || GAMECUBE_COMMON
>         default y
>  
>  config CHECK_CACHE_COHERENCY
> diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
> index 97a2dbc..31487e4 100644
> --- a/arch/powerpc/platforms/embedded6xx/Kconfig
> +++ b/arch/powerpc/platforms/embedded6xx/Kconfig
> @@ -93,4 +93,5 @@ config MPC10X_STORE_GATHERING
>  
>  config GAMECUBE_COMMON
>         bool
> +       select NOT_COHERENT_CACHE

One of the two (depends and select) is enough. I'd just drop the 'select'
line here.

	Arnd <><
