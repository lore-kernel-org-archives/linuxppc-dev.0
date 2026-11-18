Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B51C60A2610
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 13:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=jaJ/iyiX
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jV21v6Qy0z2xSl;
	Thu, 19 Nov 2026 00:07:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:760:2e00:f0a1::32"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795007235;
	cv=none; b=au1D+Tysa8gBFbhB+DOy4tqTyOw6vpa1EVZ1uXFmyTabV+1uLOJW+pXTDBrW3UEHRWZjM4MOyHFY0aApISnHbpaFm32osqMU6IxNnNm25lXGhTZPwU5YMJNdcdegYe7vtiguWANHP4uRqF4ga64wtxBM2hP5AiOD/Zfm9ChSgr6A+wvDC7khWyw8qTLQ6AUr2RLAgo26mRF+rhIPSGM+RKxXkzNFlr3pDC3N/v/5NJaUqWxqFYcvl4HV2kLhe4qZ36YMjH5WZs5LY6+cy0ZKJSW67gkcC2MyElk/YHkqTuGeTmvQv6v8vDruOUyuF/fTrWWuPBwjPm0OrYqe0j3BqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795007235; c=relaxed/relaxed;
	bh=wcQud4TjvAnhIm8lhxRx5VZLJFGXhPtPHhfm5f/gKq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCXAvoHugHJ1iLG0HuJE1pLzxKQ66qXSWA9jFBXBrS+1cBzc/6RGNv7mJt1lh2iyalQwnjRTAonYzgfSMipVeiRxGnwsNaseUKdrEJWEGj7WwuzGi11s9HONVkrovI4qs9NyD/bbyR61B2zarM1gfc1QMeDK+ln8LcmRtru9rr4mxSvi0skTlFU7tlzWZwJWX/tRT2VgfMzoYR++UHUJZbIH/AU+5GEAwQwhdD8ZrSjHCv7ZvsI3nm9ONBIW4Rg80+TMCdj4BDruMQ2JcYPat28Dvu1jQqipaM21zFgcLcqTU0R716d3zOw69cBQH1+wQn5rcAARvKKPODaO5cpU5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it; dkim=pass (1024-bit key; unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=jaJ/iyiX; dkim-atps=neutral; spf=pass (client-ip=2001:760:2e00:f0a1::32; helo=mail.virtlab.unibo.it; envelope-from=renzo@cs.unibo.it; receiver=lists.ozlabs.org) smtp.mailfrom=cs.unibo.it
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=jaJ/iyiX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cs.unibo.it (client-ip=2001:760:2e00:f0a1::32; helo=mail.virtlab.unibo.it; envelope-from=renzo@cs.unibo.it; receiver=lists.ozlabs.org)
Received: from mail.virtlab.unibo.it (mail.virtlab.unibo.it [IPv6:2001:760:2e00:f0a1::32])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jV21s3p3qz2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 00:07:11 +1100 (AEDT)
Received: from cs.unibo.it (renzopb-wl.cs.unibo.it [130.136.2.252])
	by mail.virtlab.unibo.it (Postfix) with ESMTPSA id 184BA1C024A;
	Wed, 18 Nov 2026 14:07:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1795007224;
	bh=lb0XMELlXwhZyPpxWvURW3p1in9nS5q+dLi6aSu9rQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jaJ/iyiXBY+Y4jYCYhlt5rkdRaZ0t6Gbdrnf33D7e7U//d7upt8gr4XSiHgoPzEyH
	 lakYksP8Sjnn6WqSVmC/d7K7jvdcpKTjwjF8IHU0huSQ0Ip+FazYU7PtmTQPNM8f+G
	 T8BxdetVC4nyBkGpt04dMXXUfbCznRdfgozDpKBk=
Date: Wed, 18 Nov 2026 14:07:02 +0100
From: Renzo Davoli <renzo@cs.unibo.it>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
	Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Thomas Gleixner <tglx@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, "Dmitry V . Levin" <ldv@strace.io>,
	Alexey Gladkov <legion@kernel.org>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Davide Berardi <berardi.dav@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org, strace-devel@lists.strace.io
Subject: Re: [PATCH v11 0/3] PTRACE_SET_SYSCALL_INFO: add support for seccomp
 syscall skipping
Message-ID: <av2i9kbZyMRJE9D6@cs.unibo.it>
References: <20261114181923.370930-1-renzo@cs.unibo.it>
 <av2PKIf8YsEPro8O@kunlun.suse.cz>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <av2PKIf8YsEPro8O@kunlun.suse.cz>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 12:42:32PM +0100, Michal Suchánek wrote:
> from a user point of view it is not clear to me why this would be done
> at the seccomp event when seccomp is not used.
 
Hi Michal,
 
thank you for the review.
 
You are right, and the cover letter does not explain it (only patch 2
does, briefly). The series is limited to the PTRACE_EVENT_SECCOMP stop
because that is the only stop where a syscall can currently be skipped
with a preset return value in an architecture independent way: the
tracer's request goes through the same path as SECCOMP_RET_ERRNO,
which every architecture already handles.

At the syscall entry stop this depends on the architecture's entry
code. On some architectures (e.g. MIPS) the entry path overwrites the
return value with -ENOSYS when the syscall is skipped, so the value set
by the tracer is lost. A tracer that does not otherwise use seccomp
has to install a SECCOMP_RET_TRACE filter to use this feature.

> On s390 the removal of such architecture-specific flag is proposed here:
> [...]
> While that shows a way to address this problem not all affected
> architectures implement it.

Thanks for the pointer. With 05c033db7e9a ("entry, treewide: Make
syscall_enter_from_user_mode[_work]() indicate syscall execution") and
Heiko's s390 fix, the architectures using the generic entry code
preset -ENOSYS and leave the return value alone when the syscall is
skipped, so skipping at the entry stop could be supported there. As
in patch 1, a per-task flag checked right after the ptrace entry
report could be used, so that it does not depend on the syscall
number.
 
This series stays limited to the seccomp stop, which works on all
architectures; support for the entry stop on the generic entry
architectures can follow as a separate series. If a new version is
needed, I will also explain the restriction in the cover letter.

Thanks,
renzo

