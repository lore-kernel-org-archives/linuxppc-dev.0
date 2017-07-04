Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x212D2zpczDqj1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Jul 2017 20:48:36 +1000 (AEST)
In-Reply-To: <4bd8ff1d8855711d3bf8a11eecc8068e3aabac03.1498755960.git.naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Anton Blanchard <anton@samba.org>
Subject: Re: [v5,
 1/7] powerpc64/elfv1: Only dereference function descriptor for
 non-text symbols
Message-Id: <3x212D24Vhz9s71@ozlabs.org>
Date: Tue,  4 Jul 2017 20:48:36 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-06-29 at 17:49:14 UTC, "Naveen N. Rao" wrote:
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
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/83e840c770f2c578bbbff478d62a44

cheers
