Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B3DC282C2
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 01:06:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1638A2085A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 01:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1638A2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wcTM42XRzDqJ2
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 12:06:47 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wcRB0hqvzDqQ0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 12:04:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43wcR95BZjz9rxp;
 Fri,  8 Feb 2019 12:04:53 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Russell Currey <ruscur@russell.cc>
Subject: Re: [PATCH] powerpc/powernv/idle: Restore IAMR after idle
In-Reply-To: <1549515373.con208q1rq.astroid@bobo.none>
References: <20190206062837.26917-1-ruscur@russell.cc>
 <1549515373.con208q1rq.astroid@bobo.none>
Date: Fri, 08 Feb 2019 12:04:51 +1100
Message-ID: <87o97njdjg.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:
> Russell Currey's on February 6, 2019 4:28 pm:
>> Without restoring the IAMR after idle, execution prevention on POWER9
>> with Radix MMU is overwritten and the kernel can freely execute userspace without
>> faulting.
>> 
>> This is necessary when returning from any stop state that modifies user
>> state, as well as hypervisor state.
>> 
>> To test how this fails without this patch, load the lkdtm driver and
>> do the following:
>> 
>>    echo EXEC_USERSPACE > /sys/kernel/debug/provoke-crash/DIRECT
>> 
>> which won't fault, then boot the kernel with powersave=off, where it
>> will fault.  Applying this patch will fix this.
>> 
>> Fixes: 3b10d0095a1e ("powerpc/mm/radix: Prevent kernel execution of user
>> space")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Russell Currey <ruscur@russell.cc>
>
> Good catch and debugging. This really should be a quirk, we don't want 
> to have to restore this thing on a thread switch.

I'm not sure I follow. We don't context switch it on Radix, but we do
on hash if pkeys are enabled.

> Can we put it under a CONFIG option if we're not using IAMR?

We'll always be using it with Radix, and we might be using it for pkeys
on hash, unless pkeys are compiled out. But I don't really expect anyone
to be running with pkeys compiled out.

So I think the only case we could optimise is that we're on hash and the
current thread has an IAMR of 0, then we could just not restore
(assuming we come out of idle with IAMR=0).

But maybe I'm not understanding.

cheers
