Return-Path: <SRS0=UTIz=LS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34ADAC49EA5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jun 2021 14:02:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A82AD608FE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jun 2021 14:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82AD608FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G9hfD1vZSz3c2R
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jun 2021 00:02:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G9hdp6l36z2xxn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jun 2021 00:02:06 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4G9hdn486hz9sXJ; Fri, 25 Jun 2021 00:02:05 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, kvm-ppc@vger.kernel.org
In-Reply-To: <20210526125851.3436735-1-npiggin@gmail.com>
References: <20210526125851.3436735-1-npiggin@gmail.com>
Subject: Re: [PATCH v2] KVM: PPC: Book3S HV: Save host FSCR in the P7/8 path
Message-Id: <162454330041.2930301.11877612798226022181.b4-ty@ellerman.id.au>
Date: Fri, 25 Jun 2021 00:01:40 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Cc: linuxppc-dev@lists.ozlabs.org, Fabiano Rosas <farosas@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 26 May 2021 22:58:51 +1000, Nicholas Piggin wrote:
> Similar to commit 25edcc50d76c ("KVM: PPC: Book3S HV: Save and restore
> FSCR in the P9 path"), ensure the P7/8 path saves and restores the host
> FSCR. The logic explained in that patch actually applies there to the
> old path well: a context switch can be made before kvmppc_vcpu_run_hv
> restores the host FSCR and returns.
> 
> Now both the p9 and the p7/8 paths now save and restore their FSCR, it
> no longer needs to be restored at the end of kvmppc_vcpu_run_hv

Applied to powerpc/topic/ppc-kvm.

[1/1] KVM: PPC: Book3S HV: Save host FSCR in the P7/8 path
      https://git.kernel.org/powerpc/c/6ba53317d497dec029bfb040b1daf38328fa00ab

cheers
