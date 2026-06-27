Return-Path: <linuxppc-dev+bounces-23037-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD40CC43327
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Jun 2026 01:42:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gnFfF6XhQz2yDs;
	Sat, 27 Jun 2026 11:42:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::136"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782524549;
	cv=none; b=bJm7dDKegh8Ty3QyLjPhVCDBMGCNmXzfTMECr5nWxrWiTnFA9ole3c7gVYSK4EQmWP4KZiQBfn04ybNNgWw+nI9LpBlgc203btACT/E0fFadou88tKDVk69HEZPWFeMM8SeXM/rNshMU1E3eZJmhXqLNsJqM8Ce/IAEjb1UNEghV2uj6PKH/3MX3eKahn41vJMrdoWP8xbEw6nJlDG84G1b3KfGu4bIV+uLHb95f2t7u7ziVCJqN1fmrcas/HQD7cXebqCu/uBjVh+6UOTVjR/V+mJ52ynpe9rk7MQmpj5CKXtjfSW2P1lm5Ll8goPmgR3OzrGl+YdL4l0P8cw0kqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782524549; c=relaxed/relaxed;
	bh=a3misQc9HlKUNeYqqO4Fnmvv4Fv9RkyhsTgdLQ0BWz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=al4Va8yH73hkdquoRI1JrOFonbxQPqsnLrjx3LjSvIUkthAD2hrgZ3uGZYWX9thECm1+OkpcbRRnS3LtlaGou6GAmjkVCf+ydQrKUTJU5atGUznm34Wz2L47BvQwTb6thgnZj+w/lbE3jtBhS8JVot2cQJbGYUv3WDzB/uTUreDN/ARBepl0NCwjWmdhfqwgoq1RD8N8ngOM/XK7ZPAqEuwlhbhmduKZ6W1XwMhUkSk+FtKSeMDRdIQ65FcsdMhMV/hA/QOM+6zK8yncyHPUmNE3vyPp8TcWvkVLd40CcmLmdLvf/vZTgX3sFn+82x6D6xROudPAHb4H33KN5nmMiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zytor.com; dkim=pass (2048-bit key; unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026052701 header.b=ieVY684F; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::136; helo=mail.zytor.com; envelope-from=hpa@zytor.com; receiver=lists.ozlabs.org) smtp.mailfrom=zytor.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026052701 header.b=ieVY684F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=zytor.com (client-ip=2607:7c80:54:3::136; helo=mail.zytor.com; envelope-from=hpa@zytor.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 341 seconds by postgrey-1.37 at boromir; Sat, 27 Jun 2026 11:42:27 AEST
Received: from mail.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3::136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gnFfC1hK8z2xWY
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jun 2026 11:42:26 +1000 (AEST)
Received: from [IPV6:2601:646:8081:7da1:dcd4:e1f8:5d79:bdb4] ([IPv6:2601:646:8081:7da1:dcd4:e1f8:5d79:bdb4])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 65R1EHQ12354017
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 26 Jun 2026 18:14:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 65R1EHQ12354017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026052701; t=1782522861;
	bh=a3misQc9HlKUNeYqqO4Fnmvv4Fv9RkyhsTgdLQ0BWz0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ieVY684FxDj35+1OdJbAri1pdBhTN2gqeIU7j2Y370sBUQ30QPhmIZvW75cKJPbdR
	 IMWIkamCPLrfWfNgBKcB3PhaMkYzKHTrmnUKLa1e+ZLSJhv19+SOXDBLXcwGBwQUQm
	 r/XHx5z9usnk9iv+AszJJxJtR+3sMk9VLHHsh52YfG3DsQ64mFPl5qVJWfAy/D+2Rh
	 S+WMDllsVtD5pOEp++Uf505LlYCJ5QwZinre3Oi8+jbt4xxPtHa6lglEWhLpIlBWBv
	 8Y8Cvo1WqplQrMHkk6CviVuUOV0LSl6zFgnbsOyQby5POoRmSu/3wfwF+nNtjeJn02
	 kxE798jNrTxdQ==
Message-ID: <33ef4e7b-3139-4cb8-9545-6d445bf6e5f1@zytor.com>
Date: Fri, 26 Jun 2026 18:14:11 -0700
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
Subject: Re: [PATCH 08/18] raid6: warn when using less than four devices
To: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
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
References: <20260518051804.462141-1-hch@lst.de>
 <20260518051804.462141-9-hch@lst.de>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20260518051804.462141-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-05-17 22:17, Christoph Hellwig wrote:
> Quoting H. Peter Anvin who came up with the RAID6 P/Q algorithm, and
> who wrote the initial implementation, then still part of the md driver:
> 
>   The RAID-6 code has *never* supported only 3 units, and if it ever
>   worked for *any* of the implementations it was purely by accident.
>   Speaking as the original author I should know; this was deliberate as
>   in some cases the degenerate case (3) would have required extra trays

Stupid autocorrect. That was of course supposed to be "tests" (as in extra
code paths) not "trays" :)

>   in the code to no user benefit.
> 
> While md never allowed less than 4 devices, btrfs does.  This new
> warning will trigger for such file systems, but given how it already
> causes havoc that is a good thing.  If btrfs wants to fix third, it
> should switch to transparently use three-way mirroring underneath,
> which will work as P and Q are copies of the single data device by
> the definition of the Linux RAID 6 P/Q algorithm.

For what it's worth, this is also true in the degenerate two-drive RAID-4|5
case (D = P).

	-hpa


