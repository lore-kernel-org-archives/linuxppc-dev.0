Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8679C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 13:21:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29A28217D8
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 13:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A28217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43LC8D1g9wzDr02
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 00:21:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43LC5Z3BN3zDqjY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Dec 2018 00:19:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43LC5Y6H77z9s8r;
 Fri, 21 Dec 2018 00:19:13 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH] powerpc/pkeys: copy pkey-tracking-information at fork()
In-Reply-To: <1543869802-15372-1-git-send-email-linuxram@us.ibm.com>
References: <1543869802-15372-1-git-send-email-linuxram@us.ibm.com>
Date: Fri, 21 Dec 2018 00:19:13 +1100
Message-ID: <8736qsqqsu.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: fweimer@redhat.com, Ulrich.Weigand@de.ibm.com, dave.hansen@linux.intel.com,
 linuxram@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 msuchanek@suse.de, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Ram,

Thanks for fixing this.

Ram Pai <linuxram@us.ibm.com> writes:
> diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
> index b271b28..5d65c47 100644
> --- a/arch/powerpc/mm/pkeys.c
> +++ b/arch/powerpc/mm/pkeys.c
> @@ -414,3 +414,10 @@ bool arch_vma_access_permitted(struct vm_area_struct *vma, bool write,
>  
>  	return pkey_access_permitted(vma_pkey(vma), write, execute);
>  }
> +
> +void arch_dup_pkeys(struct mm_struct *oldmm, struct mm_struct *mm)
> +{
> +	/* Duplicate the oldmm pkey state in mm: */
> +	mm_pkey_allocation_map(mm) = mm_pkey_allocation_map(oldmm);
> +	mm->context.execute_only_pkey = oldmm->context.execute_only_pkey;
> +}

Shouldn't this check if pkeys are actually in use?

eg:

diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index cf87dddefbdc..587807763737 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -418,6 +418,9 @@ bool arch_vma_access_permitted(struct vm_area_struct *vma, bool write,
 
 void arch_dup_pkeys(struct mm_struct *oldmm, struct mm_struct *mm)
 {
+	if (static_branch_likely(&pkey_disabled))
+		return;
+
 	/* Duplicate the oldmm pkey state in mm: */
 	mm_pkey_allocation_map(mm) = mm_pkey_allocation_map(oldmm);
 	mm->context.execute_only_pkey = oldmm->context.execute_only_pkey;


Ideally we'd actually do it in the inline so that the function call to
arch_dup_pkeys() can be avoided. But it looks like header dependencies
might make that hard.

cheers
