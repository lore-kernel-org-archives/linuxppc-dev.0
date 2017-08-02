Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMz3V56bKzDqmV
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 02:21:58 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v72GLYH6052680
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 12:21:56 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c3eksumr6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 12:21:56 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 3 Aug 2017 02:21:54 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v72GLotn30998780
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Aug 2017 02:21:50 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v72GLf1J002919
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Aug 2017 02:21:41 +1000
Date: Wed, 2 Aug 2017 21:51:47 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Breno Leitao <leitao@debian.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc/xmon: Dump ftrace buffers for the current CPU
References: <1501685906-10169-1-git-send-email-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1501685906-10169-1-git-send-email-leitao@debian.org>
Message-Id: <20170802162147.uwhevlxxl7c5rldr@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/08/02 11:58AM, Breno Leitao wrote:
> Current xmon 'dt' command dumps the tracing buffer for all the CPUs,
> which makes it very hard to read due to the fact that most of
> powerpc machines currently have many CPUs. Other than that, the CPU
> lines are interleaved in the ftrace log.
> 
> This new option just dumps the ftrace buffer for the current CPU.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

LGTM.
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>


> ---
>  arch/powerpc/xmon/xmon.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 08e367e3e8c3..0cbd910193fa 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -234,6 +234,7 @@ Commands:\n\
>    "\
>    dr	dump stream of raw bytes\n\
>    dt	dump the tracing buffers (uses printk)\n\
> +  dtc	dump the tracing buffers for current CPU (uses printk)\n\
>  "
>  #ifdef CONFIG_PPC_POWERNV
>  "  dx#   dump xive on CPU #\n\
> @@ -2342,6 +2343,19 @@ static void dump_one_paca(int cpu)
>  	sync();
>  }
> 
> +static void dump_tracing(void)
> +{
> +	int c;
> +
> +	c = inchar();
> +	if (c == 'c')
> +		ftrace_dump(DUMP_ORIG);
> +	else
> +		ftrace_dump(DUMP_ALL);
> +
> +	tracing_on();
> +}
> +
>  static void dump_all_pacas(void)
>  {
>  	int cpu;
> @@ -2507,6 +2521,11 @@ dump(void)
>  	}
>  #endif
> 
> +	if (c == 't') {
> +		dump_tracing();
> +		return;
> +	}
> +
>  	if (c == '\n')
>  		termch = c;
> 
> @@ -2525,9 +2544,6 @@ dump(void)
>  		dump_log_buf();
>  	} else if (c == 'o') {
>  		dump_opal_msglog();
> -	} else if (c == 't') {
> -		ftrace_dump(DUMP_ALL);
> -		tracing_on();
>  	} else if (c == 'r') {
>  		scanhex(&ndump);
>  		if (ndump == 0)
> -- 
> 2.13.2
> 
