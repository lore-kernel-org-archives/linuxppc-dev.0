Return-Path: <SRS0=rclJ=QA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCCEC282C3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 16:53:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05467218AF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 16:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05467218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43lpBk2Xp8zDqM3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 03:53:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=mark.rutland@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 43lp930tnhzDqCM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2019 03:51:59 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98533A78;
 Thu, 24 Jan 2019 08:51:57 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A94E3F237;
 Thu, 24 Jan 2019 08:51:55 -0800 (PST)
Date: Thu, 24 Jan 2019 16:51:53 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v14 02/12] powerpc/irq: use memblock functions returning
 virtual address
Message-ID: <20190124165153.GB5531@lakrids.cambridge.arm.com>
References: <cover.1548346225.git.christophe.leroy@c-s.fr>
 <1c8e658c094022a15e4b9f5ef5c191caab3c0dff.1548346225.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c8e658c094022a15e4b9f5ef5c191caab3c0dff.1548346225.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
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
Cc: linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Mike Rapoport <rppt@linux.ibm.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jan 24, 2019 at 04:19:33PM +0000, Christophe Leroy wrote:
> Since only the virtual address of allocated blocks is used,
> lets use functions returning directly virtual address.
> 
> Those functions have the advantage of also zeroing the block.
> 
> Suggested-by: Mike Rapoport <rppt@linux.ibm.com>
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

[...]

> +static void *__init alloc_stack(void)
> +{
> +	void *ptr = memblock_alloc(THREAD_SIZE, THREAD_SIZE);
> +
> +	if (!ptr)
> +		panic("cannot allocate stacks");
> +
> +	return ptr;
> +}

I believe memblock_alloc() will panic() if it cannot allocate memory,
since that goes:

 memblock_alloc()
 -> memblock_alloc_try_nid()
    -> panic()

So you can get rid of the panic() here, or if you want a custom panic
message, you can use memblock_alloc_nopanic().

[...]

>  static void *__init alloc_stack(unsigned long limit, int cpu)
>  {
> -	unsigned long pa;
> +	void *ptr;
>  
>  	BUILD_BUG_ON(STACK_INT_FRAME_SIZE % 16);
>  
> -	pa = memblock_alloc_base_nid(THREAD_SIZE, THREAD_SIZE, limit,
> -					early_cpu_to_node(cpu), MEMBLOCK_NONE);
> -	if (!pa) {
> -		pa = memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit);
> -		if (!pa)
> -			panic("cannot allocate stacks");
> -	}
> +	ptr = memblock_alloc_try_nid(THREAD_SIZE, THREAD_SIZE,
> +				     MEMBLOCK_LOW_LIMIT, limit,
> +				     early_cpu_to_node(cpu));
> +	if (!ptr)
> +		panic("cannot allocate stacks");

The same applies here -- memblock_alloc_try_nid() will panic itself
rather than returning NULL.

Otherwise, this looks like a nice cleanup. With the panics removed (or
using the _nopanic() allocators), feel free to add:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
