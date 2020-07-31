Return-Path: <SRS0=XZtv=BK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1B0C433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2020 11:33:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEEA222B40
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2020 11:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="OSEdhG5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEEA222B40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BJ4s53l9czDqfP
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2020 21:32:57 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BJ4mq74cczDqYt
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2020 21:29:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=OSEdhG5N; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4BJ4mp6L85z9sT6;
 Fri, 31 Jul 2020 21:29:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1596194955;
 bh=34jb67RQIXV7zdZcIuU4OXuBbmIQf5h3pTfTRC5qdDg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=OSEdhG5Nyegx+5lOPERe6hw4U7kZu3HZEbYJtnRsl8VvmMN3DcleE37IaNnVP2uEK
 vnTxt01f9TprUvYcrsPsp15OupO4YryCp7m4fVdSfNL9IMJlKbb7yDitd4j+gt2nfk
 2rHfXv9rxfC9ZrYOHo/yqaBQ2e5+agBi5TtmzvwiOCFWNyGdmEhN7zzl3xdYi+FcQx
 Q/FtrMUqFn4hjPy4YvFIPCZFz2pOTt4hJ3sUONjzranMjpADV7aY60FOLBiXGu+S3i
 Str4YbjIQ7Bjg9ZVLoOUxxQnotEjW8aNslQt29gVTU77jf7A+ohGujwZwWCdIYwMQr
 U3IMDb0052Vyg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 10/10] powerpc/smp: Implement cpu_to_coregroup_id
In-Reply-To: <20200731095808.GB18776@linux.vnet.ibm.com>
References: <20200727053230.19753-1-srikar@linux.vnet.ibm.com>
 <20200727053230.19753-11-srikar@linux.vnet.ibm.com>
 <87wo2k3yeq.fsf@mpe.ellerman.id.au>
 <20200731095808.GB18776@linux.vnet.ibm.com>
Date: Fri, 31 Jul 2020 21:29:13 +1000
Message-ID: <87tuxn53ee.fsf@mpe.ellerman.id.au>
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
Cc: Nathan Lynch <nathanl@linux.ibm.com>,
 Gautham R Shenoy <ego@linux.vnet.ibm.com>, Michael Neuling <mikey@neuling.org>,
 Peter Zijlstra <peterz@infradead.org>, Jordan Niethe <jniethe5@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Valentin Schneider <valentin.schneider@arm.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
> * Michael Ellerman <mpe@ellerman.id.au> [2020-07-31 18:02:21]:
>
>> Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
>> > Lookup the coregroup id from the associativity array.
>
> Thanks Michael for all your comments and inputs.
>
>> It's slightly strange that this is called in patch 9, but only properly
>> implemented here in patch 10.
>> 
>> I'm not saying you have to squash them together, but it would be good if
>> the change log for patch 9 mentioned that a subsequent commit will
>> complete the implementation and how that affects the behaviour.
>
> I probably got influenced by few LKML community members who always add a
> stub and implement the gory details in a subsequent patch. I will surely add
> the change log in patch 9 about the subsequent patches.

That's OK, it's a valid way to do things, and can be good for keeping
the size of individual patches down to make them easier to review.

But yeah a mention in the change log of the preceeding patch is helpful
for anyone looking at that commit on its own in the future.

cheers
