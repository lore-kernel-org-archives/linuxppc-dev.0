Return-Path: <sagar.abhishek@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id E05A3DDDF5
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 16:19:34 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2237151wag
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2007 23:19:33 -0700 (PDT)
Message-ID: <863e9df20706252319j239eaf44wee7a46ad742c9585@mail.gmail.com>
Date: Tue, 26 Jun 2007 11:49:33 +0530
From: "Abhishek Sagar" <sagar.abhishek@gmail.com>
To: "Michael Ellerman" <michael@ellerman.id.au>
Subject: Re: [PATCH 3/3] Make jprobes a little safer for users
In-Reply-To: <7a070581b2fe53ea65216e86c86abc4f40464341.1182822366.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <78935473b1f70c863ab0be7d6cf4bcb04922b20b.1182822366.git.michael@ellerman.id.au>
	<7a070581b2fe53ea65216e86c86abc4f40464341.1182822366.git.michael@ellerman.id.au>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
	anil.s.keshavamurthy@intel.com, linuxppc-dev@ozlabs.org,
	Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 6/26/07, Michael Ellerman <michael@ellerman.id.au> wrote:

> We can then use that in register_jprobe() to check that the entry point
> we're passed is actually in the kernel text, rather than just some random
> value.

A similar cleanup is possible even for return probes then. I wonder if
there are any kprobe related scenarios where the executable code may
be located outside the core kernel text region (e.g, ITCM?). In that
case would it also be wrong to assume that the jprobe handler may be
situated outside the kernel core text / module  region? Would it then
make sense to move this check from register_jprobe() to the arch
dependent code?

>  int __kprobes register_jprobe(struct jprobe *jp)
>  {
> +       unsigned long addr = arch_deref_entry_point(jp->entry);
> +
> +       if (!kernel_text_address(addr))
> +               return -EINVAL;

Seems like you're checking for the jprobe handler to be within
kernel/module range. Why not narrow this down to just module range
(!module_text_address(addr), say)? Core kernel functions would not be
ending with a 'jprobe_return()' anyway.

--
Abhishek Sagar

-
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
