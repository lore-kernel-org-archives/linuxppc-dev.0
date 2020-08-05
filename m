Return-Path: <SRS0=7j3x=BP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439FFC433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2020 08:31:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90A8C20792
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2020 08:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUTWGjMa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUTWGjMa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90A8C20792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BM4bt6jrVzDqgj
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2020 18:31:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=207.211.31.81;
 helo=us-smtp-delivery-1.mimecast.com; envelope-from=bhe@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=UUTWGjMa; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UUTWGjMa; 
 dkim-atps=neutral
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BM4YR2z2KzDqBh
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2020 18:29:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596616184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FvaMXP5a+m7YjPK069Q+H34K0fPtN+F8dCVJuIAUPpY=;
 b=UUTWGjMaC589yMqIkc0P3tcJrgvfrnzLO8GogIGJlXgVmu4mZ8riSGVZ80gJd910sZWZnH
 x/6LkzLnS3lm3aS9tSyXrJKXxfyikTxKoZ52heun1ooQqpuN/VBShPPPSyIpZ1aw8AoC7W
 o+e4SIr3MyXoeyUk2C1AfLQ7axybcPE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596616184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FvaMXP5a+m7YjPK069Q+H34K0fPtN+F8dCVJuIAUPpY=;
 b=UUTWGjMaC589yMqIkc0P3tcJrgvfrnzLO8GogIGJlXgVmu4mZ8riSGVZ80gJd910sZWZnH
 x/6LkzLnS3lm3aS9tSyXrJKXxfyikTxKoZ52heun1ooQqpuN/VBShPPPSyIpZ1aw8AoC7W
 o+e4SIr3MyXoeyUk2C1AfLQ7axybcPE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-Fs5bhd50MLqa0hbUoos07g-1; Wed, 05 Aug 2020 04:29:36 -0400
X-MC-Unique: Fs5bhd50MLqa0hbUoos07g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F02638064AB;
 Wed,  5 Aug 2020 08:29:30 +0000 (UTC)
Received: from localhost (ovpn-12-71.pek2.redhat.com [10.72.12.71])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E2DCC10013D0;
 Wed,  5 Aug 2020 08:29:26 +0000 (UTC)
Date: Wed, 5 Aug 2020 16:29:24 +0800
From: Baoquan He <bhe@redhat.com>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2 15/17] memblock: remove unused memblock_mem_size()
Message-ID: <20200805082924.GV10792@MiWiFi-R3L-srv>
References: <20200802163601.8189-1-rppt@kernel.org>
 <20200802163601.8189-16-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200802163601.8189-16-rppt@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Cc: Emil Renner Berthing <kernel@esmil.dk>, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 Will Deacon <will@kernel.org>, Stafford Horne <shorne@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@linux.ibm.com>,
 clang-built-linux@googlegroups.com, Ingo Molnar <mingo@redhat.com>,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org,
 openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Thomas Gleixner <tglx@linutronix.de>, Hari Bathini <hbathini@linux.ibm.com>,
 Michal Simek <monstr@monstr.eu>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 08/02/20 at 07:35pm, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The only user of memblock_mem_size() was x86 setup code, it is gone now and
> memblock_mem_size() funciton can be removed.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  include/linux/memblock.h |  1 -
>  mm/memblock.c            | 15 ---------------
>  2 files changed, 16 deletions(-)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index d70c2835e913..ec2fd8f32a19 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -450,7 +450,6 @@ static inline bool memblock_bottom_up(void)
>  
>  phys_addr_t memblock_phys_mem_size(void);
>  phys_addr_t memblock_reserved_size(void);
> -phys_addr_t memblock_mem_size(unsigned long limit_pfn);
>  phys_addr_t memblock_start_of_DRAM(void);
>  phys_addr_t memblock_end_of_DRAM(void);
>  void memblock_enforce_memory_limit(phys_addr_t memory_limit);
> diff --git a/mm/memblock.c b/mm/memblock.c
> index c1a4c8798973..48d614352b25 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1656,21 +1656,6 @@ phys_addr_t __init_memblock memblock_reserved_size(void)
>  	return memblock.reserved.total_size;
>  }
>  
> -phys_addr_t __init memblock_mem_size(unsigned long limit_pfn)
> -{
> -	unsigned long pages = 0;
> -	unsigned long start_pfn, end_pfn;
> -	int i;
> -
> -	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, NULL) {
> -		start_pfn = min_t(unsigned long, start_pfn, limit_pfn);
> -		end_pfn = min_t(unsigned long, end_pfn, limit_pfn);
> -		pages += end_pfn - start_pfn;
> -	}
> -
> -	return PFN_PHYS(pages);
> -}

Reviewed-by: Baoquan He <bhe@redhat.com>

