Return-Path: <linuxppc-dev+bounces-20749-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8397FCD4855
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 07:26:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gF7S80ytmz2ygG;
	Tue, 12 May 2026 17:26:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::b6"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778570776;
	cv=none; b=ge1rYthCrwdG0tPSDQB73WAVd5Ginn6CgplJAAyu1YCD6QeLGWyBbjhP4Zo23uRDJF+neT8Fu6/5VfbcLQ3/2WBq2O95M3O8kEDvOZQ6GOWghwKosGcI8hdC9Sk1bSQn8iKjZaKkkjFi9sgQ0vLZfIgn29yNbSWqiAZvnaI/wsaSWCdVpY0gfbk8NTuO5Yt3P/8pp+bh7Puc++rL9GyKD2W1uxyzUhFjdqZZvAOLyQxkQCo0u+N5QB+4E2NKtW5Kdk4eAQEozPm0RZKgByqFdE6iEQGcEo9+ocKOuKJiDRQCVR+wJAFsao9d2EUO4M50MA8Wfds/AQUlu8L5PcTKzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778570776; c=relaxed/relaxed;
	bh=KleV71sGLoSIpfimzX+Um4L/dQ6PAAx/tc+TAvzuzrM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=X9cPfe3R3mx0dkX/FFnswKVPl0xjclTtYGdKIMW2Ms/2jCkQzDlCXYUU6D1uQ2MECQlp7G5CC4nesuRucW7DzGunBTlFXkZvJd6QqI4IhSxxzv7UbNBK3+BTUyKXvikd4H8N36ThWvSRU2WNm2ykHrAOyvowCW953AYjVreeS4sG0OhTonJrVF20zViIkcVctsFQVXUUjeEuIO0Zs/dO6ckcUFLWTsiY59HkI4VFfVTzFOcnYy4GK8L+xjOmTm/2AEP+Eovc0Bayp61bNDYGJd/dD8WiV4RgHyDGcOPdGJ6hRycuCCepkhDDztBbla+nQl27H3zbK2rhTiev7vw4DQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CernQuon; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::b6; helo=out-182.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CernQuon;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::b6; helo=out-182.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gF7S51W26z2yb9
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 17:26:11 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778570747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KleV71sGLoSIpfimzX+Um4L/dQ6PAAx/tc+TAvzuzrM=;
	b=CernQuonrtrcVA2MC7fNDHHIbGhU1HcTungbtLCMIta9xw0yA8bkoeWkccIPdG6zmIQasQ
	tPlnFy9nQDmaZdx1tKxz4rVtOdNjCmHJN5pHH0kzenPKlNp2X88jet4kLFchRad51zy88b
	1FcHh3iaOY76S3uX79+iVXurv5RUGPs=
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH] drivers/base/memory: make memory block get/put explicit
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <943c5cd9-0796-45f5-9f8d-cb7e44457961@linux.ibm.com>
Date: Tue, 12 May 2026 15:25:14 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 David Hildenbrand <david@kernel.org>,
 Oscar Salvador <osalvador@suse.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 linux-mm@kvack.org,
 driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <ACADAE38-650D-43D6-8000-891B59850499@linux.dev>
References: <20260511111800.2181785-1-songmuchun@bytedance.com>
 <943c5cd9-0796-45f5-9f8d-cb7e44457961@linux.ibm.com>
To: Donet Tom <donettom@linux.ibm.com>
X-Migadu-Flow: FLOW_OUT



> On May 12, 2026, at 14:52, Donet Tom <donettom@linux.ibm.com> wrote:
>=20
> On 5/11/26 4:48 PM, Muchun Song wrote:
>=20
>> Rename the memory block lookup helper to make the acquired reference
>> explicit, add memory_block_put() to wrap put_device(), and collapse =
the
>> redundant section-number wrapper into a single block-id based lookup
>> interface.
>>=20
>> This makes it clearer to callers that a successful lookup holds a
>> reference that must be dropped, reducing the chance of forgetting the
>> matching put and leaking the memory block device reference.
>>=20
>> Link: =
https://lore.kernel.org/linux-mm/7887915D-E598-42B3-9AFE-BFFBACE8DE2D@linu=
x.dev/#t
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>>  .../platforms/pseries/hotplug-memory.c        | 14 ++-----
>>  drivers/base/memory.c                         | 38 =
+++++++------------
>>  drivers/base/node.c                           |  4 +-
>>  drivers/s390/char/sclp_mem.c                  | 17 ++++-----
>>  include/linux/memory.h                        |  7 +++-
>>  mm/memory_hotplug.c                           |  5 +--
>>  6 files changed, 35 insertions(+), 50 deletions(-)
>=20
>=20
>=20
> Hi
>=20
> I did some basic DLPAR memory add/remove tests on PowerPC with this =
patch, and it is working fine.
>=20
> Initial memory
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> []# cat /proc/meminfo |grep -i MemTotal
> MemTotal:       205169920 kB
>=20
> After Add
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> []# cat /proc/meminfo |grep -i MemTotal
> MemTotal:       247112960 kB
>=20
> After Remove
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> []# cat /proc/meminfo |grep -i MemTotal
> MemTotal:       173729024 kB
> []#
>=20
> Tested-by: Donet Tom <donettom@linux.ibm.com>


Really thanks for your testing.

Thanks,
Muchun.=

