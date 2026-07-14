Return-Path: <linuxppc-dev+bounces-24200-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11ECC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 09:52:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzvk45PD9z2y71;
	Tue, 14 Jul 2026 19:52:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784022764;
	cv=none; b=G2tW0VgUqHRdz6EgNy0n4/jWuh8iqmt2MGgbJYHfPO7f0JOIi8yQ0oh5GN+SJPloTEeM9LG/Xms32wz5yOxvdWjnsZzaVG4co+xOil3NT/qXdTu2wmxIynXovkSNUPB1/T/iaBK/6FSi/qbAZ4jqov8Sa8uJSdh6ibzfPz68X6tS8PFNuYkFHgU7LtM6WW6w3rlzGd0WUPP3i8wy609e+jbHCzo44aac7WQjj43N/bxIkyaSx6sKth6TFgSj8LAvM3ZN5kpP04rJweSPTyS3S0tsn3UgT9KtUZ07K6Ze9lH8Lf/0oepYjtsp1QGZuHiThpKXwWxzbCfNbEzMHoWhNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784022764; c=relaxed/relaxed;
	bh=+C5nG+xtG3hyYyQwRUQFGYH75JNuc0Lk0Ty5BqRmWNU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lGy1CEeQKgcd2G8nJWVmm9wGmuGW8Oa9T5wcNFWniagJW705HcTtAYL1Xa9Qre5PMBpARDvYpwXkIpjFmHbL9rR0Tzv1eFI+3HHuGd12As9rUXQT3tJwT8M0U911p3Yox3v7u3mGPWw0Fw4j4OpsGdabe5u+MFFY8BY9JCgef4SCHrkPU81Lnf0lTRGrC4tY8h+vkEkMYoBxrLBLOrJ1DfkrZNIaOG3277UxFSN3lQKmv4GBKBAaEoX/pne2JsLCcjMEh75+262SL/XT1sSvtOkBLcIYbfjlpDc+PSGIislsT0y/ZfHEUQZ7u7kzgGJwNg08FQ5xARPPrKAtyDulPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZgSMxxsh; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZgSMxxsh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzvk35t5cz2xqn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 19:52:43 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1FBCD601EC;
	Tue, 14 Jul 2026 09:52:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232391F00A3A;
	Tue, 14 Jul 2026 09:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784022760;
	bh=+C5nG+xtG3hyYyQwRUQFGYH75JNuc0Lk0Ty5BqRmWNU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ZgSMxxsh1Lu8MR5Z6WZ7OI+nq6F3YqTn9IBm2AINDs8o2Z/nh/SpZWcv4glu+VhPe
	 cXy87Qxg3XbvgFKPnL50ydX2ZmeXZ+Y2m0e04PAZRMRDiI7yd819Ia6OkzoYI4l8hi
	 bQ5nmUAEKOPB1JNlOSIgfbjVYFEy/Nt7TJrcZZrSwXI52rztJjb2qGdZlVK+Mik1C2
	 MqZlsgx86ioBdN1tVdskpyUDQ5X3kf6HF+H7N5Qp+yw+MWEZGk2dutdazlT0Q42W8G
	 2WBALzw60ZoYjzJMEjfOp8k80iBpzrMV5Er054iRnji2EAX6IYZOtyYaIq4WMAy0e3
	 LsRNlLUiQVPTA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v7 00/22] dma-mapping: Track shared DMA state through
 direct, pool and swiotlb paths
In-Reply-To: <cd5d0504-1592-4b48-89ea-1efe8aa57968@samsung.com>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <CGME20260707080628eucas1p13fa8a57e60ef5dd3ec651e19e42af0a1@eucas1p1.samsung.com>
 <yq5av7argr65.fsf@kernel.org>
 <fc804746-4fb8-4ea9-997f-a4cae9ba8c14@samsung.com>
 <20260713194323.GC3133966@ziepe.ca>
 <cd5d0504-1592-4b48-89ea-1efe8aa57968@samsung.com>
Date: Tue, 14 Jul 2026 15:22:27 +0530
Message-ID: <yq5aldbdnbj8.fsf@kernel.org>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Marek Szyprowski <m.szyprowski@samsung.com> writes:

> On 13.07.2026 21:43, Jason Gunthorpe wrote:
>> On Tue, Jul 07, 2026 at 03:03:48PM +0200, Marek Szyprowski wrote:
>>> I'm fine with merging on top of=C2=A0the topic branch and I assume that=
 this
>>> patchset is mature enough to give it a try in linux-next, but first I
>>> would like to get a review or at least acks from others with good CC
>>> knowledge or experience.
>> I think it is good to go from a CC perspective, there are still some
>> more items to fix up (like the MMIO) but I'd rather they be followups
>> at this point.
>
> Great. Aneesh, any chance You could send v8 with the remaining items
> fixed till end of this week? I will be happy to push it to
> dma-mapping-for-next for testing in linux-next asap.
>

Sure. You need this rebased on top of the pKVM changes, right?
Otherwise, we'll end up with conflicts when you do the final pull
request.

-aneesh

