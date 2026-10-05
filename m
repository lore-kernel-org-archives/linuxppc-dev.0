Return-Path: <linuxppc-dev+bounces-28920-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AD7CA5FCE
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Oct 2026 08:27:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hystr226Mz30VF;
	Mon, 05 Oct 2026 19:27:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791188820;
	cv=none; b=ohe3cRql0zSYUzlgYzgvvebXGvVb2lrrFh+cuHEEXXpmxh8E4BluKdQGnOcg4GuR7rsNxTW2bYgbfmK1umJ5nWlYS1HUixmZHyzWpluZ65yOEuaaEpZr7oI+LK9D9m0UxZ04mC0BATj11zI4Mfp+Ay83ktW4D0MtVrSpRNBZ6RBMQ+ofyhbGDRFYWT2gYfeoXrAA1rBQtoBeLD+6O0kAM+h5WogWr8O8VgqHxoLL6Rh82UeVXwiMNJCQKYaaPmRZ+xFwidQca9zYZCwE4FM602ffN5NCq6ArUv2XyJxTkWP8rOGg7Wch29JRcruTs2UzV/KqU8YWaRCYOl6oudA6nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791188820; c=relaxed/relaxed;
	bh=d6fLeRl3aR+E2ePxkPX9leInvYo16Bu4KYF4dHKWIKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/2GG6wTEWmlDfFtIWDLOQhKonKaYYMVXTi08aMdBnxV/b/FGc/298CFwlCoAspz7jse6gS7M3OBqGJVtW/3HE4mfpMQLxl3siuWSc1acvPpg58sJ9sPBiAeJS+rK0EOkL5hpO7i5cscfA6NCsqPa1aCXWipmzCf/PLN6ICnGXx8ciezqgSkoHhimFxmfoJ/E1XYYkrBpAsvPMka9BLyaZgMGxr5QBM9TfJPA5SXdmZcD6sjuLvGO9i3veX8X04MeXWMH3GtkwP9vVap/2vy/Fgb/wqY0FMHumAZMvf93B3i5h7kEU09Bq6dxYfXhkKZ6PJKNIjeQ0WAIqICE5QCLg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Aac/b0B3; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Aac/b0B3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hystq2w9nz2yTP
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 19:26:59 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 795BC4008A;
	Mon,  5 Oct 2026 08:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214361F000FF;
	Mon,  5 Oct 2026 08:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791188816;
	bh=d6fLeRl3aR+E2ePxkPX9leInvYo16Bu4KYF4dHKWIKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Aac/b0B34S+E7vUOvx08y0QczcJ2OBuE4MJAYHFCFCDZbnRBTUw3q6Naid03BCWB9
	 iLC3SJ28Lk1FxcP8Lj63v7wRRQlzqeMxbbMAXuU7d/TIQ7vxrBqfW6RmN8zhZpq0Ng
	 RRAU5Gm5H5wa9NkDAOFrOB/bULSPSGDrlcWpxPM1h7ZFIz2LV+P8ZMdT6kF3j3xCIO
	 XB9JE5Uzo8SZjhoV7HbcXdaBrcrK4kRk9YhuyVBrtVR8DBLKLeN9IDokSoawGdVkf0
	 MrSU1XflbTwvZGqEBNjKp8DYxWBWwoi1h57NQ1YEooa731n1p4zZE5QgnGpE+EybHn
	 rzlplJhja2ZVA==
Date: Mon, 5 Oct 2026 10:26:49 +0200
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
Message-ID: <asNfSSp-AckyeO7P@kernel.org>
References: <20260730130248.597249-2-thorsten.blum@linux.dev>
 <7d99725f-9c90-48ca-bee1-30e2e6c06617@linux.ibm.com>
 <asDClaRrHuKB44X-@kernel.org>
 <dbb4580d-7e20-4c38-9716-f39cf81a4942@linux.ibm.com>
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
In-Reply-To: <dbb4580d-7e20-4c38-9716-f39cf81a4942@linux.ibm.com>

On Mon, Oct 05, 2026 at 01:42:01PM +0530, Sourabh Jain wrote:
> On 03/10/26 14:23, Thorsten Blum wrote:
> > On Fri, Sep 25, 2026 at 11:49:04AM +0530, Sourabh Jain wrote:
> > > On 30/07/26 18:32, Thorsten Blum wrote:
> > > > Add __counted_by_ptr() to umem_info::buf and umem_info::ranges to
> > > > improve access bounds checking via CONFIG_UBSAN_BOUNDS and
> > > > CONFIG_FORTIFY_SOURCE.
> > > > 
> > > > Set the count fields before assigning the corresponding pointers, return
> > > > early on krealloc() failure, and use sizeof(*buf) when deriving
> > > > max_entries from the allocation size.
> > > > 
> > > > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > > > ---
> > > >    arch/powerpc/kexec/file_load_64.c | 22 ++++++++++++----------
> > > >    1 file changed, 12 insertions(+), 10 deletions(-)
> > > > 
> > > > diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
> > > > index 8c72e12ea44e..6424b668f0e9 100644
> > > > --- a/arch/powerpc/kexec/file_load_64.c
> > > > +++ b/arch/powerpc/kexec/file_load_64.c
> > > > @@ -34,14 +34,15 @@
> > > >    #include <asm/cputhreads.h>
> > > >    struct umem_info {
> > > > -	__be64 *buf;		/* data buffer for usable-memory property */
> > > > +	/* data buffer for usable-memory property */
> > > > +	__be64 *buf __counted_by_ptr(max_entries);
> > > >    	u32 size;		/* size allocated for the data buffer */
> > > >    	u32 max_entries;	/* maximum no. of entries */
> > > >    	u32 idx;		/* index of current entry */
> > > >    	/* usable memory ranges to look up */
> > > >    	unsigned int nr_ranges;
> > > > -	const struct range *ranges;
> > > > +	const struct range *ranges __counted_by_ptr(nr_ranges);
> > > >    };
> > > [...]
> > > >    const struct kexec_file_ops * const kexec_file_loaders[] = {
> > > > @@ -83,11 +84,12 @@ static __be64 *check_realloc_usable_mem(struct umem_info *um_info, int cnt)
> > > >    	new_size = um_info->size + MEM_RANGE_CHUNK_SZ;
> > > >    	tbuf = krealloc(um_info->buf, new_size, GFP_KERNEL);
> > > > -	if (tbuf) {
> > > > -		um_info->buf = tbuf;
> > > > -		um_info->size = new_size;
> > > > -		um_info->max_entries = (um_info->size / sizeof(u64));
> > > > -	}
> > > > +	if (!tbuf)
> > > > +		return NULL;
> > > > +
> > > > +	um_info->size = new_size;
> > > > +	um_info->max_entries = um_info->size / sizeof(*um_info->buf);
> > > > +	um_info->buf = tbuf;
> > > 
> > > Could you please explain why size and max_entries are updated before the
> > > buffer itself?
> > __counted_by_ptr() requires the counter ->max_entries to be set before
> > the ->buf pointer is assigned; otherwise you have an inconsistent state
> > where the counter doesn't match the pointer.
> 
> But isn't updating the counter holding the buffer size before the actual
> buffer
> can cause problems?
> 
> Can you share the document link of __counted_by_ptr() which says that size
> counter to be
> updated before the buffer pointer.
> 
> Here is an example in fs/coredump.c file where size counter is updated after
> the buffer
> with __counter_by_ptr():
> 
> https://github.com/torvalds/linux/blob/a90ee4305c4a5df72c11b31dacfdc76e00fcf78a/fs/coredump.c#L98
> https://github.com/torvalds/linux/blob/a90ee4305c4a5df72c11b31dacfdc76e00fcf78a/fs/coredump.c#L115

Maybe the order only matters for flexible arrays and __counted_by(), but
not for __counted_by_ptr(). I reordered it mostly out of habit from
__counted_by() annotations and assumed the same rules apply for
__counted_by_ptr(). Happy to restore the old order if it's not required.

Kees or Gustavo, what's your take on this?

Thanks,
Thorsten

