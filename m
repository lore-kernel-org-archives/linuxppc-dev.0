Return-Path: <SRS0=Y17X=YK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F54ECE599
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Oct 2019 02:20:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EE16218DE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Oct 2019 02:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE16218DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46ttDz3LdRzDr4q
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Oct 2019 13:20:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=benh@kernel.crashing.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46ttBy62SSzDqjh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2019 13:19:06 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x9H2Il8V003361;
 Wed, 16 Oct 2019 21:18:48 -0500
Message-ID: <c572c8f6badae4fcd961114ba38942afe89252ca.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mm/book3s64/hash: Update 4k PAGE_SIZE kernel
 mapping
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Christoph Hellwig
 <hch@infradead.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Thu, 17 Oct 2019 13:18:47 +1100
In-Reply-To: <87ftjtt4uw.fsf@mpe.ellerman.id.au>
References: <20191016055130.10533-1-aneesh.kumar@linux.ibm.com>
 <20191016060556.GA7279@infradead.org> <87ftjtt4uw.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Cc: Cameron Berkenpas <cam@neo-zeon.de>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2019-10-16 at 20:30 +1100, Michael Ellerman wrote:
> I think the main reason is that in some configurations we can't use 64K
> pages for MMIO, so the 64K vmalloc mappings and 4K MMIO mappings need to
> be in different segments.
> 
> It's possible that's no longer true on modern configs. But annoyingly I
> can't easily tell because the kernel doesn't know, it defers to firmware
> telling it via the "ibm,pa-features" property and setting
> MMU_FTR_CI_LARGE_PAGE.
> 
> The spec (PAPR) doesn't give us any hints either it just says the bit in
> the device tree means:
> 
>   The value of 1 indicates support for I=1 (cache inhibited) large
>   pages; else not supported.
> 
> Which at least suggests that firmware is allowed to support 64K MMIO
> mappings or not at its whim.
> 
> Hopefully Ben or Paul remember more details than me.

Not 100% certain but I think the HW only started supporting non-4k MMIO
pages with P7 (or was it some variant of P6 ?)

Also it's unclear under what circumstances the proprietary hypervisor
or KVM will allow it. I know at some point KVM didn't...

Cheers,
Ben.


