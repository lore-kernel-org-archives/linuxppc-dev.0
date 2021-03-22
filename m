Return-Path: <SRS0=7u3Q=IU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359F1C433E4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Mar 2021 11:08:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A8A56196F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Mar 2021 11:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A8A56196F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F3sF36knRz30BN
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Mar 2021 22:08:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=cFUGRWY/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=cFUGRWY/; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F3sDc1y8nz2yQp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Mar 2021 22:08:15 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4F3sDT0lfsz9sS8;
 Mon, 22 Mar 2021 22:08:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1616411289;
 bh=uxa4pHHTMVzSJZOPCsz78YK8wlcYnsE951BCdVMBFh8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=cFUGRWY/Qr86qwsUK1d49CiSAXP5qdPTyn3zQzF0R4HHxwcLccxcP0SLc9nzQn2+J
 9gKFUP4LO8HRRZ6KQud4YGoe+r7qHqfCG0MDFn//jYBydvWrKeEuZU8i79EIaYT9W5
 Rdmu/Md7ms21WOn2mLDRIFJFWMfe+tLCNZjioXivdjsNsbBwNiqfprfvYqBiYh3G77
 22lkMpE52ooBfNdL2474eXWjEsltIIw5ajfcF41sfwpZvEJ7XoKm2cNSfbrai8pKNm
 cZGA/OSAHRB1NYjAIYC6fT1RHoXNhFFGD0lh7u2v/QIDupcGg02EU7/UhdXk0iZ0aZ
 IsibVdS+bb0RA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Axtens <dja@axtens.net>, Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH v11 1/6] kasan: allow an architecture to disable inline
 instrumentation
In-Reply-To: <87r1k8av4j.fsf@dja-thinkpad.axtens.net>
References: <20210319144058.772525-1-dja@axtens.net>
 <20210319144058.772525-2-dja@axtens.net>
 <20210320014606.GB77072@balbir-desktop>
 <87r1k8av4j.fsf@dja-thinkpad.axtens.net>
Date: Mon, 22 Mar 2021 22:08:05 +1100
Message-ID: <87v99jh2ei.fsf@mpe.ellerman.id.au>
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
Cc: aneesh.kumar@linux.ibm.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, kasan-dev@googlegroups.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Daniel Axtens <dja@axtens.net> writes:
> Balbir Singh <bsingharora@gmail.com> writes:
>
>> On Sat, Mar 20, 2021 at 01:40:53AM +1100, Daniel Axtens wrote:
>>> For annoying architectural reasons, it's very difficult to support inline
>>> instrumentation on powerpc64.
>>
>> I think we can expand here and talk about how in hash mode, the vmalloc
>> address space is in a region of memory different than where kernel virtual
>> addresses are mapped. Did I recollect the reason correctly?
>
> I think that's _a_ reason, but for radix mode (which is all I support at
> the moment), the reason is a bit simpler.

Actually Aneesh fixed that in:

  0034d395f89d ("powerpc/mm/hash64: Map all the kernel regions in the same 0xc range")

The problem we had prior to that was that the linear mapping was at
(0xc << 60), vmalloc was at (0xd << 60), and vmemap was at (0xf << 60).

Meaning our shadow region would need to be more than (3 << 60) in size.

cheers
