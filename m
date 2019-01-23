Return-Path: <SRS0=6cb3=P7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D87C282C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 18:48:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1596A21855
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 18:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1596A21855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43lDp76hDBzDqCK
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 05:48:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=178.33.251.8; helo=13.mo4.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 13.mo4.mail-out.ovh.net (13.mo4.mail-out.ovh.net [178.33.251.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43lDmC5Vh7zDqCG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2019 05:47:06 +1100 (AEDT)
Received: from player691.ha.ovh.net (unknown [10.109.159.152])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 9A6BA1CC2A9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 19:40:04 +0100 (CET)
Received: from kaod.org (lfbn-1-10603-25.w90-89.abo.wanadoo.fr [90.89.194.25])
 (Authenticated sender: clg@kaod.org)
 by player691.ha.ovh.net (Postfix) with ESMTPSA id 3E85620E9CCA;
 Wed, 23 Jan 2019 18:39:56 +0000 (UTC)
Subject: Re: [PATCH 19/19] KVM: introduce a KVM_DELETE_DEVICE ioctl
To: Paul Mackerras <paulus@ozlabs.org>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107191006.10648-1-clg@kaod.org> <20190107191006.10648-3-clg@kaod.org>
 <20190122054253.GH15124@blackberry>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <57f8817f-ecef-8bae-189a-8975870411df@kaod.org>
Date: Wed, 23 Jan 2019 19:39:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190122054253.GH15124@blackberry>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13043550421226130311
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledriedtgdduudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
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

On 1/22/19 6:42 AM, Paul Mackerras wrote:
> On Mon, Jan 07, 2019 at 08:10:06PM +0100, Cédric Le Goater wrote:
>> This will be used to destroy the KVM XICS or XIVE device when the
>> sPAPR machine is reseted. When the VM boots, the CAS negotiation
>> process will determine which interrupt mode to use and the appropriate
>> KVM device will then be created.
> 
> What would be the consequence if we didn't destroy the device?

So, if we don't destroy the device, it would mean that we are 
maintaining its availability under the KVM PPC structures, VM and
vCPUs, I think the changes would be significant to have two interrupt 
devices unde the VM. We would also need a way to activate one or 
the other depending on the interrupt mode chosen by CAS. In other 
words, it's moving all the interrupt mode politics from QEMU to KVM. 
It's possible of course but I would prefer to leave the ugly details 
in QEMU.  

Let's suppose now that we keep the device alive but disconnect the 
presenters from it, and from the VM also. We would have an unused 
device in the VM. We would need way to keep an handle on it (fd 
certainly) and a KVM interface to soft reset a KVM device partially 
initialized. That's one other option.

It seemed easier to do an hard reset : create/destroy.  

> The reason I ask is that we will have to be much more careful about
> memory allocation lifetimes with this patch. 

yes. bad refcounting will lead the host kernel to a crash. 

> Having KVM devices last
> until the KVM instance is destroyed means that we generally avoid
> use-after-free bugs.  With this patch we will have to do a careful
> analysis of the lifetime of the xive structures vs. possible accesses
> on other threads to prove there are no use-after-free bugs.
> 
> For example, it is not sufficient to set any pointers in struct kvm or
> struct kvm_vcpu that point into xive structures to NULL before freeing
> the structures.  There could be code on another CPU that has read the
> pointer value before you set it to NULL and then goes and accesses it
> after you have freed it.  You need to prove that can't happen,
> possibly using some sort of explicit synchronization that ensures that
> no other CPU could still be accessing the structure at the time when
> you free it.  RCU can help with this, but in general means you need
> RCU synchronization primitives (rcu_read_lock() etc.) at all the
> places where you use the pointer, which I don't think you currently
> have.

no. indeed. I have overlooked the synchronization aspect.

> If there is a good fundamental reason why this can't happen, even
> though you don't have explicit synchronization, then at a minimum you
> need to explain that in the patch description, and ideally also in
> code comments.

OK. I did leave that patch at the end for one reason. It needs more care.

Thanks,

C.
 

