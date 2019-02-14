Return-Path: <SRS0=RHZ4=QV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB7FC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 20:26:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F8082080A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 20:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F8082080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bluematt.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440nx70K8szDqY4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 07:26:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=bluematt.me
 (client-ip=192.241.179.72; helo=mail.bluematt.me;
 envelope-from=kernel@bluematt.me; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=bluematt.me
X-Greylist: delayed 434 seconds by postgrey-1.36 at bilbo;
 Fri, 15 Feb 2019 07:25:08 AEDT
Received: from mail.bluematt.me (mail.bluematt.me [192.241.179.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440nv86XXKzDqTf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 07:25:08 +1100 (AEDT)
Received: from [192.168.0.100] (unknown [69.202.205.58])
 by mail.bluematt.me (Postfix) with ESMTPSA id E3B16139579;
 Thu, 14 Feb 2019 20:17:49 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [Bug 202149] New: NULL Pointer Dereference in __split_huge_pmd on
 PPC64LE
From: Matt Corallo <kernel@bluematt.me>
X-Mailer: iPhone Mail (16D57)
In-Reply-To: <87bm4achnu.fsf@linux.ibm.com>
Date: Thu, 14 Feb 2019 15:17:48 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <CCDBD6B9-31CD-4B94-AA8F-9BEF1C133AED@bluematt.me>
References: <bug-202149-27@https.bugzilla.kernel.org/>
 <20190104170459.c8c7fa57ba9bc8a69dee5666@linux-foundation.org>
 <87ef9nk4cj.fsf@linux.ibm.com>
 <ed4bea40-cf9e-89a1-f99a-3dbd6249847f@bluematt.me>
 <8736q2jbhr.fsf@linux.ibm.com>
 <A61367CF-277E-4E74-8A9D-C94C5E53817B@bluematt.me>
 <87bm4achnu.fsf@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 bugzilla-daemon@bugzilla.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hey, sorry for the delay on this. I had some apparently-unrelated hangs that=
 I believe were due to mpt3sas instability, and at the risk of speaking too s=
oon for a bug I couldn't reliably reproduce, this patch appears to have reso=
lved it, thanks!

> On Jan 21, 2019, at 07:35, Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com> w=
rote:
>=20
>=20
> Can you test this patch?
>=20
> =46rom e511e79af9a314854848ea8fda9dfa6d7e07c5e4 Mon Sep 17 00:00:00 2001
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Date: Mon, 21 Jan 2019 16:43:17 +0530
> Subject: [PATCH] arch/powerpc/radix: Fix kernel crash with mremap
>=20
> With support for split pmd lock, we use pmd page pmd_huge_pte pointer to s=
tore
> the deposited page table. In those config when we move page tables we need=
 to
> make sure we move the depoisted page table to the right pmd page. Otherwis=
e this
> can result in crash when we withdraw of deposited page table because we ca=
n find
> the pmd_huge_pte NULL.
>=20
> c0000000004a1230 __split_huge_pmd+0x1070/0x1940
> c0000000004a0ff4 __split_huge_pmd+0xe34/0x1940 (unreliable)
> c0000000004a4000 vma_adjust_trans_huge+0x110/0x1c0
> c00000000042fe04 __vma_adjust+0x2b4/0x9b0
> c0000000004316e8 __split_vma+0x1b8/0x280
> c00000000043192c __do_munmap+0x13c/0x550
> c000000000439390 sys_mremap+0x220/0x7e0
> c00000000000b488 system_call+0x5c/0x70
>=20
> Fixes: 675d995297d4 ("powerpc/book3s64: Enable split pmd ptlock.")
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
> arch/powerpc/include/asm/book3s/64/pgtable.h | 2 --
> 1 file changed, 2 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/i=
nclude/asm/book3s/64/pgtable.h
> index 92eaea164700..86e62384256d 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -1262,8 +1262,6 @@ static inline int pmd_move_must_withdraw(struct spin=
lock *new_pmd_ptl,
>                     struct spinlock *old_pmd_ptl,
>                     struct vm_area_struct *vma)
> {
> -    if (radix_enabled())
> -        return false;
>    /*
>     * Archs like ppc64 use pgtable to store per pmd
>     * specific information. So when we switch the pmd,
> --=20
> 2.20.1
>=20

