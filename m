Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA4A606A31A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 03:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AFKYEaz0
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDGV22Dqrz2y2B;
	Tue, 27 Oct 2026 14:40:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::13"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793072426;
	cv=none; b=RdchxPv7Hw+FNNstJXrGsSlH3tO62Xtg1oF+HGfMhJfNheZ2Xsw3nFHG6NrkHHn40ZrmuBLT/9ujQyf9NNwD9IKq6jaMGGAGODcG19jdP8cJoc4fiilxUaXywTsg+JinwBn36LT7Eu3dBAmt1qdFFy4fGszOtmL2dJCg6QLKLPhiissQevFuXP2sJQ775HQCVBjeBjaxmHHe7ZSYynnV/cZvhqGBMRznCirCbf0SZO3Fg5KN1rlHst2GjwMNeeXrz/RstCSx9HaFkt9JAVkHFihLIz3tTjUynQt2YzNGH5O8L5WAoAddRaGYX4SDk/+ChfH+2x6q+/C/k4yFoiOZuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793072426; c=relaxed/relaxed;
	bh=oEi5yv/OaTlB+//ZKfqhrPpGN262I+SDBjf+a0Db1PI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mLIiKcOwImr+qf7CA/NI36BmuS9t9cXGjDE1kk02u/I2amSFN3Ux6DE1X7pUyA0uJEq1w3G+r2B47g2/mn4mlr755OeRMoyIwBC0nlbHb6GslYjUqfRxO4PpL95aXFP1+vku6y26n10ytOO8eSloQLLAt5f2k3Nc+LM7BBrmnA1xMDE9yO1Cv3s0nD/bkzRpUr09AYdalL3FcyDAvVhmR1F1z09mCgEt9zPCUnVpZtqE0l61CyDps0ltSu68/iSjnZaUfSNlM1q0Wmw4w3TH0CpGv2NmG8zQ9g5/wf9+ttsTIVyVBwUyqaSf+RyzTWyuIhV8CQkM91vNM75SqNm2Tw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AFKYEaz0; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::13; helo=mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AFKYEaz0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::13; helo=mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-19.mta0.migadu.com [IPv6:2001:41d0:1004:224b::13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDGTx6Qhtz2xjQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 14:40:19 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=4hMaGBX4YiC1c0Vq4PKRA8fH7YfB6cD9vZ6lrLQREzM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793072400; v=1; x=1793677200;
 b=AFKYEaz0+SZhZfexOjEH3jV6iz08BG28K6F6imYpOcoyfGsUIxnWJmwVYDR7fKu+WrTb0YyD
 KDTDxZSKpy5OOj4RCgcIlqkUmG2y4i7tTyjCii4FAVtOaC8HiBsT93GoNoqbvrLniVJk2FWD3vd
 sssammMEarM54Ue7N4lAJwKU=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by mta11.migadu.com with ESMTPS id c26ab69f7955a4aa;
	Tue, 27 Oct 2026 03:40:00 +0000
X-Mizu-Trace-ID: c26ab69f7955a4aa
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH 1/2] powerpc/64s/radix: don't dedup vmemmap covered by an
 existing PMD leaf
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <97f85592bb78a273be8519e6897e7f9b9bd31469.1793070429.git.ritesh.list@gmail.com>
Date: Tue, 27 Oct 2026 11:39:45 +0800
Cc: linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Christophe Leroy <chleroy@kernel.org>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 David Hildenbrand <david@kernel.org>,
 Pavithra <pavrampu@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2C88EF3C-1E7D-4395-99C5-711FFB01469A@linux.dev>
References: <97f85592bb78a273be8519e6897e7f9b9bd31469.1793070429.git.ritesh.list@gmail.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
X-Mailer: Apple Mail (2.3901.100.1.1.12)
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ritesh,

> On Oct 27, 2026, at 11:22, Ritesh Harjani (IBM) =
<ritesh.list@gmail.com> wrote:
>=20
> radix__vmemmap_populate() is asked for one 16MB section, which is 16KB =
of
> struct pages. With no altmap it rounds the request down to a PMD leaf.
> That leaf describes 2GB of PFNs with 64KB pages (128MB with 4KB =
pages),
> so it also covers sections that are not present yet. It cannot be =
freed
> while any of those sections are still in use.
>=20
> A devdax namespace that lands in the same window is marked for vmemmap =
dedup.
> vmemmap_populate_compound_pages() treated the leaf as an existing huge =
mapping
> and skipped it. The core then initializes only the head vmemmap page =
and assumes
> the rest is the shared tail. Those remaining tail slots are real =
struct pages
> still holding the page_init_poison() pattern and are not the shared =
tail pages.

Right.

> __init_single_page() warns on the zone mismatch and the following =
pageblock init
> faults in __set_pfnblock_flags_mask().

Yeah, the new adding warning is useful.

>=20
> If the section's vmemmap is already a PMD leaf, clear its compound =
order

I think it's enough to fix this issue.

> and reuse the leaf, so every struct page in the section is =
initialized.
> The shared-tail layout needs base-page PTEs, so it cannot be built on =
top of
> this leaf and dropping the leaf is not an option while the =
neighbouring range
> is still using it. So, fail the compound populate if a leaf is still =
seen there.
>=20
> <Call Trace>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    3.467060][    T1] WARNING: mm/mm_init.c:600 at =
__init_single_page+0xd0/0xf4, CPU#0: swapper/0/1
> <...>
> [    3.477419][    T1] NIP [c000000000576b30] =
__init_single_page+0xd0/0xf4
> [    3.477827][    T1] LR [c0000000005778b0] =
__init_zone_device_page+0x30/0xb8
> [    3.478444][    T1] Call Trace:
> [    3.478764][    T1]  0x10000 (unreliable)
> [    3.479874][    T1]  memmap_init_zone_device+0x164/0x430
> [    3.480392][    T1]  memremap_pages+0x43c/0x93c
> [    3.480836][    T1]  devm_memremap_pages+0x3c/0xa4
> [    3.481328][    T1]  dev_dax_probe+0x264/0x3d0
> [    3.481817][    T1]  dax_bus_probe+0x140/0x1c8
> [    3.482237][    T1]  really_probe+0x108/0x580
> [    3.482681][    T1]  __driver_probe_device+0xcc/0x284
> [    3.483186][    T1]  driver_probe_device+0x5c/0x108
> [    3.483656][    T1]  __device_attach_driver+0x10c/0x1e8
> [    3.484134][    T1]  bus_for_each_drv+0xc0/0x13c
> <...>
> [    3.499972][    T1] BUG: Kernel NULL pointer dereference on read at =
0x00001400
> [    3.500417][    T1] Faulting instruction address: =
0xc0000000005f4ecc
> [    3.500417][    T1] Faulting instruction address: =
0xc0000000005f4ecc
> cpu 0x0: Vector: 300 (Data Access) at [c000000006756b50]
>    pc: c0000000005f4ecc: =
__set_pfnblock_flags_mask.constprop.0+0x34/0x160
>    lr: c000000000577f38: memmap_init_zone_device+0x358/0x430
>    pid   =3D 1, comm =3D swapper/0
> enter ? for help
>  memmap_init_zone_device+0x358/0x430
>  memmap_init_zone_device+0x220/0x430 (unreliable)
>  memremap_pages+0x43c/0x93c
>  devm_memremap_pages+0x3c/0xa4
>  dev_dax_probe+0x264/0x3d0
>  dax_bus_probe+0x140/0x1c8
>  really_probe+0x108/0x580
> <...>
>=20
> Fixes: bd0862382adb ("mm/sparse-vmemmap: drop Device DAX-specific =
population path")

Actually, the right Fixes is:

Fixes: f2b79c0d7968 ("powerpc/book3s64/radix: add support for vmemmap =
optimization for radix")

On older kernels, these errors are silent. They trigger a kernel panic =
when the user
actually uses Device DAX, rather than during the initialization phase.=20=


So, for older kernels, we should guide them to backport the patch.

> Reported-by: Pavithra <pavrampu@linux.ibm.com>
> Assisted-by: LLM
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
> Fixes tag here is added since the fix is dependent upon the change =
mentioned in
> "Fixes" tag. The Fixes commit-id is from mm-new branch. Although this =
could be
> an older pre-existing issue, but got exposed after this patch series.

I knew this issue, so I have a local commit to fix it as well. I'd like =
to share
it with you, because it looks a little simple, does it work for you?

powerpc/mm: fix uninitialized ZONE_DEVICE struct pages with PMDs

PowerPC radix vmemmap population can reuse an existing PMD mapping while
populating a device DAX range whose section is marked as HVO-enabled. =
The
reused mapping is an ordinary vmemmap mapping: the redundant tail struct
pages are not remapped to the shared tail page.

Leaving the section marked as HVO-enabled makes later ZONE_DEVICE
initialization treat the range as optimized and initialize only the =
struct
pages that would be backed by a real HVO mapping. The remaining tail =
struct
pages can then be left uninitialized even though they are still used as
metadata for the device DAX compound page.

The Fixes target predates the section-based vmemmap optimization
infrastructure, so older kernels do not have section state that can be
marked non-HVO. Backports to such kernels need to handle the PMD-reuse
case in powerpc radix code directly, for example by initializing the =
tail
struct pages that core ZONE_DEVICE initialization would otherwise skip.

Mark the section as non-HVO when reusing an existing PMD mapping, so the
section's HVO state matches the actual vmemmap layout and all required
struct pages are initialized.

Fixes: f2b79c0d7968 ("powerpc/book3s64/radix: add support for vmemmap =
optimization for radix")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c =
b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 72793ace1fb6..fc3a2d4b422d 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1200,7 +1200,16 @@ static int __meminit =
vmemmap_populate_compound_pages(unsigned long start_pfn,
 			return -ENOMEM;

 		if (pmd_leaf(READ_ONCE(*pmd))) {
-			/* existing huge mapping. Skip the range */
+			unsigned long addr_pfn =3D page_to_pfn((struct =
page *)addr);
+			struct mem_section *ms =3D =
__pfn_to_section(addr_pfn);
+
+			/*
+			 * Existing PMD mappings can cover the edges of =
a valid
+			 * HVO populate range.  They are ordinary =
vmemmap mappings,
+			 * so the current section must not be treated as =
HVO-backed
+			 * when its struct pages are initialized later.
+			 */
+			section_set_order(ms, 0);
 			next =3D pmd_addr_end(addr, end);
 			continue;
 		}=

