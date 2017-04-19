Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7PkB2jWTzDq9P
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 00:38:10 +1000 (AEST)
Date: Wed, 19 Apr 2017 23:37:50 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Ingo Molnar <mingo@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] kprobes: validate the symbol name length
Message-Id: <20170419233750.8552f5de8ce1ed1398807284@kernel.org>
In-Reply-To: <6e14d22994530fb5200c74d1593e73541d3b8028.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
 <6e14d22994530fb5200c74d1593e73541d3b8028.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
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

On Wed, 19 Apr 2017 18:21:02 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> When a kprobe is being registered, we use the symbol_name field to
> lookup the address where the probe should be placed. Since this is a
> user-provided field, let's ensure that the length of the string is
> within expected limits.

Would we really need this? Of course it may filter out longer
strings... anyway such name should be rejected by kallsyms.

[...]
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 6a128f3a7ed1..bb86681c8a10 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1382,6 +1382,28 @@ bool within_kprobe_blacklist(unsigned long addr)
>  	return false;
>  }
>  
> +bool is_valid_kprobe_symbol_name(const char *name)

This just check the length of symbol_name buffer, and can contain
some invalid chars.

> +{
> +	size_t sym_len;
> +	char *s;
> +
> +	s = strchr(name, ':');
> +	if (s) {
> +		sym_len = strnlen(s+1, KSYM_NAME_LEN);

If you use strnlen() here, you just need to ensure sym_len < KSYM_NAME_LEN.

> +		if (sym_len <= 0 || sym_len >= KSYM_NAME_LEN)
> +			return false;
> +		sym_len = (size_t)(s - name);
> +		if (sym_len <= 0 || sym_len >= MODULE_NAME_LEN)
> +			return false;
> +	} else {
> +		sym_len = strnlen(name, MODULE_NAME_LEN);
> +		if (sym_len <= 0 || sym_len >= MODULE_NAME_LEN)

Would you mean KSYM_NAME_LEN here?

> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>  /*
>   * If we have a symbol_name argument, look it up and add the offset field
>   * to it. This way, we can specify a relative address to a symbol.
> @@ -1397,6 +1419,8 @@ static kprobe_opcode_t *kprobe_addr(struct kprobe *p)
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

Thanks,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
