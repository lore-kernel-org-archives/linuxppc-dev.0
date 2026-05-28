Return-Path: <linuxppc-dev+bounces-21614-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9705FCD5BC9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2026 03:17:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQs9k1ptDz2xR4;
	Thu, 28 May 2026 13:17:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779938250;
	cv=none; b=HaQ+nqercEyP/Qs2XAfAs8TjWgvLByCuzheAGAFIRVO0zWl+2IMdUl9xoQiCXmMAMpodW3j7Kkdve/Zh2RQlxrvlGXhmi3foo8fbJ1JlXNdfC13O34RXEuWFJf+/LRPNCT+KNub8MfmC7pSdCvk/czMmdNijGSrZP6PpZvOia8gy5K/0ueriY8RyZ1WgXAW/KvgDHLZt0UMcgWS1qMitkdZWWo9Ojxvk7hVFMKD+Umm4PEM//4RG7DhTyrY2sKVlgjyDLFi9hI0HDarb+58o+Paw3uUkd3sTerkSkNyM7G4Cq9yVfYoF+3HMuIPrszXXcT/iVHk6s39szanPKaBAog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779938250; c=relaxed/relaxed;
	bh=Aw74MRuVap+euim+m8O+eFhYn9p3tagNAama2H6na1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gTJZ8GkmpLxcryj1MTE/bfidEbk1tM17voh5+43pYhaI7ytpt7C9a6n0bg+HHRfK3Vfl00pWK6e9XgtoyS7ugw0AWQzGe7kul7nJ0fZ7VjCm3KIZwLKLmCPjnIdQP+Bbo6R0KuEwo6nxA6dV10HChFVM6rMlr58p2WU2pEYT4bJAgqC7n1Hn9AKC6f5nqCG6DTlzIr200nkq6MbPDkhUjvFjbJIHBU5bm5z5d3SKIQjsY702poybpBv3bt3h2pJFkIyc6OZaK13/Jvgf7j+MZjPSqp+fcPHxS0AWS2sdida1QentvuxQRAqoSufLkvEqfBgPUwlzIjxo9sqQRbo6kg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dxYcDD9V; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=xueshuai@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dxYcDD9V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=xueshuai@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQs9h34s7z2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 13:17:27 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779938243; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Aw74MRuVap+euim+m8O+eFhYn9p3tagNAama2H6na1E=;
	b=dxYcDD9VGTmcjD/5cnE29dU6lCDOdI9aXzRTJwMKQLvY0a0Qo1Xx+MgpjP1tLDWSoloREo542gLVN4wDognt8jXIu/iA09NQeIvR5k54jWlYTveNg9TzLOsj4wLGJvVwwKt27DO7x9k8m/6dVO7YfI6VtREhfEJlpnu8NlU2TRY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=27;SR=0;TI=SMTPD_---0X3lAIi6_1779938240;
Received: from 30.246.179.14(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X3lAIi6_1779938240 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 28 May 2026 11:17:21 +0800
Message-ID: <2e413153-c9e7-41dc-ad8e-522871381bf7@linux.alibaba.com>
Date: Thu, 28 May 2026 11:17:17 +0800
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 8/8] lib/tests: memcpy_kunit: add memcpy_mc() and
 memcpy_mc_large() test
To: Ruidong Tian <tianruidong@linux.alibaba.com>, catalin.marinas@arm.com,
 will@kernel.org, rafael@kernel.org, tony.luck@intel.com,
 guohanjun@huawei.com, mchehab@kernel.org, tongtiangen@huawei.com,
 james.morse@arm.com, robin.murphy@arm.com, andreyknvl@gmail.com,
 dvyukov@google.com, vincenzo.frascino@arm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, ryabinin.a.a@gmail.com, glider@google.com,
 christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
 naveen.n.rao@linux.ibm.com, tglx@linutronix.de, mingo@redhat.com
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com
References: <20260518084956.2538442-1-tianruidong@linux.alibaba.com>
 <20260518084956.2538442-9-tianruidong@linux.alibaba.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260518084956.2538442-9-tianruidong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/18/26 4:49 PM, Ruidong Tian wrote:
> memcpy_mc() is the Machine-Check safe memcpy variant that returns the
> number of bytes NOT copied on a hardware memory error, or 0 on success.
> 
> Add two test cases modeled after the existing memcpy_test() and
> memcpy_large_test() implementations:

Same build issue as with copy_mc_page_test: memcpy_mc() is an arm64-
only symbol.

1. Cross-architecture build break (BLOCKER, same as patch 6)

    These tests are gated on CONFIG_ARCH_HAS_COPY_MC, which is also
    selected by x86_64 and ppc64. Neither architecture provides a
    memcpy_mc() symbol -- they use copy_mc_to_kernel() directly.

    On x86_64:

        lib/tests/memcpy_kunit.c: error: implicit declaration of
        function 'memcpy_mc' [-Werror=implicit-function-declaration]

    Fix: guard with __HAVE_ARCH_MEMCPY_MC instead:

        #ifdef __HAVE_ARCH_MEMCPY_MC
        static void memcpy_mc_test(...) { ... }
        static void memcpy_mc_large_test(...) { ... }
        #endif


> 
> Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
> ---
>   lib/tests/memcpy_kunit.c | 113 ++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 112 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/tests/memcpy_kunit.c b/lib/tests/memcpy_kunit.c
> index 85df53ccfb0c..b4b2dafb50f1 100644
> --- a/lib/tests/memcpy_kunit.c
> +++ b/lib/tests/memcpy_kunit.c
> @@ -552,6 +552,115 @@ static void copy_mc_page_test(struct kunit *test)
>   		memcmp(page_dst + PAGE_SIZE, page_zero, PAGE_SIZE), 0,
>   		"copy_mc_page overflow into adjacent page");
>   }
> +/*
> + * memcpy_mc() is a Machine-Check safe memcpy variant.
> + * Signature: int memcpy_mc(void *dst, const void *src, size_t len)
> + * Returns:   0 on success, or number of bytes NOT copied on MC error.
> + *
> + * In the normal (no-poison) path it must behave identically to memcpy()
> + * and always return 0.
> + */
> +static void memcpy_mc_test(struct kunit *test)
> +{
> +#define TEST_OP "memcpy_mc"
> +	struct some_bytes control = {
> +		.data = { 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
> +			  0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
> +			  0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
> +			  0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
> +		},
> +	};
> +	struct some_bytes zero = { };
> +	struct some_bytes middle = {
> +		.data = { 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
> +			  0x20, 0x20, 0x20, 0x20, 0x00, 0x00, 0x00, 0x00,
> +			  0x00, 0x00, 0x00, 0x20, 0x20, 0x20, 0x20, 0x20,
> +			  0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
> +		},
> +	};
> +	struct some_bytes three = {
> +		.data = { 0x00, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
> +			  0x20, 0x00, 0x00, 0x20, 0x20, 0x20, 0x20, 0x20,
> +			  0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
> +			  0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
> +			},
> +	};
> +	struct some_bytes dest = { };
> +	int ret, count;
> +	u8 *ptr;
> +
> +	/* Verify static initializers. */
> +	check(control, 0x20);
> +	check(zero, 0);
> +	compare("static initializers", dest, zero);
> +
> +	/* Verify assignment. */
> +	dest = control;
> +	compare("direct assignment", dest, control);
> +
> +	/* Verify complete overwrite. */
> +	ret = memcpy_mc(dest.data, control.data, sizeof(dest.data));
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +	compare("complete overwrite", dest, control);
> +
> +	/* Verify middle overwrite: 7 bytes at offset 12. */
> +	dest = control;
> +	ret = memcpy_mc(dest.data + 12, zero.data, 7);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +	compare("middle overwrite", dest, middle);
> +
> +	/* Verify zero-length copy is a no-op. */
> +	dest = control;
> +	ret = memcpy_mc(dest.data, zero.data, 0);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +	compare("zero length", dest, control);
> +
> +	/* Verify argument side-effects aren't repeated. */
> +	dest = control;
> +	ptr = dest.data;
> +	count = 1;
> +	memcpy(ptr++, zero.data, count++);
> +	ptr += 8;
> +	memcpy(ptr++, zero.data, count++);


    This is a verbatim paste from memcpy_test(). The intent is to
    verify that the memcpy_mc macro doesn't double-evaluate arguments,
    but the test doesn't actually call memcpy_mc(). Please change the
    two memcpy() calls to memcpy_mc() and assert their return values.

Thanks
Shuai

