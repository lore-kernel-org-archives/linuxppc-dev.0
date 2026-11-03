Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1AE606A335
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 23:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WWfjxEf8
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jK4g04gsqz2xKQ;
	Wed, 04 Nov 2026 10:34:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793748892;
	cv=none; b=c6SJw0kx/bNlZFQ4wCSFheacH3bK1Y+Me8/ouom2Wu5M8SJotrrgHEoMImX0jjxxPlDsn1YICkh2W4FykrME4oHfh9XT2pBqqwcO/w22VrcdloxbXMR4hjHbpLFWGzM24q829Im5dVjmtTS627ONU3HF1UqUUY57CofgHAaPZmLj9QJC9Xnb9Uypp7IM1pL1btt2FLonBP/yP2d7ZMQyfT8qVwYXk1P2RiMtOvrqlfQpGtDvmELRXhYv08sIusWFqIu1CYYC5HAkFhi8wyP5/DOQczqBY2cJp730DlvSkdgIhQJhUuU6KceR0ZB2bCLD2aqLlE0b3guYm4u6VPP21w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793748892; c=relaxed/relaxed;
	bh=Oc5pGUxi8G3lFQzA+IOSJJX8PHV/w0+Vbyoey5Zk2XA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wo6K7cyR4nep46e66JM6M80XSFH200smd3a1c3i2UETco7cUXy7Q42NGcPWezeZg+6yCcfbsKVQ/npzeMADVVI4pADfG+Pa8Cq+Y7WU270Zn/amT5F49HckJgEyqFH3A5UHoiiRn5cp8UVHR1pRb4GEGKe958YwLilLJXl1KSIb2Gu9+MAfMz3/+itEDWRsixtgSF2yMuKk3VRzq+m1tVYPYlyHk+QkX2LrEFp40vdXNohw6dUjIsGy0EccnUteKuqj1cGdqYSrLTVpBhk3+XgZaDRa1Oh4nHx9ervPfnh05t1X+i2aGNjdaErE9mZ/tAWyXxXizQAVxerlbHzdAzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WWfjxEf8; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=mpe@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WWfjxEf8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=mpe@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jK4fz402Jz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 10:34:51 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0E67D43F2F;
	Tue,  3 Nov 2026 23:34:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1301F0093A;
	Tue,  3 Nov 2026 23:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793748888;
	bh=Oc5pGUxi8G3lFQzA+IOSJJX8PHV/w0+Vbyoey5Zk2XA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WWfjxEf8TWpELH6Er7tK8jaF6FdmBbxrMa99unOofps685Zd21povaIP8uFqwElh8
	 7mxcUNV+gd1XHN7WLusLEn1byMDIpWAG55ctKUyRGrqUI7zdZlGYhQzIy0Qs8kvdn4
	 qIWP3wi1KG8ywH9srmFdkwRC1YJON5iFpHmhaTDV9P8NEzJIKowQa0IcJu0vmUy0Ff
	 HdMjOmnBdVpVQwIGIb8EJv9Fx4BFUPphEdY6N8dYaWqvbG/rS5rq5QWUjzZqsRuNXB
	 7XbCq07+wCRancyrOKDoPrJiih3tsRwN5EQkvAx3A0LAtT00q3pn1iWDFFK983AeOc
	 2n0H6pOFi9kKg==
Message-ID: <76dffd89-e5b6-46cc-96b1-f68ac6cc87c0@kernel.org>
Date: Wed, 4 Nov 2026 10:34:44 +1100
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/powerpc: override EMIT_TESTS instead of the
 emit_tests rule
To: Sasha Levin <sashal@kernel.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Shuah Khan <shuah@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261103232307.1924618-3-sashal@kernel.org>
Content-Language: en-US
From: Michael Ellerman <mpe@kernel.org>
In-Reply-To: <20261103232307.1924618-3-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 4/11/26 10:23 am, Sasha Levin wrote:
> The powerpc Makefiles include lib.mk and then define their own
> emit_tests rule, so every selftests build that includes powerpc warns,
> on any architecture:
> 
>    Makefile:60: warning: overriding recipe for target 'emit_tests'
>    ../lib.mk:183: warning: ignoring old recipe for target 'emit_tests'
> 
> lib.mk used to keep the recipe in an EMIT_TESTS variable that Makefiles
> could override, as they still do with RUN_TESTS, INSTALL_RULE and
> CLEAN. Commit d4e59a536f50 ("selftests: Use runner.sh for emit
> targets") dropped the variable, and commit 58b33e78a317
> ("selftests/powerpc: Fix emit_tests to work with run_kselftest.sh")
> then replaced the powerpc EMIT_TESTS definitions with rules.
> 
> Bring EMIT_TESTS back in lib.mk and override it in the powerpc Makefiles
> again. Mark the lib.mk recipe with '+', so that the powerpc sub-makes
> still get the jobserver, as they did when $(MAKE) was in the rule
> itself. The emitted test lists don't change.
> 
> Fixes: 58b33e78a317 ("selftests/powerpc: Fix emit_tests to work with run_kselftest.sh")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
> Checked with "make ARCH=powerpc emit_tests" in
> tools/testing/selftests/powerpc, which lists the same 186 tests as
> before, and with an x86_64 selftests install, whose kselftest-list.txt
> doesn't change. make -j2 --jobserver-style=pipe doesn't warn about the
> jobserver.
> 
>   tools/testing/selftests/lib.mk               | 6 +++++-
>   tools/testing/selftests/powerpc/Makefile     | 3 ++-
>   tools/testing/selftests/powerpc/pmu/Makefile | 3 ++-
>   3 files changed, 9 insertions(+), 3 deletions(-)

Thanks, this is the right fix. I should have done this in 58b33e78a317 but
just wanted to get it fixed without touching lib.mk, which was lazy.

Acked-by: Michael Ellerman <mpe@kernel.org>

cheers


