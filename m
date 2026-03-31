Return-Path: <linuxppc-dev+bounces-19109-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A085210F92E9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 18:29:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flc8m00k4z2yTH;
	Wed, 01 Apr 2026 05:29:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774981767;
	cv=none; b=nr/aYtRVyi+72nV8zY3TYcsEnWBaUb5HHcNBsJcYQUI2nwuGdFqAk8RANZwPH2Z0ckHAE1kpQ2L5wC+Av+7moYKxosQ9WbHztejWI0ishI4MUUvdoNgn/9s/D5goOnR4QOAtljlid5Ar83ar+lgiTv4vOeVvML9kOZkouSuuBi2jA7GninFEGYG6tmWRUCp4HSKSz85tIjbqPRVC652EMUqFayFPQzsm8XehII/DKjk88QKi3vwPd4NeMfEI/IrED31zxM/LH4J3DfqrX+KJilE1bg/742yMqeK3SYx5fhUA45pVEtjbX7u/mN5H9VgIXjLvec8K49ck5gRr7boK/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774981767; c=relaxed/relaxed;
	bh=J00T2JxMYTG/x/x140fHqGBOqhKZUYg0rDSqmFS8gLs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=H/507iNIpSH/jxy5v05eUwyt5jaPR9EvCSKpOaLslPLyFh08K8E0y16/Pc/INRRDr2zFoO7ZtMEi4o55DyNvVwxFDz6VFSzdeonYuNwNCivLfYOi1O2GXsAYB+0ky50vjRfglSUVJw8UJJeKMcq3Xf3mGbtvJ7c4U8lkYBRJg/cRbM7YHsPo09PchO67fhS5TwzxpIctv/5AsAbB3FfxW3ip190QpYvVKC12dZjIRvqsFjwVJJ3Dx1zDSz6G12SzQhrNMbBTNFCRb+xdS4LmZmHyTDelMBI5pAMnFA+modV/TO33FE4Et7Xc6eSzNiWNWvhMvBB6hRhQ8yXO+k2Gcw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=psWL4NZu; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=psWL4NZu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flc8l0nWdz2yL8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 05:29:26 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7F0A940A54;
	Tue, 31 Mar 2026 18:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF9FC19423;
	Tue, 31 Mar 2026 18:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774981763;
	bh=F+p+n3x+VzyufNJY9nXy/ifCuLJFzInK3nA+2woKvxI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=psWL4NZu9ag0FPb5FMERi89uk3vAYSdwJ6Jr11ixC6/8u6RxEisHJvG4oMZ0ss1wa
	 h0dqxH5s2StJz2k2ac1CKvcdQ53N1oEowBsSLP/n5D8dDYwwFkfqAo6gZliPYRZnJi
	 fs/N0xEVjUD6NdlZrzBZLQz+El5FY7Bxd/dn0oVM=
Date: Tue, 31 Mar 2026 11:29:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, willy@infradead.org,
 david@kernel.org, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, vbabka@suse.cz, jannh@google.com, rppt@kernel.org,
 mhocko@suse.com, pfalcato@suse.de, kees@kernel.org, maddy@linux.ibm.com,
 npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org,
 borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v6 2/6] mm: use vma_start_write_killable() in mm
 syscalls
Message-Id: <20260331112921.854d4f6cc793dba0972ee9f1@linux-foundation.org>
In-Reply-To: <CAJuCfpE5w8r_6Ss=5ZPrEb1RQOTG6HyY8Pivac=iiyqFRZvD4g@mail.gmail.com>
References: <20260327205457.604224-1-surenb@google.com>
	<20260327205457.604224-3-surenb@google.com>
	<5d90d998-9b8d-435c-b684-260600311797@lucifer.local>
	<CAJuCfpE5w8r_6Ss=5ZPrEb1RQOTG6HyY8Pivac=iiyqFRZvD4g@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 31 Mar 2026 08:01:11 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> > Instead? That is, assuming we really need to care about this at all.
> >
> > But I think I don't like this change at all?
> 
> Yeah, this was the part I wasn't sure if it's worth adding. With your
> vote confirming my scepticism I'll go ahead and remove the parts I
> added to avoid extra vma_start_write_killable() call (3 instances in
> all) and will post v7.

Thanks.  I'll remove v6 from mm.git and shall await Lorenzo's advice on
v7.


