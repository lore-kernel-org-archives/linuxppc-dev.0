Return-Path: <linuxppc-dev+bounces-23750-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81588C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 23:25:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvy515lJZz2ygX;
	Wed, 08 Jul 2026 09:25:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783466725;
	cv=none; b=Dx6tioTYt0FsVsxhviXtmzqP6iARJj/OZMovwSN2VphjTSjHOKNm0LTgdXIT+AqNlw/tCKyBDCJ3vPHIohXuU2ygb8x+fE4L8X5Fqnjb3kBArGIki+sY4hLcfrutpGSE8fDPwFQO53uSfuSlwfnzDAcm0RKsE7EzPxravdBrH0rd3Onv1me2Qn4nN0W83JUM7YZMw8kA//sInOmoXvzAFqv+BLYUknxlblTHNvV1jIysmk+IeRO8FXVfo/2NosFSM0ZBAjmZetK48qjmQHDt9FIefz/gIKTR0PMP44yv/zB2AXvZKKn3Dvtyb53KC6gxhvCbUb0DC9vaypEJpXyIoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783466725; c=relaxed/relaxed;
	bh=vqvYzcU0tp5QSJfTyNPQpTOuLqhjrEz7KwgIVfCBFAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RLe4+iwOWnOeKSaZPJYQXM8Z9JHnhoFEHq9UHkTRMNO0zydzmuhD8mZcnmJan2jIjZsi9QjdD+ZhkHc4g9geYQ4gyDsweNl6yO+XDRcZBEYp2GLXjlgtVZbP2mZKKymKspG6qfdgWQZ4Iews3UChN+RJ0+xTolTgs8fGwvbZBVOj/6qdOAIqTqFfRCjqxlbZLA0k0JTQtVtMqfhgiOiZ4IvbvI8fLXyicTU0GCSWJ7C7aICcrQcVWf+vza3qqfAKbviOarVP5JI/RwmKA7dQIu1o7m7p7f6ObOiq60mbcEPO9yoHrk2bKnLA1UQ9NrjBWzrldP1KZPmekbCGjJt1GA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=lreddFeQ; dkim-atps=neutral; spf=pass (client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org; envelope-from=erhard_f@mailbox.org; receiver=lists.ozlabs.org) smtp.mailfrom=mailbox.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=lreddFeQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mailbox.org (client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org; envelope-from=erhard_f@mailbox.org; receiver=lists.ozlabs.org)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bit raw public key) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvy4r3T57z2xm3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 09:25:14 +1000 (AEST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gvy4c1sx3z8v8K;
	Wed, 08 Jul 2026 01:25:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783466704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vqvYzcU0tp5QSJfTyNPQpTOuLqhjrEz7KwgIVfCBFAY=;
	b=lreddFeQoHLa1Xyd6Y4KkPd0RO2AD786VpeaTVEA2mWRO35oRc9A4pcPqeXshhyQ7qATKU
	eOJ2qllCRoADBij4MiCItoBnaLtmqZRLOuIchMAHo0rYdV2WAH0KNaoh4vjV6DhZ4rplw0
	Cp2Qrwsq98bR2GHmPE9/oDZMxzHhbq8ubCH9x0zadZohDCP8eaZS/LOquEhYAMUg7HKEtq
	MSg4q7HEolelRPkZzVC2nW8IhgF4pU9PQZ81tZzPsTW98gybdWtAA1wjq0b0IS2CNJukpW
	wYropi/VNbVvkjwHQubDGcgoKaIZA6MqNEQyHzUAdjd785OuSq5JXn3iAlixUw==
Message-ID: <b9b762d0-cfe1-4fdb-b668-b6ef4afb0059@mailbox.org>
Date: Wed, 8 Jul 2026 01:25:01 +0200
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
Subject: Re: test_bitmap fails on ppc/ppc64 on kernels v7.1.3, v7.2-rc2
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
References: <ca3547ae-8b79-43a2-a758-23ec980bfd9a@mailbox.org>
 <98d65de7-e5aa-4197-85bd-219eab01e572@kernel.org>
Content-Language: en-US, de-DE
From: Erhard Furtner <erhard_f@mailbox.org>
In-Reply-To: <98d65de7-e5aa-4197-85bd-219eab01e572@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 3151ac94355c5f55dc0
X-MBO-RS-META: 86s8qnt4tknem1r8n6pn6iix6dpmfk4h

>> test_bitmap: loaded.
>> test_bitmap: [lib/test_bitmap.c:397] bitmaps contents differ: expected 
>> "1,3-4,9", got "1,3-4,9,65-71,73-79,81-87,89-95,97-99"
>> test_bitmap: parselist('0-2047:128/256'):    912
>> test_bitmap: scnprintf("%*pbl", '0-32767'):    5977
>> test_bitmap: test_bitmap_read_perf:        1191082
>> test_bitmap: test_bitmap_write_perf:        1270153
>> test_bitmap: failed 1 out of 208655 tests
> 
> On QEMU (pmac32_defconfig) I get:
> 
> test_bitmap: loaded.
> test_bitmap: parselist('0-2047:128/256'):    2200
> test_bitmap: scnprintf("%*pbl", '0-32767'):    26440
> test_bitmap: test_bitmap_read_perf:        1819760
> test_bitmap: test_bitmap_write_perf:        18189840
> test_bitmap: all 208655 tests passed
> 
> On QEMU with your confirm I get:
> 
> [    1.162486] test_bitmap: loaded.
> [    1.177069] test_bitmap: [lib/test_bitmap.c:397] bitmaps contents 
> differ: expected "1,3-4,9", got "1,3-4,9,65-71,73-79,81-87,89-95,97-99"
> [    1.180599] test_bitmap: parselist('0-2047:128/256'):    2920
> [    1.190105] test_bitmap: scnprintf("%*pbl", '0-32767'):    65560
> [    1.427378] test_bitmap: test_bitmap_read_perf:        9546321
> [    1.438769] test_bitmap: test_bitmap_write_perf:        9344481
> [    1.457679] test_bitmap: failed 1 out of 208655 tests
> 
> So there is something with your config

Interesting! As I get the same test failure on my Talos II too.

Anyhow, I was able to bisect the issue. Offending commit is:

  # git bisect bad
6b5a4b68736798df1031404a2fad06d031253ef7 is the first bad commit
commit 6b5a4b68736798df1031404a2fad06d031253ef7 (HEAD)
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Thu Feb 26 12:16:44 2026 +0100

     bitmap: Add test for out-of-boundary modifications for scatter & gather

     Make sure that bitmap_scatter() and bitmap_gather() do not modify
     the bits outside of the given nbits span.

     Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
     Signed-off-by: Yury Norov <ynorov@nvidia.com>

  lib/test_bitmap.c | 10 +++++++---
  1 file changed, 7 insertions(+), 3 deletions(-)


Reverting this commit on top of v7.2-rc2 lets the test pass:

test_bitmap: loaded.
test_bitmap: parselist('0-2047:128/256'):	888
test_bitmap: scnprintf("%*pbl", '0-32767'):	6074
test_bitmap: test_bitmap_read_perf:		1190938
test_bitmap: test_bitmap_write_perf:		1259471
test_bitmap: all 208655 tests passed

Your hint about my config made me check a few options and I found the 
offending one, which is INIT_STACK_ALL_PATTERN=y. On a kernel built with 
INIT_STACK_ALL_ZERO=y the issue does not show up.

Regards,
Erhard

