Return-Path: <SRS0=6cb3=P7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9F2C282C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 16:58:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BCC321726
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 16:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BCC321726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43lBLM2Xk9zDqLG
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 03:58:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.40.148; helo=5.mo173.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 5.mo173.mail-out.ovh.net (5.mo173.mail-out.ovh.net
 [46.105.40.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43lBJl6q5xzDq8x
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2019 03:56:38 +1100 (AEDT)
Received: from player691.ha.ovh.net (unknown [10.109.143.183])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id A8CF6EAC03
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 17:56:34 +0100 (CET)
Received: from kaod.org (lfbn-1-10603-25.w90-89.abo.wanadoo.fr [90.89.194.25])
 (Authenticated sender: clg@kaod.org)
 by player691.ha.ovh.net (Postfix) with ESMTPSA id 8CB2820DDC84;
 Wed, 23 Jan 2019 16:56:26 +0000 (UTC)
Subject: Re: [PATCH 08/19] KVM: PPC: Book3S HV: add a VC_BASE control to the
 XIVE native device
To: Paul Mackerras <paulus@ozlabs.org>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-9-clg@kaod.org> <20190122051430.GE15124@blackberry>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <8c45581e-466e-a390-e9cd-a06b5939d2af@kaod.org>
Date: Wed, 23 Jan 2019 17:56:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190122051430.GE15124@blackberry>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11295590818108115847
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledriedtgdeliecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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

On 1/22/19 6:14 AM, Paul Mackerras wrote:
> On Mon, Jan 07, 2019 at 07:43:20PM +0100, Cédric Le Goater wrote:
>> The ESB MMIO region controls the interrupt sources of the guest. QEMU
>> will query an fd (GET_ESB_FD ioctl) and map this region at a specific
>> address for the guest to use. The guest will obtain this information
>> using the H_INT_GET_SOURCE_INFO hcall. To inform KVM of the address
>> setting used by QEMU, add a VC_BASE control to the KVM XIVE device
> 
> This needs a little more explanation.  I *think* the only way this
> gets used is that it gets returned to the guest by the new
> hypercalls.  If that is indeed the case it would be useful to mention
> that in the patch description, because otherwise taking a value that
> userspace provides and which looks like it is an address, and not
> doing any validation on it, looks a bit scary.

I think we have solved this problem in another email thread. 

The H_INT_GET_SOURCE_INFO hcall does not need to be implemented in KVM
as all the source information should already be available in QEMU. In
that case, there is no need to inform KVM of where the ESB pages are 
mapped in the guest address space. So we don't need that extra control
on the KVM device. This is good news. 

Thanks,

C. 



