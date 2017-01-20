Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v4sZG5wVBzDqVJ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jan 2017 07:22:14 +1100 (AEDT)
Date: Fri, 20 Jan 2017 14:22:03 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Darren Stevens <darren@stevens-zone.net>
Cc: linuxppc-dev@lists.ozlabs.org, Pat Wall <pjwall@mac.com>, rtd@a-eon.com,
 aperez@alexperez.com, Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: [PATCH] powerpc/pasemi/nemo: Fix low memory values for boot.
Message-ID: <20170120202203.GZ30284@gate.crashing.org>
References: <49760dd82b0.759fd78a@auth.smtp.1and1.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49760dd82b0.759fd78a@auth.smtp.1and1.co.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 20, 2017 at 05:46:13PM +0000, Darren Stevens wrote:
> --- a/arch/powerpc/kernel/head_64.S
> +++ b/arch/powerpc/kernel/head_64.S
> @@ -79,6 +79,13 @@ _GLOBAL(__start)
>     /* NOP this out unconditionally */
>  BEGIN_FTR_SECTION
>     FIXUP_ENDIAN
> +#ifdef CONFIG_PPC_PASEMI_NEMO
> +   /*
> +    * Zero address 8 so Nemo will boot
> +    */
> +   li  r0,0
> +   std 0,8(0)
> +#endif

std r0,8(0)   for clarity?


Segher
