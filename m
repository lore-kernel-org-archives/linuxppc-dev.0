Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vYpsm2WjnzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 21:47:08 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: David Daney <david.daney@cavium.com>, Jason Baron <jbaron@akamai.com>,
 Steven Rostedt <rostedt@goodmis.org>, Sachin Sant <sachinp@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, Chris Metcalf <cmetcalf@mellanox.com>,
 Ralf Baechle <ralf@linux-mips.org>, Russell King <linux@armlinux.org.uk>,
 Rabin Vincent <rabin@rab.in>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@kernel.org>,
 Zhigang Lu <zlu@ezchip.com>, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] module: set __jump_table alignment to 8
In-Reply-To: <20170301220453.4756-1-david.daney@cavium.com>
References: <20170301220453.4756-1-david.daney@cavium.com>
Date: Thu, 02 Mar 2017 21:47:07 +1100
Message-ID: <87varsj6qc.fsf@concordia.ellerman.id.au>
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

David Daney <david.daney@cavium.com> writes:

> For powerpc the __jump_table section in modules is not aligned, this
> causes a WARN_ON() splat when loading a module containing a __jump_table.

Thanks for doing the patch.

If it helps:

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

> Strict alignment became necessary with commit 3821fd35b58d
> ("jump_label: Reduce the size of struct static_key"), currently in
> linux-next, which uses the two least significant bits of pointers to
> __jump_table elements.

It would obviously be nice if this could go in before the commit that
exposes the breakage, but I guess that's problematic because Steve
doesn't want to rebase the tracing tree.

Steve I think you've already sent your pull request for this cycle? So I
guess if this can go in your first batch of fixes?

Or we could just send it directly to Linus?

cheers

> Fix by forcing __jump_table to 8, which is the same alignment used for
> this section in the kernel proper.
>
> Signed-off-by: David Daney <david.daney@cavium.com>
> Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> ---
>  scripts/module-common.lds | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/scripts/module-common.lds b/scripts/module-common.lds
> index 73a2c7d..53234e8 100644
> --- a/scripts/module-common.lds
> +++ b/scripts/module-common.lds
> @@ -19,4 +19,6 @@ SECTIONS {
>  
>  	. = ALIGN(8);
>  	.init_array		0 : { *(SORT(.init_array.*)) *(.init_array) }
> +
> +	__jump_table		0 : ALIGN(8) { KEEP(*(__jump_table)) }
>  }
> -- 
> 2.9.3
