Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0249.outbound.messaging.microsoft.com [213.199.154.249])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A00602C0077
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Aug 2013 04:53:58 +1000 (EST)
Message-ID: <1375900904.18333.26.camel@snotra.buserror.net>
Subject: Re: [RFC PATCH 7/9] powerpc: Decode and save machine check event.
From: Scott Wood <scottwood@freescale.com>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Wed, 7 Aug 2013 13:41:44 -0500
In-Reply-To: <20130807093913.5389.80206.stgit@mars.in.ibm.com>
References: <20130807093609.5389.26534.stgit@mars.in.ibm.com>
 <20130807093913.5389.80206.stgit@mars.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 Jeremy Kerr <jeremy.kerr@au1.ibm.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-08-07 at 15:09 +0530, Mahesh J Salgaonkar wrote:
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index a1aba53..0b5b04a 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -35,7 +35,7 @@ obj-y				:= cputable.o ptrace.o syscalls.o \
>  				   misc_$(CONFIG_WORD_SIZE).o vdso32/
>  obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
>  				   signal_64.o ptrace32.o \
> -				   paca.o nvram_64.o firmware.o
> +				   paca.o nvram_64.o firmware.o mce.o

What happens when we build mce.o on book3e?

Please don't take things that are specific to certain hardware and try
to apply them to all powerpc.

For that matter, it would be nice if book3s-specific (or POWER-specific)
patches had that in the subject prefix, just as booke-specific patches
do.

-Scott
