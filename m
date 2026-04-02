Return-Path: <linuxppc-dev+bounces-19222-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D1BCC6B3E
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 15:21:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmltZ365yz2xc8;
	Fri, 03 Apr 2026 02:21:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775143270;
	cv=none; b=Yk09DSOrZsAfy41FidMAZK7J9+IiCK0XbdADPR6TxwYNRo1CxpNOU3Wv4RRxDbC2SIrY2IT2WgeFZh/GYWe/gCnlSWwQLOAHrmKSm/6rhnRNcOyBn79eBdWZigV0ojNNzDvK73QJle1qAg8RZo6lxWq+2qgUhig9w3QU9STH/lQCrboSMhvxnWep9tfCWzkPXU5XzqXWLfURdJTALHDzb9cqdQG5GfJy2jrWVXz/LQimPgRXzlSNTh1hHjG/Ym2MdO5VAYDGbcsoFRhx+6rqstvxY1zCFXE0mgIuvCUVle3OrNvSqS8hmSuGvCn52Ad7G5HCQfxv13v4Jm8SCbuntQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775143270; c=relaxed/relaxed;
	bh=rEsuj9tAW4S2EEcwEEUDGnMb8ph7JuO6sY0cnWJPU3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHH5m6DhU446afdj9cl89G6nBYFIfFZ8pKoU+/GGOGrp+gJC+vVaBatiGmEqc2qvWxLj9ft+UUE2uSLmFxjx10Na2HstQqzYnhYfgPP22tVkKWIZKfssozwDbe2q/E4HCtJTXXtO2NFgzaVxKu0MyHSc0O9fJYcUmjQM29vR2zm/k1x+t0veUM4/TjdCq0BmZHQhz3L4e92B9RpCFPL23BZeoZVCANgUCR1s7BcRLrEnxDxecEJDX0MKluwftCOggReH5sXZvbwo4A31tLt/FC7oua/esCXuStGS5SR5Z6BBy3iOHGB8o9ijqioV0/jLN8f+dA4D7XXDr6nsP2fqFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XmkF6trv; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XmkF6trv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmltY1tn3z2xTh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 02:21:09 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CBBD5444E4;
	Thu,  2 Apr 2026 15:21:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89CC9C116C6;
	Thu,  2 Apr 2026 15:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775143266;
	bh=Atdp2Yq+vZCgGPsLZHwP7QsHnIJ5JB+7tYSeJ6kp9l0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XmkF6trvPGaoNBOFUq8cHYVKBAwUkaJ9Ml+6u4twA2M2M5s3Q6gHycRVNkBOMJjZB
	 mbJouLW2pyMHlWJQ7JdWPQnFRo/vp0Vkn9bLOdvDDPPUR3leEvl/Dv2uQP2PSfY3M+
	 k+L0/3DJGyLdJ2GwMM6e2GTcFrgl3Kgdm6W4G41Hk3qtvFmCzlH1kj3Oni0AyHqcEE
	 av0fuXi5U1/HM1hXHLInEx9wPVU1obh20gFaNy9M7IPSoXJ9XyuTHxDJzZCNp8PndC
	 5mJWGTC4BEtruMawXBNMLaaO0NzykwxkDaig/BLYfl3uEhemeirthSRK+EeO9yehVF
	 qdeNrnho5hDzg==
Date: Thu, 2 Apr 2026 16:20:53 +0100
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org, 
	david@kernel.org, ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, jannh@google.com, 
	rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, kees@kernel.org, 
	maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, 
	borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com, hca@linux.ibm.com, 
	gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v6 2/6] mm: use vma_start_write_killable() in mm syscalls
Message-ID: <2ecac69c-9fe3-4c29-aea6-c20d21773940@lucifer.local>
References: <20260327205457.604224-1-surenb@google.com>
 <20260327205457.604224-3-surenb@google.com>
 <5d90d998-9b8d-435c-b684-260600311797@lucifer.local>
 <CAJuCfpE5w8r_6Ss=5ZPrEb1RQOTG6HyY8Pivac=iiyqFRZvD4g@mail.gmail.com>
 <20260331112921.854d4f6cc793dba0972ee9f1@linux-foundation.org>
 <cf6975a6-336a-401b-b122-b9597b5710b7@lucifer.local>
 <CAJuCfpH2eomYbZ0DzKpkae5DKVF69aRsfXx3HzMfPc6cTT5fTg@mail.gmail.com>
 <495a4331-6575-4eb5-91a5-245ab0ad3637@lucifer.local>
 <CAJuCfpEn53AgKkjLBN2AeaHxxV8vHVj697Cb=Hb-U8LisNztxw@mail.gmail.com>
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
In-Reply-To: <CAJuCfpEn53AgKkjLBN2AeaHxxV8vHVj697Cb=Hb-U8LisNztxw@mail.gmail.com>

On Thu, Apr 02, 2026 at 08:11:44AM -0700, Suren Baghdasaryan wrote:
> On Thu, Apr 2, 2026 at 6:19 AM Lorenzo Stoakes (Oracle) <ljs@kernel.org> wrote:
> >
> > On Tue, Mar 31, 2026 at 01:14:51PM -0700, Suren Baghdasaryan wrote:
> > > On Tue, Mar 31, 2026 at 11:47 AM Lorenzo Stoakes (Oracle)
> > > <ljs@kernel.org> wrote:
> > > >
> > > > On Tue, Mar 31, 2026 at 11:29:21AM -0700, Andrew Morton wrote:
> > > > > On Tue, 31 Mar 2026 08:01:11 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
> > > > >
> > > > > > > Instead? That is, assuming we really need to care about this at all.
> > > > > > >
> > > > > > > But I think I don't like this change at all?
> > > > > >
> > > > > > Yeah, this was the part I wasn't sure if it's worth adding. With your
> > > > > > vote confirming my scepticism I'll go ahead and remove the parts I
> > > > > > added to avoid extra vma_start_write_killable() call (3 instances in
> > > > > > all) and will post v7.
> > > > >
> > > > > Thanks.  I'll remove v6 from mm.git and shall await Lorenzo's advice on
> > > > > v7.
> > > > >
> > > >
> > > > Ack, if we just drop the problematic bits we might still be fine for 7.1 :)
> > >
> > > Let's get your cleanup first and then see where we are. I also hate
> > > the way I have to report a fake error code, so with that cleanup the
> > > patchset should be much nicer.
> >
> > Ack, yeah it's horrid, + _my fault_ :)
>
> No worries, I can wait.
>
> >
> > I can put something together now perhaps that can potentially be queued up for
> > 7.2 at 7.1-rc1.
>
> Thanks! That would be appreciated.

This might not quite be 'now' as of course it's grown into something much
bigger :P

Cheers, Lorenzo

