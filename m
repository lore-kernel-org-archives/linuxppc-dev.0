Return-Path: <linuxppc-dev+bounces-2342-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3537FD21279
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Oct 2024 11:01:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XTlJc4DZkz3bcJ;
	Thu, 17 Oct 2024 22:01:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729162896;
	cv=none; b=WSWno0IxCxgZ4nGBxcMum/pt+GFX1va/L4Gqy0eEZKjIC42GaeEpNVfZkgQ9nh1f55sItT6ovXJDHmmnadc+1o3hlF87ctSzxoL3Xw771Or4U9p1d8wo7AxoBNtyy5bf/0SlDHkeKJBP8bxSKc3QdAN0CwZjEMpXBaPh9wSb6EJP3AenTs/bImiCLsjFDodsJZTjSZsbCsnZaLUmStGNKINB0JpssGaLnu1f9x2Okj2lKdXxBGKuqmnavfDcwt1xd7ArYe5HJZNHe3i6KjvTdX47Y/VE7yUoar9Wu2hoIqswg/TVhvvH2WQXi0z8XAq9LQP4iElbfyXgO2cxmS+SQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729162896; c=relaxed/relaxed;
	bh=Pd/nzyF9akbpng6TPqzu39jms953P8St88qWyc0EyJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLnVWY6n2dU2/SMMV61dw8tHvzXk5svJGQUKCgQbJ5SUdsKRmlOWt0zvKSLfUDJtN2Xaiwgp+LxoCa5y8LVdxtxeo0HDk+5uXQeTXH5iel21aKULJS8B3DsPpqwQnJjPl9J/0gOSS0p/Qw4l3T3xdx2+szbf19rScCrIsmwmkRWXqrlvHGhHCdfxx7Y259+ksJNHvi6zG1HiDBooB+NYCHSF4+SEw+b1wZ1cd+dgTpPbVg64v4VEsGMeAginvFpzuYZe4M+LancRVsAhAZEP+AvZUq58WP3LX0xPtznPrHxZMqusU+u3+6mOJBUkUHkmp0FHSt38/ylqAxe1nV1atw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de; dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=kDOPqLQw; dkim-atps=neutral; spf=pass (client-ip=65.109.113.108; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org) smtp.mailfrom=alien8.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=kDOPqLQw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=alien8.de (client-ip=65.109.113.108; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XTlJY0cVSz3bbn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2024 22:01:29 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A7EE140E015F;
	Thu, 17 Oct 2024 11:01:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sdVDBS_ar7nX; Thu, 17 Oct 2024 11:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729162873; bh=Pd/nzyF9akbpng6TPqzu39jms953P8St88qWyc0EyJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kDOPqLQwfd01tdUo+Hf4OVXgxuo46pJKP7oORLtdbIraDydDe/prjCeMrxH4Y1uan
	 9CjAXq+yELAxpK/SurLmBrpAg4pLnNKZTzIgLwbZZuXm7s6qvwX6c94cG41we8npV3
	 Z8lGeIbQw0mXOIZCY2DenKvQRnRCfOir/KixRDc3OPLcUmnNImv4aiokylotFqc0eA
	 W5HXEEi8Db40pDY7CPNQzxe8BV1pGawBzf9Nd2Q93GL0k5h+gCMWYo1DJguYOdoNtW
	 YX4TFhJAB6V78QiSMKJjIM0m2P/rKL4O7Zy5bX/hmjUv6u7qUIBpdMNIGAL4y8wTm8
	 jESmim6rKOLDOsMvESyc+Q7Bp5CXohehMONdJ5gwHWoaJ5rhtPWr/94SlmYbTimo2j
	 5DPq+0xR2UhTqYvs7o1t0y4V2SHtWARoB7OoIPY0FtZ78ptz4PHoy51S8mjVEJOfsl
	 8npF9DnqQuhw0+m6OoUbOLhktQneHmtxSNUqDlO33+Dby1VDl0102c7c3acCmw+Fv6
	 wiV71l+9Ka2wcoGSrIp3uouR8yXOpKRO9qgrid3iIgJy+olMK29uPm6SEYbgoHkPrt
	 15ir/S7Z4YlTO2stpWTN1tRehceefiVeJ08wAkG22D1N7e0J5hpHlYlCkf5TTMiei+
	 Zs5n26rDVNed+b8j6OLO22fg=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 566A840E0219;
	Thu, 17 Oct 2024 11:00:59 +0000 (UTC)
Date: Thu, 17 Oct 2024 13:00:53 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
	"Kirill A. Shutemov" <kirill@shutemov.name>,
	Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Waiman Long <longman@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] x86/uaccess: Avoid barrier_nospec() in copy_from_user()
Message-ID: <20241017110053.GBZxDuZakoxqvvITC8@fat_crate.local>
References: <CAHk-=wg341Na_hXFFkc582beXJNi+_tcDu=oMxVPTks-JoQXkQ@mail.gmail.com>
 <CAHk-=wjAoiCmPSi1OwrJofifmtRYEzecjUeu3UUUELMbJHopUA@mail.gmail.com>
 <CAHk-=wgDrG-aKVGrd-9gQsC0pMs936oo8XEFmEn6ciaT9=nfDg@mail.gmail.com>
 <20241014035436.nsleqolyj3xxysrr@treble>
 <CAHk-=widMFN2wDeS2K65f8FnW8L6gPZa6CNO4OWkv--0G2LXhw@mail.gmail.com>
 <r5ruxmop7vewd7aq6gu2zve4hfmcu4byhlebygswbqkgz43qfq@rsajyfiypcsd>
 <CAHk-=wj8v4BcD7f3pObq1wav_mJO_naisYGg6HQUcphSc-U0zA@mail.gmail.com>
 <CAHk-=wiVE1QCwnP98Hw0GfjrEKiZsvsaqgzC02zJj-BYp4-khg@mail.gmail.com>
 <81444391-9e59-4744-bbf0-2220a3042da6@citrix.com>
 <CAHk-=wgqfdRHEOdS5getruouT7N_ZT4i4gHMcwJYzcKw-s_cFA@mail.gmail.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgqfdRHEOdS5getruouT7N_ZT4i4gHMcwJYzcKw-s_cFA@mail.gmail.com>

On Wed, Oct 16, 2024 at 03:32:32PM -0700, Linus Torvalds wrote:
> My preference would actually be to do nothing, on the assumption that
> the AMD issue is actually impossible to trigger (due to CLAC/STAC
> serializing memory address checks - which the timings certainly imply
> they do).

I'm verifying that assumption...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

