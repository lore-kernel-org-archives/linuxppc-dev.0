Return-Path: <SRS0=8RrW=6O=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85E5C83003
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2020 02:36:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FFED2083B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2020 02:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="WBBHx9n9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FFED2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49CKJr3qgFzDrDf
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2020 12:36:44 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49CKGS0K2TzDr4q
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2020 12:34:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=WBBHx9n9; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49CKGQ4ZsBz9sRY;
 Thu, 30 Apr 2020 12:34:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1588214078;
 bh=BCi4c4G/ZA+9mO7Of96Qiajv3+eSTHs7JkDfkYQrlss=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=WBBHx9n9lJB5ghHEmLoQc/ndI+TE1BPqxe8vSOjeC45nb3lFf2k0AMXBBL6OQnEBX
 h7xYd9osHiC0kFJcAf39tG76Pf8UELx65k2BDL+Oo2Tl0y05j1fiJtgHLRVASvMG7A
 FwctvR5cuOxfITfXOsV8+w6eo558jf8H0jUk108No0lHZkAiT+Nyn/tuR7TIuKQIs3
 XY3PbTnCEyrTEQKMFfqwRSXnK/Udph2u6EzvETGGJUNnG7OVewxdpo5QlHsYFN6JXz
 gEWP6L/DmMUuOTnvr29OLGtVWh1qkjvpSif2RtQAD9Hg7M4zcC7PpMYTkXQARL+VRb
 rjJPdDYfz/bFw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: Re: [PATCH v5 0/5] Track and expose idle PURR and SPURR ticks
In-Reply-To: <20200423100213.GA23192@in.ibm.com>
References: <1586249263-14048-1-git-send-email-ego@linux.vnet.ibm.com>
 <04b5e2fa-089f-93c9-cde9-33a930455bb2@linux.ibm.com>
 <20200423100213.GA23192@in.ibm.com>
Date: Thu, 30 Apr 2020 12:34:52 +1000
Message-ID: <871ro5g0qb.fsf@mpe.ellerman.id.au>
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
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Gautham R Shenoy <ego@linux.vnet.ibm.com> writes:
> On Mon, Apr 20, 2020 at 03:46:35PM -0700, Tyrel Datwyler wrote:
>> On 4/7/20 1:47 AM, Gautham R. Shenoy wrote:
>> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>> > 
>> > Hi,
>> > 
>> > This is the fifth version of the patches to track and expose idle PURR
>> > and SPURR ticks. These patches are required by tools such as lparstat
>> > to compute system utilization for capacity planning purposes.
...
>> > 
>> > Gautham R. Shenoy (5):
>> >   powerpc: Move idle_loop_prolog()/epilog() functions to header file
>> >   powerpc/idle: Store PURR snapshot in a per-cpu global variable
>> >   powerpc/pseries: Account for SPURR ticks on idle CPUs
>> >   powerpc/sysfs: Show idle_purr and idle_spurr for every CPU
>> >   Documentation: Document sysfs interfaces purr, spurr, idle_purr,
>> >     idle_spurr
>> > 
>> >  Documentation/ABI/testing/sysfs-devices-system-cpu | 39 +++++++++
>> >  arch/powerpc/include/asm/idle.h                    | 93 ++++++++++++++++++++++
>> >  arch/powerpc/kernel/sysfs.c                        | 82 ++++++++++++++++++-
>> >  arch/powerpc/platforms/pseries/setup.c             |  8 +-
>> >  drivers/cpuidle/cpuidle-pseries.c                  | 39 ++-------
>> >  5 files changed, 224 insertions(+), 37 deletions(-)
>> >  create mode 100644 arch/powerpc/include/asm/idle.h
>> > 
>> 
>> Reviewed-by: Tyrel Datwyler <tyreld@linux.ibm.com>
>
> Thanks for reviewing the patches.
>
>> 
>> Any chance this is going to be merged in the near future? There is a patchset to
>> update lparstat in the powerpc-utils package to calculate PURR/SPURR cpu
>> utilization that I would like to merge, but have been holding off to make sure
>> we are synced with this proposed patchset.
>
> Michael, could you please consider this for 5.8 ?

Yes. Has it been tested on KVM at all?

cheers
