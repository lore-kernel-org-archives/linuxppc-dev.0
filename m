Return-Path: <linuxppc-dev+bounces-22741-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E81CD98E4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Jun 2026 12:42:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ggNm44qwYz2xF8;
	Wed, 17 Jun 2026 22:42:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781700132;
	cv=none; b=bsdXG4VjY1grweUcGwZ3yKBV8PK+0SG6zz1p8AJVolGLU2RYMokqi4kKPstnrLb7wLRt2EYI6tJzbxskacmxIUHICom1jEE2OB1apjTZ6cV8AzZZvFubv6DcVx1i8enZBF56Y+KecmEEo6FqF72sSZjVy1K8QWhcFl6t6KZBY4CaorM6mxfhzr+PyMri0Ud6OPPmhOo7DEOyd2o4XbmsLmSMjuHJh6QygRYjnmBlN1br6ChLHZvx0qPi+aOivU87L/Z0eJYdXjoWb/x5iakVB9+nQkcvjJCmAIeT4QtF8acPk96cbPwo58YfdAEx5BGZGIpswK6GwJz3IsxWN8O4vA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781700132; c=relaxed/relaxed;
	bh=shMcTxpz7Iae4CMErv9/x2nY1BGPOVWbdpSfFAc09vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrP3IDctFlWiYyask92WQkXyfH2m9Qrak0mATx28yWA6nZ0DgppPC/EY5vjpJLsCFwJmbp5XdTBMnLIG9D3MXAnnCsSkX/Oeu2s82Aq1zvqLxzhAdc961jvJsQScidg22tbrMuI1S+rrXN0ZEBkt7qXgakOivoF/lodd2QaPlorVUVP44EZHEatfJriQiNwnVZ9DnuHNrdDSH+3yREoiNozvymJgvUFjF6UXhuiNl5cgTC6QfLvKWcSd5aGtWBqvAhiODRWObkMSaJpmcTfArR7GKytk9fq2eSUF3n5VY3jyNM/Mbwqvhu0pTuE0hxeUNbg1beTvMylZSv5Ufra/0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Im0bG8Am; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Im0bG8Am;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ggNm3302Pz2xBb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2026 22:42:11 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8175D40945;
	Wed, 17 Jun 2026 12:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643E41F000E9;
	Wed, 17 Jun 2026 12:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781700128;
	bh=shMcTxpz7Iae4CMErv9/x2nY1BGPOVWbdpSfFAc09vY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Im0bG8AmD3bgsJUqZdYGdopEe5rvENwOqhRGA6LfcbikFOn2YUPQXBJWxsK3aAa3F
	 IKOG49MBRGBJ1Mar6LZ2Kju1FxOKtyMrE//+MnE4N9/Z71fGW3gauigkbzrv2V1kZP
	 1FNp162R2Z9QvBsI+njynVaaI0fNfgYS5ai3uG8OmNg5itH6o2+k7segaCwH+SbOb5
	 zOcIdHYuAFv7ORTp8+4nDfybUyv7DTPv3xm7a9kUQ+vj1V5p2XZfw7CYh7IqwWcWUs
	 ypezZIGEaKxUJ1MkpzhGlNdEe4jZuo9Q/Bc1arqIHR5rd7H/I68vBRL6fPgiqclkJT
	 0u72NIrlwde9g==
Date: Wed, 17 Jun 2026 14:41:54 +0200
From: Christian Brauner <brauner@kernel.org>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Davidlohr Bueso <dave@stgolabs.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-efi@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Magnus Lindholm <linmag7@gmail.com>, linux-alpha@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>, 
	linux-snps-arc@lists.infradead.org, Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	linux-riscv@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	linux-s390@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 00/19] init: discoverable root partitions, a.k.a. an
 omittable "root=" cmdline option
Message-ID: <20260617-irritation-rollen-wirst-7d636cbfec92@brauner>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260615-discoverable-root_partitions-v1-0-39c78fac42e2@kernel.org>

On Mon, Jun 15, 2026 at 06:08:56PM +0200, Vincent Mailhol wrote:
> DPS [1] defines GPT partition type UUIDs for OS partitions and
> attributes that control whether such partitions should be
> automatically discovered. The specification states that:
> 
>   The OS can discover and mount the necessary file systems with a
>   non-existent or incomplete /etc/fstab file and without the root=
>   kernel command line option.
> 
> DPS is already implemented in systemd-gpt-auto-generator [2], which,
> when embedded in an initrd, indeed allows automatic detection of the
> root filesystem through its partition type UUID.
> 
> This series adds this discovery feature directly into the kernel so
> that people who are not using systemd or not using an initrd can still
> benefit from it. The implementation follows the same model as
> systemd-gpt-auto-generator:

I happen to co-maintain the DPS. It is userspace policy and complex
userspace policy at that and does not belong into the kernel.

This also implements a really tiny portion of the spec. It deals with a
lot more complex concepts such as automatic partitioning during
installation, verity, LUKS, containers. This is really not intended for
the kernel at all. I mean, it's great that this spec is being used but I
do not want this in the kernel just for the sake of auto-discovery.

The DPS is completely generic and can be implemented by tooling other
than systemd (util-linux implements it and so does refind iirc). I think
not wanting to use or build alternative userspace tooling for this is a
really weak argument for pushing this into the kernel.

