Return-Path: <SRS0=1YdR=PK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE5BC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Jan 2019 11:38:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAB382171F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Jan 2019 11:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB382171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43V8FS2YPWzDqLL
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Jan 2019 22:38:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43V85f2rFpzDqCq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Jan 2019 22:31:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43V85f1sVwz9s9h; Wed,  2 Jan 2019 22:31:50 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43V85f0wYMz9sBn; Wed,  2 Jan 2019 22:31:49 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: f460772291f8171988b2b60141a45706123d0c69
X-Patchwork-Hint: ignore
In-Reply-To: <20190101035513.12444-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: KVM: PPC: Book3S HV: radix: Fix uninitialized var build error
Message-Id: <43V85f0wYMz9sBn@ozlabs.org>
Date: Wed,  2 Jan 2019 22:31:49 +1100 (AEDT)
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
Cc: paulus@samba.org, sjitindarsingh@gmail.com, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2019-01-01 at 03:55:13 UTC, Michael Ellerman wrote:
> Old GCCs (4.6.3 at least), aren't able to follow the logic in
> __kvmhv_copy_tofrom_guest_radix() and warn that old_pid is used
> uninitialized:
> 
>   arch/powerpc/kvm/book3s_64_mmu_radix.c:75:3: error: 'old_pid' may be
>   used uninitialized in this function
> 
> The logic is OK, we only use old_pid if quadrant == 1, and in that
> case it has definitely be initialised, eg:
> 
> 	if (quadrant == 1) {
> 		old_pid = mfspr(SPRN_PID);
> 	...
> 	if (quadrant == 1 && pid != old_pid)
> 		mtspr(SPRN_PID, old_pid);
> 
> Annotate it to fix the error.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/f460772291f8171988b2b60141a457

cheers
