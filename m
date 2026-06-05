Return-Path: <linuxppc-dev+bounces-22097-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE83CD6E5D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 05:21:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWqYK2HSBz2xnK;
	Fri, 05 Jun 2026 15:21:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.242.92
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780636655;
	cv=none; b=mV7LwjfVQBtqjSCGeG2LY/1tbSDNDlqWkeSqFJMaDrSWwdF5MMOb9/Ln3lgk2zoJfNn+xKgVH+mLXMKMyK7LvcHyTPAalbIUFh1Q0d76yYFLH46mw9alNMjvkNQstay79hdmPf4RPYzKsMX4XQxdYVAYSqx7D8BnK+Hd2sWPTVvilAO77ZfBwCuYpLn52mTSYpTC8yoH/el2DmthOGDxLw2GKASXLPqP8oxm6nGNRxDImUpnvYu1MPgnu8CxkpIKj5iTzCCB2sdMrU45IWsfsk3PrsGRvKlAyAC3Te9GT/rvzGYRjdnRzQ1XFBJUMih+Mrdf+UiaSuHetw56O02Mgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780636655; c=relaxed/relaxed;
	bh=H1e39pipjV4KwuNzj664fdzb5PjIB1uthg5jQPiGifY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QW+O1Lnu8yFvi2QxgJZXtLtWD6jSe0GTnk+3E4CJYnDwtZ94MMuH3kE0AUMjQ8Tq3sH/QAVOjZxOEwd6pRxsbzjbVzLcfEgIt740ceg0hlLRcjIbbKfkkvqloqwSoOsANZnPwY82hFACzvMNoupJV96HT8yi+kzs8OEtEBvHiqO0lPAFlpQqOtR1Zt9d1+oRR/dMywBrVw+xMYtl3KaeaCIj7XbRI6Aaz0Ky8JJavu4DdNDCpeTrR9tnHWJN0wXqEtl72gOmt7wqwMF5MjZAzlXl2ZMTUttpEhGkz5rZHCxF/DcS3sfjBer8SGEDSUkQC+ZsGHJlBENkFDLhv1R0cQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=davidgow.net; dkim=pass (4096-bit key; unprotected) header.d=davidgow.net header.i=@davidgow.net header.a=rsa-sha256 header.s=201606 header.b=V/EwKI+P; dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.a=rsa-sha256 header.s=201606 header.b=V/EwKI+P; dkim-atps=neutral; spf=pass (client-ip=203.29.242.92; helo=sphereful.davidgow.net; envelope-from=david@davidgow.net; receiver=lists.ozlabs.org) smtp.mailfrom=davidgow.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=davidgow.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=davidgow.net header.i=@davidgow.net header.a=rsa-sha256 header.s=201606 header.b=V/EwKI+P;
	dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.a=rsa-sha256 header.s=201606 header.b=V/EwKI+P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=davidgow.net (client-ip=203.29.242.92; helo=sphereful.davidgow.net; envelope-from=david@davidgow.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 459 seconds by postgrey-1.37 at boromir; Fri, 05 Jun 2026 15:17:33 AEST
Received: from sphereful.davidgow.net (sphereful.davidgow.net [203.29.242.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWqSY4LPJz2xMW
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 15:17:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
	s=201606; t=1780636223;
	bh=2ZcqJXsmrbBpKhPyQMBIArzTEmFadM28MZ9/IfA+daU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V/EwKI+P6zhGP/r+9Mgv1zGYkS6O2PmVkcNNbGkxK2aaZ3eQl28uPRTETnnKIHUAG
	 jRb5VIO5EENKtZeAjgx/7pYyjO1N0xweA+j/ZcpHbDKf+CU4/qOuPYsZIxwkkRwwZA
	 flwnKLo6WNoA+QNR76TetVK7aimJ869zkEy4faHYQu3ADslDPBFmzQVxUlEmCPEMtH
	 9gnJ5NLFc6YdKH1SUHycaIGw/n8hv6NYWsOtRkDJdPbPhYjg+vENHmgtgug79+Qq2D
	 R1Te/zMEPRZ/tgoaLPFaRNajqwkmPUhag658oGaOQJ38ExzxeWlcABaxcUvizbShqE
	 vbTLOkCsPAEMC/cmiv7pozXXdTClxWmx5iD/VCxql+bJDt+sLgslpnMspN5WwQK6xP
	 CMSR2NqLG6fcdH0MMHqgp631RSU1xMlncHjf/vhyI94YSIdVeaq1ls4Bfztul1GFh9
	 GPD/UxBBLFqyGyg8NPmu0d23Zik84n4X2Ro7SfiYoP7Ai0e2SGAYQosIk5c/+5gHTG
	 Tmni9MdVXodKjxsixFVqQ8vdmnbh8dr009fYLjs87RIEOtknIkiYh5izg7tUGfqBMS
	 DHrGiwRPiJF++h3nxIUPPwyyi/sK6ppHNTU7GTLV11JnCXmtvHze0n+CEd0irOJ5fo
	 nk6QszY6ojbVT3ZTsNuevO4o=
Received: by sphereful.davidgow.net (Postfix, from userid 119)
	id C1EDA1E920A; Fri,  5 Jun 2026 13:10:23 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
	s=201606; t=1780636223;
	bh=2ZcqJXsmrbBpKhPyQMBIArzTEmFadM28MZ9/IfA+daU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V/EwKI+P6zhGP/r+9Mgv1zGYkS6O2PmVkcNNbGkxK2aaZ3eQl28uPRTETnnKIHUAG
	 jRb5VIO5EENKtZeAjgx/7pYyjO1N0xweA+j/ZcpHbDKf+CU4/qOuPYsZIxwkkRwwZA
	 flwnKLo6WNoA+QNR76TetVK7aimJ869zkEy4faHYQu3ADslDPBFmzQVxUlEmCPEMtH
	 9gnJ5NLFc6YdKH1SUHycaIGw/n8hv6NYWsOtRkDJdPbPhYjg+vENHmgtgug79+Qq2D
	 R1Te/zMEPRZ/tgoaLPFaRNajqwkmPUhag658oGaOQJ38ExzxeWlcABaxcUvizbShqE
	 vbTLOkCsPAEMC/cmiv7pozXXdTClxWmx5iD/VCxql+bJDt+sLgslpnMspN5WwQK6xP
	 CMSR2NqLG6fcdH0MMHqgp631RSU1xMlncHjf/vhyI94YSIdVeaq1ls4Bfztul1GFh9
	 GPD/UxBBLFqyGyg8NPmu0d23Zik84n4X2Ro7SfiYoP7Ai0e2SGAYQosIk5c/+5gHTG
	 Tmni9MdVXodKjxsixFVqQ8vdmnbh8dr009fYLjs87RIEOtknIkiYh5izg7tUGfqBMS
	 DHrGiwRPiJF++h3nxIUPPwyyi/sK6ppHNTU7GTLV11JnCXmtvHze0n+CEd0irOJ5fo
	 nk6QszY6ojbVT3ZTsNuevO4o=
Received: from [IPV6:2001:8003:8810:ea00:ed87:ca88:5326:e11d] (unknown [IPv6:2001:8003:8810:ea00:ed87:ca88:5326:e11d])
	by sphereful.davidgow.net (Postfix) with ESMTPSA id 29C521E9208;
	Fri,  5 Jun 2026 13:10:23 +0800 (AWST)
Message-ID: <d7b56622-6455-4e80-844f-086a0a3b1946@davidgow.net>
Date: Fri, 5 Jun 2026 13:10:20 +0800
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
Subject: Re: [PATCH 2/2] kunit: Add example of test suite that can be skipped
 at runtime
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <raemoar63@gmail.com>
References: <20260604162805.556135-1-vaibhav@linux.ibm.com>
 <20260604162805.556135-3-vaibhav@linux.ibm.com>
From: David Gow <david@davidgow.net>
Content-Language: fr
In-Reply-To: <20260604162805.556135-3-vaibhav@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 05/06/2026 à 12:28 AM, Vaibhav Jain a écrit :
> Add an example test suite name 'example_test_skip_suite' to
> 'kunit-example-test.c' that shows how to skip an entire test suite based on
> runtime conditions.
> 
> The example suite 'example_skip_suite' provides a 'suite_init' callback
> named example_skip_suite_init() which marks the entire suite as skipped
> using kunit_mark_skipped().
> 
> This demonstrates a way for conditionally skipping test suites when any
> prerequisites for kunit_suite execution are not met. The 'suite_init'
> callback can perform any necessary checks and mark the suite as skipped,
> preventing all test cases from executing while also indicating why the
> suite was skipped.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---

Thanks!

Reviewed-by: David Gow <david@davidgow.net>

Cheers,
-- David

>  lib/kunit/kunit-example-test.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
> index 0bae7b7ca0b0..b8ded54fa46d 100644
> --- a/lib/kunit/kunit-example-test.c
> +++ b/lib/kunit/kunit-example-test.c
> @@ -591,5 +591,34 @@ static struct kunit_suite example_init_test_suite = {
>   */
>  kunit_test_init_section_suites(&example_init_test_suite);
>  
> +/*
> + * This test should always be skipped.
> + */
> +static void example_skip_suite_test(struct kunit *test)
> +{
> +	/* This line should never be seen */
> +	KUNIT_FAIL(test, "You should not see a this.");
> +}
> +
> +static struct kunit_case  example_skip_suite_test_cases[] = {
> +	KUNIT_CASE(example_skip_suite_test),
> +	{}
> +};
> +
> +static int example_skip_suite_init(struct kunit_suite *suite)
> +{
> +	kunit_mark_skipped(suite, "Test suite expected to be skipped");
> +	return 0;
> +}
> +
> +static struct kunit_suite example_test_skip_suite = {
> +	.name = "example_skip_suite",
> +	.suite_init = example_skip_suite_init,
> +	.test_cases = example_skip_suite_test_cases,
> +};
> +
> +/* This registers a test suite that will be skipped */
> +kunit_test_suite(example_test_skip_suite);
> +
>  MODULE_DESCRIPTION("Example KUnit test suite");
>  MODULE_LICENSE("GPL v2");


