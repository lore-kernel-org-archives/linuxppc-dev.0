Return-Path: <SRS0=sQnj=EY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB650C5519F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2020 02:02:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 382CA20B80
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2020 02:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="jGoJJV/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 382CA20B80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CbR0F3Z67zDqcN
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2020 13:02:37 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CbQxl0R8NzDqbf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2020 13:00:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=jGoJJV/S; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4CbQxj3Rtgz9sRR;
 Wed, 18 Nov 2020 13:00:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1605664826;
 bh=nr5e0b6T3DWeie6oub3dZMpbfzhN8bOBT6lbYrV32f0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=jGoJJV/S5AG9ERDPEYUS4pO19ELzVyTInXfjxdPh1RaUeCWhDPzXo5M8Ep5jRxkl8
 9v/olVjtGG9Qy6KFDyQ9YEytgiLHcn9UvH/UXnJ4/UL0xevZfJbkvrDsF3wJF6ngyI
 ZMud+51LoySuJRcuOCMEiqd02lx7xBEcMo7yckiZN4rv9QFThAXHV3uFhVNH5dU1yP
 SjOYpPsY7G/iSb1fQs+vK6oNtsNXwsLffJodCszooAnhWihpRwFickdiBiPXXyWrkR
 kLC32PvO+1/9EJDOP3B3dzc8fPaLFgowBWv2BUBC1nWsrhujshRF41ceFUQIBETV08
 HPRvD8HacEdTg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2 7/8] powerpc/mm: remove linear mapping if __add_pages()
 fails in arch_add_memory()
In-Reply-To: <dac16bcc-8e37-8cb2-ac61-912a17ab5985@redhat.com>
References: <20201111145322.15793-1-david@redhat.com>
 <20201111145322.15793-8-david@redhat.com> <20201117155125.GF15987@linux>
 <dac16bcc-8e37-8cb2-ac61-912a17ab5985@redhat.com>
Date: Wed, 18 Nov 2020 13:00:22 +1100
Message-ID: <87ft572zm1.fsf@mpe.ellerman.id.au>
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
Cc: Michal Hocko <mhocko@suse.com>,
 Wei Yang <richard.weiyang@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 Rashmica Gupta <rashmica.g@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

David Hildenbrand <david@redhat.com> writes:
> On 17.11.20 16:51, Oscar Salvador wrote:
>> On Wed, Nov 11, 2020 at 03:53:21PM +0100, David Hildenbrand wrote:
>>> Let's revert what we did in case seomthing goes wrong and we return an
>> "something" :-)
>
> Thanks! :)
>
> @Michael, I assume if I don't have to resend, this can be fixed up?

Yep, I fixed it up.

cheers
