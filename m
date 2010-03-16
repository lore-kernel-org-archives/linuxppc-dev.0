Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 388C9B7D24
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Mar 2010 08:19:41 +1100 (EST)
Subject: Re: [PATCH 2/4] 8xx: Avoid testing for kernel space in ITLB Miss.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
In-Reply-To: <1267172983-28721-3-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1267172983-28721-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1267172983-28721-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1267172983-28721-3-git-send-email-Joakim.Tjernlund@transmode.se>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 17 Mar 2010 08:19:36 +1100
Message-ID: <1268774376.2335.130.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-02-26 at 09:29 +0100, Joakim Tjernlund wrote:
> +#ifdef CONFIG_MODULES
> +       /* Only modules will cause ITLB Misses as we always
> +        * pin the first 8MB of kernel memory */
>         andi.   r11, r10, 0x0800        /* Address >= 0x80000000 */
>         beq     3f
>         lis     r11, swapper_pg_dir@h
>         ori     r11, r11, swapper_pg_dir@l
>         rlwimi  r10, r11, 0, 2, 19
>  3:
> +#endif

You can optimize that further I think...

You can probably just remove the code above, and add something to
do_page_fault() that lazily copies the kernel PGD entries from
swapper_pg_dir to the app pgdir. (You can even pre-fill that when
creating a new mm).

Cheers,
Ben.
