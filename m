Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMz735R2WzDrL7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 02:25:03 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v72GOqLR082049
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 12:25:01 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c3e4vnkcn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 12:25:00 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 3 Aug 2017 02:23:41 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v72GNceK19529812
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Aug 2017 02:23:38 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v72GNb3c021265
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Aug 2017 02:23:38 +1000
Date: Wed, 2 Aug 2017 21:53:35 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Breno Leitao <leitao@debian.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc/xmon: Disable tracing when entering xmon
References: <1501685906-10169-1-git-send-email-leitao@debian.org>
 <1501685906-10169-2-git-send-email-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1501685906-10169-2-git-send-email-leitao@debian.org>
Message-Id: <20170802162335.q2cqo2buimzqaepw@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/08/02 11:58AM, Breno Leitao wrote:
> If tracing is enabled and you get into xmon, the tracing buffer
> continues to be updated, causing possible loss of data and unnecessary
> tracing information coming from xmon functions.
> 
> This patch simple disables tracing when entering xmon, and reenables it
> if the kernel is resumed (with 'x').
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Two minor nits...

> ---
>  arch/powerpc/xmon/xmon.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 0cbd910193fa..0b766d7780fa 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -89,6 +89,7 @@ static unsigned long nidump = 16;
>  static unsigned long ncsum = 4096;
>  static int termch;
>  static char tmpstr[128];
> +static char tracing_enabled;
	  ^^^^
	  int

> 
>  static long bus_error_jmp[JMP_BUF_LEN];
>  static int catch_memory_errors;
> @@ -462,6 +463,9 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
>  	local_irq_save(flags);
>  	hard_irq_disable();
> 
> +	tracing_enabled = tracing_is_on();
> +	tracing_off();
> +
>  	bp = in_breakpoint_table(regs->nip, &offset);
>  	if (bp != NULL) {
>  		regs->nip = bp->address + offset;
> @@ -982,6 +986,8 @@ cmds(struct pt_regs *excp)
>  			break;
>  		case 'x':
>  		case 'X':
> +			if (tracing_enabled)
> +				tracing_on();
>  			return cmd;
>  		case EOF:
>  			printf(" <no input ...>\n");
> @@ -2353,7 +2359,6 @@ static void dump_tracing(void)
>  	else
>  		ftrace_dump(DUMP_ALL);
> 
> -	tracing_on();
>  }

I'd also remove the extra blank line there.

Apart from those:
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Thanks,
Naveen
