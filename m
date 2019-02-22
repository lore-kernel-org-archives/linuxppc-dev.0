Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA128C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 10:38:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1C5420652
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 10:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1C5420652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445SVP5mDHzDqVd
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 21:38:21 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445RNQ6Xb1zDq7k
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 20:48:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 445RNQ37Mnz9sBp; Fri, 22 Feb 2019 20:48:06 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 445RNQ0njMz9sBR; Fri, 22 Feb 2019 20:48:05 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: d976f6807ea613c54fcb74bd7ae68a43fdd62e1f
X-Patchwork-Hint: ignore
In-Reply-To: <20190220085500.29837-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: KVM: PPC: Book3S HV: Context switch IAMR on Power9
Message-Id: <445RNQ0njMz9sBR@ozlabs.org>
Date: Fri, 22 Feb 2019 20:48:05 +1100 (AEDT)
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
Cc: paulus@samba.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2019-02-20 at 08:55:00 UTC, Michael Ellerman wrote:
> kvmhv_p9_guest_entry() implements a fast-path guest entry for Power9
> when guest and host are both running with the Radix MMU.
> 
> Currently in that path we don't save the host AMR (Authority Mask
> Register) value, and we always restore 0 on return to the host. That
> is OK at the moment because the AMR is not used for storage keys with
> the Radix MMU.
> 
> However we plan to start using the AMR on Radix to prevent the kernel
> from reading/writing to userspace outside of copy_to/from_user(). In
> order to make that work we need to save/restore the AMR value.
> 
> We only restore the value if it is different from the guest value,
> which is already in the register when we exit to the host. This should
> mean we rarely need to actually restore the value when running a
> modern Linux as a guest, because it will be using the same value as
> us.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Tested-by: Russell Currey <ruscur@russell.cc>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/d976f6807ea613c54fcb74bd7ae68a43

cheers
