Return-Path: <linuxppc-dev+bounces-19553-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B086E9904B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 07:25:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsSxd0R5tz2yZ6;
	Fri, 10 Apr 2026 17:25:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775805908;
	cv=none; b=O8Z+FgBLAX5UI5fdKM3ZediaZQgVM/RLT76iMknD5qGT1FO0BFIZIuHkHaRlHZfvYe2QKAwK+dRIVMtIStX7hp0j+dHey+KUaKLoWvUaGj1WDD6WMeoPqs0oMHTtNPDczvwksbRVbzLdwNqEmNKsYp/FyBRu+G1F7Fw3I7rxpSRe1CesUKGKOYfpZr2czT6s1co6p3RGHe2aB24h87Rs/WAiGc4pL16/+KMQDhrfvzCPFU/UDsXgFkgiE7hudVM2adSdIQPJFnxjFj6B1CgngBk9wfHQvTf0lgIeNt4+DF4NZuSVNO5oHjFDWfJYZir+SN4rk4FFhh7WmknoQT2d8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775805908; c=relaxed/relaxed;
	bh=DcWWgAkaawlRZJPPVtqSkGlhDZHKznfQKlRnA0c5Grg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDmMLGPmeerVTdSfGORMXWu+NIm2017r3wD18TqR6OeskD5riLtDo3V6jNgaGc+E71NUprhLrux8jOYigMupgT1zfrRXti6qCDxc8KvY43YGNQOPOcEqyzRYPM9V+L6GVOKMw45avQQJTAS/1ti/fI1vbEkZGTSkRTLXektPYTAHx84zEj48Z4vs9J5O/gpaOaN89qe3rP+sHEXbvvfyeji/7QkwzvPB7DX9yvdrCX6HZnfNJEgTwSAhKmdkrTryBP0tnFv8YCw+dzYoeLgxduCp2FY/IEqiHm4BcnjxDBjz6pws0KQueB88rFPS/AcX6TtlDOvoTswvkpa3YuD3oA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=2/IJa6Ai; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=ZgqeBpjS; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=2/IJa6Ai;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=ZgqeBpjS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsSxb72Prz2yRl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 17:25:07 +1000 (AEST)
Date: Fri, 10 Apr 2026 09:24:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1775805899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DcWWgAkaawlRZJPPVtqSkGlhDZHKznfQKlRnA0c5Grg=;
	b=2/IJa6AigsLTvo0bFTGC10WodpRLk8D/N7yIF4mk2hA0ic4uGfAfWjwTdg8E3Nlvtj2Lcs
	zUJp97laoQ7CRjYNtXcqrcN5fesVUCoUTHK9oEAkQLTjs5LDANQANe67xcylvjxcoOv7E5
	eDKnPcTyqgGMYYqyi/DFDQYfE2xe27tDKd0TrEyTes2t3NwXyMBw/gN5qP5Xipok4cZa19
	JmOfy8zJY8p9bTmBgL6Ouwuv+fZenOL0faKHsL3WbwGKwMVtW4TWiwBb4VX2pquCJ4GiPt
	2TWv/6h7txXmhveenNET8ahEPXsqpd+QkJw1NX7NDma4Qo7TFml40MkDAUuZvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1775805899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DcWWgAkaawlRZJPPVtqSkGlhDZHKznfQKlRnA0c5Grg=;
	b=ZgqeBpjS2tQJJXjyUQm4vLhm1bLgw03s/xJ7/GPJfbak2qtTH8uDf4tZtuj4uuIZ044A61
	lpzZZ99OEq3Ku5CA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH 1/7] x86/vdso: Respect COMPAT_32BIT_TIME
Message-ID: <20260410091131-46b6354c-9d06-4e47-9345-ee224d8528f7@linutronix.de>
References: <20260227-vdso-compat_32bit_time-v1-0-3f0286a7bac3@linutronix.de>
 <20260227-vdso-compat_32bit_time-v1-1-3f0286a7bac3@linutronix.de>
 <c29f5e70-bd17-4e1b-a005-5a3282e70075@app.fastmail.com>
 <03cd1e21-a2f2-46a1-a674-cbaef9712016@app.fastmail.com>
 <20260227103226-cc3bb32c-0107-4c09-b81a-ca33ea03ad5c@linutronix.de>
 <49b7c9f9-198a-49f7-880b-6ae74d7bd985@zytor.com>
 <2b1ac7b9-fcc8-4aa3-a0ad-eb37e4bce030@app.fastmail.com>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b1ac7b9-fcc8-4aa3-a0ad-eb37e4bce030@app.fastmail.com>

On Tue, Mar 03, 2026 at 09:50:33PM +0100, Arnd Bergmann wrote:
> On Tue, Mar 3, 2026, at 19:11, H. Peter Anvin wrote:
> > On 2026-02-27 01:34, Thomas Weißschuh wrote:
> >>>>
> >>> The thing about gettimeofday() and time() is that they don't have
> >>> a 64-bit version and libc implementations are expected to call
> >>> clock_gettime() instead. The result was that there was never a
> >>> patch to turn the off either.
> >> 
> >> gettimeofday() is currently the only way to get the timezone of the kernel.
> >> But I guess this is a legacy thing anyways. If you say we should drop it,
> >> let's drop it.
> >> 
> >
> > The time zone in the kernel has never worked anyway, as it would require the
> > kernel to contain at least the forward portion of the zoneinfo/tzdata table in
> > order to actually work correctly. The only plausible use of it would be for
> > local time-based filesystems like FAT, but I don't think we bother.
> >
> > A bigger question is whether or not we should omit these from the vDSO
> > completely (potentially causing link failures) or replace them with stubs
> > returning -ENOSYS.
> 
> I see no harm in keeping gettimeofday() in the vdso when
> COMPAT_32BIT_TIME is turned on, as existing code will call it
> no matter whether it's in the vdso or the syscall.

We would still always keep them for 64-bit ABIs, right?

> Equally, I see no point in having either version of
> gettimeofday() or settimeofday() when COMPAT_32BIT_TIME is
> disabled, as clearly anything calling it would pass incorrect
> data for times past 2038.

Should we also drop the syscalls in these cases?
We will need to keep settimeofday() in some form to support the
timewarping call done by init.

Recap/Proposal:

* Keep the gettimeofday()/time() syscalls when they are y2038 safe or
  CONFIG_COMPAT_32BIT_TIME is set.
* Always provide settimeofday(). If CONFIG_COMPAT_32BIT_TIME is *not*
  set, reject passing any 'tv' argument where it may not be y2038 safe.
* The vDSO functions always mirror the systemcall availability.


Thomas

