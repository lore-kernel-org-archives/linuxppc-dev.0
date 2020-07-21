Return-Path: <SRS0=Efpx=BA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D7EC433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2020 01:47:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E30B720717
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2020 01:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="NTGNXSqf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30B720717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B9hKn5c2bzDqSQ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2020 11:47:09 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B9hHj5C5NzDqMC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2020 11:45:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=NTGNXSqf; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4B9hHj3GZFz9sRN;
 Tue, 21 Jul 2020 11:45:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1595295921;
 bh=jnjSUTXSpF1fuBUXLgx4TFMse/KODu9Uammse5sNAPs=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=NTGNXSqfQbbhxMTcclilvDY9Ux2uinchrxPdAkt5fTAD36go7S/4dyoNUdyIteB2r
 U+GAIZtxexX40HsKstsZ1sOrFkIhQDXMl872lRWNIfgsEofwzqFCIgAFHGW+x/2fvO
 Kza1xmeXJYXIZvBcOLJCZhZmvm/N+0LQnA5oOnycXd4V8H4RJPQjiDA90OdGBJUT5W
 nVn7kkzGcrY7vku7xTs4hCaURBrWj7qjC3RJshvQnQ5mpc4K/MKl/kPdRDLZGa3F4W
 FXu7sa8Y2ZRV6jq7K9JtpAnORqYt4j/SFhn4UW6oxBjg572ITuAtkbCOudgexDma0C
 sPRUP558Eul8g==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Lynch <nathanl@linux.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v3 0/4] powerpc/mm/radix: Memory unplug fixes
In-Reply-To: <87r1tb1rw2.fsf@linux.ibm.com>
References: <20200709131925.922266-1-aneesh.kumar@linux.ibm.com>
 <87r1tb1rw2.fsf@linux.ibm.com>
Date: Tue, 21 Jul 2020 11:45:20 +1000
Message-ID: <87tuy1sksv.fsf@mpe.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, Bharata B Rao <bharata@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nathan Lynch <nathanl@linux.ibm.com> writes:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>> This is the next version of the fixes for memory unplug on radix.
>> The issues and the fix are described in the actual patches.
>
> I guess this isn't actually causing problems at runtime right now, but I
> notice calls to resize_hpt_for_hotplug() from arch_add_memory() and
> arch_remove_memory(), which ought to be mmu-agnostic:
>
> int __ref arch_add_memory(int nid, u64 start, u64 size,
> 			  struct mhp_params *params)
> {
> 	unsigned long start_pfn = start >> PAGE_SHIFT;
> 	unsigned long nr_pages = size >> PAGE_SHIFT;
> 	int rc;
>
> 	resize_hpt_for_hotplug(memblock_phys_mem_size());
>
> 	start = (unsigned long)__va(start);
> 	rc = create_section_mapping(start, start + size, nid,
> 				    params->pgprot);
> ...

Hmm well spotted.

That does return early if the ops are not setup:

int resize_hpt_for_hotplug(unsigned long new_mem_size)
{
	unsigned target_hpt_shift;

	if (!mmu_hash_ops.resize_hpt)
		return 0;


And:

void __init hpte_init_pseries(void)
{
	...
	if (firmware_has_feature(FW_FEATURE_HPT_RESIZE))
		mmu_hash_ops.resize_hpt = pseries_lpar_resize_hpt;

And that comes in via ibm,hypertas-functions:

	{FW_FEATURE_HPT_RESIZE,		"hcall-hpt-resize"},


But firmware is not necessarily going to add/remove that call based on
whether we're using hash/radix.

So I think a follow-up patch is needed to make this more robust.

Aneesh/Bharata what platform did you test this series on? I'm curious
how this didn't break.

cheers
