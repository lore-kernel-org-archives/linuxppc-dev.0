Return-Path: <linuxppc-dev+bounces-28817-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897FFCA5FDD
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Oct 2026 08:53:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxfZl5T0hz2xnn;
	Sat, 03 Oct 2026 18:53:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791017631;
	cv=none; b=kT+9MpM/v0KVP5aZHJho36EKe7MZVd9VLII8JYqriRzL8GbirF07IBZAtXoVNEWZn+DD51vemoaa6YsNqbtUCGH1m7MsPBskxZvTkIMV4cRm7UMeFVz0232XZTkqf9ipkhlIMYCm5ac9mclJKatHsZ7sCkFjpurfBVwlrzzFqZnfotydepxnUp70tT39M4HJ2pgYDDLarwiM7JrUYwU/aS5NbU9FQfSGjlt4DsYefZsU/F6m1cMgenUTcg76RgFUkcPKx6e9ETzZI+7bPeWRr65U2Z/TRwHm2vrDXvW0HV9v5SNVuiCZN4VjwAgGHkp+BrrDc6lu+KwZ7LnzPik2Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791017631; c=relaxed/relaxed;
	bh=b21CljHrLJaz+1KYNLIFgGoYnXPWmckV+drXS7qQXhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7ZKK68k3sipkkAkRI0niW7NSR+UtIXoIskVTWF+AvqykrE7QJ+LoIgWjsPnnVqqw/NxDj/YVoMeqOznTgqqRQbLQpPRSiKK0p5rPUpiikUmvWmsQMNi4lYwk6QY+OMNnnwDhzdTe1anCsZK3FAUMNnzDW0sHmIKM6i31SLmNi0QLoEL2QU/WMo9MFWvxDRG6LwhwmYtCIa0kjmPrcJmhFX/PwUEoQOevAH/dciRNIs+WrGOOFRQ8GYmH+9i58ig80nXUo69OuDeA5S2BsZP8SEkyABdMuWQtduCVwsaswc7jcBMzLLCiD9V+Ll1ihA9iZ8Q9OkGZpNVyAxJqmQlmw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cVt7MXr+; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cVt7MXr+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxfZj74dtz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 18:53:49 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7540940AFE;
	Sat,  3 Oct 2026 08:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617E31F0089B;
	Sat,  3 Oct 2026 08:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791017627;
	bh=b21CljHrLJaz+1KYNLIFgGoYnXPWmckV+drXS7qQXhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cVt7MXr+HAkSren3Fx8LtMdn0ixj+ESQcUT/Qy8d4nuDimTe1xbbt59sfdeeOSvj8
	 knv68w2hlBcsyPXhpNKPoGHCotNx3lQkQuKDkbEobChZaCRwwzh7lZQkoaccfn01sV
	 dxgxptJL8F4O5FcOW4N5+Gqphq+bA/4UWQzqf/F1mDYjZtjLKvPWZKfn5eQBzcRG6d
	 Orf9TQrrTiBSKSVnBEB6Gzkm2J9m3QSNVRi7vzvjwUA9hRL7f5D8GjqwFqevTaQ3K4
	 j/RugqecWk+bmoykCXcEkwXI0GJh1BRH4qTrIIzCEI2fWNx5mdjZaSJMbDWVEEz2Y9
	 tpU014QifLrwg==
Date: Sat, 3 Oct 2026 10:53:41 +0200
From: Thorsten Blum <blum@kernel.org>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] powerpc/kexec: Annotate umem_info members with
 __counted_by_ptr
Message-ID: <asDClaRrHuKB44X-@kernel.org>
References: <20260730130248.597249-2-thorsten.blum@linux.dev>
 <7d99725f-9c90-48ca-bee1-30e2e6c06617@linux.ibm.com>
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
In-Reply-To: <7d99725f-9c90-48ca-bee1-30e2e6c06617@linux.ibm.com>

On Fri, Sep 25, 2026 at 11:49:04AM +0530, Sourabh Jain wrote:
> On 30/07/26 18:32, Thorsten Blum wrote:
> > Add __counted_by_ptr() to umem_info::buf and umem_info::ranges to
> > improve access bounds checking via CONFIG_UBSAN_BOUNDS and
> > CONFIG_FORTIFY_SOURCE.
> > 
> > Set the count fields before assigning the corresponding pointers, return
> > early on krealloc() failure, and use sizeof(*buf) when deriving
> > max_entries from the allocation size.
> > 
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >   arch/powerpc/kexec/file_load_64.c | 22 ++++++++++++----------
> >   1 file changed, 12 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
> > index 8c72e12ea44e..6424b668f0e9 100644
> > --- a/arch/powerpc/kexec/file_load_64.c
> > +++ b/arch/powerpc/kexec/file_load_64.c
> > @@ -34,14 +34,15 @@
> >   #include <asm/cputhreads.h>
> >   struct umem_info {
> > -	__be64 *buf;		/* data buffer for usable-memory property */
> > +	/* data buffer for usable-memory property */
> > +	__be64 *buf __counted_by_ptr(max_entries);
> >   	u32 size;		/* size allocated for the data buffer */
> >   	u32 max_entries;	/* maximum no. of entries */
> >   	u32 idx;		/* index of current entry */
> >   	/* usable memory ranges to look up */
> >   	unsigned int nr_ranges;
> > -	const struct range *ranges;
> > +	const struct range *ranges __counted_by_ptr(nr_ranges);
> >   };
> [...]
> >   const struct kexec_file_ops * const kexec_file_loaders[] = {
> > @@ -83,11 +84,12 @@ static __be64 *check_realloc_usable_mem(struct umem_info *um_info, int cnt)
> >   	new_size = um_info->size + MEM_RANGE_CHUNK_SZ;
> >   	tbuf = krealloc(um_info->buf, new_size, GFP_KERNEL);
> > -	if (tbuf) {
> > -		um_info->buf = tbuf;
> > -		um_info->size = new_size;
> > -		um_info->max_entries = (um_info->size / sizeof(u64));
> > -	}
> > +	if (!tbuf)
> > +		return NULL;
> > +
> > +	um_info->size = new_size;
> > +	um_info->max_entries = um_info->size / sizeof(*um_info->buf);
> > +	um_info->buf = tbuf;
> 
> 
> Could you please explain why size and max_entries are updated before the
> buffer itself?

__counted_by_ptr() requires the counter ->max_entries to be set before
the ->buf pointer is assigned; otherwise you have an inconsistent state
where the counter doesn't match the pointer.

And ->size is moved up because ->max_entries depends on it.

