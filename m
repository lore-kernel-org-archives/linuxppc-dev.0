Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w8cfW402PzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 23:54:11 +1000 (AEST)
Date: Fri, 21 Apr 2017 22:54:00 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/7] kprobes: validate the symbol name provided
 during probe registration
Message-Id: <20170421225400.81a4bd00f85725cf67c75e64@kernel.org>
In-Reply-To: <20170421123234.6895-1-naveen.n.rao@linux.vnet.ibm.com>
References: <6e14d22994530fb5200c74d1593e73541d3b8028.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170421123234.6895-1-naveen.n.rao@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 21 Apr 2017 18:02:33 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> When a kprobe is being registered, we use the symbol_name field to
> lookup the address where the probe should be placed. Since this is a
> user-provided field, let's ensure that the length of the string is
> within expected limits.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
> Masami, Michael,
> Here's a simplified version that should hopefully be fine. I have
> simplified the logic to keep the code compact and simple.

Ok, so as I replied to older version,
 - Ensure name != NULL at first.
 - Define it in kernel/kallsyms.c as a general routine.

Since this validate the string which will be passed to kallsyms,
I think it should be provided by kallsyms.

Thanks, 

> 
> - Naveen
> 
> 
>  include/linux/kprobes.h     |  1 +
>  kernel/kprobes.c            | 30 ++++++++++++++++++++++++++++++
>  kernel/trace/trace_kprobe.c |  4 ++++
>  3 files changed, 35 insertions(+)
> 
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index 1f82a3db00b1..4ee10fef5135 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -405,6 +405,7 @@ int disable_kprobe(struct kprobe *kp);
>  int enable_kprobe(struct kprobe *kp);
>  
>  void dump_kprobe(struct kprobe *kp);
> +bool is_valid_kprobe_symbol_name(const char *name);
>  
>  #else /* !CONFIG_KPROBES: */
>  
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 6a128f3a7ed1..ff9b1ac72a38 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1383,6 +1383,34 @@ bool within_kprobe_blacklist(unsigned long addr)
>  }
>  
>  /*
> + * We mainly want to ensure that the provided string is of a reasonable length
> + * and is of the form [<mod_name>:]<sym_name>, so that this is safe to process
> + * further.
> + * We don't worry about invalid characters as those will just prevent
> + * matching existing kallsyms.
> + */
> +bool is_valid_kprobe_symbol_name(const char *name)
> +{
> +	size_t sym_len;
> +	const char *s;
> +
> +	s = strnchr(name, ':', MODULE_NAME_LEN + KSYM_NAME_LEN + 1);
> +	if (s) {
> +		sym_len = (size_t)(s - name);
> +		if (sym_len <= 0  || sym_len >= MODULE_NAME_LEN)
> +			return false;
> +		s++;
> +	} else
> +		s = name;
> +
> +	sym_len = strnlen(s, KSYM_NAME_LEN);
> +	if (sym_len <= 0 || sym_len >= KSYM_NAME_LEN)
> +		return false;
> +
> +	return true;
> +}
> +
> +/*
>   * If we have a symbol_name argument, look it up and add the offset field
>   * to it. This way, we can specify a relative address to a symbol.
>   * This returns encoded errors if it fails to look up symbol or invalid
> @@ -1397,6 +1425,8 @@ static kprobe_opcode_t *kprobe_addr(struct kprobe *p)
>  		goto invalid;
>  
>  	if (p->symbol_name) {
> +		if (!is_valid_kprobe_symbol_name(p->symbol_name))
> +			return ERR_PTR(-EINVAL);
>  		addr = kprobe_lookup_name(p->symbol_name, p->offset);
>  		if (!addr)
>  			return ERR_PTR(-ENOENT);
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 5f688cc724f0..bf73e5f31128 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -704,6 +704,10 @@ static int create_trace_kprobe(int argc, char **argv)
>  			pr_info("Return probe must be used without offset.\n");
>  			return -EINVAL;
>  		}
> +		if (!is_valid_kprobe_symbol_name(symbol)) {
> +			pr_info("Symbol name is too long.\n");
> +			return -EINVAL;
> +		}
>  	}
>  	argc -= 2; argv += 2;
>  
> -- 
> 2.12.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
