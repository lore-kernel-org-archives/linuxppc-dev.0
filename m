Return-Path: <SRS0=weZV=RG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783F8C43381
	for <linuxppc-dev@archiver.kernel.org>; Sun,  3 Mar 2019 09:08:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A04D82070B
	for <linuxppc-dev@archiver.kernel.org>; Sun,  3 Mar 2019 09:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04D82070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44By4326yLzDqMw
	for <linuxppc-dev@archiver.kernel.org>; Sun,  3 Mar 2019 20:08:03 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44By2K3rHWzDqCc
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Mar 2019 20:06:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44By2J6Dmrz9s7h;
 Sun,  3 Mar 2019 20:06:32 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH] KVM: PPC: powerpc: Add count cache flush parameters to
 kvmppc_get_cpu_char()
In-Reply-To: <20190301080113.GB22341@blackberry>
References: <20190301032516.29919-1-sjitindarsingh@gmail.com>
 <87bm2vjdbw.fsf@concordia.ellerman.id.au> <20190301080113.GB22341@blackberry>
Date: Sun, 03 Mar 2019 20:06:29 +1100
Message-ID: <87wolgiay2.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>, kvm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Paul Mackerras <paulus@ozlabs.org> writes:

> On Fri, Mar 01, 2019 at 05:52:51PM +1100, Michael Ellerman wrote:
>> Suraj Jitindar Singh <sjitindarsingh@gmail.com> writes:
>> 
>> > Add KVM_PPC_CPU_CHAR_BCCTR_FLUSH_ASSIST &
>> > KVM_PPC_CPU_BEHAV_FLUSH_COUNT_CACHE to the characteristics returned from
>> > the H_GET_CPU_CHARACTERISTICS H-CALL, as queried from either the
>> > hypervisor or the device tree.
>> >
>> > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
>> > ---
>> >  arch/powerpc/include/uapi/asm/kvm.h |  2 ++
>> >  arch/powerpc/kvm/powerpc.c          | 18 ++++++++++++++----
>> >  2 files changed, 16 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
>> > index b90a7d154180..a99dcac91e50 100644
>> > --- a/arch/powerpc/kvm/powerpc.c
>> > +++ b/arch/powerpc/kvm/powerpc.c
>> > @@ -2251,12 +2253,16 @@ static int kvmppc_get_cpu_char(struct kvm_ppc_cpu_char *cp)
>> >  		if (have_fw_feat(fw_features, "enabled",
>> >  				 "fw-count-cache-disabled"))
>> >  			cp->character |= KVM_PPC_CPU_CHAR_COUNT_CACHE_DIS;
>> > +		if (have_fw_feat(fw_features, "enabled",
>> > +				 "fw-count-cache-flush-bcctr2,0,0"))
>> 
>> I don't think there's any reason KVM needs to be querying the device
>> tree directly, is there?
>> 
>> Can't it just use the security flags (security_features.h), that are
>> initialised by the powernv platform code based on the device tree.
>
> My recollection is that the security flags didn't have all the
> information we need.  It's possible that's no longer true.

Actually I don't think they existed at all back then, we didn't add them
until after the initial panic.

> I merged the patch and sent a pull request to Paolo; using the same
> pattern as the existing code made it a low-risk patch and I wanted to
> get it in for 5.1.  For 5.2 we can look at changing it over if you
> like.

Yep that's fine.

cheers
