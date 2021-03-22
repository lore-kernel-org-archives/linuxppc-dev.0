Return-Path: <SRS0=7u3Q=IU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9912C433C1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Mar 2021 23:49:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6E5E619A4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Mar 2021 23:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E5E619A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F4B6p6jF3z30Ly
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 10:49:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=EnCk7XfR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=EnCk7XfR; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F4B6N5NmWz2yZB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Mar 2021 10:49:00 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4F4B6K6sXJz9sVb;
 Tue, 23 Mar 2021 10:48:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1616456938;
 bh=3JBhxnjEwZI6EjQ3NYVUYFupetmCmjiqztYll/6iqTo=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=EnCk7XfRmIQquctVCbesCPi/NRh4AXtspTjwWeFj1Rh6t/G38dKLbk8z1S6Qt8RYR
 oB1qK7tPJLnRdD4qE+4WkkVeyQe2JgjWahVr2PtoNCyjdBFxAKWFwtkieeKX9JwKn9
 KBNKHrNZGf1nmaVaJjuKTvChahQ/dq3TebhDmFjMOO5OpdFD30a85pBtMaSMHUqjk3
 nG+HuWc+KExag1OBxab2FsBLK7+BKl86fX7IhfFWwoQ72yzPr1iOT7RMSp9lYmedMK
 kxt3ZMYIzQs2mZN60W75tgyUCLSlZkBDHtFnBi2c/SjlXBOwE3c9nbyV2VRqLRlQLx
 NVek6NSj2wYZQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Randy Dunlap <rdunlap@infradead.org>, Bhaskar Chowdhury
 <unixbhaskar@gmail.com>, benh@kernel.crashing.org, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/asm: Fix a typo
In-Reply-To: <96eda8ce-1d89-1491-51a2-92ba9883912b@infradead.org>
References: <20210322113254.2081445-1-unixbhaskar@gmail.com>
 <96eda8ce-1d89-1491-51a2-92ba9883912b@infradead.org>
Date: Tue, 23 Mar 2021 10:48:55 +1100
Message-ID: <87sg4mhhqw.fsf@mpe.ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Randy Dunlap <rdunlap@infradead.org> writes:
> On 3/22/21 4:32 AM, Bhaskar Chowdhury wrote:
>> 
>> s/poiner/pointer/
>> 
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>
> However, it would be a GOOD THING to collect multiple similar
> patches that are in e.g. arch/powerpc/ and send them as one patch
> instead of many little patches.

Yes.

Please send me one patch for all of the spelling issues you can
currently find in arch/powerpc.

cheers
