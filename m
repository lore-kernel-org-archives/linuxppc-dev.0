Return-Path: <linuxppc-dev+bounces-19160-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5A510F6FAA
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 14:40:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fm71w5bJmz2yhY;
	Thu, 02 Apr 2026 01:40:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775054420;
	cv=none; b=VF0vrBvdzsAwv+e9GkP60ShH+oW3F9eICfX+uDLiV6UO/PYsayHvF5H++Fr4wNJ4yWgMZlZx5d0Cf5oKaibZ+qOF1L2MGis08FiaiNs/wMDtPbUhZI4qT/QYEAE2VKUPBcdTBRmm8rCPjbzzTNkxazn+dz2NjEuRJmXkSU84moCMn1392kj0uBPK6DStdaQDUREM1We9H1ULBKu22r5lriH39r2HIlzDGFv1iHG+U1IjQxEdEO54aTFm/BWu20e9YMWWawnY+vs0C0sIlXD5pMTTZaVwZdWizrWjGT/DKGXLGTTRSitAlcAsnb2BjBMnSmhCbpzI6zYoZWCvDg5c4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775054420; c=relaxed/relaxed;
	bh=s2RRM3QGRUEh5mk0XorWfno6FKqdtME4d+e9bl95YEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZKnnJhLW4CVepBqxvraPPHuNjUcBIDItfnfweNh89kFhkcAWJf6U+i5Wo/RZfeG2ajXJUWXsZiVmiRcBzLNYvCv19V4Ho3IqaZA1pPaadn8xKSSPqjkol7kSL314bSiEIPslWzirtrEFUZEMY+cEHmoM6wATMY+aQgoV4R4EHVhctM//Qv/7clAwn8JA9HARpmedNLOQJ48gdRQSMp/K1CLK2I10Ngg9OZnqLYlIpvIU3roe5/lxJWloPlEEfTyoQ7l4yULNDlNmMtTxg/q2TY9YnUbjI+cIY7nf9A+wACV3JsJctZv8RpSkDgTEo3La/dU2+4wE2JKxG/eLMrgKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZnwoGBjE; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZnwoGBjE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fm71w00f3z2yVM
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 01:40:19 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2F802402E0;
	Wed,  1 Apr 2026 14:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE94C2BCB2;
	Wed,  1 Apr 2026 14:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775054418;
	bh=TykJ8jJa8X/A3BfI1NqncbeKLLHymAMT2RdQZ8mQvPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZnwoGBjE8UYsn+9Xz9/gonK7PmqMkPpL1IB6t7JB7DCHwrrblJDIa0hgV1ipYoMhw
	 UQZXBR7Wl5F3qV2fqgICwVZxPLmYkt2doik8IaYwSJ/7iDDBLX33AD2su9nPqO07dR
	 tRqWqxK6/rbyi5ekZ5BDxU0bZKz4iKvzi88B6paqwvsnZkMW11YQkyJ5gfQ9HTG3LK
	 ksHYB9pkywb4n3rstunacatxXd5ylpUyTcqBsn+rPb4HyOClK3si44RlGn2i4fFymM
	 /MI4fcS6BVZSxz6GZLlRbrXCPW2aY+Lkp9RuJOPrcDCI5NEm2pOSrt0Gvv4XqqbLM0
	 qANAOlkXh9GXA==
Date: Wed, 1 Apr 2026 15:40:16 +0100
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Sayali Patil <sayalip@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Ritesh Harjani <ritesh.list@gmail.com>, Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@kernel.org>, 
	Oscar Salvador <osalvador@suse.de>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Dev Jain <dev.jain@arm.com>, Liam.Howlett@oracle.com, linuxppc-dev@lists.ozlabs.org, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH v3 08/13] selftests/mm: ensure destination is
 hugetlb-backed in hugepage-mremap
Message-ID: <b590a17c-13ed-45f4-9f51-ac662d00e7bf@lucifer.local>
References: <cover.1774591179.git.sayalip@linux.ibm.com>
 <3b6ffba238a4b59de891acf896fa25d7d3193228.1774591179.git.sayalip@linux.ibm.com>
 <ee15d52f-45df-415b-b0d9-3d267d147e5c@kernel.org>
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
In-Reply-To: <ee15d52f-45df-415b-b0d9-3d267d147e5c@kernel.org>

On Wed, Apr 01, 2026 at 04:21:55PM +0200, David Hildenbrand (Arm) wrote:
> On 3/27/26 08:16, Sayali Patil wrote:
> > The hugepage-mremap selftest reserves the destination address using a
> > anonymous base-page mapping before calling mremap() with MREMAP_FIXED,
> > while the source region is hugetlb-backed.
> >
> > When remapping a hugetlb mapping into a base-page VMA may fail with:
> >
> >     mremap: Device or resource busy
> >
> > This is observed on powerpc hash MMU systems where slice constraints
> > and page size incompatibilities prevent the remap.

OK so digging in:

mremap -> ... -> vrm_set_new_addr() -> get_unmapped_area() -> ... (in ppc arch
code) -> slice_get_unmapped_area():

unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
				      unsigned long flags, unsigned int psize,
				      int topdown)
{
	...
	/* bunch of checks */

	/* If we have MAP_FIXED and failed the above steps, then error out */
	if (fixed)
		return -EBUSY;

	...
}

Is presumably where we hit the issue.

> >
>
> That is weird. An mremap(MREMAP_FIXED) is really just an munmap() + move.

Yeah the weird bit I guess is that we _still_ invoke get_unmapped_area() but
with MAP_FIXED set to indicate that we want the specific address, so it's
subject to the above checks.

>
> Are we sure this is not some actual problem in the hugetlb implementation?

It seems the 'slices' check sees if the _target address_ has an equivalent page
size, presumably hugetlb-mandated, and fails if they're not equivalent, so this
change is just accounting for that.


>
> > Ensure the destination region is created using MAP_HUGETLB so that both
> > source and destination VMAs are hugetlb-backed and compatible. Also add
> > MAP_POPULATE to the destination mapping to prefault hugepages,
> > matching the behaviour used for other hugetlb mapping in the test and
> > ensuring deterministic behaviour.
>
> But then the test suddenly requires more hugetlb pages, no? I don't see
> a good reason for the MAP_POPULATE, really. It will be discarded either way.

Yeah I'm not sure about the MAP_POPULATE being all that important here.

>
> >
> > Update the FLAGS macro to include MAP_HUGETLB | MAP_SHARED |
> > MAP_POPULATE so that both mappings are hugetlb-backed and compatible.
> > Also use the macro for the mmap() calls to avoid repeating
> > the flag combination.
> >
> > This ensures the test reliably exercises hugetlb mremap instead of
> > failing due to VMA type mismatch.
> >
> > Fixes: 12b613206474 ("mm, hugepages: add hugetlb vma mremap() test")
> > Acked-by: Zi Yan <ziy@nvidia.com>
> > Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> > Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
> > ---
> >  tools/testing/selftests/mm/hugepage-mremap.c | 11 ++++-------
> >  1 file changed, 4 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/testing/selftests/mm/hugepage-mremap.c b/tools/testing/selftests/mm/hugepage-mremap.c
> > index e611249080d6..48c24a4ba9a7 100644
> > --- a/tools/testing/selftests/mm/hugepage-mremap.c
> > +++ b/tools/testing/selftests/mm/hugepage-mremap.c
> > @@ -31,7 +31,7 @@
> >  #define MB_TO_BYTES(x) (x * 1024 * 1024)
> >
> >  #define PROTECTION (PROT_READ | PROT_WRITE | PROT_EXEC)
> > -#define FLAGS (MAP_SHARED | MAP_ANONYMOUS)
> > +#define FLAGS (MAP_HUGETLB | MAP_SHARED | MAP_POPULATE)
> >
> >  static void check_bytes(char *addr)
> >  {
> > @@ -121,23 +121,20 @@ int main(int argc, char *argv[])
> >
> >  	/* mmap to a PUD aligned address to hopefully trigger pmd sharing. */
> >  	unsigned long suggested_addr = 0x7eaa40000000;
> > -	void *haddr = mmap((void *)suggested_addr, length, PROTECTION,
> > -			   MAP_HUGETLB | MAP_SHARED | MAP_POPULATE, fd, 0);
> > +	void *haddr = mmap((void *)suggested_addr, length, PROTECTION, FLAGS, fd, 0);
> >  	ksft_print_msg("Map haddr: Returned address is %p\n", haddr);
> >  	if (haddr == MAP_FAILED)
> >  		ksft_exit_fail_msg("mmap1: %s\n", strerror(errno));
> >
> >  	/* mmap again to a dummy address to hopefully trigger pmd sharing. */
> >  	suggested_addr = 0x7daa40000000;
> > -	void *daddr = mmap((void *)suggested_addr, length, PROTECTION,
> > -			   MAP_HUGETLB | MAP_SHARED | MAP_POPULATE, fd, 0);
> > +	void *daddr = mmap((void *)suggested_addr, length, PROTECTION, FLAGS, fd, 0);
> >  	ksft_print_msg("Map daddr: Returned address is %p\n", daddr);
> >  	if (daddr == MAP_FAILED)
> >  		ksft_exit_fail_msg("mmap3: %s\n", strerror(errno));
> >
> >  	suggested_addr = 0x7faa40000000;
> > -	void *vaddr =
> > -		mmap((void *)suggested_addr, length, PROTECTION, FLAGS, -1, 0);
> > +	void *vaddr = mmap((void *)suggested_addr, length, PROTECTION, FLAGS, fd, 0);
> >  	ksft_print_msg("Map vaddr: Returned address is %p\n", vaddr);
> >  	if (vaddr == MAP_FAILED)
> >  		ksft_exit_fail_msg("mmap2: %s\n", strerror(errno));
>
>
> --
> Cheers,
>
> David

Cheers, Lorenzo

