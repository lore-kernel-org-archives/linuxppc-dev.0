Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0141.outbound.protection.outlook.com [207.46.163.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6C7621A06F9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 May 2014 06:56:16 +1000 (EST)
Message-ID: <1401483364.6603.212.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc/booke64: wrap tlb lock and search in htw miss
 with FTR_SMT
From: Scott Wood <scottwood@freescale.com>
To: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
Date: Fri, 30 May 2014 15:56:04 -0500
In-Reply-To: <1401461955-18007-1-git-send-email-Laurentiu.Tudor@freescale.com>
References: <1401461955-18007-1-git-send-email-Laurentiu.Tudor@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-05-30 at 17:59 +0300, Laurentiu Tudor wrote:
> Virtualized environments expose a e6500 dual-threaded core
> as two single-threaded e6500 cores.

s/expose/may expose/

I'll fix when applying.

>  Take advantage of this and get rid of the tlb lock and the trap-causing tlbsx in
> the htw miss handler by guarding with CPU_FTR_SMT, as it's
> already being done in the bolted tlb1 miss handler.

It's also possible that some non-virtualized workloads may also benefit
from getting rid of the lock more than they benefit from enabling SMT
(or perform better without SMT for other reasons).

-Scott
