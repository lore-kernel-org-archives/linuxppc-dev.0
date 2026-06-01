Return-Path: <linuxppc-dev+bounces-21774-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE90CD6E4C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Jun 2026 06:22:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gTP4w0z93z2y8p;
	Mon, 01 Jun 2026 16:22:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780294928;
	cv=none; b=bRrOznd6DBBcNoyrx1OJWnTQY1nCxN1S0hFphX+vuxRHYHleOYh/eCI/ZT4GFQvlxMzS58Mq55YvroUjIk1IAxwEO4TW4QIqGxEjkUNSniGnQ8qNZaULk/b30DDBRD+OiVKigCauZJwo6HJKcSLGniQN792nG7FHNDV3eSChwKS7eCQtnZcTtK/xueXeBe5ulW1GuZqSFFIQnGUwciL9wGtNo9gs/p/WHRYjB2004Aox+Qrg4xbvA7BS4R4MR1P4svQpQYZSdJJ58NiyPnoC/MNrguXU4R3mfmQf1giNJcaNI0126OP217soiN2DA7AFxS20ITDXo5BTsGtQ6Pq08A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780294928; c=relaxed/relaxed;
	bh=JC8ooVvP2VP/aGda96PWkp1u1gfkWKF0V7K4OvYMrQ0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GYXirF2eOIfNCFYHs3z+Fq54pCVSVV3PYmDkm6wxFw2AYIOkQ0BA2jfI0dJkQrIw3Y6zBkN+XUQ3Vvd4J79nbDhTfvDL5ehHMQ9HIWGw7lnh91N/oBuXiLTuxZMgRCmQETEKCQgP6inxZagi+zC4aQI4pBOU04+31DtHr2fQSZS71l3Vsl5dFuvI7u49q1Wi+jo/uKDAqzEQnm+XbGnAonWRj9WkIgCmoO6wlJZX7OpBJtveiR4nkv/R+GHpyhUWAFkq3b0qNNjW8Rg1nQCHV5ip/vbGB1Gx74xmbHbISFX8QcH6EWIZwu6qIJ08iV14e83gQmYYEoMLtx95UM5Osw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=fW0n2LvL; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=fW0n2LvL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gTP4t1xy1z2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2026 16:22:05 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6066A60018;
	Mon,  1 Jun 2026 06:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6EF1F00893;
	Mon,  1 Jun 2026 06:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1780294922;
	bh=JC8ooVvP2VP/aGda96PWkp1u1gfkWKF0V7K4OvYMrQ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fW0n2LvLA05tb2iQ906w0acukFZB8rLE3cTd1M/E6TWaNZTa7efwKjZR2iJ/XTWtD
	 AfsMdMqXq0uzEb+suh5q0lWPl5L7N40QUUeZM7mMmFZ+mWQdCXweHKjMUM4MaZtfCa
	 a9cfW5u2ZJd7OM7vWe3vuxhUGSm7LI+8uJL4Tss0=
Date: Sun, 31 May 2026 23:22:01 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Pavithra <pavrampu@linux.ibm.com>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ritesh.list@gmail.com, david@kernel.org, ziy@nvidia.com, mhocko@kernel.org,
 osalvador@suse.de, lorenzo.stoakes@oracle.com, dev.jain@arm.com,
 Liam.Howlett@oracle.com, linmiaohe@huawei.com
Subject: Re: [PATCH] selftests/mm/run_vmtests.sh: Fix protection_keys binary
 name in run_vmtests.sh
Message-Id: <20260531232201.7613f20b850f0bff4f133f3b@linux-foundation.org>
In-Reply-To: <20260601061314.898388-1-pavrampu@linux.ibm.com>
References: <20260601061314.898388-1-pavrampu@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Jun 2026 11:43:14 +0530 Pavithra <pavrampu@linux.ibm.com> wrote:

> we have protection_keys_32 and protection_keys_64 tests mentioned in
> run_vmtests.sh but the binary name is protection_keys with current
> kernel,

Is it?

Makefile has:

VMTARGETS := protection_keys
VMTARGETS += pkey_sighandler_tests
BINARIES_32 := $(VMTARGETS:%=%_32)
BINARIES_64 := $(VMTARGETS:%=%_64)

hp2:/usr/src/mm/tools/testing/selftests/mm> ls -l prot*
-rwxrwxr-x 1 akpm akpm 117792 May 31 23:20 protection_keys_64
-rw-rw-r-- 1 akpm akpm  48448 May 31 21:54 protection_keys.c


