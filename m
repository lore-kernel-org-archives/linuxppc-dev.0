Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37506C282C4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 15:38:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E38B20823
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 15:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E38B20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tX0g1fd9zDqL2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 02:38:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.34.195; helo=11.mo4.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 15430 seconds by postgrey-1.36 at bilbo;
 Tue, 05 Feb 2019 02:36:33 AEDT
Received: from 11.mo4.mail-out.ovh.net (11.mo4.mail-out.ovh.net
 [46.105.34.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tWyn5rKszDqHJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 02:36:32 +1100 (AEDT)
Received: from player168.ha.ovh.net (unknown [10.109.143.208])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id DD2B61D482A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2019 16:36:28 +0100 (CET)
Received: from kaod.org (lfbn-1-10603-25.w90-89.abo.wanadoo.fr [90.89.194.25])
 (Authenticated sender: clg@kaod.org)
 by player168.ha.ovh.net (Postfix) with ESMTPSA id 225D7241C963;
 Mon,  4 Feb 2019 15:36:17 +0000 (UTC)
Subject: Re: [PATCH 08/19] KVM: PPC: Book3S HV: add a VC_BASE control to the
 XIVE native device
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-9-clg@kaod.org> <20190122051430.GE15124@blackberry>
 <8c45581e-466e-a390-e9cd-a06b5939d2af@kaod.org>
 <20190204044933.GC1927@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <04d4acf7-978f-fb40-a64b-b6df3ecc8a5e@kaod.org>
Date: Mon, 4 Feb 2019 16:36:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204044933.GC1927@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6627891280804547463
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrkeeggdejlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2/4/19 5:49 AM, David Gibson wrote:
> On Wed, Jan 23, 2019 at 05:56:26PM +0100, Cédric Le Goater wrote:
>> On 1/22/19 6:14 AM, Paul Mackerras wrote:
>>> On Mon, Jan 07, 2019 at 07:43:20PM +0100, Cédric Le Goater wrote:
>>>> The ESB MMIO region controls the interrupt sources of the guest. QEMU
>>>> will query an fd (GET_ESB_FD ioctl) and map this region at a specific
>>>> address for the guest to use. The guest will obtain this information
>>>> using the H_INT_GET_SOURCE_INFO hcall. To inform KVM of the address
>>>> setting used by QEMU, add a VC_BASE control to the KVM XIVE device
>>>
>>> This needs a little more explanation.  I *think* the only way this
>>> gets used is that it gets returned to the guest by the new
>>> hypercalls.  If that is indeed the case it would be useful to mention
>>> that in the patch description, because otherwise taking a value that
>>> userspace provides and which looks like it is an address, and not
>>> doing any validation on it, looks a bit scary.
>>
>> I think we have solved this problem in another email thread. 
>>
>> The H_INT_GET_SOURCE_INFO hcall does not need to be implemented in KVM
>> as all the source information should already be available in QEMU. In
>> that case, there is no need to inform KVM of where the ESB pages are 
>> mapped in the guest address space. So we don't need that extra control
>> on the KVM device. This is good news.
> 
> Ah, good to hear.  I thought this looked strange.

yes. I didn't know which path to choose between HV real mode, HV, QEMU. 
It's clarified now. 

But now, we have nested, and this is adding quite a bit of strangeness 
to the hcall possibilities.

C.  
