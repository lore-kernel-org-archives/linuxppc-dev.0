Return-Path: <shuahkh@osg.samsung.com>
Received: from lists.s-osg.org (lists.s-osg.org [54.187.51.154])
 by lists.ozlabs.org (Postfix) with ESMTP id 6BEEA1A0DC8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jan 2015 02:23:50 +1100 (AEDT)
Message-ID: <54B53884.9010702@osg.samsung.com>
Date: Tue, 13 Jan 2015 08:23:48 -0700
From: Shuah Khan <shuahkh@osg.samsung.com>
MIME-Version: 1.0
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 08/12] selftests, powerpc: Add test for DSCR SPR numbers
References: <1421144560-15901-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1421144560-15901-9-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1421144560-15901-9-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Cc: mikey@neuling.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/13/2015 03:22 AM, Anshuman Khandual wrote:
> This patch adds a test which verifies that the DSCR privilege and
> problem state SPR read & write accesses while making sure that the
> results are always the same irrespective of which SPR number is
> being used.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>  tools/testing/selftests/powerpc/dscr/Makefile      |  2 +-
>  .../selftests/powerpc/dscr/dscr_user_test.c        | 62 ++++++++++++++++++++++
>  2 files changed, 63 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/powerpc/dscr/dscr_user_test.c
> 
> diff --git a/tools/testing/selftests/powerpc/dscr/Makefile b/tools/testing/selftests/powerpc/dscr/Makefile
> index aede453..ae865d8 100644
> --- a/tools/testing/selftests/powerpc/dscr/Makefile
> +++ b/tools/testing/selftests/powerpc/dscr/Makefile
> @@ -1,4 +1,4 @@
> -PROGS := dscr_default_test dscr_explicit_test
> +PROGS := dscr_default_test dscr_explicit_test dscr_user_test
>  
>  CFLAGS := $(CFLAGS) -lpthread
>  
> diff --git a/tools/testing/selftests/powerpc/dscr/dscr_user_test.c b/tools/testing/selftests/powerpc/dscr/dscr_user_test.c
> new file mode 100644
> index 0000000..f25d68e
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/dscr/dscr_user_test.c
> @@ -0,0 +1,62 @@
> +/*
> + * POWER Data Stream Control Register (DSCR) SPR test
> + *
> + * This test modifies the DSCR value through both the SPR number
> + * based mtspr instruction and then makes sure that the same is
> + * reflected through mfspr instruction using either of the SPR
> + * numbers.
> + *
> + * When using the privilege state SPR, the instructions such as
> + * mfspr or mtspr are priviledged and the kernel emulates them
> + * for us. Instructions using problem state SPR can be exuecuted
> + * directly without any emulation if the HW supports them. Else
> + * they also get emulated by the kernel.
> + *
> + * Copyright (C) 2013 Anton Blanchard <anton@au.ibm.com>, IBM
> + * Copyright (C) 2015 Anshuman Khandual <khandual@linux.vnet.ibm.com>, IBM
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +#include "dscr.h"
> +
> +static int check_dscr(char *str)
> +{
> +	unsigned long cur_dscr, cur_dscr_usr;
> +
> +	cur_dscr = get_dscr();
> +	cur_dscr_usr = get_dscr_usr();
> +	if (cur_dscr != cur_dscr_usr) {
> +		printf("%s set, kernel get %lx != user get %lx\n",
> +					str, cur_dscr, cur_dscr_usr);
> +		return 1;
> +	}
> +	return 0;
> +}
> +
> +int test_body(void)
> +{
> +	int i;
> +
> +	check_dscr("");
> +
> +	for (i = 0; i < COUNT; i++) {
> +		set_dscr(i);
> +		if (check_dscr("kernel"))
> +			return 1;
> +	}
> +
> +	for (i = 0; i < COUNT; i++) {
> +		set_dscr_usr(i);
> +		if (check_dscr("user"))
> +			return 1;
> +	}
> +	return 0;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	return test_harness(test_body, "dscr_user_test");
> +}
> 

Could you please add a .gitignore for powerpc targets as we
discussed earlier. It can be separate patch.

Also, I would like to see the test results reports using
kselftest.h - it can be separate patch in the interest of
getting tests in.

Acked-by: Shuah Khan <shuahkh@osg.samsung.com>

Please take this through powerpc maintainer git.

thanks,
-- Shuah

-- 
Shuah Khan
Sr. Linux Kernel Developer
Open Source Innovation Group
Samsung Research America (Silicon Valley)
shuahkh@osg.samsung.com | (970) 217-8978
