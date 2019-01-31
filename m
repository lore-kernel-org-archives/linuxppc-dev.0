Return-Path: <SRS0=ULCe=QH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD27BC282D8
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 03:04:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A16F2184D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 03:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="cKVL5p30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A16F2184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qlTF1tVzzDqVb
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 14:04:49 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qlPK12BCzDqRS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 14:01:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="cKVL5p30"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 43qlPJ52lKz9s9G; Thu, 31 Jan 2019 14:01:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1548903684; bh=CiEa7/ispOH3TP+2ICZWifKUsD/VmMIOhlRYzRKj14g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cKVL5p304rFqZ24DvDzTJhR21VKjctaIY0phLTQWRE0qiX8TbT7lUrIarGQYyX7IC
 bZcJLso4N4s9YtWRa4bPo1XbX9+iN45M74zdp6Goxypemc9PsPuCPh/Y00UPySlgXf
 7WfZCh+DPRfh29rzWSen7d7TCX2Wyf5KXkNppnw3eJqDWlTZR4A3yyck9+dBKJ0h/6
 xuHEd8NQg//LxrSb6c6KNxo1am7PL1TANUKHga0DkXsFhVFugcdMjFpLVhwO1P0rHy
 6us9GV4RxafG0YUK9kYJOys618eHxvgB4z0w9uI8+hpvWq8O1uCp+3x3XkT57V4SVC
 oxCHqELT2xekA==
Date: Thu, 31 Jan 2019 14:01:20 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 05/19] KVM: PPC: Book3S HV: add a new KVM device for the
 XIVE native exploitation mode
Message-ID: <20190131030120.GB4675@blackberry>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-6-clg@kaod.org>
 <20190122050520.GC15124@blackberry>
 <d21664e5-1d9c-5a55-5b83-bf5e6247917a@kaod.org>
 <20190130042919.GA27109@blackberry>
 <74d4fe26-9e5a-a72e-815a-223a55f1bc0f@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74d4fe26-9e5a-a72e-815a-223a55f1bc0f@kaod.org>
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

On Wed, Jan 30, 2019 at 08:01:22AM +0100, Cédric Le Goater wrote:
> On 1/30/19 5:29 AM, Paul Mackerras wrote:
> > On Mon, Jan 28, 2019 at 06:35:34PM +0100, Cédric Le Goater wrote:
> >> On 1/22/19 6:05 AM, Paul Mackerras wrote:
> >>> On Mon, Jan 07, 2019 at 07:43:17PM +0100, Cédric Le Goater wrote:
> >>>> This is the basic framework for the new KVM device supporting the XIVE
> >>>> native exploitation mode. The user interface exposes a new capability
> >>>> and a new KVM device to be used by QEMU.
> >>>
> >>> [snip]
> >>>> @@ -1039,7 +1039,10 @@ static int kvmppc_book3s_init(void)
> >>>>  #ifdef CONFIG_KVM_XIVE
> >>>>  	if (xive_enabled()) {
> >>>>  		kvmppc_xive_init_module();
> >>>> +		kvmppc_xive_native_init_module();
> >>>>  		kvm_register_device_ops(&kvm_xive_ops, KVM_DEV_TYPE_XICS);
> >>>> +		kvm_register_device_ops(&kvm_xive_native_ops,
> >>>> +					KVM_DEV_TYPE_XIVE);
> >>>
> >>> I think we want tighter conditions on initializing the xive_native
> >>> stuff and creating the xive device class.  We could have
> >>> xive_enabled() returning true in a guest, and this code will get
> >>> called both by PR KVM and HV KVM (and HV KVM no longer implies that we
> >>> are running bare metal).
> >>
> >> So yes, I gave nested a try with kernel_irqchip=on and the nested hypervisor 
> >> (L1) obviously crashes trying to call OPAL. I have tighten the test with : 
> >>
> >> 	if (xive_enabled() && !kvmhv_on_pseries()) {
> >>
> >> for now.
> >>
> >> As this is a problem today in 5.0.x, I will send a patch for it if you think
> > 
> > How do you mean this is a problem today in 5.0?  I just tried 5.0-rc1
> > with kernel_irqchip=on in a nested guest and it works just fine.  What
> > exactly did you test?
> 
> L0: Linux 5.0.0-rc3 (+ KVM HV)
> L1:     QEMU pseries-4.0 (kernel_irqchip=on) - Linux 5.0.0-rc3 (+ KVM HV)
> L2:          QEMU pseries-4.0 (kernel_irqchip=on) - Linux 5.0.0-rc3
> 
> L1 crashes when L2 starts and tries to initialize the KVM IRQ device as 
> it does an OPAL call and its running under SLOF. See below.

OK, you must have a QEMU that advertises XIVE to the guest (L1).  In
that case I can see that L1 would try to do XICS-on-XIVE, which won't
work.  We need to fix that.  Unfortunately the XICS-on-XICS emulation
won't work as is in L1 either, but I think we can fix that by
disabling the real-mode XICS hcall handling.

> I don't understand how L2 can work with kernel_irqchip=on. Could you
> please explain ? 

If QEMU decides to advertise XIVE to the L2 guest and the L2 guest can
do XIVE, then the only possibility is to use the XIVE software
emulation in QEMU, and if kernel_irqchip=on has been specified
explicitly, maybe QEMU decides to terminate the guest rather than
implicitly turning off kernel_irqchip.

If QEMU decides not to advertise XIVE to the L2 guest, or the L2 guest
can't do XIVE, then we could use the XICS-on-XICS emulation in L1 as
long as either (a) L1 is not using XIVE, or (b) we modify the
XICS-on-XICS code to avoid using any XICS or XIVE access (i.e. just
using calls to generic kernel facilities).

Ultimately, if the spapr xive backend code in the kernel could be
extended to provide all the low-level functions that the XICS-on-XIVE
code needs, then we could do XICS-on-XIVE in a guest.

Paul.
