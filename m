Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 342BDB6F85
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Sep 2011 17:05:03 +1000 (EST)
Subject: Re: [PATCH REPOST] perf event, POWER 6: L1 cache read and write
	access event code fix]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Carl E. Love" <cel@linux.vnet.ibm.com>
In-Reply-To: <1317245013.5461.11.camel@oc5652146517.ibm.com>
References: <1317245013.5461.11.camel@oc5652146517.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 29 Sep 2011 17:04:52 +1000
Message-ID: <1317279892.29415.182.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <bherren@au1.ibm.com>,
	Paul Mackerras <pmac@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-09-28 at 14:23 -0700, Carl E. Love wrote:
> Ben, Paul:
>  
> I posted this patch to lkml but did not copy the linuxppc-dev@ozlabs.org
> mailing list.  

Patch is also completely damaged. I'm fixing it up myself this time
around but by now you should know how to send patches correctly :-(

Ben.

>                    Carl Love
> ---------------------------------------------------------------------
> 
> The current L1 cache read event code 0x80082 only counts for thread 0. The
> event code 0x280030 should be used to count events on thread 0 and 1. The
> patch fixes the event code for the L1 cache read.
> 
> The current L1 cache write event code 0x80086 only counts for thread 0. The
> event code 0x180032 should be used to count events on thread 0 and 1. The
> patch fixes the event code for the L1 cache write.
> 
> FYI, the documentation lists three event codes for the L1 cache read event
> and three event codes for the L1 cache write event.  The event description
> for the event codes is as follows:
> 
> L1 cache read requests  0x80082  LSU 0 only
> L1 cache read requests  0x8008A  LSU 1 only
> L1 cache read requests  0x80030  LSU 1 or LSU 0, counter 2 only.
> 
> L1 cache store requests 0x80086  LSU 0 only
> L1 cache store requests 0x8008E  LSU 1 only
> L1 cache store requests 0x80032  LSU 0 or LSU 1, counter 1 only.
> 
> There can only be one request from either LSU 0 or 1 active at a time.
> 
> Signed-off-by: Carl Love <cel@us.ibm.com>
> ---
>  arch/powerpc/kernel/power6-pmu.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/power6-pmu.c b/arch/powerpc/kernel/power6-pmu.c
> index 03b95e2..0bbc901 100644
> --- a/arch/powerpc/kernel/power6-pmu.c
> +++ b/arch/powerpc/kernel/power6-pmu.c
> @@ -487,8 +487,8 @@ static int power6_generic_events[] = {
>   */
>  static int power6_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
>         [C(L1D)] = {            /*      RESULT_ACCESS   RESULT_MISS */
> -               [C(OP_READ)] = {        0x80082,        0x80080         },
> -               [C(OP_WRITE)] = {       0x80086,        0x80088         },
> +               [C(OP_READ)] = {        0x280030,       0x80080         },
> +               [C(OP_WRITE)] = {       0x180032,       0x80088         },
>                 [C(OP_PREFETCH)] = {    0x810a4,        0               },
>         },
>         [C(L1I)] = {            /*      RESULT_ACCESS   RESULT_MISS */
> 
> 
