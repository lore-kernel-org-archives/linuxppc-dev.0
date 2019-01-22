Return-Path: <SRS0=/GF9=P6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AEAC282C3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 04:48:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9BFC20861
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 04:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="kMtaip4L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9BFC20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43kGCH54vdzDqN0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 15:48:43 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43kG9P11D7zDqMW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2019 15:47:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="kMtaip4L"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 43kG9N5rjNz9s7h; Tue, 22 Jan 2019 15:47:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1548132424; bh=u2CFoOD8bqIGSv6F2J8T5tqEITC+0JWEpRQmH+GjGLg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kMtaip4LzNEl7zb12QUPkR/KadBf6kXtK9kuWAYqR82r5bSB1gpn013fI1YgFJz06
 5pxPBARqluCm2zRGaNspu20dkKAZHv+WE//lf4Yljjzq2GGZMccOZEPLfpTvE0mxEG
 58NGxzYW8Lj6q+jZQORyy7tBh1PF1/eGeSIVtMPoSyZ4wUX9GoPcbOzQcxJHfb/Amu
 b2x7IOCZcgey4wMVUYh13XZH8ylLyjjDRbGnzdTd35Ho4xNDmX1XI7flUDQ9KuHAM6
 VN/7Uu0fFUoM1D7n0gROBcWs01BRAP20TQGeVUjpZw9Wy/HbYj2kpPRaGCMzLF9DMG
 wcbTEoWYFvFYg==
Date: Tue, 22 Jan 2019 15:46:54 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 00/19] KVM: PPC: Book3S HV: add XIVE native exploitation
 mode
Message-ID: <20190122044654.GA15124@blackberry>
References: <20190107184331.8429-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190107184331.8429-1-clg@kaod.org>
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

On Mon, Jan 07, 2019 at 07:43:12PM +0100, Cédric Le Goater wrote:
> Hello,
> 
> On the POWER9 processor, the XIVE interrupt controller can control
> interrupt sources using MMIO to trigger events, to EOI or to turn off
> the sources. Priority management and interrupt acknowledgment is also
> controlled by MMIO in the CPU presenter subengine.
> 
> PowerNV/baremetal Linux runs natively under XIVE but sPAPR guests need
> special support from the hypervisor to do the same. This is called the
> XIVE native exploitation mode and today, it can be activated under the
> PowerPC Hypervisor, pHyp. However, Linux/KVM lacks XIVE native support
> and still offers the old interrupt mode interface using a
> XICS-over-XIVE glue which implements the XICS hcalls.
> 
> The following series is proposal to add the same support under KVM.
> 
> A new KVM device is introduced for the XIVE native exploitation
> mode. It reuses most of the XICS-over-XIVE glue implementation
> structures which are internal to KVM but has a completely different
> interface. A set of Hypervisor calls configures the sources and the
> event queues and from there, all control is done by the guest through
> MMIOs.
> 
> These MMIO regions (ESB and TIMA) are exposed to guests in QEMU,
> similarly to VFIO, and the associated VMAs are populated dynamically
> with the appropriate pages using a fault handler. This is implemented
> with a couple of KVM device ioctls.
> 
> On a POWER9 sPAPR machine, the Client Architecture Support (CAS)
> negotiation process determines whether the guest operates with a
> interrupt controller using the XICS legacy model, as found on POWER8,
> or in XIVE exploitation mode. Which means that the KVM interrupt
> device should be created at runtime, after the machine as started.
> This requires extra KVM support to create/destroy KVM devices. The
> last patches are an attempt to solve that problem.
> 
> Migration has its own specific needs. The patchset provides the
> necessary routines to quiesce XIVE, to capture and restore the state
> of the different structures used by KVM, OPAL and HW. Extra OPAL
> support is required for these.

Thanks for the patchset.  It mostly looks good, but there are some
more things we need to consider, and I think a v2 will be needed.

One general comment I have is that there are a lot of acronyms in this
code and you mostly seem to assume that people will know what they all
mean.  It would make the code more readable if you provide the
expansion of the acronym on first use in a comment or whatever.  For
example, one of the patches in this series talks about the "EAS"
without ever expanding it in any comment or in the patch description,
and I have forgotten just at the moment what EAS stands for (I just
know that understanding the XIVE is not eas-y. :)

Another general comment is that you seem to have written all this
code assuming we are using HV KVM in a host running bare-metal.
However, we could be using PR KVM (either in a bare-metal host or in a
guest), or we could be doing nested HV KVM where we are using the
kvm_hv module inside a KVM guest and using special hypercalls for
controlling our guests.

It would be perfectly acceptable for now to say that we don't yet
support XIVE exploitation in those scenarios, as long as we then make
sure that the new KVM capability reports false in those scenarios, and
any attempt to use the XIVE exploitation interfaces fails cleanly.
I don't see that either of those is true in the patch set as it
stands, so that is one area that needs to be fixed.

A third general comment is that the new KVM interfaces you have added
need to be documented in the files under Documentation/virtual/kvm.

Paul.
