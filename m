Return-Path: <linuxppc-dev+bounces-20273-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB105FF8875
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 11:45:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5Fqm2flWz2yVL;
	Wed, 29 Apr 2026 21:45:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777463156;
	cv=none; b=mrcjJB3szMyQAz1fUgekX7WHYaecedEoK8Amk8kckW9sECxfictOW0KMaHXslum34MS5lWVCMLY5OXyBrhYk9TWcG/jEcKLXEO7oBGDpi5ST3ZTcNtJoDIfxa59616hy1mCUFfwbUgfWR1T0DFiSnOmH5fdPzZgBVyu1Anq007I1GcO5H/deQP1qDXHL3bpUJzKm9qURghx4qivzzmoyvwIgJugkC8uUI0Op781SCl5ySZirF4PCSM0oXsXXUIyWqqLt05ZWgZvBZ3WpLrpo34lJhREMPaM+x4hXRepbLFe3Z5eYHP9jStDz947mR9/HHAv8UnwnLIdOzRCuC3wChQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777463156; c=relaxed/relaxed;
	bh=xaL8VcaU8H1R9SMtLtMJ1N8wtrCf/A8hHORhOEO76GQ=;
	h=Message-ID:Date:MIME-Version:To:From:Cc:Subject:Content-Type; b=kLM/5FGgE/3HdYFmZRyAu9g9/GunFVJGnr3FxivobEivwaDk16LkFHr8YNV90yyuprSRH9ensIe3xIxu4IqS1mBjbZq70ssjFn9M92o8omXJ1vIVlL2whsdrrRMPIppm8XtpG9B75j+NesBfVatbNeAd/1sPiHqtPDC76J4DnfDhfJYYf7KZnTKNhpy8tD623x0/Ie7dnX5VH0rg4dGo9s7AuYkmVfDx1M2L4Gp0yZ+ZbOFUwuFTa2fHzWOrAKyMQoNkuKKUXn+B+2oLrrnUZ2HSpr+8rsl19KwZJ1Wam873Wr/ZECEBQF+2ZKljO63hyYO2WtQr5LtegYP4BiqOLg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=RCMTWi+1; dkim-atps=neutral; spf=pass (client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org; envelope-from=erhard_f@mailbox.org; receiver=lists.ozlabs.org) smtp.mailfrom=mailbox.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=RCMTWi+1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mailbox.org (client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org; envelope-from=erhard_f@mailbox.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 5268 seconds by postgrey-1.37 at boromir; Wed, 29 Apr 2026 21:45:54 AEST
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050:0:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5Fqk0wwdz2ySf
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 21:45:51 +1000 (AEST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4g5FqT43hZz9tXW;
	Wed, 29 Apr 2026 13:45:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1777463141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xaL8VcaU8H1R9SMtLtMJ1N8wtrCf/A8hHORhOEO76GQ=;
	b=RCMTWi+1S7Adm4i5Qd9KNVCPACBoZvHlEJCDJfHyVsSJmpMTyhWEVVNU5/v8bDL8+cciNu
	AZ8L2334kbHO88xg8tXu9LDW1kolYaqU3EzSwUQLaChdVtrROYuS39mOuiqSWs4piFB3dD
	17UqF5Nyiu9lGe0taTR3ZfZur8pCqfrLKLFwrTTYL3tD3xop1Wg7O2PgIBR9wtpOg0gRYp
	n6C/gC/wZQzI7Ck8S4nQBH/bRohLMgBLKmdfSXGHvdQUX5GhLl/TLN6hLQ+I2dLP1WI+ix
	sJX2BsPkg8NM2nYcHRsmIAdkdii75o4zBjh9QwMuDGyEzWkjJ2zPduAI+WTg/Q==
Message-ID: <2708666d-68f8-4cd3-9b25-f14ceeba3a1f@mailbox.org>
Date: Wed, 29 Apr 2026 13:45:39 +0200
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
To: linux-hardening@vger.kernel.org
Content-Language: en-US, de-DE
From: Erhard Furtner <erhard_f@mailbox.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: iov_kunit_copy_to_kvec: ASSERTION FAILED at
 lib/tests/kunit_iov_iter.c:63, Expected got == npages, but, got == 1 (0x1),
 npages == 256 (0x100) (v7.0.2, ppc)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ur1j3q3gm9worq7tf8p415mp9i7fsqhg
X-MBO-RS-ID: 0d80a3b4a733c79c910

Greetings!

Getting this on my G4 DP on kernel v7.0.2 and v7.1-rc1 via 'modprobe -v 
kunit_iov_iter':

[...]
KTAP version 1
  1..1
      KTAP version 1
      # Subtest: iov_iter
      # module: kunit_iov_iter
      1..12
      # iov_kunit_copy_to_kvec: ASSERTION FAILED at 
lib/tests/kunit_iov_iter.c:63
      Expected got == npages, but
          got == 1 (0x1)
          npages == 256 (0x100)
      not ok 1 iov_kunit_copy_to_kvec
      # iov_kunit_copy_from_kvec: ASSERTION FAILED at 
lib/tests/kunit_iov_iter.c:63
      Expected got == npages, but
          got == 1 (0x1)
          npages == 256 (0x100)
      not ok 2 iov_kunit_copy_from_kvec
      # iov_kunit_copy_to_bvec: ASSERTION FAILED at 
lib/tests/kunit_iov_iter.c:63
      Expected got == npages, but
          got == 1 (0x1)
          npages == 256 (0x100)
      not ok 3 iov_kunit_copy_to_bvec
      # iov_kunit_copy_from_bvec: ASSERTION FAILED at 
lib/tests/kunit_iov_iter.c:63
      Expected got == npages, but
          got == 1 (0x1)
          npages == 256 (0x100)
      not ok 4 iov_kunit_copy_from_bvec
      # iov_kunit_copy_to_folioq: ASSERTION FAILED at 
lib/tests/kunit_iov_iter.c:63
      Expected got == npages, but
          got == 1 (0x1)
          npages == 256 (0x100)
      not ok 5 iov_kunit_copy_to_folioq
      # iov_kunit_copy_from_folioq: ASSERTION FAILED at 
lib/tests/kunit_iov_iter.c:63
      Expected got == npages, but
          got == 1 (0x1)
          npages == 256 (0x100)
      not ok 6 iov_kunit_copy_from_folioq
      # iov_kunit_copy_to_xarray: ASSERTION FAILED at 
lib/tests/kunit_iov_iter.c:63
      Expected got == npages, but
          got == 1 (0x1)
          npages == 256 (0x100)
      not ok 7 iov_kunit_copy_to_xarray
      # iov_kunit_copy_from_xarray: ASSERTION FAILED at 
lib/tests/kunit_iov_iter.c:63
      Expected got == npages, but
          got == 1 (0x1)
          npages == 256 (0x100)
      not ok 8 iov_kunit_copy_from_xarray
      # iov_kunit_extract_pages_kvec: ASSERTION FAILED at 
lib/tests/kunit_iov_iter.c:63
      Expected got == npages, but
          got == 1 (0x1)
          npages == 256 (0x100)
      not ok 9 iov_kunit_extract_pages_kvec
      # iov_kunit_extract_pages_bvec: ASSERTION FAILED at 
lib/tests/kunit_iov_iter.c:63
      Expected got == npages, but
          got == 1 (0x1)
          npages == 256 (0x100)
      not ok 10 iov_kunit_extract_pages_bvec
      # iov_kunit_extract_pages_folioq: ASSERTION FAILED at 
lib/tests/kunit_iov_iter.c:63
      Expected got == npages, but
          got == 1 (0x1)
          npages == 256 (0x100)
      not ok 11 iov_kunit_extract_pages_folioq
      # iov_kunit_extract_pages_xarray: ASSERTION FAILED at 
lib/tests/kunit_iov_iter.c:63
      Expected got == npages, but
          got == 1 (0x1)
          npages == 256 (0x100)
      not ok 12 iov_kunit_extract_pages_xarray
  # iov_iter: pass:0 fail:12 skip:0 total:12
  # Totals: pass:0 fail:12 skip:0 total:12
  not ok 1 iov_iter


Suppose this may be a ppc/BE specific test failure as I don't get it on 
my Thinkpad T60 (x86).

Full dmesg and kernel .config available on request.

Greetings,
Erhard

