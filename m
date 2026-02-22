Return-Path: <linuxppc-dev+bounces-17015-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72973C636BC
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Feb 2026 21:34:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fJy1P6lzzz2xMt;
	Mon, 23 Feb 2026 08:34:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771796073;
	cv=none; b=TDkyBeK4eztZB+zPr0w15KPETadMGUybDRaJaNsqog0tCZF2wIUjxi8X2GHGbgwyRvE/jv2VGc+O5x+SLNRJiMs0Txsddfc7Bvv6/mHd4QBuiXCwluAnuishwzMqLoebXr/eH+N0P3ACYa5/Yp8o/ZDQ9BSzKIf/jEGmaGy+6kizeBCB/T3BIJHPBpZaqBXPBOfN5O0MWT1NQ3O/F4vyLf4AsNvhxH2POZFXWkJEFk4IC8SjnJdcOz3mdkHLj0Jz5fv+LrEC5ubvjoXGq4Gh2ly8+XalrSkk5duWkLmF9G9PCVuiLH4sS0hfQPRbfSizY1ZmS2vRtokCkZzC+ri/ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771796073; c=relaxed/relaxed;
	bh=EmvFoagq4laq5CsfLkxqtnL3auTtxR8uqVSGiltKyEI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=blKSQNRNvA/3FRf/PV6Z39ucjN5uZs8Ap1ZwBfUfoupRvvW07FkQY0RWOUEubp9FfCUXVymoIaJltje1lAO/8MWchqWsA5QbDYjIZ0ZgNQpRiwzgJ2yAWMs0+j0fxWFNKHafCEXF6O6xpgJeB8m+oo5cp7sIKKLWxNZtmXNFHhB8NH1hB0MQmjj5wPoTIw0K15UQAQtYQy1LHQlRmtKCDYgBDppAJrFLS8NMU1jaLpdzMlG9YMxLe2bMpBkIbYhrCqXWxsr/HF+DZ2oiN1pji5sBUY+JDuc1aROAvRJcRygRXRGeF4ZPyaORfeLwp1cWOvhiN426HkXI4Snj5Fqk8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=F3kE5G5Y; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=F3kE5G5Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fJy1P24Hxz2xGF
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2026 08:34:33 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 899A460121;
	Sun, 22 Feb 2026 21:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3118FC116D0;
	Sun, 22 Feb 2026 21:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771796070;
	bh=MoM4gAfGlJ1ngKCroMgt6s8hQQRUOv2GP6lsvWBTYTk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=F3kE5G5YSHiCVZ5mOwWBQ1EmkdZUUxri8FWvUUe1+bPk6Car0R0kut2uvNuYHVkAa
	 g8IvAYcI7E8/6hHCb/jrPziQTKClMwrJ6H0Y/aYHLJyimbtr/frfU8CLViovCDA9UV
	 HIObLbqEucr9FrLIbWX5/hRoPhPnR0+zxQyrVmCTdNaMIGloFGLnnqKAP5W6Ewm6w7
	 I/owa0GiWqAQBaI4TmPdDfE67f10RHZ+BDAgtt/1JTGJALkdfXpJeUzGxFHrjR/KHe
	 NiTE6uiB4kCm6q8SZrGgK2AZmAXo4GAErDwos4utQpdh9gKlK0o0vXjumdP0UVYmSi
	 KhiPc2AZqyPxQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Huacai Chen
 <chenhuacai@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark
 Rutland <mark.rutland@arm.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Ard Biesheuvel <ardb@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>,
 David Laight <david.laight.linux@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 3/3] randomize_kstack: Unify random source across arches
In-Reply-To: <20260119130122.1283821-4-ryan.roberts@arm.com>
References: <20260119130122.1283821-1-ryan.roberts@arm.com>
 <20260119130122.1283821-4-ryan.roberts@arm.com>
Date: Sun, 22 Feb 2026 22:34:26 +0100
Message-ID: <87ecmcwjh9.ffs@tglx>
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
Content-Type: text/plain

On Mon, Jan 19 2026 at 13:01, Ryan Roberts wrote:
> I tested an earlier version of this change on x86 bare metal and it
> showed a smaller but still significant improvement. The bare metal
> system wasn't available this time around so testing was done in a VM
> instance. I'm guessing the cost of rdtsc is higher for VMs.

No it's not, unless the hypervisor traps RDTSC, which would be insane as
that would cause massive regressions all over the place.

So guessing is not really helpful if you want to argue performance.

Thanks,

        tglx

