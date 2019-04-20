Return-Path: <SRS0=K0D4=SW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5818DC282DD
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Apr 2019 11:02:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B9A12087B
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Apr 2019 11:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9A12087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44mVKT37VTzDqSl
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Apr 2019 21:02:05 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44mVHd1Hd2zDqRS
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Apr 2019 21:00:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44mVHV0c1bz9s70;
 Sat, 20 Apr 2019 21:00:21 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] x86/mpx: fix recursive munmap() corruption
In-Reply-To: <20190419194747.5E1AD6DC@viggo.jf.intel.com>
References: <20190419194747.5E1AD6DC@viggo.jf.intel.com>
Date: Sat, 20 Apr 2019 21:00:21 +1000
Message-ID: <878sw5szzu.fsf@concordia.ellerman.id.au>
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
Cc: linux-arch@vger.kernel.org, hjl.tools@gmail.com, mhocko@suse.com,
 rguenther@suse.de, gxt@pku.edu.cn, jdike@addtoit.com,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-um@lists.infradead.org,
 x86@kernel.org, stable@vger.kernel.org, luto@amacapital.net,
 linux-mm@kvack.org, paulus@samba.org, richard@nod.at,
 yang.shi@linux.alibaba.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, vbabka@suse.cz, anton.ivanov@cambridgegreys.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Dave Hansen <dave.hansen@linux.intel.com> writes:
> Changes from v1:
>  * Fix compile errors on UML and non-x86 arches
>  * Clarify commit message and Fixes about the origin of the
>    bug and add the impact to powerpc / uml / unicore32
>
> --
>
> This is a bit of a mess, to put it mildly.  But, it's a bug
> that only seems to have showed up in 4.20 but wasn't noticed
> until now because nobody uses MPX.
>
> MPX has the arch_unmap() hook inside of munmap() because MPX
> uses bounds tables that protect other areas of memory.  When
> memory is unmapped, there is also a need to unmap the MPX
> bounds tables.  Barring this, unused bounds tables can eat 80%
> of the address space.
>
> But, the recursive do_munmap() that gets called vi arch_unmap()
> wreaks havoc with __do_munmap()'s state.  It can result in
> freeing populated page tables, accessing bogus VMA state,
> double-freed VMAs and more.
>
> To fix this, call arch_unmap() before __do_unmap() has a chance
> to do anything meaningful.  Also, remove the 'vma' argument
> and force the MPX code to do its own, independent VMA lookup.
>
> == UML / unicore32 impact ==
>
> Remove unused 'vma' argument to arch_unmap().  No functional
> change.
>
> I compile tested this on UML but not unicore32.
>
> == powerpc impact ==
>
> powerpc uses arch_unmap() well to watch for munmap() on the
> VDSO and zeroes out 'current->mm->context.vdso_base'.  Moving
> arch_unmap() makes this happen earlier in __do_munmap().  But,
> 'vdso_base' seems to only be used in perf and in the signal
> delivery that happens near the return to userspace.  I can not
> find any likely impact to powerpc, other than the zeroing
> happening a little earlier.

Yeah I agree.

> powerpc does not use the 'vma' argument and is unaffected by
> its removal.
>
> I compile-tested a 64-bit powerpc defconfig.

Thanks.

cheers
