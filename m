Return-Path: <paubert@iram.es>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 762E71A0260
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 21:09:55 +1100 (AEDT)
Received: from navarro.puc.rediris.es (navarro.puc.rediris.es
 [IPv6:2001:720:418:ca01::131])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 091E51400A0
 for <linuxppc-dev@ozlabs.org>; Sat, 28 Mar 2015 21:09:55 +1100 (AEDT)
Date: Sat, 28 Mar 2015 10:17:05 +0100
From: Gabriel Paubert <paubert@iram.es>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v4 2/2] selftests/powerpc: Add a test of the
 switch_endian() syscall
Message-ID: <20150328091705.GC4500@visitor2.iram.es>
References: <1427505550-13252-1-git-send-email-mpe@ellerman.id.au>
 <1427505550-13252-2-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427505550-13252-2-git-send-email-mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Jeremy Kerr <jk@ozlabs.org>,
 khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Mar 28, 2015 at 12:19:10PM +1100, Michael Ellerman wrote:
> This adds a test of the switch_endian() syscall we added in the previous
> commit.
> 
> We test it by calling the endian switch syscall, and then executing some
> code in the other endian to check everything went as expected. That code
> checks registers we expect to be maintained are. If the endian switch
> failed to happen that code sequence will be illegal and cause the test
> to abort.
> 
> We then switch back to the original endian, do the same checks and
> finally write a success message and exit(0).
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> ---
> v3: Have the test switch back to the original endian.
> v4: Add .gitignore.
>     Drop the message write in the checking code - it clobbers some regs
>     and breaks the second check.
> 
>  tools/testing/selftests/powerpc/Makefile           |  2 +-
>  .../selftests/powerpc/switch_endian/.gitignore     |  2 +
>  .../selftests/powerpc/switch_endian/Makefile       | 23 +++++
>  .../selftests/powerpc/switch_endian/check.S        | 98 ++++++++++++++++++++++
>  .../selftests/powerpc/switch_endian/common.h       |  6 ++
>  .../powerpc/switch_endian/switch_endian_test.S     | 82 ++++++++++++++++++
>  6 files changed, 212 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/powerpc/switch_endian/.gitignore
>  create mode 100644 tools/testing/selftests/powerpc/switch_endian/Makefile
>  create mode 100644 tools/testing/selftests/powerpc/switch_endian/check.S
>  create mode 100644 tools/testing/selftests/powerpc/switch_endian/common.h
>  create mode 100644 tools/testing/selftests/powerpc/switch_endian/switch_endian_test.S

[snipped]
> diff --git a/tools/testing/selftests/powerpc/switch_endian/switch_endian_test.S b/tools/testing/selftests/powerpc/switch_endian/switch_endian_test.S
> new file mode 100644
> index 000000000000..eee0e393600b
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/switch_endian/switch_endian_test.S
> @@ -0,0 +1,82 @@
> +#include "common.h"
> +
> +	.data
> +	.balign 8
> +message:
> +	.ascii "success: switch_endian_test\n\0"
> +
> +	.section ".toc"
> +	.balign 8
> +pattern:
> +	.llong 0x5555AAAA5555AAAA
> +
> +	.text
> +FUNC_START(_start)
> +	/* Load the pattern */
> +	ld	r15, pattern@TOC(%r2)
> +
> +	/* Setup CR, only CR2-CR4 are maintained */
> +	lis	r3, 0x00FF
> +	ori	r3, r3, 0xF000
> +	mtcr	r3
> +
> +	/* Load the pattern slightly modified into the registers */
> +	mr	r3, r15
> +	addi	r4, r15, 4
> +
> +	addi	r5, r15, 32
> +	mtlr	r5
> +
> +	addi	r5, r15, 5
> +	addi	r6, r15, 6
> +	addi	r7, r15, 7
> +	addi	r8, r15, 8
> +
> +	/* r9 - r12 are clobbered */
> +
> +	addi	r13, r15, 13
> +	addi	r14, r15, 14
> +
> +	/* Skip r15 we're using it */
> +
> +	addi	r16, r15, 16
> +	addi	r16, r15, 16

Duplicate?


> +	addi	r17, r15, 17
> +	addi	r18, r15, 18
> +	addi	r19, r15, 19
> +	addi	r20, r15, 20
> +	addi	r21, r15, 21
> +	addi	r22, r15, 22
> +	addi	r23, r15, 23
> +	addi	r24, r15, 24
> +	addi	r25, r15, 25
> +	addi	r26, r15, 26
> +	addi	r27, r15, 27
> +	addi	r28, r15, 28
> +	addi	r29, r15, 29
> +	addi	r30, r15, 30
> +	addi	r31, r15, 31
> +
> +	/*
> +	 * Call the syscall to switch endian.
> +	 * It clobbers r9-r12, XER, CTR and CR0-1,5-7.
> +	 */
> +	li r0, __NR_switch_endian
> +	sc
> +
> +#include "check-reversed.S"
> +
> +	/* Flip back, r0 already has the switch syscall number */
> +	.long	0x02000044	/* sc */
> +
> +#include "check.S"
> +
> +	li	r0, __NR_write
> +	li	r3, 1	/* stdout */
> +	ld	r4, message@got(%r2)
> +	li	r5, 28	/* strlen(message3) */
> +	sc
> +	li      r0, __NR_exit
> +	li	r3, 0
> +	sc
> +	b       .
> -- 
> 2.1.0

    Gabriel
