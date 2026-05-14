Return-Path: <linuxppc-dev+bounces-20962-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E508CD4F3D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 May 2026 20:10:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gGhKX0VmMz2xtC;
	Fri, 15 May 2026 06:10:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::136"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778789455;
	cv=none; b=K/wVuL0uf1ZuWva05bqbve12910OL/G1ToJEvclMsRZ7G4q2gvvhWxBmF/n49Fj4kl1j5yOHf2UJiWrRvxs3ZvnmoMjgSeRqZfj2Y+Y8zfWp+R6NXCsm67Uzhf04EJNmj/umQqQz4sSwaHcRwZXrDrPIlX56Rvdqv3DZgaL72z6QkXWN4wummMGe9m1B6BX2s5LyL3MPjk31SVFz3k/vAnoi4W80r53+SmKYeDcDGjayuMo22RPxbBIETj+bqTIHG7ZmLcuWOx513TFAdLCHO59PNMwnUD0ndhXemMpioEkqYyRHTW297gRz5+yv2Afk43kvBT7fvh44wtSQJ9sy/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778789455; c=relaxed/relaxed;
	bh=xeBHge+llXOwbb4JcAn9Da3zKsJCWrqg8YV6SgfLoXo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Z7qQiY/9y5VXTLxakDt7HMuBRfPN023dp9Nqs9YMqbMhGbNKrmEIl/azaO/DANgfuYTNwtmq/nwQeL508jbfw+yG2bavCeGb+0s2Rte5IgWRVIhXZMvvVu31vq5X3BLg0C8FRIJk/l7R7zW9Zj8QRtlkE9MD8KuFkzyaqHYScrNSsM20OZSdKx2NPWUMUSqlRnv4dqGdBc9vRC4/vRmh5Qico/uAwu0unlgH0IorqPKuWaSf2qlsdJtOAPQrvs/J1479jikrAG5uYyUFnbOuZqogX2B83SZwlbEm+TlAmhtsgvziQa+sJkp3Wxg/alU4GbAR7rHrlRPlu6Kk21jG2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zytor.com; dkim=pass (2048-bit key; unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026042601 header.b=TMJRrv8q; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::136; helo=mail.zytor.com; envelope-from=hpa@zytor.com; receiver=lists.ozlabs.org) smtp.mailfrom=zytor.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026042601 header.b=TMJRrv8q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=zytor.com (client-ip=2607:7c80:54:3::136; helo=mail.zytor.com; envelope-from=hpa@zytor.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 99813 seconds by postgrey-1.37 at boromir; Fri, 15 May 2026 06:10:53 AEST
Received: from mail.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3::136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gGhKT3qKbz2xlV
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2026 06:10:52 +1000 (AEST)
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 64EJvxqM1443783
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 14 May 2026 12:58:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 64EJvxqM1443783
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026042601; t=1778788682;
	bh=xeBHge+llXOwbb4JcAn9Da3zKsJCWrqg8YV6SgfLoXo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=TMJRrv8qsGR2DCztL/jIBPGQO28wsQqHTK/NveRi2zk0+LzcLKFnn8Iviy502ok9i
	 5OPdaLnKd7D98poTZNiOmU0cpqecXLRAlMLlzcNAcqmYAOBC161NH9p9vqagHz1Xzp
	 BPHAozGQd8pC11kLXAzXk4hpCEC4Qm5nr3r8fLBpDaXFU6ItVDJJC6CoKBpExDsJpx
	 SBUnV+538SZRyCwQ4LxXbvqDNKSQfPPT+pqoR4zWD30U5xD3yvUXZOrx9md0+xwCLQ
	 k9df5Yhe3oajwADOBTxx2BUJt+DFl3mJhhVx9sGvHpXM1M36RT8sI9kIAAkr7iTx6O
	 TigG32CPWMUsQ==
Date: Thu, 14 May 2026 12:57:53 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: kreijack@inwind.it, Goffredo Baroncelli <kreijack@libero.it>,
        Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.cz>
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
Subject: Re: [PATCH 01/19] btrfs: require at least 4 devices for RAID 6
User-Agent: K-9 Mail for Android
In-Reply-To: <0a8d1ff4-f5a2-49e9-aa45-d25dbe4ded40@libero.it>
References: <20260512052230.2947683-1-hch@lst.de> <20260512052230.2947683-2-hch@lst.de> <20260512114231.GG2558453@suse.cz> <20260513054742.GA1018@lst.de> <0a8d1ff4-f5a2-49e9-aa45-d25dbe4ded40@libero.it>
Message-ID: <0507CCEF-0548-442F-8703-1D006B5E068B@zytor.com>
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

On May 14, 2026 12:51:59 PM PDT, Goffredo Baroncelli <kreijack@libero=2Eit>=
 wrote:
>On 13/05/2026 07=2E47, Christoph Hellwig wrote:
>> On Tue, May 12, 2026 at 01:42:31PM +0200, David Sterba wrote:
>
>>=20
>>> The degenerate modes of
>>> raid0, 5, or 6 are explicit as a possible middle step when converting
>>> profiles=2E  We can use a fallback implementation for this case if the
>>> accelerated implementations cannot do it=2E
>>=20
>> This is not about a degenerated mode=2E  For a degenerated RAID 6, pari=
ty
>> generation uses the RAID 5 XOR routines as the second parity will be
>> missing=2E  This is about generating two parities for a single data dis=
k,
>> which must be explicitly selected=2E
>>=20
>
>I think that the David concern is : "what happens for an already
>existing btrfs raid6 3 disks filesystem when the user upgrade the kernel =
?"
>(I am thinking when a new BG needs to be allocated)=2E=2E=2E
>
>BR
>GB
>

That's what I'm saying =E2=80=93 it should invoke the RAID-1 code under th=
e cover (as with 3 disks, D =3D P =3D Q=2E)

