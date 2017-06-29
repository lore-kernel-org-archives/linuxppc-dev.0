Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyxYm6ccxzDqjs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 21:01:48 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id e199so12697225pfh.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 04:01:48 -0700 (PDT)
Date: Thu, 29 Jun 2017 21:01:30 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, Anton
 Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 7/7] powerpc/64s: Blacklist rtas entry/exit from kprobes
Message-ID: <20170629210130.242bd2c3@roar.ozlabs.ibm.com>
In-Reply-To: <39d40efd808c6346b97e5bfe4be47546919cb91b.1498732172.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498732172.git.naveen.n.rao@linux.vnet.ibm.com>
 <39d40efd808c6346b97e5bfe4be47546919cb91b.1498732172.git.naveen.n.rao@linux.vnet.ibm.com>
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

On Thu, 29 Jun 2017 16:11:10 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> We can't take traps with relocation off, so blacklist enter_rtas() and
> rtas_return_loc(). However, instead of blacklisting all of enter_rtas(),
> introduce a new symbol __enter_rtas from where on we can't take a trap
> and blacklist that.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/entry_64.S | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index 0c27084800b6..16f4c4a1a294 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -1082,6 +1082,7 @@ _GLOBAL(enter_rtas)
>  	sync				/* disable interrupts so SRR0/1 */
>  	mtmsrd	r0			/* don't get trashed */
>  
> +__enter_rtas:

Hmm, am I missing something, or is there a reason to put these labels
after the mtmsr? Even if kprobes does the right thing, I think it's
easier to read the code if you cover the mtmsr as well.

Thanks,
Nick
