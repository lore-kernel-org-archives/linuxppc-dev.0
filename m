Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyxJF0VVhzDrM4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 20:50:05 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id u62so11499904pgb.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 03:50:04 -0700 (PDT)
Date: Thu, 29 Jun 2017 20:49:45 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, Anton
 Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 1/7] powerpc64/elfv1: Only dereference function
 descriptor for non-text symbols
Message-ID: <20170629204945.03bf29b8@roar.ozlabs.ibm.com>
In-Reply-To: <46b6f6aaec8dd297c2d8e811c82dc2303ff13508.1498732172.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498732172.git.naveen.n.rao@linux.vnet.ibm.com>
 <46b6f6aaec8dd297c2d8e811c82dc2303ff13508.1498732172.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 29 Jun 2017 16:11:04 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Currently, we assume that the function pointer we receive in
> ppc_function_entry() points to a function descriptor. However, this is
> not always the case. In particular, assembly symbols without the right
> annotation do not have an associated function descriptor. Some of these
> symbols are added to the kprobe blacklist using _ASM_NOKPROBE_SYMBOL().
> 
> When such addresses are subsequently processed through
> arch_deref_entry_point() in populate_kprobe_blacklist(), we see the
> below errors during bootup:
>     [    0.663963] Failed to find blacklist at 7d9b02a648029b6c
>     [    0.663970] Failed to find blacklist at a14d03d0394a0001
>     [    0.663972] Failed to find blacklist at 7d5302a6f94d0388
>     [    0.663973] Failed to find blacklist at 48027d11e8610178
>     [    0.663974] Failed to find blacklist at f8010070f8410080
>     [    0.663976] Failed to find blacklist at 386100704801f89d
>     [    0.663977] Failed to find blacklist at 7d5302a6f94d00b0
> 
> Fix this by checking if the function pointer we receive in
> ppc_function_entry() already points to kernel text. If so, we just
> return it as is. If not, we assume that this is a function descriptor
> and proceed to dereference it.
> 
> Suggested-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/code-patching.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
> index abef812de7f8..5482928eea1b 100644
> --- a/arch/powerpc/include/asm/code-patching.h
> +++ b/arch/powerpc/include/asm/code-patching.h
> @@ -83,8 +83,16 @@ static inline unsigned long ppc_function_entry(void *func)
>  	 * On PPC64 ABIv1 the function pointer actually points to the
>  	 * function's descriptor. The first entry in the descriptor is the
>  	 * address of the function text.
> +	 *
> +	 * However, we may also receive pointer to an assembly symbol. To
> +	 * detect that, we first check if the function pointer we receive
> +	 * already points to kernel/module text and we only dereference it
> +	 * if it doesn't.
>  	 */
> -	return ((func_descr_t *)func)->entry;
> +	if (kernel_text_address((unsigned long)func))
> +		return (unsigned long)func;
> +	else
> +		return ((func_descr_t *)func)->entry;

This seems good to me now. I guess it should do the right thing with
modules too, looking at kernel_text_address implementation.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
