Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9DF362C00E8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jul 2013 16:03:32 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 15 Jul 2013 11:27:55 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 2B485E0055
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jul 2013 11:33:17 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6F63LWu33095702
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jul 2013 11:33:22 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6F63MGH032374
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jul 2013 16:03:24 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Scott Wood <scottwood@freescale.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/fsl-booke: Work around erratum A-006958
In-Reply-To: <1373677412-24329-1-git-send-email-scottwood@freescale.com>
References: <1373677412-24329-1-git-send-email-scottwood@freescale.com>
Date: Mon, 15 Jul 2013 11:33:22 +0530
Message-ID: <87mwpojr6d.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> writes:



> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> index ae0aaea..7f0e2e5 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -165,6 +165,17 @@ config PPC_E500MC
>  	  such as e5500/e6500), and must be disabled for running on
>  	  e500v1 or e500v2.
>
> +config FSL_ERRATUM_A_006958
> +	bool
> +	depends on PPC_E500MC && PPC64
> +	default y
> +	help
> +	  Workaround for erratum A-006958, which says that 64-bit
> +	  timebase reads are not atomic.  The workaround is to fall back
> +	  to the 32-bit method of reading timebase.  Note that timebase
> +	  is readable by userspace, so any non-vdso userspace accesses
> +	  will need to have the workaround applied separately.
> +
>  config PPC_FPU
>  	bool
>  	default y if PPC64


I am completely new to this area, so ignore if it is silly. But how do
we expect to select this config ? Should that happen via .config ?
That seems strange, because without this change some of the configs
will surely be broken/buggy right ?. I was expecting it not be a config
entry, primarily because I haven't seem something similar on other
archs. And if there is an erratum against a cpu release, we should by
default apply this when we know we are running on those cpus right ?
Which implies this should not be a config option ?

-aneesh
