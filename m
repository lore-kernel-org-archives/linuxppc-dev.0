Return-Path: <linuxppc-dev+bounces-23093-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE77AC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 12:47:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpmJb3gN5z2ySS;
	Mon, 29 Jun 2026 22:47:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::136"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782737247;
	cv=none; b=SrP6LlylGa+9kouL/lXeox8Op888xkBsl8ZDl8fyFM6dt1p6E8HgxCmBXxt39TbtKH2CoyXJKxAKGWUZY6Ovs5X1LTHkgJJTNEnxwivmhc26dMkqGKsWZvNVJjGP1FZRVaUh6VkvbtoGTT4pk2xwPprKwqs6elEdthIGfnZ+6YeYsIzuD4s1UzfWM4bQyApx5CIJaIUSHamMDvWWlNrjW8ejFfYaASdS+XY0dzuZT91RrvEX4e4Yrs1RS2MCNIeSXVsIboifAmx8yNGpYina/eM9hy4qPscBuvmCTjSiPnAsH8YyNqNIZYOhFU1ejqYwo4zHphnduvMkluEBeMCpEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782737247; c=relaxed/relaxed;
	bh=F5eNBCeca9FFTuFbHhVBFOemJYWYzDmHgzejZkXlIwM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=J23fCuJt53Kyj9U2USeLQ7EBe/cH9F8HPTC+mDheD7PudyRjGe+pL8TNHFb32HKDlbiGPS79GhGnAdgDKNhuV7huCjRhjqB9ofzanx7Y2b3v0tGyE/JeGVayoUUfw1daNzrTiWGUjyJM6OIU0xJ/yDN3xBZtAPjJpR39YUT+uZ5zgaxZU4aLyygpuIcOCWr1z6L2nSGFWr/qYLiEzNHz30ecHAX9Wn0YzXN7LZvVWYC2d61Fo+C/cef9S3b+f6o7IP69k1eqoHopUAk/DNuzO4IW21mmwNy4i9faRfP7y2EN6G/0SX0jAlZMLAPTWMManKalj8hJsFuffdck9hL57Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zytor.com; dkim=pass (2048-bit key; unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026062701 header.b=ItDa3yOy; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::136; helo=mail.zytor.com; envelope-from=hpa@zytor.com; receiver=lists.ozlabs.org) smtp.mailfrom=zytor.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026062701 header.b=ItDa3yOy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=zytor.com (client-ip=2607:7c80:54:3::136; helo=mail.zytor.com; envelope-from=hpa@zytor.com; receiver=lists.ozlabs.org)
Received: from mail.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3::136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpmJX6Dt3z2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 22:47:22 +1000 (AEST)
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 65TCYlVH219229
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 29 Jun 2026 05:34:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 65TCYlVH219229
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026062701; t=1782736492;
	bh=F5eNBCeca9FFTuFbHhVBFOemJYWYzDmHgzejZkXlIwM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ItDa3yOyOnzgUJtBSZCdhS4zlYRD1XzlbHnWBCrsgDuyOKDQnLXWfugxh1RYrcnHj
	 Wo6d2ASe4aa2kENlvakDGwv3s+KtWwghI1YzuSK4mfraTOB1p7+BurPnKzbMpbQKQL
	 FArnwwcKd8vhlMO88QNlKM8z1OAEuHhiE7bWCyq/7xJ09JZm9//17j5avtQhx3ZQCW
	 62VMIArJVSZ3KSFw9+v6qyIZPgiOE1KxeelvfNkr5eljLOhZuntNE2qq7OnkyMcON6
	 lCC018LGMBA4PoGUZ03daik0PWEEF4Ej3Y7mFmcxCoVSXT9w4uUsvXWEvA5Jy73wT+
	 n9LoSC8sobApw==
Date: Mon, 29 Jun 2026 05:34:41 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Christoph Hellwig <hch@lst.de>
CC: Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Song Liu <song@kernel.org>,
        Yu Kuai <yukuai@alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com>,
        Li Nan <linan122@huawei.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-raid@vger.kernel.org
Subject: Re: cleanup the RAID6 P/Q library v3
User-Agent: K-9 Mail for Android
In-Reply-To: <20260629122152.GA21344@lst.de>
References: <20260518051804.462141-1-hch@lst.de> <20260518141205.c100f76eec5f58e78bbbf7af@linux-foundation.org> <20260519082432.GA14956@lst.de> <7d8efc7c-65e3-49f8-9381-910de7affef2@zytor.com> <20260629122152.GA21344@lst.de>
Message-ID: <8684FEC2-AD56-4BDA-874F-1D3D7170F880@zytor.com>
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
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On June 29, 2026 5:21:52 AM PDT, Christoph Hellwig <hch@lst=2Ede> wrote:
>On Fri, Jun 26, 2026 at 05:52:18PM -0700, H=2E Peter Anvin wrote:
>> On 2026-05-19 01:24, Christoph Hellwig wrote:
>> >=20
>> > raid6: rework registration of optimized algorithms
>> >=20
>> >  - avx2 instead of avx512 is probably the right thing for no
>> >    benchmarking, but if it was intentional (it wasn't), that should
>> >    be document=2E  So I'll just switch back to the previous version t=
o
>> >    keep the state of the art
>>=20
>> It is unlikely to be the right thing *going forward*, though=2E
>>=20
>> The very unfortunate performance inversion is likely model-specific=2E =
It is one
>> of those things where you largely would have to have a list of quirks :=
(
>
>Note that the default is still to benchmark the implementations=2E
>This is just about the case where the user explicitly disabled that
>benchmark-based selection=2E
>

The real issue though is that the benchmarking isn't really helpful, eithe=
r=2E=20

It has to do with power across the whole chip, so it perversely enough dep=
ends on what *else* is going on=2E=2E=2E

