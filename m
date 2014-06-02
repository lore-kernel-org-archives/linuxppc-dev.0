Return-Path: <Laurentiu.Tudor@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0207.outbound.protection.outlook.com [207.46.163.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 33E201A0055
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jun 2014 22:48:43 +1000 (EST)
Message-ID: <538C7297.4040307@freescale.com>
Date: Mon, 2 Jun 2014 15:48:23 +0300
From: Tudor Laurentiu <b10716@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2] powerpc/booke64: wrap tlb lock and search in htw miss
 with FTR_SMT
References: <1401489946-12935-1-git-send-email-scottwood@freescale.com>
In-Reply-To: <1401489946-12935-1-git-send-email-scottwood@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/31/2014 01:45 AM, Scott Wood wrote:
> From: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
>
> Virtualized environments may expose a e6500 dual-threaded core
> as two single-threaded e6500 cores. Take advantage of this
> and get rid of the tlb lock and the trap-causing tlbsx in
> the htw miss handler by guarding with CPU_FTR_SMT, as it's
> already being done in the bolted tlb1 miss handler.
>
> As seen in the results below, measurements done with lmbench
> random memory access latency test running under Freescale's
> Embedded Hypervisor, there is a ~34% improvement.
>
> Memory latencies in nanoseconds - smaller is better
>      (WARNING - may not be correct, check graphs)
> ----------------------------------------------------
> Host       Mhz   L1 $   L2 $    Main mem    Rand mem
> ---------  ---   ----   ----    --------    --------
> smt       1665 1.8020   13.2    83.0         1149.7
> nosmt     1665 1.8020   13.2    83.0          758.1
>
> Signed-off-by: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
> Cc: Scott Wood <scottwood@freescale.com>
> [scottwood@freescale.com: commit message tweak]
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> v2:
>   - s/expose/may expose/ in commit message
>   - rebased onto my patch queue to resolve conflict

Thanks!

>   - resent since the original didn't make it to the list archives
>     or patchwork.

The only thing i can think of is that maybe i've misspelled the mailing 
list address ...

---
Best Regards, Laurentiu
