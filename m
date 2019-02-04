Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F23C282C4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 12:19:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 741022082E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 12:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741022082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tRbF3pjJzDqFv
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 23:19:21 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tRVZ3DZmzDqGG
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2019 23:15:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43tRVY55PHz9sCh; Mon,  4 Feb 2019 23:15:17 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43tRVY3Qdhz9s6w;
 Mon,  4 Feb 2019 23:15:17 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/64s: Remove MSR_RI optimisation in
 system_call_exit()
In-Reply-To: <1548232157.y0q1xpn4sp.astroid@bobo.none>
References: <20190117113510.4265-1-mpe@ellerman.id.au>
 <1548232157.y0q1xpn4sp.astroid@bobo.none>
Date: Mon, 04 Feb 2019 23:15:16 +1100
Message-ID: <87zhrbn417.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

> Michael Ellerman's on January 17, 2019 9:35 pm:
>> Currently in system_call_exit() we have an optimisation where we
>> disable MSR_RI (recoverable interrupt) and MSR_EE (external interrupt
>> enable) in a single mtmsrd instruction.
>>=20
>> Unfortunately this will no longer work with THREAD_INFO_IN_TASK,
>> because then the load of TI_FLAGS might fault and faulting with MSR_RI
>> clear is treated as an unrecoverable exception which leads to a
>> panic().
>>=20
>> So change the code to only clear MSR_EE prior to loading TI_FLAGS,
>> leaving the clear of MSR_RI until later. We have some latitude in
>> where do the clear of MSR_RI. A bit of experimentation has shown that
>> this location gives the least slow down.
>>=20
>> This still causes a noticeable slow down in our null_syscall
>> performance. On a Power9 DD2.2:
>>=20
>>   Before        After         Delta     Delta %
>>   955 cycles    999 cycles    -44	-4.6%
>>=20
>> On the plus side this does simplify the code somewhat, because we
>> don't have to reenable MSR_RI on the restore_math() or
>> syscall_exit_work() paths which was necessitated previously by the
>> optimisation.
>>=20
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>
> But only because spectre and meltdown broke my spirit.

=F0=9F=98=AD=F0=9F=98=AD=F0=9F=98=AD=F0=9F=98=AD=F0=9F=98=AD=F0=9F=98=AD=F0=
=9F=98=AD=F0=9F=98=AD=F0=9F=98=AD=F0=9F=98=AD

Thanks for reviewing it anyway.

cheers
