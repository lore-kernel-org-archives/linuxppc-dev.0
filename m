Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 289ACB6FA7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 09:05:08 +1000 (EST)
Message-ID: <4FEA4013.5030003@freescale.com>
Date: Tue, 26 Jun 2012 18:04:51 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 4/4] powerpc/perf: Use perf_instruction_pointer in
 callchains
References: <20120626210013.2fbb9044@kryten> <20120626210420.4e5e7e78@kryten>
In-Reply-To: <20120626210420.4e5e7e78@kryten>
Content-Type: text/plain; charset="UTF-8"
Cc: sukadev@linux.vnet.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/26/2012 06:04 AM, Anton Blanchard wrote:
> 
> We use SIAR or regs->nip for the instruction pointer depending on
> the PMU configuration, but we always use regs->nip in the callchain.
> 
> Use perf_instruction_pointer so the backtrace is consistent.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
> 
> Index: linux-build/arch/powerpc/perf/callchain.c
> ===================================================================
> --- linux-build.orig/arch/powerpc/perf/callchain.c	2012-04-12 11:36:26.236223786 +1000
> +++ linux-build/arch/powerpc/perf/callchain.c	2012-06-26 12:49:28.944202712 +1000
> @@ -57,7 +57,7 @@ perf_callchain_kernel(struct perf_callch
>  
>  	lr = regs->link;
>  	sp = regs->gpr[1];
> -	perf_callchain_store(entry, regs->nip);
> +	perf_callchain_store(entry, perf_instruction_pointer(regs));

Won't this break core-fsl-emb, which doesn't define
perf_instruction_pointer()?

-Scott
