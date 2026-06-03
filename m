Return-Path: <linuxppc-dev+bounces-21954-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D37CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 06:43:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVdT56y7qz2yNn;
	Wed, 03 Jun 2026 16:43:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780469033;
	cv=none; b=ge2RXf1EWdOfYO0125CqOp27rw6ZAz5oU1Mm0iJgrtgVirlURlm3DP05P7HZebGOBYA4VULR1Tz3fGqOCv3XMCS5ADdTDtgvMEquP9prbbhK7bDlgoekKVr5sUCMNB2EUJhIedXch5D4RoNB3sCDW6ObzJfL0bZc1dw1g5YQ+Gy9KYtkIu2wE75naBz03Cyz6Q9DYybvYcwxso5svYVKmlUm02+vr7SKA18bPv4X0HKjmjg8lwS2LA/7vzr8gnfNAXU0T7QumJ6x7EJejEXyi9FK8lhiae9CBvzEBjnqL+eRHN3SHx0f19klvHN42W38Y3PB4WTbD5XgkYpZ28oZyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780469033; c=relaxed/relaxed;
	bh=l2U/psbOjtWYh2SCJbkYu/baXgbGYWIqQwuv2O2CqKA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=h57hoh1YgBZ//j8kTNkzFPjf5nFOFTA+eOfNFIIsS7fsLABZzG4+Fgtb7UhTm5OqK5IDsfvR2f0tpjrJ8yZWOPVUv39chhafL6FbP9mw4jP7+lnx5NyaJTtIFi8+rKSAr4dHOBaEXYTT7e0M6+fAzynYYTaKPaKpBpyvpnAmLSWxYZG3BjZC5YmoN8K0z0kEi4PNOJ/ebpOdUQeJ4YlFuvhPbTl/O++lYe7tSq7zqs8jBtdT88O63HPG49A8Yybxr5hJuJbRQG2N8geg0JbAayHZXQH2x763rYD4z0wQZtdmGP+X82nh45rKeb1nS5TpyiEDV50DBSWx/FH83u64Pg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YtpYu9yo; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YtpYu9yo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVdT52jFfz2xc2
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 16:43:53 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7D7816008A;
	Wed,  3 Jun 2026 06:43:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2591F00893;
	Wed,  3 Jun 2026 06:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780469030;
	bh=l2U/psbOjtWYh2SCJbkYu/baXgbGYWIqQwuv2O2CqKA=;
	h=Date:From:To:Subject;
	b=YtpYu9yoT7v5BbyzLN18ku7SSM6iX7g3CSbhH1EhV1nPjLQf5qCgt30MUiRQ/HCu3
	 Wyd8ET75n+7PV5HT0/jjkP1uDddsMyrQI8yLIzg/cmSibmRFLv4b9+IDOjEMoauMYC
	 5zJw3nCGavEg0lUrvn65jWocu9EjMVOoCPr/VublvLue85UnZTkwiQBUCZMdVu3NUu
	 2Mi/Ewa9YDE6O4PCxYkuWZzMfAVwVzppGClYNMBVhwXvaJHpR68zu7uIycJAaWwqql
	 BzFcx//OuJuO+qC1/wUZXn0aVMbKXbWCqX4BoTaHchTlAXPq3KaQX9p49GxsAOcBc9
	 N74pZTDjw2gRA==
Date: Tue, 2 Jun 2026 23:42:25 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
	Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: ppc64le kunit test failure: guest_state_buffer_test
Message-ID: <20260603064225.GC18149@sol>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

FYI, the KUnit test arch/powerpc/kvm/test-guest-state-buffer.c is
failing when run in QEMU PPC64LE:

[  146.554299][    T1]     KTAP version 1^M
[  146.554348][    T1]     # Subtest: guest_state_buffer_test^M
[  146.554543][    T1]     # module: test_guest_state_buffer^M
[  146.554927][    T1]     1..7^M
[  146.556873][    T1]     ok 1 test_creating_buffer^M
[  146.558221][    T1]     ok 2 test_adding_element^M
[  146.559532][    T1]     ok 3 test_gs_bitmap^M
[  146.560309][    T1]     ok 4 test_gs_parsing^M
[  146.561246][    T1]     ok 5 test_gs_msg^M
[  146.562116][    T1]     ok 6 test_gs_hostwide_msg^M
[  146.562911][  T428]     # test_gs_hostwide_counters: ASSERTION FAILED at arch/powerpc/kvm/test-guest-state-buffer.c:488^M
[  146.562911][  T428]     Expected rc == 0, but^M
[  146.562911][  T428]         rc == -2 (0xfffffffffffffffe)^M
[  146.563600][    T1]     not ok 7 test_gs_hostwide_counters^M
[  146.563653][    T1] # guest_state_buffer_test: pass:6 fail:1 skip:0 total:7^M

Tested on next-20260602.  I haven't bisected it.

Note that this test is in the defconfig.

- Eric

