Return-Path: <linuxppc-dev+bounces-17329-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B2BFD9E1A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Feb 2026 22:10:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMQdL6hKCz3bZm;
	Fri, 27 Feb 2026 09:10:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772143846;
	cv=none; b=EMuno1uR13UKVbl+ogYp5ParVSbDyh01FA3yctabgjAWrcGqemXZL27NMDV8f3/a9iApBRngGaVgcInHk9K7szAXio9p5gJPX762gba7BVxczY/skoJ8u1cPD/CjWTr1NTuOI3PKySNSRPZhbntiU02UXEBZBI8g207Cg4D4j/vzak1XfZ6D23sJ+mX634lU/6PvgZ5iob3ODINRr4YF0NV6AsmsnlceJ/lHvxs3T/KCwFtN9XFBk3fp95JgjDSIxoB1AhVIPb/4JuNm8KqM8lL4zEW9ZowLT3GOWVOsAMI4yf/Nrhnjs8zJyCbx2pXNcZwZ80uKHhzlHVp6usckuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772143846; c=relaxed/relaxed;
	bh=3ilvamkoK822H0OMpkLt0O2v/cHCUl9aKFe1v6Kcca4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSJrJHMdfNg2UwLvL0+KP1/5iab7iN+0i+TrsOwEJvelqqvS6dNmfbQIgOMWHCP6FyQN+/Go5Kayt5BC0G/KcSXf+/J+61KaEzwWapv6sjFEflI3N5keisn8VU1pC6zmJzZ1umHCN68IyOdFLwcFaNVjHjPCIqJjwJUzbS6d7xYhInjDebx/PRXp3QsCYzDkhaBK1CmHTg3p3GFmM40TbmS3XiIUgWBHsuCLj/3svdH6B20xyVq7MeJifG2f9UiQyGtpIE+DiIA45pG2uJR5rikigB1d5pYF1aKfNNVp4c+BR3Zj6xBjFXnJ8LXhFQLlqtv8b6AWi+RFiVyxDJXwfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 593 seconds by postgrey-1.37 at boromir; Fri, 27 Feb 2026 09:10:45 AEDT
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMQdK73mZz2yr6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2026 09:10:45 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3731168C4E; Thu, 26 Feb 2026 23:00:39 +0100 (CET)
Date: Thu, 26 Feb 2026 23:00:38 +0100
From: hch <hch@lst.de>
To: Richard Weinberger <richard@nod.at>
Cc: hch <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>, will <will@kernel.org>,
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
Subject: Re: [PATCH 03/25] um/xor: don't override XOR_SELECT_TEMPLATE
Message-ID: <20260226220038.GA15172@lst.de>
References: <20260226151106.144735-1-hch@lst.de> <20260226151106.144735-4-hch@lst.de> <445921547.2198.1772142326749.JavaMail.zimbra@nod.at>
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
In-Reply-To: <445921547.2198.1772142326749.JavaMail.zimbra@nod.at>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Feb 26, 2026 at 10:45:26PM +0100, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
> > Von: "hch" <hch@lst.de>
> > XOR_SELECT_TEMPLATE is only ever called with a NULL argument, so all the
> > ifdef'ery doesn't do anything.  With our without this, the time travel
> > mode should work fine on CPUs that support AVX2, as the AVX2
> > implementation is forced in this case, and won't work otherwise.
> 
> IIRC Johannes added XOR_SELECT_TEMPLATE() here to skip
> the template selection logic because it didn't work with time travel mode.
> 
> Johannes, can you please test whether this change does not break
> time travel mode?

I'm pretty sure that was the intent, but as I wrote above it worked
and still works on AVX-supporting CPUs by chance, and already doesn't
on older CPUs, and unless my git blaming went wrong someewhere already
didn't when this was originally added.


