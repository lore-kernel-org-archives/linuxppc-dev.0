Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D79CD1A2E1C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 17:55:40 +1000 (AEST)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 859FA140291
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2015 17:55:40 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 12 Aug 2015 17:55:39 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C6EAF3578057
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2015 17:55:36 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7C7tM0b65404984
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2015 17:55:31 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7C7t3nT026640
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2015 17:55:03 +1000
Message-ID: <55CAFBC6.8060700@linux.vnet.ibm.com>
Date: Wed, 12 Aug 2015 13:24:46 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/xmon: Allow limiting the size of the paca display
References: <1439362653-14665-1-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1439362653-14665-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/12/2015 12:27 PM, Michael Ellerman wrote:
> The paca display is already more than 24 lines, which can be problematic
> if you have an old school 80x24 terminal, or more likely you are on a
> virtual terminal which does not scroll for whatever reason.
> 
> We'd like to expand the paca display even more, so add a way to limit
> the number of lines that are displayed.
> 
> This adds a third form of 'dp' which is 'dp # #', where the first number
> is the cpu, and the second is the number of lines to display.
> 
> Example output:
> 
>   5:mon> dp 3 6
>   paca for cpu 0x3 @ c00000000fdc0d80:
>    possible         = yes
>    present          = yes
>    online           = yes
>    lock_token       = 0x8000            	(0xa)
>    paca_index       = 0x3               	(0x8)
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/xmon/xmon.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index e599259d84fc..6f44e9c07f34 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -205,6 +205,7 @@ Commands:\n\
>  #ifdef CONFIG_PPC64
>    "\
>    dp[#]	dump paca for current cpu, or cpu #\n\
> +  dp##  dump paca for cpu #, only # lines\n\
>    dpa	dump paca for all possible cpus\n"
>  #endif
>    "\
> @@ -2070,9 +2071,10 @@ static void xmon_rawdump (unsigned long adrs, long ndump)
>  }
>  
>  #ifdef CONFIG_PPC64
> -static void dump_one_paca(int cpu)
> +static void dump_one_paca(int cpu, int num_lines)
>  {
>  	struct paca_struct *p;
> +	int i;
>  
>  	if (setjmp(bus_error_jmp) != 0) {
>  		printf("*** Error dumping paca for cpu 0x%x!\n", cpu);
> @@ -2090,9 +2092,12 @@ static void dump_one_paca(int cpu)
>  	printf(" %-*s = %s\n", 16, "present", cpu_present(cpu) ? "yes" : "no");
>  	printf(" %-*s = %s\n", 16, "online", cpu_online(cpu) ? "yes" : "no");
>  
> +	i = 4; /* We always print the first four lines */
> +
>  #define DUMP(paca, name, format) \
> -	printf(" %-*s = %#-*"format"\t(0x%lx)\n", 16, #name, 18, paca->name, \
> -		offsetof(struct paca_struct, name));
> +	if (!num_lines || i++ < num_lines)

All look good except the fact that we are using 0 to signify that
there is no limit to the number of lines. Is not it bit confusing ?
