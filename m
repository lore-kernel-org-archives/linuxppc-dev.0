Return-Path: <srs0=2eb5=kq=au1.ibm.com=andrew.donnellan@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gDQ20wmXzF09Y
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 10:16:58 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41gDQ209Zxz8vpy
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 10:16:58 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41gDQ13pGZz9s82
 for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2018 10:16:56 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7108ZdW136458
 for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2018 20:16:55 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kjv37we9d-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2018 20:16:55 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 1 Aug 2018 01:16:52 +0100
Subject: Re: [PATCH v2 2/2] selftests/powerpc: Add more version checks to
 alignment_handler test
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org
References: <20180731120842.32715-1-mpe@ellerman.id.au>
 <20180731120842.32715-2-mpe@ellerman.id.au>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 1 Aug 2018 10:16:45 +1000
MIME-Version: 1.0
In-Reply-To: <20180731120842.32715-2-mpe@ellerman.id.au>
Message-Id: <f58c9a15-6d86-2e8c-ffa6-174e9d1af728@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 31/07/18 22:08, Michael Ellerman wrote:
> The alignment_handler is documented to only work on Power8/Power9, but
> we can make it run on older CPUs by guarding more of the tests with
> feature checks.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Looks good to me.

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>   .../powerpc/alignment/alignment_handler.c          | 67 +++++++++++++++++++---
>   1 file changed, 59 insertions(+), 8 deletions(-)
> 
> v2: Don't incorrectly duplicate any of the tests, as noticed by @ajd.
> 
> diff --git a/tools/testing/selftests/powerpc/alignment/alignment_handler.c b/tools/testing/selftests/powerpc/alignment/alignment_handler.c
> index 0eddd16af49f..169a8b9719fb 100644
> --- a/tools/testing/selftests/powerpc/alignment/alignment_handler.c
> +++ b/tools/testing/selftests/powerpc/alignment/alignment_handler.c
> @@ -49,6 +49,8 @@
>   #include <setjmp.h>
>   #include <signal.h>
>   
> +#include <asm/cputable.h>
> +
>   #include "utils.h"
>   
>   int bufsize;
> @@ -289,6 +291,7 @@ int test_alignment_handler_vsx_206(void)
>   	int rc = 0;
>   
>   	SKIP_IF(!can_open_fb0());
> +	SKIP_IF(!have_hwcap(PPC_FEATURE_ARCH_2_06));
>   
>   	printf("VSX: 2.06B\n");
>   	LOAD_VSX_XFORM_TEST(lxvd2x);
> @@ -306,6 +309,7 @@ int test_alignment_handler_vsx_207(void)
>   	int rc = 0;
>   
>   	SKIP_IF(!can_open_fb0());
> +	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_2_07));
>   
>   	printf("VSX: 2.07B\n");
>   	LOAD_VSX_XFORM_TEST(lxsspx);
> @@ -380,7 +384,6 @@ int test_alignment_handler_integer(void)
>   	LOAD_DFORM_TEST(ldu);
>   	LOAD_XFORM_TEST(ldx);
>   	LOAD_XFORM_TEST(ldux);
> -	LOAD_XFORM_TEST(ldbrx);
>   	LOAD_DFORM_TEST(lmw);
>   	STORE_DFORM_TEST(stb);
>   	STORE_XFORM_TEST(stbx);
> @@ -400,8 +403,23 @@ int test_alignment_handler_integer(void)
>   	STORE_XFORM_TEST(stdx);
>   	STORE_DFORM_TEST(stdu);
>   	STORE_XFORM_TEST(stdux);
> -	STORE_XFORM_TEST(stdbrx);
>   	STORE_DFORM_TEST(stmw);
> +
> +	return rc;
> +}
> +
> +int test_alignment_handler_integer_206(void)
> +{
> +	int rc = 0;
> +
> +	SKIP_IF(!can_open_fb0());
> +	SKIP_IF(!have_hwcap(PPC_FEATURE_ARCH_2_06));
> +
> +	printf("Integer: 2.06\n");
> +
> +	LOAD_XFORM_TEST(ldbrx);
> +	STORE_XFORM_TEST(stdbrx);
> +
>   	return rc;
>   }
>   
> @@ -410,6 +428,7 @@ int test_alignment_handler_vmx(void)
>   	int rc = 0;
>   
>   	SKIP_IF(!can_open_fb0());
> +	SKIP_IF(!have_hwcap(PPC_FEATURE_HAS_ALTIVEC));
>   
>   	printf("VMX\n");
>   	LOAD_VMX_XFORM_TEST(lvx);
> @@ -441,20 +460,14 @@ int test_alignment_handler_fp(void)
>   	printf("Floating point\n");
>   	LOAD_FLOAT_DFORM_TEST(lfd);
>   	LOAD_FLOAT_XFORM_TEST(lfdx);
> -	LOAD_FLOAT_DFORM_TEST(lfdp);
> -	LOAD_FLOAT_XFORM_TEST(lfdpx);
>   	LOAD_FLOAT_DFORM_TEST(lfdu);
>   	LOAD_FLOAT_XFORM_TEST(lfdux);
>   	LOAD_FLOAT_DFORM_TEST(lfs);
>   	LOAD_FLOAT_XFORM_TEST(lfsx);
>   	LOAD_FLOAT_DFORM_TEST(lfsu);
>   	LOAD_FLOAT_XFORM_TEST(lfsux);
> -	LOAD_FLOAT_XFORM_TEST(lfiwzx);
> -	LOAD_FLOAT_XFORM_TEST(lfiwax);
>   	STORE_FLOAT_DFORM_TEST(stfd);
>   	STORE_FLOAT_XFORM_TEST(stfdx);
> -	STORE_FLOAT_DFORM_TEST(stfdp);
> -	STORE_FLOAT_XFORM_TEST(stfdpx);
>   	STORE_FLOAT_DFORM_TEST(stfdu);
>   	STORE_FLOAT_XFORM_TEST(stfdux);
>   	STORE_FLOAT_DFORM_TEST(stfs);
> @@ -466,6 +479,38 @@ int test_alignment_handler_fp(void)
>   	return rc;
>   }
>   
> +int test_alignment_handler_fp_205(void)
> +{
> +	int rc = 0;
> +
> +	SKIP_IF(!can_open_fb0());
> +	SKIP_IF(!have_hwcap(PPC_FEATURE_ARCH_2_05));
> +
> +	printf("Floating point: 2.05\n");
> +
> +	LOAD_FLOAT_DFORM_TEST(lfdp);
> +	LOAD_FLOAT_XFORM_TEST(lfdpx);
> +	LOAD_FLOAT_XFORM_TEST(lfiwax);
> +	STORE_FLOAT_DFORM_TEST(stfdp);
> +	STORE_FLOAT_XFORM_TEST(stfdpx);
> +
> +	return rc;
> +}
> +
> +int test_alignment_handler_fp_206(void)
> +{
> +	int rc = 0;
> +
> +	SKIP_IF(!can_open_fb0());
> +	SKIP_IF(!have_hwcap(PPC_FEATURE_ARCH_2_06));
> +
> +	printf("Floating point: 2.06\n");
> +
> +	LOAD_FLOAT_XFORM_TEST(lfiwzx);
> +
> +	return rc;
> +}
> +
>   void usage(char *prog)
>   {
>   	printf("Usage: %s [options]\n", prog);
> @@ -513,9 +558,15 @@ int main(int argc, char *argv[])
>   			   "test_alignment_handler_vsx_300");
>   	rc |= test_harness(test_alignment_handler_integer,
>   			   "test_alignment_handler_integer");
> +	rc |= test_harness(test_alignment_handler_integer_206,
> +			   "test_alignment_handler_integer_206");
>   	rc |= test_harness(test_alignment_handler_vmx,
>   			   "test_alignment_handler_vmx");
>   	rc |= test_harness(test_alignment_handler_fp,
>   			   "test_alignment_handler_fp");
> +	rc |= test_harness(test_alignment_handler_fp_205,
> +			   "test_alignment_handler_fp_205");
> +	rc |= test_harness(test_alignment_handler_fp_206,
> +			   "test_alignment_handler_fp_206");
>   	return rc;
>   }
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
