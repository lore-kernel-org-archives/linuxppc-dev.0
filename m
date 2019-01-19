Return-Path: <SRS0=aKpC=P3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0752C61CE4
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 23:59:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AF722086D
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 23:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF722086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43hvth3ZqtzDqtY
	for <linuxppc-dev@archiver.kernel.org>; Sun, 20 Jan 2019 10:59:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=will.deacon@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 43hvrx2WfjzDqtQ
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Jan 2019 10:58:08 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFDD0A78;
 Sat, 19 Jan 2019 15:58:06 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8586F3F6A8;
 Sat, 19 Jan 2019 15:58:01 -0800 (PST)
Date: Sat, 19 Jan 2019 23:57:57 +0000
From: Will Deacon <will.deacon@arm.com>
To: Alexandre Ghiti <aghiti@upmem.com>
Subject: Re: [PATCH] hugetlb: allow to free gigantic pages regardless of the
 configuration
Message-ID: <20190119235756.GF26876@brain-police>
References: <20190117183953.5990-1-aghiti@upmem.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117183953.5990-1-aghiti@upmem.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 Alexandre Ghiti <alex@ghiti.fr>, x86@kernel.org, hch@infradead.org,
 Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, Borislav Petkov <bp@alien8.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Mike Kravetz <mike.kravetz@oracle.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jan 17, 2019 at 06:39:53PM +0000, Alexandre Ghiti wrote:
> From: Alexandre Ghiti <alex@ghiti.fr>
> 
> On systems without CMA or (MEMORY_ISOLATION && COMPACTION) activated but
> that support gigantic pages, boottime reserved gigantic pages can not be
> freed at all. This patchs simply enables the possibility to hand back
> those pages to memory allocator.
> 
> This commit then renames gigantic_page_supported and
> ARCH_HAS_GIGANTIC_PAGE to make them more accurate. Indeed, those values
> being false does not mean that the system cannot use gigantic pages: it
> just means that runtime allocation of gigantic pages is not supported,
> one can still allocate boottime gigantic pages if the architecture supports
> it.
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
> 
> - Compiled on all architectures
> - Tested on riscv architecture
> 
>  arch/arm64/Kconfig                           |  2 +-
>  arch/arm64/include/asm/hugetlb.h             |  7 +++--

The arm64 bits look straightforward enough to me...

Acked-by: Will Deacon <will.deacon@arm.com>

Will
