Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vYJvn6kz3zDqGh
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 02:17:09 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v21FEEUb042078
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Mar 2017 10:17:08 -0500
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28wxray6q7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Mar 2017 10:17:07 -0500
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 1 Mar 2017 20:47:04 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id D5276125805B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Mar 2017 20:47:13 +0530 (IST)
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v21FH1Tf6619354
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Mar 2017 20:47:01 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v21FH0lF011198
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Mar 2017 20:47:01 +0530
Date: Wed, 1 Mar 2017 20:46:59 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v2 3.5/5] trace/kprobes: Add back warning about offset in
 return probes
References: <cover.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
 <183e7ce2921a08c9c755ee9a5da3134febc6695b.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170227113252.05e9c0df@gandalf.local.home>
 <20170227115204.00f92846@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170227115204.00f92846@gandalf.local.home>
Message-Id: <20170301151659.GO4212@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/02/27 11:52AM, Steven Rostedt (VMware) wrote:
> Let's not remove the warning about offsets and return probes when the
> offset is invalid.

Good point!

Thanks, Steve!

> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

> ---
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 3f4f788..f626235 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -695,6 +695,11 @@ static int create_trace_kprobe(int argc, char **argv)
>  			pr_info("Failed to parse symbol.\n");
>  			return ret;
>  		}
> +		if (offset && is_return &&
> +		    !arch_function_offset_within_entry(offset)) {
> +			pr_info("Given offset is not valid for return probe.\n");
> +			return -EINVAL;
> +		}
>  	}
>  	argc -= 2; argv += 2;
> 
> 
