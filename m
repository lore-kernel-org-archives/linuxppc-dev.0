Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7pN52G83zDq9B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 16:08:53 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] kprobes: validate the symbol name length
In-Reply-To: <6e14d22994530fb5200c74d1593e73541d3b8028.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
 <6e14d22994530fb5200c74d1593e73541d3b8028.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
Date: Thu, 20 Apr 2017 16:08:52 +1000
Message-ID: <87o9vr4nm3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:

> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 6a128f3a7ed1..bb86681c8a10 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1382,6 +1382,28 @@ bool within_kprobe_blacklist(unsigned long addr)
>  	return false;
>  }
>  
> +bool is_valid_kprobe_symbol_name(const char *name)
> +{
> +	size_t sym_len;
> +	char *s;
> +
> +	s = strchr(name, ':');
> +	if (s) {
> +		sym_len = strnlen(s+1, KSYM_NAME_LEN);
> +		if (sym_len <= 0 || sym_len >= KSYM_NAME_LEN)
> +			return false;
> +		sym_len = (size_t)(s - name);
> +		if (sym_len <= 0 || sym_len >= MODULE_NAME_LEN)
> +			return false;
> +	} else {
> +		sym_len = strnlen(name, MODULE_NAME_LEN);
> +		if (sym_len <= 0 || sym_len >= MODULE_NAME_LEN)
> +			return false;
> +	}

I think this is probably more elaborate than it needs to be.

Why not just check the string is <= (MODULE_NAME_LEN + KSYM_NAME_LEN) ?

cheers
