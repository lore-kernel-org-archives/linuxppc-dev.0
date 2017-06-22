Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtSHq39nJzDvHV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 13:49:11 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id y7so964397pfd.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 20:49:11 -0700 (PDT)
Date: Thu, 22 Jun 2017 13:48:58 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 6/6] powerpc/64s: Blacklist rtas entry/exit from kprobes
Message-ID: <20170622134858.63031e22@roar.ozlabs.ibm.com>
In-Reply-To: <482db382b611b0a97bb1d897b3b38cc083e10965.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
 <482db382b611b0a97bb1d897b3b38cc083e10965.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
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

On Thu, 22 Jun 2017 00:08:42 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> We can't take traps with relocation off, so blacklist enter_rtas() and
> rtas_return_loc(). However, instead of blacklisting all of enter_rtas(),
> introduce a new symbol __enter_rtas from where on we can't take a trap
> and blacklist that.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/entry_64.S | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index d376f07153d7..49c35450f399 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -1076,6 +1076,8 @@ _GLOBAL(enter_rtas)
>          rldicr  r9,r9,MSR_SF_LG,(63-MSR_SF_LG)
>  	ori	r9,r9,MSR_IR|MSR_DR|MSR_FE0|MSR_FE1|MSR_FP|MSR_RI|MSR_LE
>  	andc	r6,r0,r9
> +
> +__enter_rtas:
>  	sync				/* disable interrupts so SRR0/1 */
>  	mtmsrd	r0			/* don't get trashed */

Along the lines of the system call patch... For consistency, could we
put the __enter_rtas right after mtmsrd? And I wonder if we shoul
come up with a common prefix or postfix naming convention for these
such labels used to control probing?

How do opal calls avoid tracing?

Thanks,
Nick
