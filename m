Return-Path: <SRS0=I40Z=CT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00A0C43461
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2020 07:39:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A166620795
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2020 07:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="BF7AAp9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A166620795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bn9lG5tVNzDqd1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2020 17:39:54 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bn9hw71w6zDqYp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2020 17:37:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=BF7AAp9/; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Bn9hw4Nkzz9sTN;
 Thu, 10 Sep 2020 17:37:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1599723472;
 bh=3jBMjRK0WZtKLCxDaHVlm9FRHjCru7cKoycDTMb3DtY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=BF7AAp9/ESaDPwprqHwp4iZa+AcEER1Ne0FBbjjxvh2WME1Vp6ihmn2sZgAz/L1gu
 x+xCXmBT1nUoR2012ILJddWXvmLj544GrIYA95tiQzgM6JFpdJ/FKMarQC9p2FrIH1
 XU6iXz2c6WMblF2JcEgMPZxpkNe5XNJARbxT/VHpx8Fhs0BnDA5x9bn/+rsVv3mwoe
 clwryaJmT6LoDdvUFpGj8q9VU2kZUPyR+ssuHY5/IireX0QK41nfxeVCnKYB3agQcL
 QJFrKeKuPMGudICeN2uq1g6bKY2gPJmZE5RL8yRnRIiOT6EIIQesP7eoEQiLgNTbg/
 BZF9prsDIdkDg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Ellerman <patch-notifications@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, Nathan Lynch <nathanl@linux.ibm.com>
Subject: Re: [PATCH] powerpc/pseries: explicitly reschedule during drmem_lmb
 list traversal
In-Reply-To: <159965716536.808686.6770489962945335382.b4-ty@ellerman.id.au>
References: <20200728173741.717372-1-nathanl@linux.ibm.com>
 <159965716536.808686.6770489962945335382.b4-ty@ellerman.id.au>
Date: Thu, 10 Sep 2020 17:37:48 +1000
Message-ID: <877dt2rsj7.fsf@mpe.ellerman.id.au>
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
Cc: tyreld@linux.ibm.com, cheloha@linux.ibm.com, ldufour@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman <patch-notifications@ellerman.id.au> writes:
> On Tue, 28 Jul 2020 12:37:41 -0500, Nathan Lynch wrote:
>> The drmem lmb list can have hundreds of thousands of entries, and
>> unfortunately lookups take the form of linear searches. As long as
>> this is the case, traversals have the potential to monopolize the CPU
>> and provoke lockup reports, workqueue stalls, and the like unless
>> they explicitly yield.
>> 
>> Rather than placing cond_resched() calls within various
>> for_each_drmem_lmb() loop blocks in the code, put it in the iteration
>> expression of the loop macro itself so users can't omit it.
>
> Applied to powerpc/next.
>
> [1/1] powerpc/pseries: explicitly reschedule during drmem_lmb list traversal
>       https://git.kernel.org/powerpc/c/9d6792ffe140240ae54c881cc4183f9acc24b4df

Some script gremlins here, I actually applied v3 (only once).

cheers
