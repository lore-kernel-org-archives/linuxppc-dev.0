Return-Path: <linuxppc-dev+bounces-20270-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB467FF8875
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 10:18:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5CtX3yl7z2yD6;
	Wed, 29 Apr 2026 20:18:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777457892;
	cv=none; b=Zd+KcD6UzAwOvAVQUra64iBjuUlHd4YeDW+16Zg49uC9Dz9I94WeK43C8Hjs8XWInJ6tA3UEhlnCgDiwIjABDT2oHQO2q4b9XI5gSGxwoMh6NjLFX1o8lV96Ver8JKKtweXMpX+e+a+UjKntdQcL7u47UoBL1qT4uPWRZKLgjPWYvFQzTQZ61VhtRJq5UsfCHzSl8RzLckf/B6PIdHZK0EuCrOCZuzqOmHdP2bKa1nOKZBAblfBL0QdGZVVfb9Q2pARncgHKlqQ3fo7PJ7u9zZuG0ReU7KXuLUDQuvcvVF6Tgsb/CCu2LgggDXq4F7LTLG/J2oMESL796p3cJtDbkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777457892; c=relaxed/relaxed;
	bh=Yl3S+f3STSDCEgzzf0rBEyoOYrRNmCDGnCoCO5wEQJA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Dt7QfEtgQQPMwfFsB11Lmf9WTSFQPvUsbAHmYlcl58CdF6hufvJx3SWZquGPcZ3k0sSBPIfP5X2yrh2dz386PlhzfLGuUCLLOvIk93Os9y65ZTO3Ts1M1ZkhZOTLgsRF+TRpMXLgsedX4OxbceWo2MJKeYfmh1JjXpFS1vpJTSFqt8PYfEWorL6AEZDX1YQjtls1hllSzolvxFFW3lvtF4rXKssQb8bIZNQRXjbsp+PSxbMwfrpN0KSFUGd7etVeF+J0A1DDOPwZVTb8jxk2/cOs3DOB7FU8WhdwxcSah6XM+1NAhNWv67v8LF3k9NsoO01oW/XQLwWMLxq2CWoMGw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=WJaaztFx; dkim-atps=neutral; spf=pass (client-ip=80.241.56.152; helo=mout-p-102.mailbox.org; envelope-from=erhard_f@mailbox.org; receiver=lists.ozlabs.org) smtp.mailfrom=mailbox.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=WJaaztFx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mailbox.org (client-ip=80.241.56.152; helo=mout-p-102.mailbox.org; envelope-from=erhard_f@mailbox.org; receiver=lists.ozlabs.org)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5CtT6k0Hz2xSB
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 20:18:09 +1000 (AEST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4g5CtK269zz9vGr;
	Wed, 29 Apr 2026 12:18:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1777457881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Yl3S+f3STSDCEgzzf0rBEyoOYrRNmCDGnCoCO5wEQJA=;
	b=WJaaztFxIUZAAFLmCLpiwhxAqJKwPGlCERdO044yhI5FkFH031ra0/55nbrAGhYlW0uH6W
	LZCNEhlSyPUXDZT/YHXpxzGL0vpRBc97cJu96rlSjE9gawgP3vE/33c5Lgz9cLDZWc4/10
	VIT3KFQ7o+5ZyDmUGr7q20Ytw2/60FYPp29llzIFtX+rIbqPpW+4usgKnUIzlUGguoeoWx
	IFEMU/Vk13LcywyRLPl/Znm6pT5IVeqnJVgdkCtHhhu9czkkGGZwjfDOfuM87UJk9Sju6h
	R6RAxhAAdVSX/aWKAdIhZqykpy52wkDHEDnxQKXcnUEJOe39hBWhbmnEVrfTNg==
Message-ID: <f45fd960-335c-4761-9590-ff8eccb62e9a@mailbox.org>
Date: Wed, 29 Apr 2026 12:17:58 +0200
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
Content-Language: en-US, de-DE
To: linux-hardening@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
From: Erhard Furtner <erhard_f@mailbox.org>
Subject: fortify_test_known_sizes: EXPECTATION FAILED at
 lib/tests/fortify_kunit.c:90 (v7.0.2, ppc)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: f665d335b0d2e075d32
X-MBO-RS-META: h7xis46hfirjohtwbznkzn46x93kcntz

Greetings!

Getting this on my G4 DP on kernel v7.0.2 and v7.1-rc1 at running 
fortify_kunit test:

[...]
KTAP version 1
1..1
     KTAP version 1
     # Subtest: fortify
     # module: fortify_kunit
     1..26
     # fortify_test_known_sizes: EXPECTATION FAILED at 
lib/tests/fortify_kunit.c:90
     Expected ({ char *__p = (char *)(stack); size_t __ret = 
(~(size_t)0); const size_t __p_size = 
__builtin_dynamic_object_size(stack, 1); if (__p_size != (~(size_t)0) && 
__builtin_constant_p(*__p)) { size_t __p_len = __p_size - 1; if 
(__builtin_constant_p(__p[__p_len]) && __p[__p_len] == '\0') __ret = 
__builtin_strlen(__p); } __ret; }) == 5, but
         ({ char *__p = (char *)(stack); size_t __ret = (~(size_t)0); 
const size_t __p_size = __builtin_dynamic_object_size(stack, 1); if 
(__p_size != (~(size_t)0) && __builtin_constant_p(*__p)) { size_t 
__p_len = __p_size - 1; if (__builtin_constant_p(__p[__p_len]) && 
__p[__p_len] == '\0') __ret = __builtin_strlen(__p); } __ret; }) == 
4294967295 (0xffffffff)
     not ok 1 fortify_test_known_sizes
     ok 2 fortify_test_control_flow_split
     ok 3 fortify_test_alloc_size_kmalloc_const
     ok 4 fortify_test_alloc_size_kmalloc_dynamic
     ok 5 fortify_test_alloc_size_vmalloc_const
     ok 6 fortify_test_alloc_size_vmalloc_dynamic
     ok 7 fortify_test_alloc_size_kvmalloc_const
     ok 8 fortify_test_alloc_size_kvmalloc_dynamic
     ok 9 fortify_test_alloc_size_devm_kmalloc_const
     ok 10 fortify_test_alloc_size_devm_kmalloc_dynamic
     ok 11 fortify_test_realloc_size
     ok 12 fortify_test_strlen
     ok 13 fortify_test_strnlen
     ok 14 fortify_test_strcpy
     ok 15 fortify_test_strncpy
     ok 16 fortify_test_strscpy
     ok 17 fortify_test_strcat
     ok 18 fortify_test_strncat
     ok 19 fortify_test_strlcat
     ok 20 fortify_test_memcpy
     ok 21 fortify_test_memmove
     ok 22 fortify_test_memscan
     ok 23 fortify_test_memchr
     ok 24 fortify_test_memchr_inv
     ok 25 fortify_test_memcmp
     ok 26 fortify_test_kmemdup
# fortify: pass:25 fail:1 skip:0 total:26
# Totals: pass:25 fail:1 skip:0 total:26


Suppose this may be a ppc/BE specific test failure as I don't get it on 
my Thinkpad T60 (x86).

Full dmesg and kernel .config available on request.

Greetings,
Erhard

