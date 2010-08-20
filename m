Return-Path: <sam@ravnborg.org>
Received: from pfepa.post.tele.dk (pfepa.post.tele.dk [195.41.46.235])
	by ozlabs.org (Postfix) with ESMTP id BD4A8B70E1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 Aug 2010 16:43:54 +1000 (EST)
Date: Fri, 20 Aug 2010 08:43:48 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] rwsem: Move powerpc atomic-long based
	implementation to asm-generic
Message-ID: <20100820064348.GA19989@merkur.ravnborg.org>
References: <1282107803.22370.173.camel@pasglop>
	<20100817.222818.193699062.davem@davemloft.net>
	<1282195403.22370.296.camel@pasglop>
	<20100818.222925.233689776.davem@davemloft.net>
	<1282281295.22370.401.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1282281295.22370.401.camel@pasglop>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, paulus@au.ibm.com,
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
	akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> diff --git a/include/asm-generic/rwsem-cmpxchg.h b/include/asm-generic/rwsem-cmpxchg.h
> new file mode 100644
> index 0000000..2b1c859
> --- /dev/null
> +++ b/include/asm-generic/rwsem-cmpxchg.h
> @@ -0,0 +1,183 @@
> +#ifndef _RWSEM_CMPXCHG_H
> +#define _RWSEM_CMPXCHG_H
> +
> +#ifndef _LINUX_RWSEM_H
> +#error "Please don't include <asm/rwsem.h> directly, use <linux/rwsem.h> instead."
> +#endif
> +
> +#ifdef __KERNEL__

#ifdef __KERNEL__ is only relevant for exported headers.
For kernel only headers like this is does not make sense,
but it does not harm.

	Sam
