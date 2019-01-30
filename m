Return-Path: <SRS0=D1of=QG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5D8C282D4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 06:26:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4811E2175B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 06:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="L+WwwSU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4811E2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qCzv3Pf3zDqTF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 17:26:03 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qCsm6v9vzDqKT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 17:20:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="L+WwwSU3"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 43qCsm4QCvz9sBb; Wed, 30 Jan 2019 17:20:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1548829244; bh=/BMsMDm1cvNVoz8tjvY6ZfaMVml1EgbF5FG8SOyMsHI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=L+WwwSU3ocdYYJKA7ChmUQJaLC1xYRY5sw61oiPcif4mgbzNBTGBeWL6KO+83TdMY
 RqDPPlJQmNPAmie5mYYqEe6IQzZC+yJJDd3AciCqC6adIZnQp6zpfKiq3ktnRuP+Au
 Gh6t8WIivy403n2+OVmqDH4vt9/AlVpLHUj31dnj+ThYe3grjIXczxhkQXREC8VYrn
 X0KJ+2R9X5WrgtB1GHXamb/2chyrs/sKnTVhUv9Z9qevlboQVskZEe8yTEB0tKxd/o
 1nuzAlkPrG+Dgnz7nZ0IWIweNBBROKZSq09WJmlTLNUa4bXr7KeU6wb6PZwCwyNjqq
 H4Vjg3RvQvwrA==
Date: Wed, 30 Jan 2019 16:40:11 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 00/19] KVM: PPC: Book3S HV: add XIVE native exploitation
 mode
Message-ID: <20190130054011.GB27109@blackberry>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190122044654.GA15124@blackberry>
 <2f9b4420-ef90-20b8-d31b-dc547a6aa6b4@kaod.org>
 <20190128055108.GC3237@blackberry>
 <f2e9a801-d0a9-bf29-7b3e-29269021ecb4@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2e9a801-d0a9-bf29-7b3e-29269021ecb4@kaod.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jan 29, 2019 at 02:51:05PM +0100, Cédric Le Goater wrote:
> >>> Another general comment is that you seem to have written all this
> >>> code assuming we are using HV KVM in a host running bare-metal.
> >>
> >> Yes. I didn't look at the other configurations. I thought that we could
> >> use the kernel_irqchip=off option to begin with. A couple of checks
> >> are indeed missing.
> > 
> > Using kernel_irqchip=off would mean that we would not be able to use
> > the in-kernel XICS emulation, which would have a performance impact.
> 
> yes. But it is not supported today. Correct ? 

Not correct, it has been working for years, and works in v5.0-rc1 (I
just tested it), at both L0 and L1.

> > We need an explicit capability for XIVE exploitation that can be
> > enabled or disabled on the qemu command line, so that we can enforce a
> > uniform set of capabilities across all the hosts in a migration
> > domain.  And it's no good to say we have the capability when all
> > attempts to use it will fail.  Therefore the kernel needs to say that
> > it doesn't have the capability in a PR KVM guest or in a nested HV
> > guest.
> 
> OK. I will work on adding a KVM_CAP_PPC_NESTED_IRQ_HV capability 
> for future use.

That's not what I meant.  Why do we need that?  I meant that querying
the new KVM_CAP_PPC_IRQ_XIVE capability should return 0 if we are in a
guest.  It should only return 1 if we are running bare-metal on a P9.

> >>> However, we could be using PR KVM (either in a bare-metal host or in a
> >>> guest), or we could be doing nested HV KVM where we are using the
> >>> kvm_hv module inside a KVM guest and using special hypercalls for
> >>> controlling our guests.
> >>
> >> Yes. 
> >>
> >> It would be good to talk a little about the nested support (offline 
> >> may be) to make sure that we are not missing some major interface that 
> >> would require a lot of change. If we need to prepare ground, I think
> >> the timing is good.
> >>
> >> The size of the IRQ number space might be a problem. It seems we 
> >> would need to increase it considerably to support multiple nested 
> >> guests. That said I haven't look much how nested is designed.  
> > 
> > The current design of nested HV is that the entire non-volatile state
> > of all the nested guests is encapsulated within the state and
> > resources of the L1 hypervisor.  That means that if the L1 hypervisor
> > gets migrated, all of its guests go across inside it and there is no
> > extra state that L0 needs to be aware of.  That would imply that the
> > VP number space for the nested guests would need to come from within
> > the VP number space for L1; but the amount of VP space we allocate to
> > each guest doesn't seem to be large enough for that to be practical.
> 
> If the KVM XIVE device had some information on the max number of CPUs 
> provisioned for the guest, we could optimize the VP allocation.

The problem is that we might have 1000 guests running under L0, or we
might have 1 guest running under L0 and 1000 guests running under it,
and we have no way to know which situation to optimize for at the
point where an L1 guest starts.  If we had an enormous VP space then
we could just give each L1 guest a large amount of VP space and solve
it that way; but we don't.

Paul.
