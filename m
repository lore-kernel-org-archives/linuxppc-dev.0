Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9BBC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 11:46:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B68020693
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 11:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B68020693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Kn423Z2YzDqNS
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 22:46:42 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Kn0n3z8dzDqLs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2019 22:43:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44Kn0l3QjTz9s55; Thu, 14 Mar 2019 22:43:49 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 35f2806b481f5b9207f25e1886cba5d1c4d12cc7
X-Patchwork-Hint: ignore
In-Reply-To: <20190222172531.16369-1-aneesh.kumar@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v2] powerpc/hugetlb: Don't do runtime allocation of 16G pages in
 LPAR configuration
Message-Id: <44Kn0l3QjTz9s55@ozlabs.org>
Date: Thu, 14 Mar 2019 22:43:49 +1100 (AEDT)
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2019-02-22 at 17:25:31 UTC, "Aneesh Kumar K.V" wrote:
> We added runtime allocation of 16G pages in
> commit 4ae279c2c96a ("powerpc/mm/hugetlb: Allow runtime allocation of 16G.")
> That was done to enable 16G allocation on PowerNV and KVM config. In case of KVM
> config, we mostly would have the entire guest RAM backed by 16G hugetlb pages for
> this to work. PAPR do support partial backing of guest RAM with hugepages via
> ibm,expected#pages node of memory node in the device tree. This means rest of the
> guest RAM won't be backed by 16G contiguous pages in the host and hence a hash page
> table insertion can fail in such case.
> 
> An example error message will look like
> 
> hash-mmu: mm: Hashing failure ! EA=0x7efc00000000 access=0x8000000000000006 current=readback
> hash-mmu:     trap=0x300 vsid=0x67af789 ssize=1 base psize=14 psize 14 pte=0xc000000400000386
> readback[12260]: unhandled signal 7 at 00007efc00000000 nip 00000000100012d0 lr 000000001000127c code 2
> 
> This patch address that by preventing runtime allocation of 16G hugepages in
> LPAR config. To allocate 16G hugetlb one need to kernel command line
> hugepagesz=16G hugepages=<number of 16G pages>
> 
> With radix translation mode we don't run into this issue.
> 
> This change will preventÂ runtime allocation of 16G hugetlb pages on kvm with
> hash translation mode. However, with the current upstream it was observed that
> 16G hugetlbfs backed guest doesn't boot at all.
> 
> We observe boot failure with the below message.
> [131354.647546] KVM: map_vrma at 0 failed, ret=-4
> 
> That means this patch is not resulting in an observable regression. Once we fix
> the boot issue with 16G hugetlb backed memory, we need to use ibm,expected#pages
> memory node attribute to indicate 16G page reservation to the guest. This will
> also enable partial backing of guest RAM with 16G pages.
> 
> Fixes: 4ae279c2c96a ("powerpc/mm/hugetlb: Allow runtime allocation of 16G.")
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/35f2806b481f5b9207f25e1886cba5d1

cheers
