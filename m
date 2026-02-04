Return-Path: <linuxppc-dev+bounces-16586-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BAF0E9D3F5
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Feb 2026 15:19:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f5kXM6K0gz2xm3;
	Thu, 05 Feb 2026 02:18:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770218339;
	cv=none; b=EBfkyZybGh7HiSNID+ltIY9fdPitrQw18w1ke3snIPFw4MMnuHlFq7D2N3HaPwZSv8UtdWBOmtdQ6rBREm/hzc8ctlfaDzrQ2ENKly+B2Gixma8zD7bcTUYiqe/rXxI+DcqKG6xSWmtz5rYT320Zn8DbJX9XI+I/VQpRCRijNePPNSghdUrnZzL2USivbDcNdX0jYd3tM6Om8otrLax1xWPgMaCT/Uw+zkcvaTeLradyg19BYg/v+CH+lu92zw+lDsFa3pNroJsN5gJhpHMCleKrpwaWdmFTwQ21YojpqjZHmx8YbG1GSsL9MoBKh41l9uPcXPjIeqsxNML7rq0q9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770218339; c=relaxed/relaxed;
	bh=/r/U7r4dQEZ/kZMSFCyP4yoofqRWU4bOUtamKZ8X9ic=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=YwzP7rQlqFzaNRWQcfF+NyBZajDy6yN1xlNW7dJGXoo6w2/iWItG859bp+GUDZOhfLDb9RRdTnRpCc4hd3p9H7l+k9PwiO3uKPVefKSp4g5F30CkfsaPveyj9LOsCHYWdbyNAm6do4fOS4se1YzShKBWnhylT9T0nBcvrl7N3cfiIjz/SGU5jMIlSn9MVnfv1Uqv8KBt1jhKRCVdKJ7lsms2cGVMJZhb2idaluRMZgX05Yl1D5WRenpN54+13G6BABhTfDKuznaXFi8rYCFiJYnpBW6Zj/xMo5ETdFRbl+mUIhWp2ONppyyZH4VZqtmxYu6gou1rRyHvUyAVCz+g3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lP9jjWuk; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lP9jjWuk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f5kXL54bQz2xJ5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Feb 2026 02:18:58 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 35E8460127;
	Wed,  4 Feb 2026 15:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CB0C4CEF7;
	Wed,  4 Feb 2026 15:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770218334;
	bh=R/vYVRpiIAu9yQjINq8nY1wv3oc/VE2zCfT+3Ijz/40=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=lP9jjWukmyB7EFdcetvQyxJXXhPXHKFrHML61W5B4WEE2icZWtPcdHewuK9ibiQSH
	 baHVldFuhplxp1PjWrkUvgBUAqF2CYkBFeVGLnNwUwkiGBAvquhy6eQOJlFnEK/OG6
	 +kbH9QMJq5wOxeUTLb8QBIRZYZUXssU3nJXQGW/oQwWwDjZpXkZZDLLlM7aTjaotLh
	 hQI8JrMDt+oQPfUg+LwhFUQMEcNewdPw4h6R1vnHzQ03FRwAxL0GI+H0bbsOW+WiiB
	 /IiKPTahxsOHwXboK2DPHJAjYjwXBfN72iHP/Tu+OF5yPCmds+AKnE1m6BIdY6O3d8
	 IJbrU76l0lcww==
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
Date: Wed, 04 Feb 2026 16:18:47 +0100
Message-Id: <DG6A0WRA0JZC.SPDT9WEXF92K@kernel.org>
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
In-Reply-To: <20260204040505.8447-2-linkmauve@linkmauve.fr>

On Wed Feb 4, 2026 at 5:04 AM CET, Link Mauve wrote:
> Another option would be to call u32::swap_bytes() on the data being
> read/written, but these helpers make the Rust code as ergonomic as the C
> code.
>
> Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>

The I/O stuff recently changed quite significantly, please have a look at t=
he
driver-core-next branch [1] in the driver-core tree.

Also, instead of providing additional *be() methods, we should just create =
a new
type io::Endianness and use it to indicate the device endianness when reque=
sting
the I/O resource.

For instance, for your driver we could have

	request.iomap_exclusive_sized::<8>(Endianness::Big)?

and then let the I/O backend choose the correct accessors based on this.

I.e. the device is either big or little endian, hence we don't need to prov=
ide
both accessors at the same time.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core=
.git/log/?h=3Ddriver-core-next

