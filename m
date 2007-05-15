Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E528BDDEDC
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 17:36:04 +1000 (EST)
Subject: Re: [PATCH v2] pcmcia: ppc64 needs 32-bit ioaddr_t
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070515043343.GA6561@lixom.net>
References: <20070512143105.GA12890@lixom.net>
	<20070515043343.GA6561@lixom.net>
Content-Type: text/plain
Date: Tue, 15 May 2007 17:35:05 +1000
Message-Id: <1179214505.32247.172.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-pcmcia@lists.infradead.org, paulus@samba.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-05-14 at 23:33 -0500, Olof Johansson wrote:
> ppc64 really needs ioaddr_t to be 32-bit, since I/O beyond the
> first PCI bus might be mapped at a higher range.
> 
> While the type is exported to userspace, there hasn't been any platforms
> with PCMCIA on 64-bit powerpc until now, so changing it won't regress
> any existing users. Besides, those interfaces are overdue for removal
> already.
> 
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> Index: 2.6.21/include/pcmcia/cs_types.h
> ===================================================================
> --- 2.6.21.orig/include/pcmcia/cs_types.h
> +++ 2.6.21/include/pcmcia/cs_types.h
> @@ -21,7 +21,7 @@
>  #include <sys/types.h>
>  #endif
>  
> -#if defined(__arm__) || defined(__mips__)
> +#if defined(__arm__) || defined(__mips__) || defined(__powerpc64__)
>  /* This (ioaddr_t) is exposed to userspace & hence cannot be changed. */
>  typedef u_int   ioaddr_t;
>  #else
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
