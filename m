Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tMl8B2zgbzDvmk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 21:24:26 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [PATCH] powerpc: kprobes: invoke handlers directly
In-Reply-To: <20161118113926.31350-1-naveen.n.rao@linux.vnet.ibm.com>
References: <20161118113926.31350-1-naveen.n.rao@linux.vnet.ibm.com>
Date: Mon, 21 Nov 2016 21:24:25 +1100
Message-ID: <87bmx9w2p2.fsf@concordia.ellerman.id.au>
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
> +#ifdef CONFIG_KPROBES
> +	if (kprobe_post_handler(regs))
> +		return;
> +#endif
...
> +#ifdef CONFIG_KPROBES
> +		if (kprobe_handler(regs))
> +			goto bail;
> +#endif
...
> +#ifdef CONFIG_KPROBES
> +		if (kprobe_post_handler(regs))
> +			return;
> +#endif
...
> +#ifdef CONFIG_KPROBES
> +		if (kprobe_post_handler(regs))
> +			return;
> +#endif
> +

Sorry too many ifdefs.

Can you please add empty static inline versions for CONFIG_KPROBES=n
that always return false. The compiler will be smart enough to elide
them entirely.

cheers
