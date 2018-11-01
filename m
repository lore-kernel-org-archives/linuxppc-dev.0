Return-Path: <SRS0=OEx3=NM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33CAC0044C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 03:58:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 408C720820
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 03:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 408C720820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42lrzL1k9czF3L3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 14:58:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42lrvs615nzF3L8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2018 14:55:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42lrvr6qrQz9sPp;
 Thu,  1 Nov 2018 14:55:36 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Florian Weimer <fweimer@redhat.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: PIE binaries are no longer mapped below 4 GiB on ppc64le
In-Reply-To: <87k1lyf2x3.fsf@oldenburg.str.redhat.com>
References: <87k1lyf2x3.fsf@oldenburg.str.redhat.com>
Date: Thu, 01 Nov 2018 14:55:34 +1100
Message-ID: <87lg6dfo3t.fsf@concordia.ellerman.id.au>
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
Cc: linux-mm@kvack.org, keescook@chromium.org, amodra@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Florian,

Florian Weimer <fweimer@redhat.com> writes:
> We tried to use Go to build PIE binaries, and while the Go toolchain is
> definitely not ready (it produces text relocations and problematic
> relocations in general), it exposed what could be an accidental
> userspace ABI change.
>
> With our 4.10-derived kernel, PIE binaries are mapped below 4 GiB, so
> relocations like R_PPC64_ADDR16_HA work:
>
> 21f00000-220d0000 r-xp 00000000 fd:00 36593493                           /root/extld
> 220d0000-220e0000 r--p 001c0000 fd:00 36593493                           /root/extld
> 220e0000-22100000 rw-p 001d0000 fd:00 36593493                           /root/extld
...
>
> With a 4.18-derived kernel (with the hashed mm), we get this instead:
>
> 120e60000-121030000 rw-p 00000000 fd:00 102447141                        /root/extld
> 121030000-121060000 rw-p 001c0000 fd:00 102447141                        /root/extld
> 121060000-121080000 rw-p 00000000 00:00 0 

I assume that's caused by:

  47ebb09d5485 ("powerpc: move ELF_ET_DYN_BASE to 4GB / 4MB")

Which did roughly:

  -#define ELF_ET_DYN_BASE	0x20000000
  +#define ELF_ET_DYN_BASE		(is_32bit_task() ? 0x000400000UL : \
  +					   0x100000000UL)

And went into 4.13.

> ...
> I'm not entirely sure what to make of this, but I'm worried that this
> could be a regression that matters to userspace.

It was a deliberate change, and it seemed to not break anything so we
merged it. But obviously we didn't test widely enough.

So I guess it clearly can matter to userspace, and it used to work, so
therefore it is a regression.

But at the same time we haven't had any other reports of breakage, so is
this somehow specific to something Go is doing? Or did we just get lucky
up until now? Or is no one actually testing on Power? ;)

cheers
