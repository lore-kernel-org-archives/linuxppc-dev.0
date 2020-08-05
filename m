Return-Path: <SRS0=7j3x=BP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFF8C433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2020 03:16:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A80A3207FC
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2020 03:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="h2/1diyM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A80A3207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BLxbm63LPzDqP0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2020 13:16:20 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BLxPB4ZlkzDqZk
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2020 13:07:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=h2/1diyM; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4BLxP904K2z9sR4;
 Wed,  5 Aug 2020 13:07:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1596596829;
 bh=cFnOx9MLQDAqDwbnGPI2ZmfS5spxvaNeWSCSo9hMxag=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=h2/1diyMDAwiQxGA6H1jgJ9kmhVmy0uG0MDsBMuebFNASEQXitbNgwI4s494iWK4D
 nmN1FJya2ptM7fxL1PRY2wsb1Z35yBEXMCbwiEj7ethGQ5B2Cr5LHhyGKoC5BhO2ol
 d3zfbexRVOwwD6s+HdC4MuRsdTnTejyiSzz7pVL+bRjMXoyu8oDmOe8FCjDIx9l3D1
 nMf2BrhKUNI5J/uE1NXz5fqlO9wfvV19ut9f+T0v4jW5n5tjUHoVxluZTaZOAU3czM
 PwHS32Jwib9t0RIoDZQa3Frg1xL7gdVIoVsPPf3LVYL2OUELuY2Yh7AkDQx488+88y
 U6czWI61Th9/w==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] powerpc/pseries/hotplug-cpu: increase wait time for vCPU
 death
In-Reply-To: <20200804161609.6cb2cb71@bahia.lan>
References: <20200804032937.7235-1-mdroth@linux.vnet.ibm.com>
 <873652zg8h.fsf@mpe.ellerman.id.au> <20200804161609.6cb2cb71@bahia.lan>
Date: Wed, 05 Aug 2020 13:07:08 +1000
Message-ID: <87zh79yen7.fsf@mpe.ellerman.id.au>
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
Cc: Nathan Lynch <nathanl@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 Cedric Le Goater <clg@kaod.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Greg Kurz <groug@kaod.org> writes:
> On Tue, 04 Aug 2020 23:35:10 +1000
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>> There is a bit of history to this code, but not in a good way :)
>> 
>> Michael Roth <mdroth@linux.vnet.ibm.com> writes:
>> > For a power9 KVM guest with XIVE enabled, running a test loop
>> > where we hotplug 384 vcpus and then unplug them, the following traces
>> > can be seen (generally within a few loops) either from the unplugged
>> > vcpu:
>> >
>> >   [ 1767.353447] cpu 65 (hwid 65) Ready to die...
>> >   [ 1767.952096] Querying DEAD? cpu 66 (66) shows 2
>> >   [ 1767.952311] list_del corruption. next->prev should be c00a000002470208, but was c00a000002470048
>> ...
>> >
>> > At that point the worker thread assumes the unplugged CPU is in some
>> > unknown/dead state and procedes with the cleanup, causing the race with
>> > the XIVE cleanup code executed by the unplugged CPU.
>> >
>> > Fix this by inserting an msleep() after each RTAS call to avoid
>> 
>> We previously had an msleep(), but it was removed:
>> 
>>   b906cfa397fd ("powerpc/pseries: Fix cpu hotplug")
>
> Ah, I hadn't seen that one...
>
>> > pseries_cpu_die() returning prematurely, and double the number of
>> > attempts so we wait at least a total of 5 seconds. While this isn't an
>> > ideal solution, it is similar to how we dealt with a similar issue for
>> > cede_offline mode in the past (940ce422a3).
>> 
>> Thiago tried to fix this previously but there was a bit of discussion
>> that didn't quite resolve:
>> 
>>   https://lore.kernel.org/linuxppc-dev/20190423223914.3882-1-bauerman@linux.ibm.com/
>
> Yeah it appears that the motivation at the time was to make the "Querying DEAD?"
> messages to disappear and to avoid potentially concurrent calls to rtas-stop-self
> which is prohibited by PAPR... not fixing actual crashes.

I'm pretty sure at one point we were triggering crashes *in* RTAS via
this path, I think that got resolved.

>> Spinning forever seems like a bad idea, but as has been demonstrated at
>> least twice now, continuing when we don't know the state of the other
>> CPU can lead to straight up crashes.
>> 
>> So I think I'm persuaded that it's preferable to have the kernel stuck
>> spinning rather than oopsing.
>> 
>
> +1
>
>> I'm 50/50 on whether we should have a cond_resched() in the loop. My
>> first instinct is no, if we're stuck here for 20s a stack trace would be
>> good. But then we will probably hit that on some big and/or heavily
>> loaded machine.
>> 
>> So possibly we should call cond_resched() but have some custom logic in
>> the loop to print a warning if we are stuck for more than some
>> sufficiently long amount of time.
>
> How long should that be ?

Yeah good question.

I guess step one would be seeing how long it can take on the 384 vcpu
machine. And we can probably test on some other big machines.

Hopefully Nathan can give us some idea of how long he's seen it take on
large systems? I know he was concerned about the 20s timeout of the
softlockup detector.

Maybe a minute or two?

>> > Fixes: eac1e731b59ee ("powerpc/xive: guest exploitation of the XIVE interrupt controller")
>> > Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1856588
>> 
>> This is not public.
>
> I'll have a look at changing that.

Thanks.

cheers
