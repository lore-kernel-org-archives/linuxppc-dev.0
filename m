Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mY394J9bzF15H
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 11:03:49 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] selftests/powerpc: add test to verify rfi flush across a
 system call
In-Reply-To: <20180406165546.19433-1-naveen.n.rao@linux.vnet.ibm.com>
References: <20180406165546.19433-1-naveen.n.rao@linux.vnet.ibm.com>
Date: Thu, 17 May 2018 11:03:48 +1000
Message-ID: <877eo3nle3.fsf@concordia.ellerman.id.au>
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

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:

> diff --git a/tools/testing/selftests/powerpc/utils.c b/tools/testing/selftests/powerpc/utils.c
> index d46916867a6f..c6b1d20ed3ba 100644
> --- a/tools/testing/selftests/powerpc/utils.c
> +++ b/tools/testing/selftests/powerpc/utils.c
> @@ -104,3 +111,149 @@ int pick_online_cpu(void)
>  	printf("No cpus in affinity mask?!\n");
>  	return -1;
>  }
...
> +
> +static void sigill_handler(int signr, siginfo_t *info, void *unused)
> +{
> +	static int warned = 0;
> +	ucontext_t *ctx = (ucontext_t *)unused;
> +	unsigned int *pc = (unsigned int *)ctx->uc_mcontext.gp_regs[PT_NIP];

The above doesn't work on 32-bit, and this code is sometimes built 32-bit.

For an example of how to handle 32 and 64-bit, see eg:

  tools/testing/selftests/powerpc/primitives/load_unaligned_zeropad.c

cheers
