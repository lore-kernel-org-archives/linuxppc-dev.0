Return-Path: <linuxppc-dev+bounces-16587-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4F5E9D3FF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Feb 2026 15:20:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f5kZ66BF0z2xm3;
	Thu, 05 Feb 2026 02:20:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770218430;
	cv=none; b=R52nrh/HxwcI99LbTcg1ZVdg4WAAgXi6sYi3MvMJgtPAKtdeHA1IYGRhX+l/+smtvrLvNFnVfGzLrFSCAPXEsWgTU04lwOZBANIgeFOSMkq509uFb7vsY/aOgNl+dEMYmDoatWjp7VGj5Y3ilBHWxwoqJavHQ+wgG7S+0VLNvF8xZVVww6MMPDhskBPKgqoFaZTPOXGFlLo0u+ZhKozMXnrzPTiyEcgqMf6psYG0a9lepDLlxebRU55vh1ChMMnJYaE1KfaKcCBfAlJY55k59RZvokpAiYHG2WC8BES98OVaFMM1q3+JrUe2oHzU9Kl20JFxzwWIfL0tfF8AQtKjAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770218430; c=relaxed/relaxed;
	bh=7pD4L63+b+j3hA00EWBUcMoTppTDGstuV/J24qN2eq8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Mus2u9TR2NHizEpuIwVYP4R1Dd3og3JvtCjbnSvNdYx2Y9ThcoTQ4aVnHHUi3QjAs/kinPw9PRKNZIpNyd3R7TX/TpQzfeO53G90oPvdxyvUes6hGwmkMOuQtB2T+LA21zvKJEs0UX1fjGXXw6ZwvRjgQSsZGjqKgdvem5KsVFUDjFZkz48icqoEchwaMPZsTDsmGaNTEx91Mngw1aT68vEr4oUXIBMdiRbbswtTdq/W6qMv7FT9UnES4kX6lfEzjzpH5ZQNiMuOWtDLFwzVGcbHE1fwiIF9IeenkCHclizzjW01IG30/N55fdjnlIoUWTXyBVsWjk4rTh8bgRNPug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ubXJVA9I; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ubXJVA9I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f5kZ61ZD7z2xJ5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Feb 2026 02:20:30 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 29FA960138;
	Wed,  4 Feb 2026 15:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D537DC19423;
	Wed,  4 Feb 2026 15:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770218427;
	bh=LV83XAoHqKAShfT+AE1ovPhvCrwFlhSL6wBvyLgD+xY=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=ubXJVA9IWQFsVT10MV2cX8xswhetEh26NAfls/hCUAlfrGGDCWcWxFPBf7Zi5FVzg
	 ZVvKGaDsLhtq4c0XyIq9GvAgi8sZDwd56jJXpJliLSsDtyM3l3d8PghQupdMMVALTD
	 8Z44+C7aR1EXkXVA28gk2mQVJomrAxQfxnLTTioF3nuWtawWMU3TwM5WaxQkV2/BtN
	 E3FbJj++4DNnvWR3TyGdZZ8lg1un5DVgh+693lqv/tDluv/nYwwYPr/ZEbhW/ZFpiv
	 Ng6eYhXiyLX3/BdlY/jMPTb+n99xaEWOjC0DtKeV8QVBBEnvpLvLec6vZetewHt2fT
	 KJrj0xGWmUGkA==
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
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Feb 2026 16:20:20 +0100
Message-Id: <DG6A23IKOR3S.E8UNRLDT8GRD@kernel.org>
Subject: Re: [PATCH v2 1/4] rust: io: Add big-endian read and write
 functions
Cc: <rust-for-linux@vger.kernel.org>, "Madhavan Srinivasan"
 <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>, "Nicholas
 Piggin" <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, "Srinivas Kandagatla" <srini@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Ard Biesheuvel" <ardb@kernel.org>, "Martin
 K. Petersen" <martin.petersen@oracle.com>, "Eric Biggers"
 <ebiggers@google.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Lyude Paul" <lyude@redhat.com>, "Asahi Lina" <lina+kernel@asahilina.net>,
 "Viresh Kumar" <viresh.kumar@linaro.org>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "FUJITA Tomonori" <fujita.tomonori@gmail.com>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <officialTechflashYT@gmail.com>, "Ash Logan" <ash@heyquark.com>, "Roberto
 Van Eeden" <rw-r-r-0644@protonmail.com>,
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: "Link Mauve" <linkmauve@linkmauve.fr>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260204040505.8447-1-linkmauve@linkmauve.fr>
 <20260204040505.8447-2-linkmauve@linkmauve.fr>
 <DG6A0WRA0JZC.SPDT9WEXF92K@kernel.org>
In-Reply-To: <DG6A0WRA0JZC.SPDT9WEXF92K@kernel.org>

On Wed Feb 4, 2026 at 4:18 PM CET, Danilo Krummrich wrote:
> On Wed Feb 4, 2026 at 5:04 AM CET, Link Mauve wrote:
>> Another option would be to call u32::swap_bytes() on the data being
>> read/written, but these helpers make the Rust code as ergonomic as the C
>> code.
>>
>> Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
>
> The I/O stuff recently changed quite significantly, please have a look at=
 the
> driver-core-next branch [1] in the driver-core tree.
>
> Also, instead of providing additional *be() methods, we should just creat=
e a new
> type io::Endianness and use it to indicate the device endianness when req=
uesting
> the I/O resource.
>
> For instance, for your driver we could have
>
> 	request.iomap_exclusive_sized::<8>(Endianness::Big)?
>
> and then let the I/O backend choose the correct accessors based on this.
>
> I.e. the device is either big or little endian, hence we don't need to pr=
ovide
> both accessors at the same time.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-co=
re.git/log/?h=3Ddriver-core-next

Forgot to mention, please also consider this patch series [2] for your work=
.

[2] https://lore.kernel.org/all/20260202-io-v1-0-9bb2177d23be@nvidia.com/

