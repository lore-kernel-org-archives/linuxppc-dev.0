Return-Path: <SRS0=D1of=QG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23A2C282D4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 06:27:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A72D20863
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 06:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="Y4gLih/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A72D20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qD1Y2DhWzDqTG
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 17:27:29 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qCsn1hTMzDqKs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 17:20:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="Y4gLih/y"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 43qCsm72Fnz9sBn; Wed, 30 Jan 2019 17:20:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1548829244; bh=jrarVp/BZh8voZ+lzHDdowvtJzKFRop93AUeKa5SPhY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Y4gLih/yfsx9naVnsLrg1LVaqktIu7ucj95+z6YQLwdIQJWrP+d7cvRiUvljALEgO
 8jHe5n3cPTnaf/4amBcDjnGG+G3ZQy5kKvE6fazfDTdwUzqS0G3kSyhWues6tCXhS1
 RtB6+zXGSlzIOHDk1LtmiXAV96su1ob+/F8Gu1qMcHdfDFwKhRcd0XhXrbLq6IVwj/
 ZBHNLXDQhLmNRHq83p12yBr4Z4uvbiJBRC6F0Mv1gQlt5AOtJxMflDFJkM7KXS8r4t
 yNj8hv24wFkbTwK6jqI35dLwOTaKDzxWevlCDNBxC5podx7bhgkOc2kLANl9fLmgfr
 cmFc4lFZyu8jg==
Date: Wed, 30 Jan 2019 15:29:19 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 05/19] KVM: PPC: Book3S HV: add a new KVM device for the
 XIVE native exploitation mode
Message-ID: <20190130042919.GA27109@blackberry>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-6-clg@kaod.org>
 <20190122050520.GC15124@blackberry>
 <d21664e5-1d9c-5a55-5b83-bf5e6247917a@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d21664e5-1d9c-5a55-5b83-bf5e6247917a@kaod.org>
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

On Mon, Jan 28, 2019 at 06:35:34PM +0100, Cédric Le Goater wrote:
> On 1/22/19 6:05 AM, Paul Mackerras wrote:
> > On Mon, Jan 07, 2019 at 07:43:17PM +0100, Cédric Le Goater wrote:
> >> This is the basic framework for the new KVM device supporting the XIVE
> >> native exploitation mode. The user interface exposes a new capability
> >> and a new KVM device to be used by QEMU.
> > 
> > [snip]
> >> @@ -1039,7 +1039,10 @@ static int kvmppc_book3s_init(void)
> >>  #ifdef CONFIG_KVM_XIVE
> >>  	if (xive_enabled()) {
> >>  		kvmppc_xive_init_module();
> >> +		kvmppc_xive_native_init_module();
> >>  		kvm_register_device_ops(&kvm_xive_ops, KVM_DEV_TYPE_XICS);
> >> +		kvm_register_device_ops(&kvm_xive_native_ops,
> >> +					KVM_DEV_TYPE_XIVE);
> > 
> > I think we want tighter conditions on initializing the xive_native
> > stuff and creating the xive device class.  We could have
> > xive_enabled() returning true in a guest, and this code will get
> > called both by PR KVM and HV KVM (and HV KVM no longer implies that we
> > are running bare metal).
> 
> So yes, I gave nested a try with kernel_irqchip=on and the nested hypervisor 
> (L1) obviously crashes trying to call OPAL. I have tighten the test with : 
> 
> 	if (xive_enabled() && !kvmhv_on_pseries()) {
> 
> for now.
> 
> As this is a problem today in 5.0.x, I will send a patch for it if you think

How do you mean this is a problem today in 5.0?  I just tried 5.0-rc1
with kernel_irqchip=on in a nested guest and it works just fine.  What
exactly did you test?

> it is correct. I don't think we should bother taking care of the PR case
> on P9. Should we ? 

We do need to take care of PR KVM on P9, since it is the only form of
nested KVM that works inside a host in HPT mode.

Paul.
