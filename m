Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 681D2B6F14
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 Aug 2010 12:07:56 +1000 (EST)
Subject: Re: [PATCH 2/2] rwsem: Move powerpc atomic-long based
	implementation to asm-generic
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20100820064348.GA19989@merkur.ravnborg.org>
References: <1282107803.22370.173.camel@pasglop>
	<20100817.222818.193699062.davem@davemloft.net>
	<1282195403.22370.296.camel@pasglop>
	<20100818.222925.233689776.davem@davemloft.net>
	<1282281295.22370.401.camel@pasglop>
	<20100820064348.GA19989@merkur.ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 24 Aug 2010 11:32:05 +1000
Message-ID: <1282613525.22370.486.camel@pasglop>
Mime-Version: 1.0
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

On Fri, 2010-08-20 at 08:43 +0200, Sam Ravnborg wrote:
> > diff --git a/include/asm-generic/rwsem-cmpxchg.h b/include/asm-generic/rwsem-cmpxchg.h
> > new file mode 100644
> > index 0000000..2b1c859
> > --- /dev/null
> > +++ b/include/asm-generic/rwsem-cmpxchg.h
> > @@ -0,0 +1,183 @@
> > +#ifndef _RWSEM_CMPXCHG_H
> > +#define _RWSEM_CMPXCHG_H
> > +
> > +#ifndef _LINUX_RWSEM_H
> > +#error "Please don't include <asm/rwsem.h> directly, use <linux/rwsem.h> instead."
> > +#endif
> > +
> > +#ifdef __KERNEL__
> 
> #ifdef __KERNEL__ is only relevant for exported headers.
> For kernel only headers like this is does not make sense,
> but it does not harm.

Well, it was there in the first place, I think we've carried around
forever, but as you say, it doesn't really harm.

Ben.
