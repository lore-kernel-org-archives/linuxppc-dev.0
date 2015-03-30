Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 71E971A0079
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 21:58:04 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BE1CC1400A0
 for <linuxppc-dev@ozlabs.org>; Mon, 30 Mar 2015 21:58:03 +1100 (AEDT)
Message-ID: <1427713068.20500.79.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Export __spin_yield
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 30 Mar 2015 21:57:48 +1100
In-Reply-To: <CAMuHMdVX450vQpYzZX+QGTY9ZUfaTuHZaNgizmuCd0HiaUc=_w@mail.gmail.com>
References: <54EE5989.7010800@linux.vnet.ibm.com>
 <20150319230848.GB31148@iris.ozlabs.ibm.com>
 <CAMuHMdVX450vQpYzZX+QGTY9ZUfaTuHZaNgizmuCd0HiaUc=_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "Suresh E. Warrier" <warrier@linux.vnet.ibm.com>,
 Linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-03-30 at 12:17 +0200, Geert Uytterhoeven wrote:
> Hi Ben,
> 
> On Fri, Mar 20, 2015 at 12:08 AM, Paul Mackerras <paulus@samba.org> wrote:
> > On Wed, Feb 25, 2015 at 05:23:53PM -0600, Suresh E. Warrier wrote:
> >> Export __spin_yield so that the arch_spin_unlock() function can
> >> be invoked from a module. This will be required for modules where
> >> we want to take a lock that is also is acquired in hypervisor
> >> real mode. Because we want to avoid running any lockdep code
> >> (which may not be safe in real mode), this lock needs to be
> >> an arch_spinlock_t instead of a normal spinlock.
> >>
> >> Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
> >
> > Acked-by: Paul Mackerras <paulus@samba.org>
> 
> Something went wrong when applying this, as it ended up as:

Ugh, weird. I must have fucked up something when rebasing. I don't
want to rebase that branch now that it's out, I know of at least one
series based on it. We'll live with it.

> commit 1f8c82ab1b0bc7e24601c0fca411fd27b9c883ef
> Author: Geert Uytterhoeven <geert+renesas@glider.be>
> Date:   Wed Mar 4 12:56:20 2015 +0100
> 
>     cpufreq/ppc: Add missing #include <asm/smp.h>
> 
>     If CONFIG_SMP=n, <linux/smp.h> does not include <asm/smp.h>, causing:
> 
>     drivers/cpufreq/ppc-corenet-cpufreq.c: In function 'corenet_cpufreq_cpu_init
>     drivers/cpufreq/ppc-corenet-cpufreq.c:173:3: error: implicit declaration of
>     X-Patchwork-Id: 443703
>     Message-Id: <54EE5989.7010800@linux.vnet.ibm.com>
>     To: linuxppc-dev@ozlabs.org
>     Date: Wed, 25 Feb 2015 17:23:53 -0600
> 
>     Export __spin_yield so that the arch_spin_unlock() function can
>     be invoked from a module. This will be required for modules where
>     we want to take a lock that is also is acquired in hypervisor
>     real mode. Because we want to avoid running any lockdep code
>     (which may not be safe in real mode), this lock needs to be
>     an arch_spinlock_t instead of a normal spinlock.
> 
>     Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
>     Acked-by: Paul Mackerras <paulus@samba.org>
>     Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
