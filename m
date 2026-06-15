Return-Path: <linuxppc-dev+bounces-22653-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C599CD98C5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 17:05:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfGhJ4P5Xz3bwF;
	Tue, 16 Jun 2026 03:05:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a03:a000:7:0:5054:ff:fe1c:15ff"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781543104;
	cv=none; b=URQFQr6V36/EJKhDZxwhKnCR+j0+8t7JlYhO/lSvCf0cXQPTc2NLsvySGDd4bhIu9TYXmbsIso5dxbxxOy0rCGoBRq8M73h/YAUqXJFzvvs6rS+ZIqQu2Oulhp14b9QRE2XjWP6OMkN3KvqLef+H78W1zNBDrebniFaMijSZ9c8ccwavvcki+hv7SUiPO57B1B0REL9gjSPdL7f9xTO5WBvD1D44o1FL+ufmOCPx2tfwlMrg0cDqXTVW0tX+lZe931fxPu3764DW6Gy/gnyS/A45JGFs+lm8nYX0oNJCzgOMr6mz2nWhzRh4IO8MK7MGNn410HVqz+kvPrzoS9NkfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781543104; c=relaxed/relaxed;
	bh=be/KypQX5Q9fujajARM6Q7r9w26ilWIZmzbrtGfAKys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bW1kyZLP3kE6je3C5PkmqgVHY/q46kuhpN7kVIcF1WnPhmHabhsAmT2YDLZVOKfTEtQGSyl7XGWyFR2ZIkM9ZvuCnm7RW/vGn4MPakE2s36Eem58omKpcYUQ5L/5Ew75jWu+ca40faTuVWvlM8RN0T0syU6Qq9ShArR+BOZnT6WLraNVwhhyfpkqpfj8p7LTGo7E9CJ+EoQFPxtX9z4etuf8roGfGsJ9Vaz3vYH+1oVtIElK/Dl1aJPPw1CmP9jnPyxEPdpNqraYJiBlH0Gog7/tmmM8sZT6JjKibVNYJO9MVNX3cViTQY+PeuXTrisikrZYUmldru+XrTHyWx60ew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=SLabnQnx; dkim-atps=neutral; spf=none (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org) smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=SLabnQnx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=ftp.linux.org.uk (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfGhF3jt5z3bw9
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 03:05:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=be/KypQX5Q9fujajARM6Q7r9w26ilWIZmzbrtGfAKys=; b=SLabnQnxi8RKG6kB4YLIrRrIte
	+jYEaBgX5DOoDOdPOU6k6ypOK6lDxxOMXQzKEUszFj5yTLPDASBaagrmnsOk8tUGdmzHw2XGk68HM
	2J1tv7+pE0CjbBOIjeYCz0TsyHOIrqFb8Mb1LadfEs+3t0bUVsavfv//KIZ2S3hmTXIBIqEbnE3qn
	zsd3Hxu29/Ylu8C3lRKI+WwMxWxUWcLIz0u0fTGyYSKAR/XPPXo0Rkv03xUIJElu5cOtap9hCSZj1
	74eb7LaTsGudBKuTsb4/IH254uFPRDECMTh8XzLqKRh9ykQzpGUZV9OECxDmxcCHO22vobRU+rK1T
	RNRNGWLQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wZAjg-00000000Vxn-0xg6;
	Mon, 15 Jun 2026 17:04:32 +0000
Date: Mon, 15 Jun 2026 18:04:32 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Davidlohr Bueso <dave@stgolabs.net>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>, linux-alpha@vger.kernel.org,
	Vineet Gupta <vgupta@kernel.org>,
	linux-snps-arc@lists.infradead.org,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-s390@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 00/19] init: discoverable root partitions, a.k.a. an
 omittable "root=" cmdline option
Message-ID: <20260615170432.GW2636677@ZenIV>
References: <20260615-discoverable-root_partitions-v1-0-39c78fac42e2@kernel.org>
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
In-Reply-To: <20260615-discoverable-root_partitions-v1-0-39c78fac42e2@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jun 15, 2026 at 06:08:56PM +0200, Vincent Mailhol wrote:

> Tested with GRUB, which implements the LoaderDevicePartUUID EFI variable
> in its bli module [3]. With this, I was able to boot a kernel with a
> completely empty cmdline and no initrd.
> 
> [1] The Discoverable Partitions Specification (DPS)
> Link: https://uapi-group.org/specifications/specs/discoverable_partitions_specification/
> 
> [2] systemd-gpt-auto-generator
> Link: https://www.freedesktop.org/software/systemd/man/latest/systemd-gpt-auto-generator.html
> 
> [3] GRUB -- §16.2 bli
> Link: https://www.gnu.org/software/grub/manual/grub/html_node/bli_005fmodule.html

So what does that thing, tied to EFI as it is, have to do with architectures where
	* firmware is rather unlike EFI
	* firmware wouldn't know what to do with GPT
	* GRUB is *not* ported to, let alone used
such as, say it, the very first one mentioned at your [1]?

Or is that conditional upon "if anyone wants to design replacement firmware
for those, and if they agree to follow our wishlist"?

