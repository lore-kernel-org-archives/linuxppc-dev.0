Return-Path: <linuxppc-dev+bounces-20983-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC88CD343F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2026 14:52:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gH9C85YrQz2xnH;
	Sat, 16 May 2026 00:52:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778856724;
	cv=none; b=jjZ9wkoxRCOkkSNygX0YUPD/BZZc0jx86cSzSzAT/8ZvppPmnMVEVFOLjh+0xw5W5UNZnHhojN/vVnR2usNnlrJC6zNZaDjYxUrJ+7URePi3v/C84jmUgsIDGSNopKNkBnjLr53B57H3YFoStco7a2zJ5DdG03Xi/fE3eWWJftx76yfJMR9gnD8FJLgAXCa0qw12Gq3DcBsiOIGhhRyzMrgqrAxu7hrb3gRJICMtdHRBIPIJTr4Yxp1Cvb9E+hgHWBe2fjh86cmtiO2DYSlbKRdJ0mLlWO8Qlsbg2EAOwphly9ixbiDETHwf0FzJDZcbEZqusRoaSfqSd/0CITOa4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778856724; c=relaxed/relaxed;
	bh=C1D/1YterPCnTmcPwmatqIt56Q+poHbCW9oYvcHSQ2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUaAes0yTTRdXTcLcCnya9k2aSzm/e+irJMuLIWr8dJipErJhQlB/zAcqRyCab2JMNEWhuGnec0pVdtFpj+qgSAlIJXzwqlvD25XXON9aQjVOG47nSupve2lZWGBhfSJL8iDs5FGJ+pwU3JPe+bss0Iy09vvHhjxeyg5DodZEQIztqq6usBCmDBhnPQMy4/n3KBWzpQu6OIfagPDHBV/8M1vWqfvRdgT2VyHOl66chnQEwNawRoC3p3p4oljHASDnSCd5Glx/g3UKyflyfx0OQzJmaZLxBzBUcB9CtLMNN9aJY6QsZ6O41/bapVTDlPivBAUalA+4rXuJLcNv58Q9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=dsterba@suse.cz; receiver=lists.ozlabs.org) smtp.mailfrom=suse.cz
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=dsterba@suse.cz; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gH9C80K7Cz2xFl
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 May 2026 00:52:03 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4B04666D5C;
	Fri, 15 May 2026 14:52:00 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 041E0593A9;
	Fri, 15 May 2026 14:52:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BdG/ABAzB2onPgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 15 May 2026 14:52:00 +0000
Date: Fri, 15 May 2026 16:51:58 +0200
From: David Sterba <dsterba@suse.cz>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: kreijack@inwind.it, Goffredo Baroncelli <kreijack@libero.it>,
	Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
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
	Herbert Xu <herbert@gondor.apana.org.au>,
	Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com>,
	Li Nan <linan122@huawei.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-raid@vger.kernel.org
Subject: Re: [PATCH 01/19] btrfs: require at least 4 devices for RAID 6
Message-ID: <20260515145158.GP2558453@suse.cz>
Reply-To: dsterba@suse.cz
References: <20260512052230.2947683-1-hch@lst.de>
 <20260512052230.2947683-2-hch@lst.de>
 <20260512114231.GG2558453@suse.cz>
 <20260513054742.GA1018@lst.de>
 <0a8d1ff4-f5a2-49e9-aa45-d25dbe4ded40@libero.it>
 <0507CCEF-0548-442F-8703-1D006B5E068B@zytor.com>
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
In-Reply-To: <0507CCEF-0548-442F-8703-1D006B5E068B@zytor.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 4B04666D5C
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 12:57:53PM -0700, H. Peter Anvin wrote:
> On May 14, 2026 12:51:59 PM PDT, Goffredo Baroncelli <kreijack@libero.it> wrote:
> >On 13/05/2026 07.47, Christoph Hellwig wrote:
> >> On Tue, May 12, 2026 at 01:42:31PM +0200, David Sterba wrote:
> >
> >> 
> >>> The degenerate modes of
> >>> raid0, 5, or 6 are explicit as a possible middle step when converting
> >>> profiles.  We can use a fallback implementation for this case if the
> >>> accelerated implementations cannot do it.
> >> 
> >> This is not about a degenerated mode.  For a degenerated RAID 6, parity
> >> generation uses the RAID 5 XOR routines as the second parity will be
> >> missing.  This is about generating two parities for a single data disk,
> >> which must be explicitly selected.
> >> 
> >
> >I think that the David concern is : "what happens for an already
> >existing btrfs raid6 3 disks filesystem when the user upgrade the kernel ?"
> >(I am thinking when a new BG needs to be allocated)...
> 
> That's what I'm saying – it should invoke the RAID-1 code under the cover (as with 3 disks, D = P = Q.)

Thanks, it was not clear to me what you meant. For the two edge cases
the code should do simple memcpy for both calculations of parity and
recovery.

