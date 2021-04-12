Return-Path: <SRS0=//ir=JJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279B6C433ED
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Apr 2021 11:02:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75CDD61074
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Apr 2021 11:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75CDD61074
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FJm681T9bz30KH
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Apr 2021 21:02:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FJm5m2YNyz2xZM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Apr 2021 21:02:00 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4FJm5X3TZzz9tyQf;
 Mon, 12 Apr 2021 13:01:52 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id uqxnhjxGkXvi; Mon, 12 Apr 2021 13:01:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4FJm5X2L2kz9tyQd;
 Mon, 12 Apr 2021 13:01:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 44C598B78F;
 Mon, 12 Apr 2021 13:01:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id zdhaUy4GMB_D; Mon, 12 Apr 2021 13:01:57 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 41C188B78D;
 Mon, 12 Apr 2021 13:01:56 +0200 (CEST)
Subject: Re: [PATCH] powerpc: alignment: Remove unneeded variables
To: Wan Jiabing <wanjiabing@vivo.com>, Michael Ellerman <mpe@ellerman.id.au>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Shuah Khan <shuah@kernel.org>,
 Jordan Niethe <jniethe5@gmail.com>, Michael Neuling <mikey@neuling.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20210412095923.3916-1-wanjiabing@vivo.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <8cca3679-f932-fbd7-fb6f-f5c2e641aec0@csgroup.eu>
Date: Mon, 12 Apr 2021 13:01:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210412095923.3916-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: kael_w@yeah.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 12/04/2021 à 11:59, Wan Jiabing a écrit :
> Fix coccicheck warning:

Can you mention in the commit subject that it is selftests and not the core part of powerpc which is 
addressed here ?

> 
> ./tools/testing/selftests/powerpc/alignment/alignment_handler.c:539:5-7:
> Unneeded variable: "rc". Return "0" on line 562
> ./tools/testing/selftests/powerpc/alignment/alignment_handler.c:567:5-7:
> Unneeded variable: "rc". Return "0" on line 580
> ./tools/testing/selftests/powerpc/alignment/alignment_handler.c:585:5-7:
> Unneeded variable: "rc". Return "0" on line 594
> ./tools/testing/selftests/powerpc/alignment/alignment_handler.c:600:5-7:
> Unneeded variable: "rc". Return "0" on line 611
> ./tools/testing/selftests/powerpc/alignment/alignment_handler.c:416:5-7:
> Unneeded variable: "rc". Return "0" on line 470
> ./tools/testing/selftests/powerpc/alignment/alignment_handler.c:475:5-7:
> Unneeded variable: "rc". Return "0" on line 485
> ./tools/testing/selftests/powerpc/alignment/alignment_handler.c:490:5-7:
> Unneeded variable: "rc". Return "0" on line 506
> ./tools/testing/selftests/powerpc/alignment/alignment_handler.c:511:5-7:
> Unneeded variable: "rc". Return "0" on line 534
> ./tools/testing/selftests/powerpc/alignment/alignment_handler.c:331:5-7:
> Unneeded variable: "rc". Return "0" on line 344
> ./tools/testing/selftests/powerpc/alignment/alignment_handler.c:349:5-7:
> Unneeded variable: "rc". Return "0" on line 360
> ./tools/testing/selftests/powerpc/alignment/alignment_handler.c:365:5-7:
> Unneeded variable: "rc". Return "0" on line 392
> ./tools/testing/selftests/powerpc/alignment/alignment_handler.c:397:5-7:
> Unneeded variable: "rc". Return "0" on line 411
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>   .../powerpc/alignment/alignment_handler.c     | 48 +++++--------------
>   1 file changed, 12 insertions(+), 36 deletions(-)
> 
> diff --git a/tools/testing/selftests/powerpc/alignment/alignment_handler.c b/tools/testing/selftests/powerpc/alignment/alignment_handler.c
> index c25cf7cd45e9..48bfb7b36d84 100644
> --- a/tools/testing/selftests/powerpc/alignment/alignment_handler.c
> +++ b/tools/testing/selftests/powerpc/alignment/alignment_handler.c
> @@ -328,8 +328,6 @@ static bool can_open_cifile(void)
>   
>   int test_alignment_handler_vsx_206(void)
>   {
> -	int rc = 0;
> -
>   	SKIP_IF(!can_open_cifile());
>   	SKIP_IF(!have_hwcap(PPC_FEATURE_ARCH_2_06));
>   
> @@ -341,13 +339,11 @@ int test_alignment_handler_vsx_206(void)
>   	STORE_VSX_XFORM_TEST(stxvd2x);
>   	STORE_VSX_XFORM_TEST(stxvw4x);
>   	STORE_VSX_XFORM_TEST(stxsdx);
> -	return rc;
> +	return 0;
>   }
>   
>   int test_alignment_handler_vsx_207(void)
>   {
> -	int rc = 0;
> -
>   	SKIP_IF(!can_open_cifile());
>   	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_2_07));
>   
> @@ -357,13 +353,11 @@ int test_alignment_handler_vsx_207(void)
>   	LOAD_VSX_XFORM_TEST(lxsiwzx);
>   	STORE_VSX_XFORM_TEST(stxsspx);
>   	STORE_VSX_XFORM_TEST(stxsiwx);
> -	return rc;
> +	return 0;
>   }
>   
>   int test_alignment_handler_vsx_300(void)
>   {
> -	int rc = 0;
> -
>   	SKIP_IF(!can_open_cifile());
>   
>   	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_00));
> @@ -389,13 +383,11 @@ int test_alignment_handler_vsx_300(void)
>   	STORE_VSX_XFORM_TEST(stxvx);
>   	STORE_VSX_XFORM_TEST(stxvl);
>   	STORE_VSX_XFORM_TEST(stxvll);
> -	return rc;
> +	return 0;
>   }
>   
>   int test_alignment_handler_vsx_prefix(void)
>   {
> -	int rc = 0;
> -
>   	SKIP_IF(!can_open_cifile());
>   	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_1));
>   
> @@ -408,13 +400,11 @@ int test_alignment_handler_vsx_prefix(void)
>   	STORE_VSX_8LS_PREFIX_TEST(PSTXSSP, 0);
>   	STORE_VSX_8LS_PREFIX_TEST(PSTXV0, 0);
>   	STORE_VSX_8LS_PREFIX_TEST(PSTXV1, 1);
> -	return rc;
> +	return 0;
>   }
>   
>   int test_alignment_handler_integer(void)
>   {
> -	int rc = 0;
> -
>   	SKIP_IF(!can_open_cifile());
>   
>   	printf("Integer\n");
> @@ -467,13 +457,11 @@ int test_alignment_handler_integer(void)
>   	STORE_DFORM_TEST(stmw);
>   #endif
>   
> -	return rc;
> +	return 0;
>   }
>   
>   int test_alignment_handler_integer_206(void)
>   {
> -	int rc = 0;
> -
>   	SKIP_IF(!can_open_cifile());
>   	SKIP_IF(!have_hwcap(PPC_FEATURE_ARCH_2_06));
>   
> @@ -482,13 +470,11 @@ int test_alignment_handler_integer_206(void)
>   	LOAD_XFORM_TEST(ldbrx);
>   	STORE_XFORM_TEST(stdbrx);
>   
> -	return rc;
> +	return 0;
>   }
>   
>   int test_alignment_handler_integer_prefix(void)
>   {
> -	int rc = 0;
> -
>   	SKIP_IF(!can_open_cifile());
>   	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_1));
>   
> @@ -503,13 +489,11 @@ int test_alignment_handler_integer_prefix(void)
>   	STORE_MLS_PREFIX_TEST(PSTH);
>   	STORE_MLS_PREFIX_TEST(PSTW);
>   	STORE_8LS_PREFIX_TEST(PSTD);
> -	return rc;
> +	return 0;
>   }
>   
>   int test_alignment_handler_vmx(void)
>   {
> -	int rc = 0;
> -
>   	SKIP_IF(!can_open_cifile());
>   	SKIP_IF(!have_hwcap(PPC_FEATURE_HAS_ALTIVEC));
>   
> @@ -531,13 +515,11 @@ int test_alignment_handler_vmx(void)
>   	STORE_VMX_XFORM_TEST(stvehx);
>   	STORE_VMX_XFORM_TEST(stvewx);
>   	STORE_VMX_XFORM_TEST(stvxl);
> -	return rc;
> +	return 0;
>   }
>   
>   int test_alignment_handler_fp(void)
>   {
> -	int rc = 0;
> -
>   	SKIP_IF(!can_open_cifile());
>   
>   	printf("Floating point\n");
> @@ -559,13 +541,11 @@ int test_alignment_handler_fp(void)
>   	STORE_FLOAT_XFORM_TEST(stfsux);
>   	STORE_FLOAT_XFORM_TEST(stfiwx);
>   
> -	return rc;
> +	return 0;
>   }
>   
>   int test_alignment_handler_fp_205(void)
>   {
> -	int rc = 0;
> -
>   	SKIP_IF(!can_open_cifile());
>   	SKIP_IF(!have_hwcap(PPC_FEATURE_ARCH_2_05));
>   
> @@ -577,13 +557,11 @@ int test_alignment_handler_fp_205(void)
>   	STORE_FLOAT_DFORM_TEST(stfdp);
>   	STORE_FLOAT_XFORM_TEST(stfdpx);
>   
> -	return rc;
> +	return 0;
>   }
>   
>   int test_alignment_handler_fp_206(void)
>   {
> -	int rc = 0;
> -
>   	SKIP_IF(!can_open_cifile());
>   	SKIP_IF(!have_hwcap(PPC_FEATURE_ARCH_2_06));
>   
> @@ -591,14 +569,12 @@ int test_alignment_handler_fp_206(void)
>   
>   	LOAD_FLOAT_XFORM_TEST(lfiwzx);
>   
> -	return rc;
> +	return 0;
>   }
>   
>   
>   int test_alignment_handler_fp_prefix(void)
>   {
> -	int rc = 0;
> -
>   	SKIP_IF(!can_open_cifile());
>   	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_1));
>   
> @@ -608,7 +584,7 @@ int test_alignment_handler_fp_prefix(void)
>   	LOAD_FLOAT_MLS_PREFIX_TEST(PLFD);
>   	STORE_FLOAT_MLS_PREFIX_TEST(PSTFS);
>   	STORE_FLOAT_MLS_PREFIX_TEST(PSTFD);
> -	return rc;
> +	return 0;
>   }
>   
>   void usage(char *prog)
> 
