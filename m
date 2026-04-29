Return-Path: <linuxppc-dev+bounces-20294-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8068FF8867
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 14:56:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5L3J2sJFz2ySf;
	Thu, 30 Apr 2026 00:56:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777474572;
	cv=none; b=LmfSJIkqsaqF/6MFzAVp7vhUf8rvESTSs+V0tRvtN4wgTL8YYMwL4R5wkarFOEwumdFGxwnhCvpatveYfvM48zwYDA/CRhsq4FbSkXcpdJVcwofY9fcJOJ0aRL0RjTj/hiGtnfBpo6oiDItu/MCa33TZknL9nqdgX7vm9fnxa2jNQBeEyuEqKFrEvU36ry4zmRA4PPbdKKfRW9ay9f+Kx0T2+xDrlskZ85XYoUBRPjKAm1Nty9EMy6RAWtzMw+172f0THtuJxbIBdR4JTja+JcPFPWeyy7EZYp+34OovxETga0V9qlwF/DYTt9vExoH67chRtVtU+B6eoXItZLZZVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777474572; c=relaxed/relaxed;
	bh=+b7k0N0qTxSsM85yq3NXVVu9sTCY5exLO54paoX+uGA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LJdgcIDZEXXftrcn2z89MTI7Y/MYX1o2iy6OESjGd38M4KT1L8RWOYOZnoLez9pDG8SlAL07FtX/uEGib7JpDo9Wl++oiRr7I3Lg6vBgHQZ+ly0z5OaeTTBV3MzbFxuccyrMNT978Y6vcf0c4eZ+xuMtRiH01b/xunoU2BVWl0+yYyOg+j/EAX9a4SuvYdQPa9wLzWwGEphQ1K/8FzcLLJsZwQaVxlHNKetNKu996N8/hSCb4GCd765DGj0K3vt4E8QvskOtMMlMNi6d4njkmgdCxGW9oi9YGVrBz+tcLMWeaAlQOBWSphTXvtOi9aUM4CHgLdIX0RrDhhThagryKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZmhLNwPC; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZmhLNwPC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5L3H3hmtz2ySc
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 00:56:11 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2F76943CAC;
	Wed, 29 Apr 2026 14:56:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A35C19425;
	Wed, 29 Apr 2026 14:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777474569;
	bh=CSOdFd7szD0Ao2hLSpmBMSj30LDJUzA9HwyCrM7mFHE=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=ZmhLNwPCzDGJ+arpjX/REC5icJ2Ri121oKkTKnsEizrLsLOE0N9ruH0+blxCJ0LB9
	 Y02Um7/DMSfFqkuKD/x3CFV9Ev7cXtjw1UKSfxRJMOa0gXelaJcysFoSIOuY0mjek2
	 exllRRmPlOrTFrPEPwxevy99PBRROS4q+P8l+Dzff+ivsGhJ0G8GY8r0ObGkhg5FzL
	 LyX8ECyspMDfX51u3V7tk1Baw0PjirR51qlJtPJW8SqInAFa9z/46rU31e1lMgE5lK
	 seiZfHePVXeLK1ofRDMLLO1JeV1BO+tls7GmQZ9RfNzX42+Y9qgFKX0mzsw+g4hT7i
	 f41/6U4FINpSg==
Message-ID: <87c448ad-4ee0-4605-8a5f-7c7661a156a2@kernel.org>
Date: Wed, 29 Apr 2026 16:56:05 +0200
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
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: Re: iov_kunit_copy_to_kvec: ASSERTION FAILED at
 lib/tests/kunit_iov_iter.c:63, Expected got == npages, but, got == 1 (0x1),
 npages == 256 (0x100) (v7.0.2, ppc)
To: Erhard Furtner <erhard_f@mailbox.org>, linux-hardening@vger.kernel.org,
 Kees Cook <kees@kernel.org>, David Howells <dhowells@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org
References: <2708666d-68f8-4cd3-9b25-f14ceeba3a1f@mailbox.org>
Content-Language: fr-FR
In-Reply-To: <2708666d-68f8-4cd3-9b25-f14ceeba3a1f@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 29/04/2026 à 13:45, Erhard Furtner a écrit :
> Greetings!
> 
> Getting this on my G4 DP on kernel v7.0.2 and v7.1-rc1 via 'modprobe -v 
> kunit_iov_iter':
> 
> [...]
> KTAP version 1
>   1..1
>       KTAP version 1
>       # Subtest: iov_iter
>       # module: kunit_iov_iter
>       1..12
>       # iov_kunit_copy_to_kvec: ASSERTION FAILED at lib/tests/ 
> kunit_iov_iter.c:63
>       Expected got == npages, but
>           got == 1 (0x1)
>           npages == 256 (0x100)
>       not ok 1 iov_kunit_copy_to_kvec

This happens in alloc_pages_bulk_noprof(), due to

	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
	if (!pcp)
		goto failed;

Because:

#ifdef CONFIG_SMP
[...]
/*
  * On CONFIG_SMP=n the UP implementation of spin_trylock() never fails 
and thus
  * is not compatible with our locking scheme. However we do not need 
pcp for
  * scalability in the first place, so just make all the trylocks fail 
and take
  * the slow path unconditionally.
  */
#else
#define pcp_spin_trylock(ptr)		\
		NULL


So apparently it is expected that alloc_pages_bulk() returns 1 on non-SMP.

Christophe

>       # iov_kunit_copy_from_kvec: ASSERTION FAILED at lib/tests/ 
> kunit_iov_iter.c:63
>       Expected got == npages, but
>           got == 1 (0x1)
>           npages == 256 (0x100)
>       not ok 2 iov_kunit_copy_from_kvec
>       # iov_kunit_copy_to_bvec: ASSERTION FAILED at lib/tests/ 
> kunit_iov_iter.c:63
>       Expected got == npages, but
>           got == 1 (0x1)
>           npages == 256 (0x100)
>       not ok 3 iov_kunit_copy_to_bvec
>       # iov_kunit_copy_from_bvec: ASSERTION FAILED at lib/tests/ 
> kunit_iov_iter.c:63
>       Expected got == npages, but
>           got == 1 (0x1)
>           npages == 256 (0x100)
>       not ok 4 iov_kunit_copy_from_bvec
>       # iov_kunit_copy_to_folioq: ASSERTION FAILED at lib/tests/ 
> kunit_iov_iter.c:63
>       Expected got == npages, but
>           got == 1 (0x1)
>           npages == 256 (0x100)
>       not ok 5 iov_kunit_copy_to_folioq
>       # iov_kunit_copy_from_folioq: ASSERTION FAILED at lib/tests/ 
> kunit_iov_iter.c:63
>       Expected got == npages, but
>           got == 1 (0x1)
>           npages == 256 (0x100)
>       not ok 6 iov_kunit_copy_from_folioq
>       # iov_kunit_copy_to_xarray: ASSERTION FAILED at lib/tests/ 
> kunit_iov_iter.c:63
>       Expected got == npages, but
>           got == 1 (0x1)
>           npages == 256 (0x100)
>       not ok 7 iov_kunit_copy_to_xarray
>       # iov_kunit_copy_from_xarray: ASSERTION FAILED at lib/tests/ 
> kunit_iov_iter.c:63
>       Expected got == npages, but
>           got == 1 (0x1)
>           npages == 256 (0x100)
>       not ok 8 iov_kunit_copy_from_xarray
>       # iov_kunit_extract_pages_kvec: ASSERTION FAILED at lib/tests/ 
> kunit_iov_iter.c:63
>       Expected got == npages, but
>           got == 1 (0x1)
>           npages == 256 (0x100)
>       not ok 9 iov_kunit_extract_pages_kvec
>       # iov_kunit_extract_pages_bvec: ASSERTION FAILED at lib/tests/ 
> kunit_iov_iter.c:63
>       Expected got == npages, but
>           got == 1 (0x1)
>           npages == 256 (0x100)
>       not ok 10 iov_kunit_extract_pages_bvec
>       # iov_kunit_extract_pages_folioq: ASSERTION FAILED at lib/tests/ 
> kunit_iov_iter.c:63
>       Expected got == npages, but
>           got == 1 (0x1)
>           npages == 256 (0x100)
>       not ok 11 iov_kunit_extract_pages_folioq
>       # iov_kunit_extract_pages_xarray: ASSERTION FAILED at lib/tests/ 
> kunit_iov_iter.c:63
>       Expected got == npages, but
>           got == 1 (0x1)
>           npages == 256 (0x100)
>       not ok 12 iov_kunit_extract_pages_xarray
>   # iov_iter: pass:0 fail:12 skip:0 total:12
>   # Totals: pass:0 fail:12 skip:0 total:12
>   not ok 1 iov_iter
> 
> 
> Suppose this may be a ppc/BE specific test failure as I don't get it on 
> my Thinkpad T60 (x86).
> 
> Full dmesg and kernel .config available on request.
> 
> Greetings,
> Erhard
> 


