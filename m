Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B0C001007D4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2011 16:48:39 +1100 (EST)
Message-ID: <1322632107.21641.43.camel@pasglop>
Subject: Re: [PATCH 4/6] powerpc/boot: Add extended precision shifts to the
 boot wrapper.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tony Breeds <tony@bakeyournoodle.com>
Date: Wed, 30 Nov 2011 16:48:27 +1100
In-Reply-To: <1322630640-13708-5-git-send-email-tony@bakeyournoodle.com>
References: <1322630640-13708-1-git-send-email-tony@bakeyournoodle.com>
 <1322630640-13708-5-git-send-email-tony@bakeyournoodle.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-11-30 at 16:23 +1100, Tony Breeds wrote:
> Code copied from arch/powerpc/kernel/misc_32.S
> 
> Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
> ---
>  arch/powerpc/boot/div64.S |   52 +++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 52 insertions(+), 0 deletions(-)

Should we just link with libgcc ? :-)

Cheers,
Ben.

> diff --git a/arch/powerpc/boot/div64.S b/arch/powerpc/boot/div64.S
> index d271ab5..bbcb8a4 100644
> --- a/arch/powerpc/boot/div64.S
> +++ b/arch/powerpc/boot/div64.S
> @@ -57,3 +57,55 @@ __div64_32:
>  	stw	r8,4(r3)
>  	mr	r3,r6		# return the remainder in r3
>  	blr
> +
> +/*
> + * Extended precision shifts.
> + *
> + * Updated to be valid for shift counts from 0 to 63 inclusive.
> + * -- Gabriel
> + *
> + * R3/R4 has 64 bit value
> + * R5    has shift count
> + * result in R3/R4
> + *
> + *  ashrdi3: arithmetic right shift (sign propagation)	
> + *  lshrdi3: logical right shift
> + *  ashldi3: left shift
> + */
> +	.globl __ashrdi3
> +__ashrdi3:
> +	subfic	r6,r5,32
> +	srw	r4,r4,r5	# LSW = count > 31 ? 0 : LSW >> count
> +	addi	r7,r5,32	# could be xori, or addi with -32
> +	slw	r6,r3,r6	# t1 = count > 31 ? 0 : MSW << (32-count)
> +	rlwinm	r8,r7,0,32	# t3 = (count < 32) ? 32 : 0
> +	sraw	r7,r3,r7	# t2 = MSW >> (count-32)
> +	or	r4,r4,r6	# LSW |= t1
> +	slw	r7,r7,r8	# t2 = (count < 32) ? 0 : t2
> +	sraw	r3,r3,r5	# MSW = MSW >> count
> +	or	r4,r4,r7	# LSW |= t2
> +	blr
> +
> +	.globl __ashldi3
> +__ashldi3:
> +	subfic	r6,r5,32
> +	slw	r3,r3,r5	# MSW = count > 31 ? 0 : MSW << count
> +	addi	r7,r5,32	# could be xori, or addi with -32
> +	srw	r6,r4,r6	# t1 = count > 31 ? 0 : LSW >> (32-count)
> +	slw	r7,r4,r7	# t2 = count < 32 ? 0 : LSW << (count-32)
> +	or	r3,r3,r6	# MSW |= t1
> +	slw	r4,r4,r5	# LSW = LSW << count
> +	or	r3,r3,r7	# MSW |= t2
> +	blr
> +
> +	.globl __lshrdi3
> +__lshrdi3:
> +	subfic	r6,r5,32
> +	srw	r4,r4,r5	# LSW = count > 31 ? 0 : LSW >> count
> +	addi	r7,r5,32	# could be xori, or addi with -32
> +	slw	r6,r3,r6	# t1 = count > 31 ? 0 : MSW << (32-count)
> +	srw	r7,r3,r7	# t2 = count < 32 ? 0 : MSW >> (count-32)
> +	or	r4,r4,r6	# LSW |= t1
> +	srw	r3,r3,r5	# MSW = MSW >> count
> +	or	r4,r4,r7	# LSW |= t2
> +	blr
