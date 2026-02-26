Return-Path: <linuxppc-dev+bounces-17328-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC08DFD9E1A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Feb 2026 21:54:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMQGD0swGz2xNT;
	Fri, 27 Feb 2026 08:54:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=116.203.167.152
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772142852;
	cv=none; b=A0DomemZydR1grwlvvJ5d4PyPG4s9hKHQuZtC3aE7zl92P/IFiQtR4klDOSudDv41zkuyV1lSTmE5ySVYQlwnBA+wQyLvd3AAq49hzkVIFK749zcZ9o3GcPtt0o9M9zs7IxxVhuCPLCZH+bTlMknF41dSHtgwf8OgW5ehgcNLbq9d+/qU/pDvbauFnMyIFfn7xCF+tOChLcUqM5HYImlP+HiojRXWVMZtLNrtIhbwHD5mrIa9PuP6O+QGGUtw0sFKBFKgrIAJDRujh5JVhcPMu03TAfT8zgkVEjA4Hf9fyVIs5DcBSeuXkxHHdOjb6N31Aym7FtvmOUoHlOJw/8ONw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772142852; c=relaxed/relaxed;
	bh=0IoW2lvrXsjb3iAXC2/BQDLTRJdTcFAm/Q7tz8IzCp4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=X5kRLX/EDvdci2U+poGHvPaKwb3r/Ddxy/pBgwvWorgFr4Os42IA6ANqphWBV7MPROy9Tf9WZd/OXyk4yakczCPiNsgUHMkptdr98UdYH4ZFIFyIbyevQiR1IKhr+dzwJ14NX7heemR39zju/B8XNGK7eGQdKzEl2XGil+PoMvs9WJHoIuBWiXUq1kw/G+A5KblNtiarhfiRjJZWtRAKKeLhysYcI9oSGs1eQErZcXGPFortEszCCnfUH0k6xgR8kqW4Kujq+mW10uSKacFHHIMVXGEEcm0qRv7eNZRUlH25OVfW29PovBsT/wunxJ9YQ5NH1Y/0pSP2FEkDmzbonQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=permerror (client-ip=116.203.167.152; helo=lithops.sigma-star.at; envelope-from=richard@nod.at; receiver=lists.ozlabs.org) smtp.mailfrom=nod.at
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Unknown mechanism found: ipv4:195.201.40.130) smtp.mailfrom=nod.at (client-ip=116.203.167.152; helo=lithops.sigma-star.at; envelope-from=richard@nod.at; receiver=lists.ozlabs.org)
X-Greylist: delayed 514 seconds by postgrey-1.37 at boromir; Fri, 27 Feb 2026 08:54:10 AEDT
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMQGB4qJNz2xN8
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2026 08:54:10 +1100 (AEDT)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 0B325298599;
	Thu, 26 Feb 2026 22:45:29 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id vJnDbvqv8fxU; Thu, 26 Feb 2026 22:45:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id E98F629859D;
	Thu, 26 Feb 2026 22:45:27 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jjhkwk3e1cfi; Thu, 26 Feb 2026 22:45:27 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 2545C298580;
	Thu, 26 Feb 2026 22:45:27 +0100 (CET)
Date: Thu, 26 Feb 2026 22:45:26 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: hch <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Richard Henderson <richard.henderson@linaro.org>, 
	Matt Turner <mattst88@gmail.com>, 
	Magnus Lindholm <linmag7@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, will <will@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
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
	Sven Schnelle <svens@linux.ibm.com>, davem <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	Thomas Gleixner <tglx@kernel.org>, mingo <mingo@redhat.com>, 
	bp <bp@alien8.de>, dave hansen <dave.hansen@linux.intel.com>, 
	x86 <x86@kernel.org>, hpa <hpa@zytor.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, 
	dan j williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>, 
	Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>, 
	Li Nan <linan122@huawei.com>, 
	linux-alpha <linux-alpha@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	loongarch <loongarch@lists.linux.dev>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, 
	linux-s390 <linux-s390@vger.kernel.org>, 
	sparclinux <sparclinux@vger.kernel.org>, 
	linux-um <linux-um@lists.infradead.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, 
	linux-btrfs <linux-btrfs@vger.kernel.org>, 
	linux-arch <linux-arch@vger.kernel.org>, 
	linux-raid <linux-raid@vger.kernel.org>
Message-ID: <445921547.2198.1772142326749.JavaMail.zimbra@nod.at>
In-Reply-To: <20260226151106.144735-4-hch@lst.de>
References: <20260226151106.144735-1-hch@lst.de> <20260226151106.144735-4-hch@lst.de>
Subject: Re: [PATCH 03/25] um/xor: don't override XOR_SELECT_TEMPLATE
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
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF147 (Linux)/8.8.12_GA_3809)
Thread-Topic: um/xor: don't override XOR_SELECT_TEMPLATE
Thread-Index: geHUNAwCPFDc7iDnvkYlaCznwUsWXw==

----- Urspr=C3=BCngliche Mail -----
> Von: "hch" <hch@lst.de>
> XOR_SELECT_TEMPLATE is only ever called with a NULL argument, so all the
> ifdef'ery doesn't do anything.  With our without this, the time travel
> mode should work fine on CPUs that support AVX2, as the AVX2
> implementation is forced in this case, and won't work otherwise.

IIRC Johannes added XOR_SELECT_TEMPLATE() here to skip
the template selection logic because it didn't work with time travel mode.

Johannes, can you please test whether this change does not break
time travel mode?

Thanks,
//richard

