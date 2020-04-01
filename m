Return-Path: <SRS0=4P7+=5R=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A5EC43331
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2020 03:39:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89A4520772
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2020 03:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="bwEQGMbb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A4520772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48sX4l11YyzDqyB
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2020 14:39:35 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48sX2Q1hdPzDqvY
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2020 14:37:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=bwEQGMbb; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 48sX2P44kRz9sPF;
 Wed,  1 Apr 2020 14:37:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1585712253;
 bh=67EUNvcwDnTByTJa6D9p17NeqFs9S6BMU3vJ1BaQew0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=bwEQGMbbZOsaGu3z2Z0eGw2pC+YxaflIMg0kulI501D4cqM97HYqG+yJfEvPaEJb2
 bw7Sg8SQz0jDzfmwftlqj76yTh3u22F1HPdsuqZtgmuRbiyVVx9OSOM6jAN9P8Z+VE
 QKRUvcwpFEoaQFoE2Vih6hAfrdzbR9+7+hykkN4WXUAxsvPVE6aLDrlGAhhcE8B40x
 F/+4z8nCR6tW+OPk4ofXIAdva9sYBk7uA3VAhKnFh4FWgK96ytiMEW7gtKiMgwBHPT
 PkxB+t9lfVL/L4suUAAk2s2va9RNzyuuVuf3GbVsCBV2RxEx90jkiyA2njOBmR7Z91
 9JdvA2prTEZaQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Shuah Khan <skhan@linuxfoundation.org>,
 Sandipan Das <sandipan@linux.ibm.com>, shuah@kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/2] selftests: vm: Build fixes for powerpc64
In-Reply-To: <4837525c-c078-0e33-614e-103514946ff9@linuxfoundation.org>
References: <cover.1580367152.git.sandipan@linux.ibm.com>
 <4837525c-c078-0e33-614e-103514946ff9@linuxfoundation.org>
Date: Wed, 01 Apr 2020 14:37:40 +1100
Message-ID: <87a73vvptn.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: aneesh.kumar@linux.ibm.com, kamalesh@linux.vnet.ibm.com, linux-mm@kvack.org,
 mhiramat@kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Shuah Khan <skhan@linuxfoundation.org> writes:
> On 1/30/20 12:01 AM, Sandipan Das wrote:
>> The second patch was already posted independently but because
>> of the changes in the first patch, the second one now depends
>> on it. Hence posting it now as a part of this series.
>> 
>> The last version (v2) of the second patch can be found at:
>> https://patchwork.ozlabs.org/patch/1225969/
>> 
>> Sandipan Das (2):
>>    selftests: vm: Do not override definition of ARCH
>>    selftests: vm: Fix 64-bit test builds for powerpc64le
>> 
>>   tools/testing/selftests/vm/Makefile    | 4 ++--
>>   tools/testing/selftests/vm/run_vmtests | 2 +-
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>> 
>
> Michael,
>
> I see your tested-by on these two patches. I will take these
> through kselftest fixes.

Thanks.

cheers
