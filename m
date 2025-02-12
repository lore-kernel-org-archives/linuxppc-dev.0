Return-Path: <linuxppc-dev+bounces-6130-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32526C02198
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Feb 2025 16:21:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YtNqG5Kcgz30Ss;
	Thu, 13 Feb 2025 03:21:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739377290;
	cv=none; b=h7fzj/q0TBD7mDfsX8MgDLalmlH/5nBOFJR4bX9l9xnXyal2yYvpW3h8igz6O0HuYJprp2kPKRv0x8Y9QImuiKB3dXFzIiOx/B/rlzsMV2mU/5Gow5o/z4rQHtIru2MmVrBT6smUFQ0Fipx/rM2L8XTI/jmJgqXXvyt+CSEHQ457ndXwX3fegUzIKugk9RwBoIV4PXKVY0SHzRjL0JimdVL0djLiLkhV1KAFfZ/AlZUobsXwadUo3470f2yUJoi7tv5NQN67D5xkBOdaCF/pRSJj2EzXnhDPjiTZPOg9aWWvWASpLirVftGSlqjLGqmLrr+nuPG9Q5hetMS8DXNm+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739377290; c=relaxed/relaxed;
	bh=TQHyxxf7U+Q7ArPF2wvkaxK+HZ9Xg/0EjkAQ4iTH/Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKRMcvFIZcHz1Hx4GC6pDHAs9qyDpB/sKCmNK2kCvwazPMkg+3YsuLQH37f3se9eaciE6RThxBKlpfStte5K/5LPy5YIENl0zBxA/E7pmpOIku0b1QZs/jVDyePr07gXmGllxIwiZE0OMNIxT9vrfKTA17SIdz5CofJIn+26mecTH8+Pv0YVbTKwKAmDLYdJc2eXFxI3Fl+GcIuRd+f+5K9xjJRoQu+1DPIIM1P6rQcM2ZlL/2LLe5wjBf/s2tLyPnUMnOYlSkXcwd7k5DA05a4oL3PJrWblltBKpYXcbiWoZQtn4wNug8b6rrV9sjITlx1iNg7IP9o3nkrulD9+pQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=cmarinas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=cmarinas@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YtNqF4976z2yh2
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Feb 2025 03:21:29 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id CFDD8A40C23;
	Wed, 12 Feb 2025 16:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC65FC4CEDF;
	Wed, 12 Feb 2025 16:21:20 +0000 (UTC)
Date: Wed, 12 Feb 2025 16:21:18 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Tong Tiangen <tongtiangen@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Morse <james.morse@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com, wangkefeng.wang@huawei.com,
	Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH v13 2/5] arm64: add support for ARCH_HAS_COPY_MC
Message-ID: <Z6zKfvxKnRlyNzkX@arm.com>
References: <20241209024257.3618492-1-tongtiangen@huawei.com>
 <20241209024257.3618492-3-tongtiangen@huawei.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209024257.3618492-3-tongtiangen@huawei.com>

(catching up with old threads)

On Mon, Dec 09, 2024 at 10:42:54AM +0800, Tong Tiangen wrote:
> For the arm64 kernel, when it processes hardware memory errors for
> synchronize notifications(do_sea()), if the errors is consumed within the
> kernel, the current processing is panic. However, it is not optimal.
> 
> Take copy_from/to_user for example, If ld* triggers a memory error, even in
> kernel mode, only the associated process is affected. Killing the user
> process and isolating the corrupt page is a better choice.

I agree that killing the user process and isolating the page is a better
choice but I don't see how the latter happens after this patch. Which
page would be isolated?

> Add new fixup type EX_TYPE_KACCESS_ERR_ZERO_MEM_ERR to identify insn
> that can recover from memory errors triggered by access to kernel memory,
> and this fixup type is used in __arch_copy_to_user(), This make the regular
> copy_to_user() will handle kernel memory errors.

Is the assumption that the error on accessing kernel memory is
transient? There's no way to isolate the kernel page and also no point
in isolating the destination page either.

-- 
Catalin

