Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61CFC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 12:50:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95C2820C01
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 12:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95C2820C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444HWn4ynYzDqJ8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 23:50:29 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444HTJ3TrlzDqGB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 23:48:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 444HTH2lyTz9s70;
 Wed, 20 Feb 2019 23:48:19 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, benh@kernel.crashing.org,
 Daniel Axtens <dja@axtens.net>, paulus@samba.org
Subject: Re: [RFC PATCH 2/2] powerpc/mm/hash64: Map all the kernel mapping in
 the same 0xc range
In-Reply-To: <1550559594.nl4vxs2jg6.astroid@bobo.none>
References: <20190217051609.24140-1-aneesh.kumar@linux.ibm.com>
 <20190217051609.24140-2-aneesh.kumar@linux.ibm.com>
 <1550555813.fmra4d124d.astroid@bobo.none>
 <61b935a8-6fb2-e1ec-15cb-fbe4f293fe80@linux.ibm.com>
 <1550559594.nl4vxs2jg6.astroid@bobo.none>
Date: Wed, 20 Feb 2019 23:48:19 +1100
Message-ID: <87k1hu7hik.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nicholas Piggin <npiggin@gmail.com> writes:
> Aneesh Kumar K.V's on February 19, 2019 4:00 pm:
>> On 2/19/19 11:28 AM, Nicholas Piggin wrote:
>>> Aneesh Kumar K.V's on February 17, 2019 3:16 pm:
>>>> This patch maps vmap, IO and vmemap regions in the 0xc address range
>>>> instead of the current 0xd and 0xf range. This brings the mapping closer
>>>> to radix translation mode.
>>> 
>>> What was the reason for that address layout in the first place?
>>> 
>> 
>> To bring in closer to radix translation mode and it should also help 
>> with KASAN implementation.
>
> No I mean the old implementation. Your change seems fine, it would just
> be good to know what the downside (if any) is from changing. Maybe it 
> was just to make debugging slightly simpler?

I don't know what the reason was for using 0xd to begin with. The
original ppc64 port already had it.

Takes a few seconds to load:
  https://github.com/mpe/linux-fullhistory/commit/c3aa9878533e724f639852c3d951e6a169e04081#diff-0adfdefb64f0f0ef306be06ce7f953ebR173

#define PAGE_OFFSET     0xC000000000000000
#define KERNELBASE      PAGE_OFFSET
#define VMALLOCBASE     0xD000000000000000
#define IOREGIONBASE    0xE000000000000000


cheers
