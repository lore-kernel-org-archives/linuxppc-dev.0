Return-Path: <linuxppc-dev+bounces-17599-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03059EDA68D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Mar 2026 16:04:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQLGV2jr5z30Lw;
	Wed, 04 Mar 2026 03:04:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772553874;
	cv=none; b=iB7Qz2K67qgRyuE25U87uUMNRD9LwE66MuohdHNeg3177sW8+VJy7RFPJAIsuvpD4acH6YIReeXCkLeKQX5R8CdwjzoSDLR0rqj/WEmavCSlFJ5ah9OlYzke2hefLnwJSHb5MWfilewlSr3yI4FBlPyRHRpw+ouudMXzHKNKmaPd6hqEcrf6qe5S50ijE7o0q3tvI29S8Qp9preHRQsj0l2gCBQsIdd9ieUIK3yRJyhWtInJvxlAxOKXs6Iwg+vm7udrJqnSEwlb3thvfQ2eNyhq6qdY9Vox6GJU2yskvMRwzs/Lrt4szEsEhHmz8piZfsthWw/mAHrmdJOAWK98Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772553874; c=relaxed/relaxed;
	bh=ERL2crkSWjiWFfCd5r7i8dDIcE1qMmW2T7rRhLnWeUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fENzP/gAyVzSGd6goe2bDLv/Swomai/9i4+5BA7Gtk1yXpkHfoewB/UIR5m3s2W6amRbw3d4SMPS0Cl21bh0BNujHmwjHT6SJgG2BnXHulDtDI35UXjA8DzP5BX+sLrqQzLFRzCwYpGGd3sRA9Vd91SwycMOQ9Eqn/Ge/Dl6Ig13e/wYO0UDM57n1hLAlsm/87CU5SIxJPVIWyVWZreDallKSEI03GN4oaGVQQnhTCy6p6lODrayHzS0Be6vsrpuSOG82PdMv5fwHgs6bd9oY80vLSlJLzB34RuklxuI+b7MLbymIC93UbnvYkm1yEGFK6xooZLmfVEDHIfgrLbhTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQLGT2gX2z2xP9
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 03:04:33 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2F91868BEB; Tue,  3 Mar 2026 17:04:29 +0100 (CET)
Date: Tue, 3 Mar 2026 17:04:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
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
	Li Nan <linan122@huawei.com>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: [PATCH 16/25] sparc: move the XOR code to lib/raid/
Message-ID: <20260303160428.GE7021@lst.de>
References: <20260226151106.144735-1-hch@lst.de> <20260226151106.144735-17-hch@lst.de> <20260228054716.GF65277@quark>
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
In-Reply-To: <20260228054716.GF65277@quark>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Feb 27, 2026 at 09:47:16PM -0800, Eric Biggers wrote:
> On Thu, Feb 26, 2026 at 07:10:28AM -0800, Christoph Hellwig wrote:
> > diff --git a/arch/sparc/lib/xor.S b/lib/raid/xor/sparc/xor-niagara.S
> > similarity index 53%
> > rename from arch/sparc/lib/xor.S
> > rename to lib/raid/xor/sparc/xor-niagara.S
> > index 35461e3b2a9b..f8749a212eb3 100644
> > --- a/arch/sparc/lib/xor.S
> > +++ b/lib/raid/xor/sparc/xor-niagara.S
> > @@ -1,11 +1,8 @@
> >  /* SPDX-License-Identifier: GPL-2.0 */
> >  /*
> > - * arch/sparc64/lib/xor.S
> > - *
> >   * High speed xor_block operation for RAID4/5 utilizing the
> > - * UltraSparc Visual Instruction Set and Niagara store-init/twin-load.
> > + * Niagara store-init/twin-load.
> >   *
> > - * Copyright (C) 1997, 1999 Jakub Jelinek (jj@ultra.linux.cz)
> >   * Copyright (C) 2006 David S. Miller <davem@davemloft.net>
> >   */
> >  
> > @@ -16,343 +13,6 @@
> >  #include <asm/dcu.h>
> >  #include <asm/spitfire.h>
> >  
> 
> <linux/export.h> can be removed from the two assembly files, since all
> the invocations of EXPORT_SYMBOL() in them were removed.
> 
> Also, xor-niagara.S ended up without a .text directive at the beginning.
> Probably it was unnecessary anyway.  However, this seems unintentional,
> given that xor-vis.S still has it.

I'll probably undo the split and just do the mechanical move for the
next version.  This was a bit too much change even if a split would be
my preferred outcome.


