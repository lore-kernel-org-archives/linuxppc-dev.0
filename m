Return-Path: <linuxppc-dev+bounces-20924-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC83CD37AC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 20:19:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gG4Z240qGz2xn3;
	Thu, 14 May 2026 06:19:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778703578;
	cv=none; b=iR6GG/h3t8UI4OTwj8VGkQ6oR987KtBxvrAAA5qheOqqAFYdkPxTVhnHm8Vt1xDxDQM8PTPA6DOCL32kKv9H7/2bz+1mdR3bXG/hZNTbBg7yh6MIuxgdmQ34WiaUTC8lzeiAXjWy6sbRAK7J09cTlp+kzPEUaznMDiHaN+vbU8DfEY7g5H219NUBFUqFpjp0c6fb3Nco3dXAdC8ZadC8Y0kfehcOOPQRyVNcC0ajS/LW/TNPdD4fsSZnzQmGWk1Avz2tGi5iY1TC019uHzVifMFpVjiXd54++IVuWbHL2djz+IlqIirHTJSus3nNUlNTXKwLgqPbTX+LBXAwCtylGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778703578; c=relaxed/relaxed;
	bh=uEs2l25RMgTsDXvEQvBIXqNT2xkIVk4H/8R/2ZbyLkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6VW/59Bw3dqlTyD3m0wZ94URuc5m56sz/mfzLIOQvy79DlG0mXkCWC0zllvmEerUWJc6B6Hj97PmZK5DEoa4T6ZXTS5IFEO0PlsNCj3VJythLGnyzkhweMVOfk57d7vHuyoMIAaap7bjZX1GusCYhmuHs3axBkpXEyrDdbaVxsk1+h1ZmihSpO4OMwlJNtmaOTBa3KNBkiU001yvsr9V9die29eWS6dRXDzEIC/1bJIP6oJRosSeg/cpyfYHEoWEDVWyOCTFKwXBdpcHhmqQwSeHOnWA6yi7jkZlCO00D62rzLQSAqCNf6DHW54+H7wpguj+8bjndGEgmNY4hDs4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=dsterba@suse.cz; receiver=lists.ozlabs.org) smtp.mailfrom=suse.cz
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=dsterba@suse.cz; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gG4Z13pLnz2xld
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2026 06:19:37 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ED6E36B0F3;
	Wed, 13 May 2026 20:19:29 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5E0E593A9;
	Wed, 13 May 2026 20:19:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G7fLJ9HcBGpwcwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 13 May 2026 20:19:29 +0000
Date: Wed, 13 May 2026 22:19:28 +0200
From: David Sterba <dsterba@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
	Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>,
	Li Nan <linan122@huawei.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-raid@vger.kernel.org
Subject: Re: [PATCH 01/19] btrfs: require at least 4 devices for RAID 6
Message-ID: <20260513201928.GO2558453@suse.cz>
Reply-To: dsterba@suse.cz
References: <20260512052230.2947683-1-hch@lst.de>
 <20260512052230.2947683-2-hch@lst.de>
 <20260512114231.GG2558453@suse.cz>
 <20260513054742.GA1018@lst.de>
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
In-Reply-To: <20260513054742.GA1018@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: ED6E36B0F3
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 07:47:42AM +0200, Christoph Hellwig wrote:
> On Tue, May 12, 2026 at 01:42:31PM +0200, David Sterba wrote:
> > On Tue, May 12, 2026 at 07:20:41AM +0200, Christoph Hellwig wrote:
> > > While the RAID6 algorithm could in theory support 3 devices by just
> > > copying the data disk to the two parity disks, this version is not only
> > > useless because it is a suboptimal version of 3-way mirroring, but also
> > > broken with various crashes and incorrect parity generation in various
> > > architecture-optimized implementations.  Disallow it similar to mdraid
> > > which requires at least 4 devices for RAID 6.
> > > 
> > > Fixes: 53b381b3abeb ("Btrfs: RAID5 and RAID6")
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > This patch should have been sent separately as it has user visible
> > impact and can potentially break some setups.
> 
> It _is_ sent out separate.

It's public interface change of btrfs but in a patch series cleaning
up some library code, I noticed it by accident.

> > The degenerate modes of
> > raid0, 5, or 6 are explicit as a possible middle step when converting
> > profiles.  We can use a fallback implementation for this case if the
> > accelerated implementations cannot do it.
> 
> This is not about a degenerated mode.  For a degenerated RAID 6, parity
> generation uses the RAID 5 XOR routines as the second parity will be
> missing.  This is about generating two parities for a single data disk,
> which must be explicitly selected.

The calcuation is a different than what I'm concened about, changing
minimum devices from 3 to 4 is a breaking change. If the library won't
provide the xor/parity functions then we'll have to add a fallback for
this special case.

