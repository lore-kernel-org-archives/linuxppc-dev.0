Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D24291A05A9
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Jun 2014 16:18:11 +1000 (EST)
Message-ID: <1401603491.13479.11.camel@ale.ozlabs.ibm.com>
Subject: Re: [PATCH] powerpc, xmon: Enable hardware instruction breakpoint
 support on POWER8
From: Michael Neuling <mikey@neuling.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Sun, 01 Jun 2014 16:18:11 +1000
In-Reply-To: <1401451823-25547-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1401451823-25547-1-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-05-30 at 17:40 +0530, Anshuman Khandual wrote:
> This patch enables support for hardware instruction breakpoints on POWER8=
 with
> the help of a new register called CIABR (Completed Instruction Address Br=
eakpoint
> Register). With this patch, single hardware instruction breakpoint can be=
 added
> and cleared during any active xmon debug session. This hardware based ins=
truction
> breakpoint mechanism works correctly along with the existing TRAP based i=
nstruction
> breakpoints available on xmon. Example usage as follows.

Have you actually tried this on a guest?

Please also compile with a range of configs.  It doesn't compile with
ppc64e_defconfig.

In file included from /scratch/mikey/src/linux-ozlabs/arch/powerpc/xmon/xmo=
n.c:51:0:
/scratch/mikey/src/linux-ozlabs/arch/powerpc/include/asm/plpar_wrappers.h: =
In function 'get_cede_latency_hint':
/scratch/mikey/src/linux-ozlabs/arch/powerpc/include/asm/plpar_wrappers.h:2=
6:9: error: 'struct paca_struct' has no member named 'lppaca_ptr'
/scratch/mikey/src/linux-ozlabs/arch/powerpc/include/asm/plpar_wrappers.h: =
In function 'set_cede_latency_hint':
/scratch/mikey/src/linux-ozlabs/arch/powerpc/include/asm/plpar_wrappers.h:3=
1:2: error: 'struct paca_struct' has no member named 'lppaca_ptr'
/scratch/mikey/src/linux-ozlabs/arch/powerpc/include/asm/plpar_wrappers.h: =
In function 'plpar_page_set_loaned':
/scratch/mikey/src/linux-ozlabs/arch/powerpc/include/asm/plpar_wrappers.h:9=
8:2: error: implicit declaration of function 'cmo_get_page_size' [-Werror=
=3Dimplicit-function-declaration]
cc1: all warnings being treated as errors

> -				    (bp->enabled & BP_IABR)? "inst": "trap");
> +					(bp->enabled & (BP_IABR | BP_CIABR))?
> +				       				"inst": "trap");

Git complains about whitespace issues here.  Spaces before tabs.

Mikey
