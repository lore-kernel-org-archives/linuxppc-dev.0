Return-Path: <sam@ravnborg.org>
Received: from pasmtpB.tele.dk (pasmtpb.tele.dk [80.160.77.98])
	by ozlabs.org (Postfix) with ESMTP id DDAF6DDF0A
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 19:57:30 +1100 (EST)
Date: Wed, 13 Feb 2008 09:57:35 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: David Miller <davem@davemloft.net>
Subject: Re: [GIT]: Make LMB code sharable with sparc64.
Message-ID: <20080213085735.GB8091@uranus.ravnborg.org>
References: <20080213.004120.22092044.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080213.004120.22092044.davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 13, 2008 at 12:41:20AM -0800, David Miller wrote:
> 
> As I mentioned to a few ppc folks at LCA08 I plan to use
> the LMB code from powerpc as a basis for NUMA support on
> sparc64.
> 
> There are two changes.
> 
> 1) Move arch/powerpc/mm/lmb.c to lib/lmb.c, put the main
>    interface bits in include/linux/lmb.h, put arch-specific
>    bits in asm/lmb.h and add Kconfig machinery to build this
>    stuff on sparc64.
> 
> 2) Fix a bug in lmb_alloc() wherein the size was not aligned
>    so we could easily run out of reserve blocks because
>    every aligned allocation would create a tiny hole, and
>    secondly the lmb_reserve() call there did not have it's
>    return value checked.
> 
> Powerpc folks, if there are no objections please pull, thanks!
> 
> The following changes since commit 96b5a46e2a72dc1829370c87053e0cd558d58bc0:
>   Linus Torvalds (1):
>         WMI: initialize wmi_blocks.list even if ACPI is disabled
> 
> are available in the git repository at:
> 
>   master.kernel.org:/pub/scm/linux/kernel/git/davem/lmb-2.6.git master

Review had been easier if the patch was inlined.
Took a quick look at the small Kconfig bits.

>From arch/sparc64/Kconfig:
+config LMB
+       def_bool y
+

Can we plase have this changed to use:

 config SPARC64
+	select HAVE_LMB

And then in lib/Kconfig have
+config HAVE_LMB
+	bool

So we avoid creating a new variable each time we introdce LMB support.
You would need to update powerpc Kconfig too of course.

This way of doing it is documented in:
Documenation/kbuild/kconfig.language.txt

Thanks,
	Sam
