Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B3C292C00BE
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2012 18:20:37 +1100 (EST)
Message-ID: <1354692031.2351.4.camel@pasglop>
Subject: Re: [PATCH 1/3] powerpc: Relocate prom_init.c on 64bit
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
Date: Wed, 05 Dec 2012 18:20:31 +1100
In-Reply-To: <20121205110723.68839261@kryten>
References: <20121127143903.4b5cab17@kryten>
 <1353993743.2179.28.camel@pasglop> <20121205110723.68839261@kryten>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, amodra@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-12-05 at 11:07 +1100, Anton Blanchard wrote:
> Hi Ben,
> 
> > My only potential objection was that it might have been cleaner to
> > actually build prom_init.c as a separate binary alltogether and piggy
> > back it...
> 
> Yeah, I went through a number of options before settling on this one.

Heh, yeah, that what happens when nothing is fully satisfactory...

 .../...

> Build prom_init.c 32 bit, tack it onto the end of the vmlinux and
> add a trampoline at the start of the vmlinux.
> 
> This means a vmlinux will be bootable and profiling tools will work
> against it. Even so it feels gross to me.

It does, might be less gross to have prom_init.c be .incbin'ed in
vmlinux like the vdso is ... better than tacking it at the end. Still
makes it annoying to debug crashes in prom_init itself.

I'll review your patch when I get a chance as the "least bad"
solution :-)

Cheers,
Ben.
