Return-Path: <linuxppc-dev+bounces-18990-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18CB7FF4940
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 05:27:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkfrV56DRz2xpt;
	Mon, 30 Mar 2026 16:27:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774848426;
	cv=none; b=krY5h1tD00g2aHdwH7sR7Y3wn8ygCG/k15LLBBYhYd83I0Kz7LtmRFY0v8f3p4IxZh/KFpDW/+j6RYnPprbsQReITXWrknmlGlowNk0hFLvFVuVT32yoOWsR2u3VvHtXXsl23cy0If5UeCP63CnhgbJ6f9msy1JYd11oGoJz3UY4WBSNV7UR0v9F1ETaQgB9gHR5EFpRd1tKHXMbihKnuGfoLNtzLJbbrBu4AsAItL3i2RnQB/+s1wDGRepvsgBWoYPiIBf/gGgQZTN9iubSoq4ILOXvxY0CnqtY7q2tFbg6zTDxR2jEiUOSlhmKfemO6xxY62f8k+F8on5l3lujyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774848426; c=relaxed/relaxed;
	bh=P2s+k2TM5rp2RD2a3wpwN+IFaO39gd4Lf0/s3XTaUg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuveO3ANsDsADf+ciMVQVFxgpmieBt/Et3P9diU28Nihvo8pzKDbTtAKqiQWwQio5kuWl1KG0BEaANl5AYIG7s4L7dHalgOp/rTD4tlxzwfLBspxFrs8GUIshPl9aVeeUiQ6XukX99nscm/65Q/h8PqKAZajLaJ+b+PyaIJExYiWZpZLHP/0qq8nQYhjGSPOS2lBU15uImH1P/7KgkBrSRmMQdkH4n8AC4YElE9ocQuyuxnP5bQOiNsa0kVoaoSrSRWqIkyh+Z0FUBIeiN/wymVy/thKpMpBVLZxA6Iku8TWh1uRvNJ48UEJJ1odiLsad+FT3zIfqJwincByLwqwaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkfrT1Pr1z2xlK
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 16:27:03 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6E3C268B05; Mon, 30 Mar 2026 07:26:55 +0200 (CEST)
Date: Mon, 30 Mar 2026 07:26:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
	Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>,
	Li Nan <linan122@huawei.com>, Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: cleanup the RAID5 XOR library v4
Message-ID: <20260330052655.GA4592@lst.de>
References: <20260327061704.3707577-1-hch@lst.de> <20260329213119.GA2106@quark>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329213119.GA2106@quark>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Mar 29, 2026 at 02:31:19PM -0700, Eric Biggers wrote:
> But yes, as Andrew mentioned there are two "xor: add a better public
> API" patches.  They should be folded together.

Yes.  This is the ages old git bug of creating duplicate commits when
a rebase has conflicts biting again, sorry.


