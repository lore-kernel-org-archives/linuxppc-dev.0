Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46E2F1A0745
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 16:01:31 +1100 (AEDT)
Message-ID: <1426222890.23806.1.camel@ellerman.id.au>
Subject: Re: [PATCH 2/2] selftests/powerpc: Add a test of the
 switch_endian() syscall
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Date: Fri, 13 Mar 2015 16:01:30 +1100
In-Reply-To: <1426221564-15086-2-git-send-email-mpe@ellerman.id.au>
References: <1426221564-15086-1-git-send-email-mpe@ellerman.id.au>
 <1426221564-15086-2-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-03-13 at 15:39 +1100, Michael Ellerman wrote:
> diff --git a/tools/testing/selftests/powerpc/syscalls/endian-test.S b/tools/testing/selftests/powerpc/syscalls/endian-test.S
> new file mode 100644
> index 000000000000..0beca323247a
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/syscalls/endian-test.S
> @@ -0,0 +1,247 @@
> +#include <ppc-asm.h>
> +#include <asm/unistd.h>
> +
> +#ifndef __NR_switch_endian
> +#define __NR_switch_endian 363
> +#endif
> +
> +	.data
> +	.balign 8
> +message:
> +	.ascii "success: endian-test\n"
> +
> +	.section .toc
> +	.balign 8
> +pattern:
> +	.llong 0x5555AAAA5555AAAA
> +
> +	.text
> +FUNC_START(_start)
> +	/* Load some addresses to start with */
> +	ld	r14, message@got(%r2)
> +	ld	r15, pattern@toc(%r2)


Because ... stupid, the "toc" references above break on big endian.

Fixed by doing:
	.section ".toc"

and:
	ld	r15, pattern@TOC(%r2)

cheers
