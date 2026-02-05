Return-Path: <linuxppc-dev+bounces-16615-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BEAEC1EAD
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Feb 2026 12:48:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6H8X5ZwHz2yF1;
	Thu, 05 Feb 2026 23:48:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=82.65.109.163
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770295724;
	cv=none; b=BjyMGABRf6oyZW3mYkOXpfuYBDjiA8guIKOssNY2gaPvAC5Plhza3wu6mP1S2btkBF8enKkpKwWIJ6l4t64OpxTBBzohKkeQpd0/rgVFIuzx6xBX4T9FnIi0tX0jwjtL5MFKGnuFLbOIAhLcv2KiCRNuZZ7eCy0sJvg2Lv1LfoThEiXilOYRH9dr5YCdKEOtGOn5BjmR1sFdYqYbQCuk6lj+b1VGcFtCqNp9jQ9NhaWGEaNlXbctiL701HAYkyH3R0I7XX/xxf56XrK3x8XexA9w/7EaVMGw5p52hLW8eHJlwbeTja2UBCrJJPDI23HzQtRjjfXhEsOOoM0JQlqu1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770295724; c=relaxed/relaxed;
	bh=g0LaQspl9srLk8Lur3rWa+c8LeH6NGZNqUB1Y1GusZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eEHlfywnQKffAxSeW3+7Np6wHe68rXk+eUnzNCzFhlETJiqVnWYi7ypm7oR+6itf8w/qLTFasvdmDT0+tfJMJclcQjxOGT0n5PzLSf+zAtd/gizW0N8XXdQ2FKV4ESv7Agg9Xb909vEpZQl887f3xeucN0Y9jX1khm8oDDdw5o5u+xhezGhmO6V4t9IFL3DfPstouKCE0rh/I+nY+zT8DtfoS09auqxJ/iyp5FYkO4kVp3enQAfqxxgAurw47eTEc8jd21HNHjTCAsD4nq3uTgR/ikp5NhV4h5W4sC5dC58SyjfgiLnQJ/kqvN+JNqa2K6KfN7AoBW0WLTJslqDRMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass (client-ip=82.65.109.163; helo=luna.linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org) smtp.mailfrom=linkmauve.fr
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linkmauve.fr (client-ip=82.65.109.163; helo=luna.linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org)
Received: from luna.linkmauve.fr (luna.linkmauve.fr [82.65.109.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6H8V4vz0z2xrk
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Feb 2026 23:48:41 +1100 (AEDT)
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id D0AB5F43B46; Thu, 05 Feb 2026 13:48:32 +0100 (CET)
Date: Thu, 5 Feb 2026 13:48:32 +0100
From: Link Mauve <linkmauve@linkmauve.fr>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Link Mauve <linkmauve@linkmauve.fr>, rust-for-linux@vger.kernel.org,
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
Subject: Re: [PATCH v2 2/4] rust: nvmem: Add an abstraction for nvmem
 providers
Message-ID: <aYSRoIvhx5FAygDe@luna>
References: <20260204040505.8447-1-linkmauve@linkmauve.fr>
 <20260204040505.8447-3-linkmauve@linkmauve.fr>
 <DG6A3L2W1YC0.YOB6BUMGG38F@kernel.org>
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
In-Reply-To: <DG6A3L2W1YC0.YOB6BUMGG38F@kernel.org>
Jabber-ID: linkmauve@linkmauve.fr

On Wed, Feb 04, 2026 at 04:22:16PM +0100, Danilo Krummrich wrote:
> On Wed Feb 4, 2026 at 5:04 AM CET, Link Mauve wrote:
> > +impl Device {
> > +    /// Register a managed nvmem provider on the given device.
> > +    pub fn nvmem_register<T>(&self, mut config: NvmemConfig<T>, priv_: &T::Priv)
> > +    where
> > +        T: NvmemProvider + Default,
> > +    {
> > +        // FIXME: The last cast to mut indicates some unsoundness here.
> > +        config.inner.priv_ = core::ptr::from_ref(priv_).cast::<c_void>().cast_mut();
> > +        config.inner.dev = self.as_raw();
> > +        config.inner.reg_read = Some(NvmemConfig::<T>::reg_read);
> > +        config.inner.reg_write = Some(NvmemConfig::<T>::reg_write);
> > +        // SAFETY: Both self and config can’t be null here, and should have the correct type.
> > +        unsafe { bindings::devm_nvmem_register(self.as_raw(), &config.inner) };
> > +    }
> > +}
> 
> This should not be a method on the generic device type. Typically we use a
> Registration struct for this, i.e. this would become
> nvmem::Registration::register().

Should I also switch to the nvmem_register()/nvmem_unregister() API
instead of the devm_nvmem_register() API, so that the unregister can
happen in the Drop impl instead of being managed by the kernel?

-- 
Link Mauve

