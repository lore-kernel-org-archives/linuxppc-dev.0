Return-Path: <linuxppc-dev+bounces-18932-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86D910F2861
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 17:37:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fj7BC3nKwz2xmX;
	Sat, 28 Mar 2026 04:37:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774633027;
	cv=none; b=R3AvcnCYQjFj5l3dRPLLJkvgc7d3clNWhGgW2kqXIyXCeJ6UgONvfxVHERqI6ABOxNSHfnMHPC3flLNm90AbHBgh5njKErrZRvxEXVCl+p6p2oSqdYhx9UDUgRAQKtz91+zNGl39kVVr/9dbSpf604jZUwEasUbxQ70J0ULGQsSeWmaabEaznz5SqKr1yBo1pThV22zHvmERSsgFxWOc3vTJnfo94vEAxS5AlUVJj0URHPZPiMCQgBkGbGhc6BE6gGBpGnYvoLFZa0v8dAX9SdMa0lGhC99ogjk66Q0AKGIQwMl29KQOhMikfiwWk9swfhn9WFrbU4ds0jKB7Rk/jw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774633027; c=relaxed/relaxed;
	bh=qjbVszfk5H0B4FMQ+oBG1kCyJ2Mm1XRJcJft2Can3OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJ1fTroY1k3QhpYBeteXT3MXmV8Nuobo1QgH3RV7oKYRuS9P74sZi8KFzqq41FT4qN/YML64w2CmWdm7pUAv1KPRf4sp0jv23S3d02XXSDylfe65DjM0ISRHyGs17ObKwNQKtEwytnjTSp5Pmd7vZatxtTAtYiVumTJTC6qNOOP9yPqgrm25hmDnCtrcf1k9UAe7AqnDGLOZsw9/c0OCjWnOEvw7VHfCVzFqeuBA6QMz7WFKag4M33d30GIh0cUstB77WEtF5s9337YYhvxlph59K9gFV3dFv2EC713oJb6K/mxA3WGSpmrqyDlIOupfrA65tE6cYwdELpWDhXJoUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ltMB+8JM; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ltMB+8JM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fj7BB5zmvz2xR4
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2026 04:37:06 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3DECE600AE;
	Fri, 27 Mar 2026 17:37:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5743DC19424;
	Fri, 27 Mar 2026 17:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774633023;
	bh=qjbVszfk5H0B4FMQ+oBG1kCyJ2Mm1XRJcJft2Can3OE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ltMB+8JMKlPEXIY+iIffEuXUD808lFlKdG9/t8DDuX0N0gSKM2YjihjUaPimovERF
	 nONpobPbdpl1PNuDk7eWBuDiZuCBgL7jiX1dh0NOWE4sxMlAVvIXTrQ9rW57zK9dPr
	 gPFB0fWqjJ6aQujfaZXbKSmqImEHgvcmo5w7aKr794x1Of9QkaASPEInq4ggaixK3F
	 +ITlFC4rXBuG5I83mFhZQcA3KPGihyZQyj6vqfjt+MyFHxzhhFqSK89Z15LiwM6mHF
	 nTrt+qNaLoz/uftVzl17mVVVTodB57d8SFUettkdWl1gRWWGNnkDz+BDwpWKIq+CFU
	 w8w+9j5eLaqqg==
Date: Fri, 27 Mar 2026 17:37:01 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org, 
	david@kernel.org, ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, lorenzo.stoakes@oracle.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 0/6] Use killable vma write locking in most places
Message-ID: <df0c2fc2-467a-4ffb-a697-7c89d64bad6b@lucifer.local>
References: <20260326080836.695207-1-surenb@google.com>
 <20260327094738.7150efc3b0619e6ccf095c23@linux-foundation.org>
 <20260327100322.b539f1a9f3662a0a4c080cce@linux-foundation.org>
 <CAJuCfpFxZsnZqqfoKXX=JEBrBaqZHNAgBE0VHbTc=GhQzP7X=g@mail.gmail.com>
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
In-Reply-To: <CAJuCfpFxZsnZqqfoKXX=JEBrBaqZHNAgBE0VHbTc=GhQzP7X=g@mail.gmail.com>

On Fri, Mar 27, 2026 at 10:32:27AM -0700, Suren Baghdasaryan wrote:
> On Fri, Mar 27, 2026 at 10:03 AM Andrew Morton
> <akpm@linux-foundation.org> wrote:
> >
> > On Fri, 27 Mar 2026 09:47:38 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > > Three of your patches lack review tags so now it's 65!
> >
> > Three is now zero, thanks Lorenzo.
>
> I just finished fixups for issues Sashiko flagged. They are pretty
> small but important. Testing them right now and running Sashiko
> locally. Once done I'll post v6 and will ask Lorenzo to re-review
> those specific changes. Sorry Lorenzo, I'll point out the specific
> changes I had to make and will try to make it easy for you.

No worries :)

Could you send to ljs@kernel.org on the respin? Sorry to nag about it but my
email more and more set up for that and makes my life a wee bit easier :>)

> Thanks,
> Suren.

Cheers, Lorenzo

