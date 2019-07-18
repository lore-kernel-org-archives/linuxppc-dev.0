Return-Path: <SRS0=Nz1t=VP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A1AC76191
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jul 2019 14:02:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06C2E2173E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jul 2019 14:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C2E2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45qG6L2LdzzDqJl
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jul 2019 00:02:18 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45qFzp43HZzDqXl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jul 2019 23:56:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 45qFzp31PNz9sBt; Thu, 18 Jul 2019 23:56:38 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 63279eeb7f93abb1692573c26f1e038e1a87358b
In-Reply-To: <20190703012022.15644-1-sjitindarsingh@gmail.com>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH 1/3] KVM: PPC: Book3S HV: Always save guest pmu for guest
 capable of nesting
Message-Id: <45qFzp31PNz9sBt@ozlabs.org>
Date: Thu, 18 Jul 2019 23:56:38 +1000 (AEST)
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
Cc: kvm-ppc@vger.kernel.org, sjitindarsingh@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2019-07-03 at 01:20:20 UTC, Suraj Jitindar Singh wrote:
> The performance monitoring unit (PMU) registers are saved on guest exit
> when the guest has set the pmcregs_in_use flag in its lppaca, if it
> exists, or unconditionally if it doesn't. If a nested guest is being
> run then the hypervisor doesn't, and in most cases can't, know if the
> pmu registers are in use since it doesn't know the location of the lppaca
> for the nested guest, although it may have one for its immediate guest.
> This results in the values of these registers being lost across nested
> guest entry and exit in the case where the nested guest was making use
> of the performance monitoring facility while it's nested guest hypervisor
> wasn't.
> 
> Further more the hypervisor could interrupt a guest hypervisor between
> when it has loaded up the pmu registers and it calling H_ENTER_NESTED or
> between returning from the nested guest to the guest hypervisor and the
> guest hypervisor reading the pmu registers, in kvmhv_p9_guest_entry().
> This means that it isn't sufficient to just save the pmu registers when
> entering or exiting a nested guest, but that it is necessary to always
> save the pmu registers whenever a guest is capable of running nested guests
> to ensure the register values aren't lost in the context switch.
> 
> Ensure the pmu register values are preserved by always saving their
> value into the vcpu struct when a guest is capable of running nested
> guests.
> 
> This should have minimal performance impact however any impact can be
> avoided by booting a guest with "-machine pseries,cap-nested-hv=false"
> on the qemu commandline.
> 
> Fixes: 95a6432ce903 "KVM: PPC: Book3S HV: Streamlined guest entry/exit path on P9 for radix guests"
> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Series applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/63279eeb7f93abb1692573c26f1e038e1a87358b

cheers
