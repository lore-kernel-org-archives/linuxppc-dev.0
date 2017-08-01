Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xM6DY14gQzDqhm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Aug 2017 16:41:48 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v716cpms014081
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Aug 2017 02:41:46 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c2mhgr4p7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Aug 2017 02:41:46 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 1 Aug 2017 16:41:43 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v716eQip21495940
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Aug 2017 16:40:26 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v716eHRo027268
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Aug 2017 16:40:17 +1000
Date: Tue, 1 Aug 2017 12:10:24 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Breno Leitao <leitao@debian.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] powerpc/xmon: Disable and enable tracing command
References: <1501521731-12123-1-git-send-email-leitao@debian.org>
 <1501521731-12123-2-git-send-email-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1501521731-12123-2-git-send-email-leitao@debian.org>
Message-Id: <20170801064024.colxo4i3z764m36k@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/07/31 02:22PM, Breno Leitao wrote:
> If tracing is enabled and you get into xmon, the tracing buffer
> continues to be updated, causing possible loss of data due to buffer
> overflow and unnecessary tracing information coming from xmon functions.
> 
> This patch adds a new option that allows the tracing to be disabled and
> re-enabled from inside xmon.

How is this new option useful? In the next patch, you disable tracing by 
default -- in what scenario do you expect to have to re-enable tracing 
from within xmon?

> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  arch/powerpc/xmon/xmon.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 0cbd910193fa..19276d2f2f25 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -89,6 +89,7 @@ static unsigned long nidump = 16;
>  static unsigned long ncsum = 4096;
>  static int termch;
>  static char tmpstr[128];
> +static char tracing_enabled = 1;
> 
>  static long bus_error_jmp[JMP_BUF_LEN];
>  static int catch_memory_errors;
> @@ -268,6 +269,7 @@ Commands:\n\
>    Sr #	read SPR #\n\
>    Sw #v write v to SPR #\n\
>    t	print backtrace\n\
> +  v	trace enable/disable\n\
>    x	exit monitor and recover\n\
>    X	exit monitor and don't recover\n"
>  #if defined(CONFIG_PPC64) && !defined(CONFIG_PPC_BOOK3E)
> @@ -983,6 +985,17 @@ cmds(struct pt_regs *excp)
>  		case 'x':
>  		case 'X':
>  			return cmd;
> +		case 'v':
> +			if (tracing_is_on()) {
> +				printk("Disabling tracing\n");
> +				tracing_enabled = 0;
> +				tracing_off();

This only disables trace buffer updates - ftrace (and all its callbacks, 
et al) remains active, which isn't desirable. Can you see if this works 
for you:
https://patchwork.ozlabs.org/patch/769611/

- Naveen
