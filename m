Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao09.cox.net (fed1rmmtao09.cox.net [68.230.241.30])
	by ozlabs.org (Postfix) with ESMTP id 9F40567AC7
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Feb 2005 04:34:52 +1100 (EST)
Date: Wed, 9 Feb 2005 10:34:50 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Mikael Pettersson <mikpe@user.it.uu.se>
Message-ID: <20050209173450.GA3226@smtp.west.cox.net>
References: <16906.12395.517982.168072@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <16906.12395.517982.168072@alkaid.it.uu.se>
Cc: paulus@samba.org, linux-kerne@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH][2.6.11-rc3] gcc-4.0 fixes for ppc32
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 09, 2005 at 04:46:51PM +0100, Mikael Pettersson wrote:
> These patches are needed to allow me to build a working
> 2.6.11-rc3 kernel for ppc32 with gcc-4.0 (20050130 snapshot):
> 
> - The static time_offset in arch/ppc/kernel/time.c triggers a
>   declaration conflict with the non-static one in include/linux/timex.h.
>   Solution: s/time_offset/ppc_time_offset/g in ppc's time.c.
> - OpenPIC is declared extern in open_pic_defs.h but static in
>   open_pic.c. Solution: remove the extern decl.
> - prom_display_paths[] and prom_num_displays are declared extern in
>   include/asm-ppc/prom.h but static in arch/ppc/syslib/prom_init.c.
>   Solution: remove the extern decls.
> - The 'const' on __USE_RTC() in include/asm-ppc/time.h triggers
>   compiler warnings. Change it to use compiler.h's __attribute_const__.
>   (This mirrors changes that have already been made in e.g. byteorder.h.)
> 
> Tested on an eMac. No breakage observed.
> 
> Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

This all looks fine to me, will send once 2.6.12-rc1 opens.

-- 
Tom Rini
http://gate.crashing.org/~trini/
