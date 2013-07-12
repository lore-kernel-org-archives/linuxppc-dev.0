Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4E4C82C0319
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2013 18:37:29 +1000 (EST)
Message-ID: <1373618233.19894.143.camel@pasglop>
Subject: Re: [PATCH v2 1/2] powerpc/math-emu: move the flush FPU state
 function into do_mathemu
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kevin Hao <haokexin@gmail.com>
Date: Fri, 12 Jul 2013 18:37:13 +1000
In-Reply-To: <1373607402-21738-2-git-send-email-haokexin@gmail.com>
References: <1373607402-21738-1-git-send-email-haokexin@gmail.com>
 <1373607402-21738-2-git-send-email-haokexin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-07-12 at 13:36 +0800, Kevin Hao wrote:
> +       /*
> +        * If we support a HW FPU, we need to ensure the FP state
> +        * if flushed into the thread_struct before attempting
> +        * emulation
> +        */
> +#ifdef CONFIG_PPC_FPU
> +       flush_fp_to_thread(current);
> +#endif
> +

While at it, care to send a patch that defined an empty
flush_fp_to_thread() in the header instead ?

ie, switch_to.h

#ifdef CONFIG_PPC_FPU
extern void flush_fp_to_thread(struct task-struct *);
#else
static inline void flush_fp_to_thread(struct task-struct *) { };
#endif

And get rid of the ifdef's here (and elsewhere if any) ?

Thanks !

Cheers,
Ben.
