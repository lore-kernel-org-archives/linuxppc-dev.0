Return-Path: <linuxppc-dev+bounces-16740-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A464E81BAF
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Feb 2026 12:29:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f8kXY3skFz2yFm;
	Mon, 09 Feb 2026 23:29:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770640173;
	cv=none; b=VdLBJdkZGjEFR9wDX5FB8VbJASJVeATUSNh5jbo3gFa/LecScnTvAnn/1vJj1rzWzfXyiR0sTxRKuAu6l7Ug7td3eIvFLMNFHVKjKlBpM19dv0GcGPWbcu71WJ9WrHCUGbI4OHMRCVaDuAFUf57sjE5bWw8Xeei+gR7v9FtfevquxRwh810891aNVn+kCnul+aCG2uGwcZNMakq5nTWFQRvHzzJOC6ZNC9cZ6ogdQf/qlfUMWWh7NhS7z8S6VkwyHjAGKUsb9hwyfd+WkGA8Qxv6zxUTHEqzRKouCnQqNrM90VnhcK8ixGVU9YdJFGBEhX74tCk9wO1iugf+qHv5DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770640173; c=relaxed/relaxed;
	bh=aPyWXd5JW5FTA5n2xYq7xUZFQYSdg/d4Q2uYiB/yjOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPxiUIOC26jI+Q1qmmzGXoVpox6dvru6p5lLA9t0TjFZ1ng1+RI+Zqoxg+Y6GLCC6UwdDyqID2PdVNz4mH7QagUEHZQl+iMk+zd6+EtLoqPUGHWysn9PVjUq3w7kl3dDGv8T9HsFgoe0umhqUnksYgJLu6rpJCgWDS0LjjiyiI/CeNd2YapAKxapW7jRo9lK1nL7MORH3JKt8GIZsnCD+YkNvQySAeuWi3MrymtS0vcwESFWf9k1OrEOmVCdDsiCfzVNfnhwq0P1rdoO9Ut3znOk8bZsnnPCjnSX1AlkL7J2zRBhi5AGZYXvriIbmovpjYcgarCPC2SpnF9pnrI4XQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FimbCrO3; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FimbCrO3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f8kXX6hhkz2xBV
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Feb 2026 23:29:32 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D92374095D;
	Mon,  9 Feb 2026 12:29:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C81C116C6;
	Mon,  9 Feb 2026 12:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770640170;
	bh=rZJsEwJQERROgyEOKeX0VRgi9ahkckCIU8JBoz0SPhE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FimbCrO3xbNLl5zpKdTswhL+5udkXP3NNz5ny++NqpSl/moVIpiBsyBJNHKVz8oa/
	 0JHXWuH2LZ4q/bluRskbXFtGjkVLrn6R4QLRS4pJICtH+6ARlhGx2G5U3ryk2hyYAo
	 ohWvOc3Sljf3NS896r5wx0UP9sRBwjQRHD/9AaSTDwDtYOScrnzOJiHSz8DfnoZ6Oh
	 cVOxeouAZOeeAJEh/6pMNtlucg6Qh2GK4OIgKTwqWes+06LVnRW1h/DvwRlm/Q7Jxq
	 T9jfjyLbCXQOBSWvcafVgW0zQhNFe+8eT48ZC5IHsyyq/xww4t8p5RQv2+0uYczpFV
	 fN3sdbLB4g1kQ==
Message-ID: <b07f1bc6-c63e-4b97-95d6-c639186a89dd@kernel.org>
Date: Mon, 9 Feb 2026 13:29:22 +0100
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
Subject: Re: [PATCH V4 2/3] rust: Add PowerPC support
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: linkmauve@linkmauve.fr, ojeda@kernel.org, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 dakr@kernel.org, corbet@lwn.net, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, peterz@infradead.org, jpoimboe@kernel.org,
 jbaron@akamai.com, rostedt@goodmis.org, ardb@kernel.org,
 rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20260209105456.1551677-1-mkchauras@gmail.com>
 <20260209105456.1551677-3-mkchauras@gmail.com>
 <CANiq72nqH=H4a_Yo17KPmku5pPRMVRBADgj8j+=TcR=3r0vOdQ@mail.gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <CANiq72nqH=H4a_Yo17KPmku5pPRMVRBADgj8j+=TcR=3r0vOdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 09/02/2026 à 13:02, Miguel Ojeda a écrit :
> On Mon, Feb 9, 2026 at 11:55 AM Mukesh Kumar Chaurasiya (IBM)
> <mkchauras@gmail.com> wrote:
>>
>> These changes aren’t the only ones required to get the kernel to compile
>> and link on PowerPC
> 
> Is this patch not complete, then? It is up to the PowerPC maintainers
> what they want to merge, of course, but I don't think we should add
> the line in `Documentation/` if it does not work yet.

As far as I understand the patch is complete, the problem is outside the 
kernel, it is in the libcore provided by rust or the rust compiler.

That libcore seems to call __udivdi3() and __umoddi3() which are not 
provided by the kernel. Instead if should call the functions do_div() 
and friends provided by include/asm-generic/div64.h, or provide 
__udivdi3() and __umoddi3() on its own.

Christophe

