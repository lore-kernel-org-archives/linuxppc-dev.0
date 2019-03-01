Return-Path: <SRS0=P3hO=RE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1B2C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 06:54:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E07B52186A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 06:54:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E07B52186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449gBv5TV8zDqSN
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 17:54:31 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449g912fYFzDqQj
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2019 17:52:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 449g902kvgz9s2R;
 Fri,  1 Mar 2019 17:52:52 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: powerpc: Add count cache flush parameters to
 kvmppc_get_cpu_char()
In-Reply-To: <20190301032516.29919-1-sjitindarsingh@gmail.com>
References: <20190301032516.29919-1-sjitindarsingh@gmail.com>
Date: Fri, 01 Mar 2019 17:52:51 +1100
Message-ID: <87bm2vjdbw.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>, kvm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Suraj Jitindar Singh <sjitindarsingh@gmail.com> writes:

> Add KVM_PPC_CPU_CHAR_BCCTR_FLUSH_ASSIST &
> KVM_PPC_CPU_BEHAV_FLUSH_COUNT_CACHE to the characteristics returned from
> the H_GET_CPU_CHARACTERISTICS H-CALL, as queried from either the
> hypervisor or the device tree.
>
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> ---
>  arch/powerpc/include/uapi/asm/kvm.h |  2 ++
>  arch/powerpc/kvm/powerpc.c          | 18 ++++++++++++++----
>  2 files changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index b90a7d154180..a99dcac91e50 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -2251,12 +2253,16 @@ static int kvmppc_get_cpu_char(struct kvm_ppc_cpu_char *cp)
>  		if (have_fw_feat(fw_features, "enabled",
>  				 "fw-count-cache-disabled"))
>  			cp->character |= KVM_PPC_CPU_CHAR_COUNT_CACHE_DIS;
> +		if (have_fw_feat(fw_features, "enabled",
> +				 "fw-count-cache-flush-bcctr2,0,0"))

I don't think there's any reason KVM needs to be querying the device
tree directly, is there?

Can't it just use the security flags (security_features.h), that are
initialised by the powernv platform code based on the device tree.

I seem to remember we didn't do it that way originally just because we
didn't have time to get everything lined up.

cheers
