Return-Path: <cyrilbur@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYpyn0MchzDsF9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 14:50:57 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id 128so187615pfb.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 21:50:56 -0700 (PDT)
Message-ID: <1473828648.2554.9.camel@gmail.com>
Subject: Re: [PATCH v14 04/15] selftests/powerpc: Add ptrace tests for
 GPR/FPR registers
From: Cyril Bur <cyrilbur@gmail.com>
To: wei.guo.simon@gmail.com, linuxppc-dev@lists.ozlabs.org
Cc: Shuah Khan <shuah@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Chris Smart <chris@distroguy.com>, Suraj Jitindar Singh
 <sjitindarsingh@gmail.com>, Michael Neuling <mikey@neuling.org>, Anshuman
 Khandual <khandual@linux.vnet.ibm.com>, Jack Miller <jack@codezen.org>,
 Rashmica Gupta <rashmicy@gmail.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Date: Wed, 14 Sep 2016 14:50:48 +1000
In-Reply-To: <1473665605-11890-5-git-send-email-wei.guo.simon@gmail.com>
References: <1473665605-11890-1-git-send-email-wei.guo.simon@gmail.com>
 <1473665605-11890-5-git-send-email-wei.guo.simon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-09-12 at 15:33 +0800, wei.guo.simon@gmail.com wrote:
> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> 
> This patch adds ptrace interface test for GPR/FPR registers.
> This adds ptrace interface based helper functions related to
> GPR/FPR access and some assembly helper functions related to
> GPR/FPR registers.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
> ---
>  tools/testing/selftests/powerpc/ptrace/Makefile    |   3 +-
>  .../testing/selftests/powerpc/ptrace/ptrace-gpr.c  | 196
> +++++++++++++++++++
>  .../testing/selftests/powerpc/ptrace/ptrace-gpr.h  |  74 ++++++++
>  tools/testing/selftests/powerpc/ptrace/ptrace.S    | 131
> +++++++++++++
>  tools/testing/selftests/powerpc/ptrace/ptrace.h    | 211
> +++++++++++++++++++++
>  5 files changed, 614 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-
> gpr.c
>  create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-
> gpr.h
>  create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace.S
> 

[snip]

> new file mode 100644
> index 0000000..193beea
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/ptrace/ptrace.S
> @@ -0,0 +1,131 @@
> +/*
> + * Ptrace interface test helper assembly functions
> + *
> + * Copyright (C) 2015 Anshuman Khandual, IBM Corporation.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +#include <ppc-asm.h>
> +#include "../reg.h"
> +
> +
> +/* Non volatile GPR - unsigned long buf[18] */
> +FUNC_START(load_gpr)
> +	ld	14, 0*8(3)
> +	ld	15, 1*8(3)
> +	ld	16, 2*8(3)
> +	ld	17, 3*8(3)
> +	ld	18, 4*8(3)
> +	ld	19, 5*8(3)
> +	ld	20, 6*8(3)
> +	ld	21, 7*8(3)
> +	ld	22, 8*8(3)
> +	ld	23, 9*8(3)
> +	ld	24, 10*8(3)
> +	ld	25, 11*8(3)
> +	ld	26, 12*8(3)
> +	ld	27, 13*8(3)
> +	ld	28, 14*8(3)
> +	ld	29, 15*8(3)
> +	ld	30, 16*8(3)
> +	ld	31, 17*8(3)
> +	blr
> +FUNC_END(load_gpr)
> +
> +FUNC_START(store_gpr)
> +	std	14, 0*8(3)
> +	std	15, 1*8(3)
> +	std	16, 2*8(3)
> +	std	17, 3*8(3)
> +	std	18, 4*8(3)
> +	std	19, 5*8(3)
> +	std	20, 6*8(3)
> +	std	21, 7*8(3)
> +	std	22, 8*8(3)
> +	std	23, 9*8(3)
> +	std	24, 10*8(3)
> +	std	25, 11*8(3)
> +	std	26, 12*8(3)
> +	std	27, 13*8(3)
> +	std	28, 14*8(3)
> +	std	29, 15*8(3)
> +	std	30, 16*8(3)
> +	std	31, 17*8(3)
> +	blr
> +FUNC_END(store_gpr)
> +
> +/* Single Precision Float - float buf[32] */
> +FUNC_START(load_fpr)
> +	lfs 0, 0*4(3)
> +	lfs 1, 1*4(3)
> +	lfs 2, 2*4(3)
> +	lfs 3, 3*4(3)
> +	lfs 4, 4*4(3)
> +	lfs 5, 5*4(3)
> +	lfs 6, 6*4(3)
> +	lfs 7, 7*4(3)
> +	lfs 8, 8*4(3)
> +	lfs 9, 9*4(3)
> +	lfs 10, 10*4(3)
> +	lfs 11, 11*4(3)
> +	lfs 12, 12*4(3)
> +	lfs 13, 13*4(3)
> +	lfs 14, 14*4(3)
> +	lfs 15, 15*4(3)
> +	lfs 16, 16*4(3)
> +	lfs 17, 17*4(3)
> +	lfs 18, 18*4(3)
> +	lfs 19, 19*4(3)
> +	lfs 20, 20*4(3)
> +	lfs 21, 21*4(3)
> +	lfs 22, 22*4(3)
> +	lfs 23, 23*4(3)
> +	lfs 24, 24*4(3)
> +	lfs 25, 25*4(3)
> +	lfs 26, 26*4(3)
> +	lfs 27, 27*4(3)
> +	lfs 28, 28*4(3)
> +	lfs 29, 29*4(3)
> +	lfs 30, 30*4(3)
> +	lfs 31, 31*4(3)
> +	blr
> +FUNC_END(load_fpr)
> +
> +FUNC_START(store_fpr)
> +	stfs 0, 0*4(3)
> +	stfs 1, 1*4(3)
> +	stfs 2, 2*4(3)
> +	stfs 3, 3*4(3)
> +	stfs 4, 4*4(3)
> +	stfs 5, 5*4(3)
> +	stfs 6, 6*4(3)
> +	stfs 7, 7*4(3)
> +	stfs 8, 8*4(3)
> +	stfs 9, 9*4(3)
> +	stfs 10, 10*4(3)
> +	stfs 11, 11*4(3)
> +	stfs 12, 12*4(3)
> +	stfs 13, 13*4(3)
> +	stfs 14, 14*4(3)
> +	stfs 15, 15*4(3)
> +	stfs 16, 16*4(3)
> +	stfs 17, 17*4(3)
> +	stfs 18, 18*4(3)
> +	stfs 19, 19*4(3)
> +	stfs 20, 20*4(3)
> +	stfs 21, 21*4(3)
> +	stfs 22, 22*4(3)
> +	stfs 23, 23*4(3)
> +	stfs 24, 24*4(3)
> +	stfs 25, 25*4(3)
> +	stfs 26, 26*4(3)
> +	stfs 27, 27*4(3)
> +	stfs 28, 28*4(3)
> +	stfs 29, 29*4(3)
> +	stfs 30, 30*4(3)
> +	stfs 31, 31*4(3)
> +	blr
> +FUNC_END(store_fpr)

I wrote similar functions in math/fpu_asm.S perhaps it would be time
consolidate those and these into an fpu_asm.S file at a higher level,
TM related tests would benefit as well.

> diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace.h
> b/tools/testing/selftests/powerpc/ptrace/ptrace.h
> index fbf73ca..1019004 100644
> --- a/tools/testing/selftests/powerpc/ptrace/ptrace.h
> +++ b/tools/testing/selftests/powerpc/ptrace/ptrace.h
> @@ -157,6 +157,214 @@ fail:
>  	return TEST_FAIL;
>  }
>  
[snip]
