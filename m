Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXTFL26n3zDrJy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 22:29:58 +1000 (AEST)
In-Reply-To: <1502710943-22738-1-git-send-email-anju@linux.vnet.ibm.com>
To: Anju T <anju@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: hemant@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: Fix for supporting nest events on muti socket system
Message-Id: <3xXTFL0DTRz9t5V@ozlabs.org>
Date: Wed, 16 Aug 2017 22:29:57 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-08-14 at 11:42:23 UTC, Anju T wrote:
> In a multi node system with discontinuous node id, nest event values
> are not showing up properly.That is,
> 
> snip from lscpu output:
> 
> ..
> NUMA node0 CPU(s): 0-15
> NUMA node8 CPU(s): 16-31
> ..
> 
> Nest event values on such systems are broken:
> 
> $./perf stat -e 'nest_powerbus0_imc/PM_PB_CYC/' -C 0-14 -I 1000 sleep 1000
> #           time             counts unit events
>      1.000294577    30,17,24,42,880 nest_powerbus0_imc/PM_PB_CYC/
>      2.000528938    29,92,08,53,760 nest_powerbus0_imc/PM_PB_CYC/
>      3.000713925    29,92,08,00,000 nest_powerbus0_imc/PM_PB_CYC/
>      4.000901944    29,95,08,63,360 nest_powerbus0_imc/PM_PB_CYC/
>      5.001089119    29,92,07,92,320 nest_powerbus0_imc/PM_PB_CYC/
>      6.001276106    29,92,08,11,520 nest_powerbus0_imc/PM_PB_CYC/
> 
> $./perf stat -e 'nest_powerbus0_imc/PM_PB_CYC/' -C 16-28 -I 1000 sleep 1000
> #           time             counts unit events
>      1.000049902    <not supported> nest_powerbus0_imc/PM_PB_CYC/
>      2.000147269    <not supported> nest_powerbus0_imc/PM_PB_CYC/
>      3.000219730    <not supported> nest_powerbus0_imc/PM_PB_CYC/
>      4.000288098    <not supported> nest_powerbus0_imc/PM_PB_CYC/
>      5.000358716    <not supported> nest_powerbus0_imc/PM_PB_CYC/
>      6.000435615    <not supported> nest_powerbus0_imc/PM_PB_CYC/
>      7.000508481    <not supported> nest_powerbus0_imc/PM_PB_CYC/
> 
> This is because, when fetching for the reference count, node id is used
> as the array index which is not how this is done when initializing the
> structure. Patch to fix the same by using the right index to get the
> nest_imc_refc.
> 
> $./perf stat -e 'nest_powerbus0_imc/PM_PB_CYC/' -C 16-28 -I 1000 sleep 1000
> #           time             counts unit events
>      1.000241961    26,12,35,28,704 nest_powerbus0_imc/PM_PB_CYC/
>      2.000451678    25,95,72,48,512 nest_powerbus0_imc/PM_PB_CYC/
>      3.000634963    25,93,13,96,608 nest_powerbus0_imc/PM_PB_CYC/
>      4.000821186    25,95,74,38,208 nest_powerbus0_imc/PM_PB_CYC/
>      5.001005221    25,93,13,30,048 nest_powerbus0_imc/PM_PB_CYC/ 
> 
> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7efbae90892b7858f1d4873d34ffff

cheers
