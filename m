Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao11.cox.net (fed1rmmtao11.cox.net [68.230.241.28])
	by ozlabs.org (Postfix) with ESMTP id 684CE2BDA0
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Oct 2004 04:15:44 +1000 (EST)
Date: Fri, 15 Oct 2004 11:15:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-ID: <20041015181539.GG19791@smtp.west.cox.net>
References: <20041015160941.GA4054@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20041015160941.GA4054@logos.cnet>
Cc: "Nei A. Chiaradia" <nei.chiaradia@cyclades.com>,
	Regina Kodato <regina.kodato@cyclades.com>,
	Wanda Rosalino <wanda.rosalino@cyclades.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] PRxK sub-architecture
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

[ Switched over to linuxppc-embedded ]

On Fri, Oct 15, 2004 at 01:09:41PM -0300, Marcelo Tosatti wrote:

Just some rough comments:

[snip]
> diff -Nur --exclude-from=/tmp/exclude linux-2.6-bkppc.orig/arch/ppc/8xx_io/fec.c linux-2.6-bkppc/arch/ppc/8xx_io/fec.c
> --- linux-2.6-bkppc.orig/arch/ppc/8xx_io/fec.c	2004-09-02 08:52:19.000000000 -0300
> +++ linux-2.6-bkppc/arch/ppc/8xx_io/fec.c	2004-09-02 14:33:23.000000000 -0300
> @@ -173,7 +173,7 @@
>  	uint	phy_status;
>  	uint	phy_speed;
>  	phy_info_t	*phy;
> -	struct tq_struct phy_task;
> +	struct work_struct phy_task;
>  
>  	uint	sequence_done;
>  

This looks like a dupe of what's already in linuxppc-2.5.

[snip]
> diff -Nur --exclude-from=/tmp/exclude linux-2.6-bkppc.orig/arch/ppc/boot/simple/embed_config.c linux-2.6-bkppc/arch/ppc/boot/simple/embed_config.c
> --- linux-2.6-bkppc.orig/arch/ppc/boot/simple/embed_config.c	2004-09-02 08:52:19.000000000 -0300
> +++ linux-2.6-bkppc/arch/ppc/boot/simple/embed_config.c	2004-09-02 10:17:19.000000000 -0300

This looks like it should be done in prxk.c, with the various hooks that
we provide in misc.c, which might have to be ported to misc-embedded.c.

[snip]
> diff -Nur --exclude-from=/tmp/exclude linux-2.6-bkppc.orig/arch/ppc/boot/simple/head.S linux-2.6-bkppc/arch/ppc/boot/simple/head.S
> --- linux-2.6-bkppc.orig/arch/ppc/boot/simple/head.S	2004-09-02 08:52:19.000000000 -0300
> +++ linux-2.6-bkppc/arch/ppc/boot/simple/head.S	2004-09-02 17:30:39.000000000 -0300

Do we really need to do this?  If so, why?

[snip]
> diff -Nur --exclude-from=/tmp/exclude linux-2.6-bkppc.orig/include/asm-ppc/prxk.h linux-2.6-bkppc/include/asm-ppc/prxk.h
> --- linux-2.6-bkppc.orig/include/asm-ppc/prxk.h	1969-12-31 21:00:00.000000000 -0300
> +++ linux-2.6-bkppc/include/asm-ppc/prxk.h	2004-09-02 08:54:51.000000000 -0300
[snip]
> +/* Machine type
> +*/
> +#define _MACH_8xx (_MACH_PRxK)

Eh?  Is there more to come that moves 8xx towards what we have on
pmac/prep/chrp ?  Or a left-over from older kernels?

Thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
