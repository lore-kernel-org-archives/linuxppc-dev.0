Return-Path: <linuxppc-dev+bounces-16076-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C414ACA5FB1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Jan 2026 16:46:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dwY9s3Gbsz2xQB;
	Wed, 21 Jan 2026 03:46:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768927569;
	cv=none; b=CjXZaSBlkzFqNz+wZDZsJa0Oilsj2z4DqjaKqtzRuEWm1nIGwA340DBy61KNYqOc4fe6A0gUlsPkF4ujmnq2OoqsvPYwNdauDKHc+wdEgmM+w0LXPtkp6DGVDfgL7mNoNBRAqY7dGuMR3ivREHIDyvCjnbClijj1Ax2nPfWnxNwqfmkmjr2LTdYMCAZCpCI6ptxO3INsD3DdBla7hYaky/nWFNNNGuMPYvuz8CdIrAXGeRGawoNy6IFH0IXEMpajvMmYgnZTiC6hEUJwjLT9VogJLoHiheH3GixwBv6fzc05jmIL9+EIxNiy408GYHRkQhyOAxZRnqWnc85uIwjn5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768927569; c=relaxed/relaxed;
	bh=GYJIKeSCyLSC7tzF8rbMDrps3XHjO9NAgwZz6IjopgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ort0OSYJTsq2zhGd1Sp/IPZ3UggGyXUcuw4evJT1RZ531URICrxJWyrkXcAP5C+DrDPFmEHFwsST8O2bV+ldhMzoMoe1hQwFYNnP0Vfa99tvamwWcGAFI3h6agVG3ss1tYJUxCk+heI6SZcQmV78sLkyTuCqENJ7suAggUEcMHbsjaNvneVtHpkheegG2G0sVLzNJMfeYr2JaQ8cjwFYmXGlbS30Hbd/FGNLsbTGTKSmHPg1O4U/vY1uXovWWXiRLjA2KGv0eaHG6j1EGktWShKUyvJaAEmgdWhxs1HOT/CygZZhSIABy7ZspQelQOhDzdnX0Qfk3Ho7SxlyqqUURA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=ryan.roberts@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=ryan.roberts@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dwY9r6Ssnz2x9M
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2026 03:46:08 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E55491476;
	Tue, 20 Jan 2026 08:45:30 -0800 (PST)
Received: from [10.1.39.200] (XHFQ2J9959.cambridge.arm.com [10.1.39.200])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 600763F694;
	Tue, 20 Jan 2026 08:45:33 -0800 (PST)
Message-ID: <c5922290-f01c-4c77-995a-9a0ef89053a1@arm.com>
Date: Tue, 20 Jan 2026 16:45:31 +0000
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
Subject: Re: [PATCH v4 0/3] Fix bugs and performance of kstack offset
 randomisation
Content-Language: en-GB
To: Dave Hansen <dave.hansen@intel.com>, Kees Cook <kees@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, Ard Biesheuvel <ardb@kernel.org>,
 Jeremy Linton <jeremy.linton@arm.com>,
 David Laight <david.laight.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260119130122.1283821-1-ryan.roberts@arm.com>
 <20fb97f1-7e50-485a-bdfd-a2901d20ec84@intel.com>
 <C502BCE6-2FB2-4A06-93A8-E8DEDFC22914@kernel.org>
 <785a7d90-babe-43af-93a6-c220c1877bcf@arm.com>
 <a8ca3483-d61a-41bd-9b1b-17a8f3ac03eb@intel.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <a8ca3483-d61a-41bd-9b1b-17a8f3ac03eb@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/01/2026 16:37, Dave Hansen wrote:
> On 1/20/26 08:32, Ryan Roberts wrote:
>> I don't think this question was really addressed to me, but I'll give my opinion
>> anyway; I agree it's pretty binary - it will either work or it will explode.
>> I've tested on arm64 and x86_64 so I have high confidence that it works. If you
>> get it into -next ASAP it has 3 weeks to soak before the merge window opens
>> right? (Linus said he would do an -rc8 this cycle). That feels like enough time
>> to me. But it's your tree 😉
> 
> First of all, thank you for testing it on x86! Having that one data
> point where it helped performance is super valuable.
> 
> I'm more worried that it's going to regress performance somewhere and
> then it's going to be a pain to back out. I'm not super worried about
> functional regressions.

Fair enough. Let's go slow then.

