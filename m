Return-Path: <linuxppc-dev+bounces-17733-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E4FEFCE37
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 18:47:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fR1ql2F2Xz3c1T;
	Thu, 05 Mar 2026 05:47:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=82.65.109.163
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772650035;
	cv=none; b=LUUloLHOB/9IkSV+HRgIP2h6LULe6nd1U5vKf/b7SQ2PQC5KvstxKhGBnq9brXqZfV+Eh9wt5MFtaB616Mwbja4Oh5qqEyqs0d9mYjzd4Z+fG5eE058cu0iHiHqL2Lspsi95KNbkin0e6xB7/m2ijw3f+MdEym/OnmSw0iQzWhbGbjDgRFv5bPwU196ya1TPwJYYcVW4DlWg9qbNWmrFu9jO5DfGRDq7fdSbwIsq2WVz2uUYK3s52D7+p3Xbmmj1iKnxo+8/bkf6cZBwOXXrTZuXbuA9xS0COrPQm0W9USfUEXjQiCiWMNdVOUrwz0lbhSGWbZsdIEw2zfxcHiu08Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772650035; c=relaxed/relaxed;
	bh=dzCHBWMrd9w+GUDKyr3YgtkjLsg3arxs4nOnEeh92lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xc3iICRAD3i+cTJfDfHuR2IAKPyM0wSMhCiuxSE8LCnFArybnCPJsYO3MAUbXgVqs38pbuiLo6MYX36Gr5NOSZLkhi4oxO/Mr8n1AiknbddtZHIVvrqiWoS3k3V8hf20/3aSEz1i6GgweCxcYWmw57AWIdLIWmy9qwqPHVqGZpWp0JAwn2vyAQUhBmRoobDOqoOKK8IxA2KiPi20R2JKoDVvgB9DxUvM7LTqZGbHVCnNBDk1TN3xk6eyZ0uqlD10ZUdl2SkNHuYnJRt8rtmrPHUqkck2Kzt/RxDSx3mdgqKpwrwLSGX4a4OFrepHPOjV+nwjXmgOXe9XLkoGWO/DwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass (client-ip=82.65.109.163; helo=luna.linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org) smtp.mailfrom=linkmauve.fr
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linkmauve.fr (client-ip=82.65.109.163; helo=luna.linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org)
Received: from luna.linkmauve.fr (82-65-109-163.subs.proxad.net [82.65.109.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fR1qj6FX0z3c1J
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Mar 2026 05:47:12 +1100 (AEDT)
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id C5E68F4392B; Wed, 04 Mar 2026 19:46:59 +0100 (CET)
Date: Wed, 4 Mar 2026 19:46:59 +0100
From: Link Mauve <linkmauve@linkmauve.fr>
To: Link Mauve <linkmauve@linkmauve.fr>
Cc: rust-for-linux@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Eric Biggers <ebiggers@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lyude Paul <lyude@redhat.com>,
	Asahi Lina <lina+kernel@asahilina.net>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Tamir Duberstein <tamird@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	officialTechflashYT@gmail.com, Ash Logan <ash@heyquark.com>,
	Roberto Van Eeden <rw-r-r-0644@protonmail.com>,
	Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [PATCH v2 3/4] nvmem: Replace the Wii and Wii U OTP driver with
 a Rust one
Message-ID: <aah-I7qxeI0Va3Qy@luna>
References: <20260204040505.8447-1-linkmauve@linkmauve.fr>
 <20260204040505.8447-4-linkmauve@linkmauve.fr>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260204040505.8447-4-linkmauve@linkmauve.fr>
Jabber-ID: linkmauve@linkmauve.fr

Hi,

I’m working on a v3 of this series atm.

On Wed, Feb 04, 2026 at 05:05:00AM +0100, Link Mauve wrote:
> I wrote this driver long ago, and wanted to try seeing how hard it would
> be to convert it to Rust.
> 
> It is a very simple driver, we write the address we want to read in one
> memory address, and read the data from a second memory address.  A third
> memory address can be used to disable all reads in a range until the
> system has been rebooted, but I didn’t find any reason to expose that
> feature.
> 
> I made sure to use no unsafe in this driver, to make sure the API
> exposed in the previous commit is usable.
> 
> Ideally we wouldn’t have to impl the write() function in
> NintendoOtpProvider, but currently the vtable requires both.
> 
> I have tested this driver only on a Wii so far, but I assume it will
> work the same on a Wii U, just exposing more memory banks.
> 
> Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
> ---
>  drivers/nvmem/Kconfig         |   1 +
>  drivers/nvmem/Makefile        |   2 +-
>  drivers/nvmem/nintendo-otp.c  | 122 --------------------------------
>  drivers/nvmem/nintendo_otp.rs | 127 ++++++++++++++++++++++++++++++++++
>  4 files changed, 129 insertions(+), 123 deletions(-)
>  delete mode 100644 drivers/nvmem/nintendo-otp.c
>  create mode 100644 drivers/nvmem/nintendo_otp.rs

Should I make it a Rust reference driver[1] and keep the C version, or
is replacing the C driver like I’m doing here okay?  Ideally I would
only maintain the Rust version in the end, but I’m fine with maintaining
both for the time being, until we have everything sorted out.

[1] https://rust-for-linux.com/rust-reference-drivers

-- 
Link Mauve

