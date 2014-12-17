Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B5B091A04D4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Dec 2014 11:03:27 +1100 (AEDT)
Message-ID: <1418774597.17248.1.camel@ellerman.id.au>
Subject: Re: [PATCH v2 1/3] powerpc/nvram: move generic code for nvram and
 pstore
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Wed, 17 Dec 2014 11:03:17 +1100
In-Reply-To: <20141216180530.7778.23702.stgit@localhost.localdomain>
References: <20141216180442.7778.38272.stgit@localhost.localdomain>
 <20141216180530.7778.23702.stgit@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-12-16 at 23:35 +0530, Hari Bathini wrote:
> With minor checks, we can move most of the code for nvram
> under pseries to a common place to be re-used by other
> powerpc platforms like powernv. This patch moves such
> common code to arch/powerpc/kernel/nvram_64.c file.

Sharing the code is great.

But, you need to keep in mind that it is very common for us to build kernels
with both POWERNV=y and PSERIES=y.

So you need to make sure you're only using CONFIG_PPC_PSERIES to protect things
that are optional on pseries. Not things that we *shouldn't* be doing on
powernv.

For example the logic in nvram_init_oops_partition() looks like it might do the
wrong thing for PSERIES=y POWERNV=y.

> diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
> index b390f55..a033fe9 100644
> --- a/arch/powerpc/include/asm/rtas.h
> +++ b/arch/powerpc/include/asm/rtas.h
> @@ -343,6 +343,8 @@ extern int early_init_dt_scan_rtas(unsigned long node,
>  extern void pSeries_log_error(char *buf, unsigned int err_type, int fatal);
>  
>  #ifdef CONFIG_PPC_PSERIES
> +extern unsigned long last_rtas_event;
> +extern int clobbering_unread_rtas_event(void);

You should add an empty version of this for !PSERIES, so you don't have to
ifdef all the call sites.

cheers
