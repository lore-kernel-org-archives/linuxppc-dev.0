Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2ED331A03EF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 12:10:10 +1100 (AEDT)
Received: from mail-pf0-x233.google.com (mail-pf0-x233.google.com
 [IPv6:2607:f8b0:400e:c00::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9685D140C1F
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2016 12:10:09 +1100 (AEDT)
Received: by mail-pf0-x233.google.com with SMTP id x65so22691480pfb.1
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Feb 2016 17:10:09 -0800 (PST)
Subject: Re: [PATCH 09/12] powerpc/ftrace: Use generic ftrace_modify_all_code()
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <1456324115-21144-1-git-send-email-mpe@ellerman.id.au>
 <1456324115-21144-9-git-send-email-mpe@ellerman.id.au>
Cc: duwe@lst.de, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz, live-patching@vger.kernel.org, mbenes@suse.cz
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <56CE5469.6050804@gmail.com>
Date: Thu, 25 Feb 2016 12:10:01 +1100
MIME-Version: 1.0
In-Reply-To: <1456324115-21144-9-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 25/02/16 01:28, Michael Ellerman wrote:
> From: Torsten Duwe <duwe@lst.de>
>
> Convert powerpc's arch_ftrace_update_code() from its own version to use
> the generic default functionality (without stop_machine -- our
> instructions are properly aligned and the replacements atomic).
>
> With this we gain error checking and the much-needed function_trace_op
> handling.
>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/kernel/ftrace.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
>
> diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
> index c6408a399ac6..56e5bd53c323 100644
> --- a/arch/powerpc/kernel/ftrace.c
> +++ b/arch/powerpc/kernel/ftrace.c
> @@ -527,20 +527,13 @@ void ftrace_replace_code(int enable)
>  	}
>  }
>  
> +/*
> + * Use the default ftrace_modify_all_code, but without
> + * stop_machine().
> + */
>  void arch_ftrace_update_code(int command)
>  {
> -	if (command & FTRACE_UPDATE_CALLS)
> -		ftrace_replace_code(1);
> -	else if (command & FTRACE_DISABLE_CALLS)
> -		ftrace_replace_code(0);
> -
> -	if (command & FTRACE_UPDATE_TRACE_FUNC)
> -		ftrace_update_ftrace_func(ftrace_trace_function);
> -
> -	if (command & FTRACE_START_FUNC_RET)
> -		ftrace_enable_ftrace_graph_caller();
> -	else if (command & FTRACE_STOP_FUNC_RET)
> -		ftrace_disable_ftrace_graph_caller();
> +	ftrace_modify_all_code(command);
>  }
>  
>  int __init ftrace_dyn_arch_init(void)
Reviewed-by: Balbir Singh <bsingharora@gmail.com>

Balbir
