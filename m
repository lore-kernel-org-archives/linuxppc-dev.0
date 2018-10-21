Return-Path: <SRS0=xfaR=NB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF17ECDE44
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Oct 2018 21:54:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD4C520658
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Oct 2018 21:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="hOoSkXtp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4C520658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42dYMm0FHlzF35f
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 08:54:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="hOoSkXtp";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42dYKB6rg8zDrhR
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2018 08:52:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="hOoSkXtp"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 42dYKB4tPqz9sC7; Mon, 22 Oct 2018 08:52:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1540158734; bh=vKCV2ENQL4G46pe6d58GVsscQnqmchkL7CPId3DS6Ts=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hOoSkXtplHzQK7lyJ65GWDelhrBah1FMsYxnF+Nvv/tQfZ2RACI2bK4NLOra/gF39
 zSLgU7buVr3fGid0q+W06Prk/rG0tNstIvOENTUbxf6k2ZSl9skzLHPpqm6bwzNTFC
 O0SmHvE+C9RKN6B6LGeqE7SYPvDhdS+W4Fq/zfX4RODbtPSlDSi17KYkB58/luQKWh
 P236pLO9EOxhwA1kkskM3MRNqGEyXO7VFRwasbU0eb0eO9GC3Tp1gFx64PHk4zCqRU
 m/2dE/Qsh2ZRyXzpJRGB5IhSjJAHEIV0mdtaQuZPqRy0BiWbIghoCfnAllDk47oT0H
 zMdZV54jeR6KA==
Date: Mon, 22 Oct 2018 08:52:11 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v2] KVM: PPC: Optimize clearing TCEs for sparse
 tables
Message-ID: <20181021215211.GA16320@blackberry>
References: <20181015100841.33267-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015100841.33267-1-aik@ozlabs.ru>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 15, 2018 at 09:08:41PM +1100, Alexey Kardashevskiy wrote:
> The powernv platform maintains 2 TCE tables for VFIO - a hardware TCE
> table and a table with userspace addresses. These tables are radix trees,
> we allocate indirect levels when they are written to. Since
> the memory allocation is problematic in real mode, we have 2 accessors
> to the entries:
> - for virtual mode: it allocates the memory and it is always expected
> to return non-NULL;
> - fr real mode: it does not allocate and can return NULL.
> 
> Also, DMA windows can span to up to 55 bits of the address space and since
> we never have this much RAM, such windows are sparse. However currently
> the SPAPR TCE IOMMU driver walks through all TCEs to unpin DMA memory.
> 
> Since we maintain a userspace addresses table for VFIO which is a mirror
> of the hardware table, we can use it to know which parts of the DMA
> window have not been mapped and skip these so does this patch.
> 
> The bare metal systems do not have this problem as they use a bypass mode
> of a PHB which maps RAM directly.
> 
> This helps a lot with sparse DMA windows, reducing the shutdown time from
> about 3 minutes per 1 billion TCEs to a few seconds for 32GB sparse guest.
> Just skipping the last level seems to be good enough.
> 
> As non-allocating accessor is used now in virtual mode as well, rename it
> from IOMMU_TABLE_USERSPACE_ENTRY_RM (real mode) to _RO (read only).
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Thanks, applied to my kvm-ppc-next branch, and now in the kvm next
branch also.

Paul.
