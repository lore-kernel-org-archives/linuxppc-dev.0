Return-Path: <SRS0=q2Dt=QN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DE4C169C4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 07:37:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E391F218A1
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 07:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E391F218A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43vYDh5TJnzDqPy
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 18:37:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.58.226; helo=3.mo2.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 3.mo2.mail-out.ovh.net (3.mo2.mail-out.ovh.net [46.105.58.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43vYC11KqczDqPH
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Feb 2019 18:35:39 +1100 (AEDT)
Received: from player711.ha.ovh.net (unknown [10.109.146.82])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 0DDD317E1DE
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Feb 2019 08:35:35 +0100 (CET)
Received: from kaod.org (lfbn-1-10603-25.w90-89.abo.wanadoo.fr [90.89.194.25])
 (Authenticated sender: clg@kaod.org)
 by player711.ha.ovh.net (Postfix) with ESMTPSA id 7BF71258EF4D;
 Wed,  6 Feb 2019 07:35:24 +0000 (UTC)
Subject: Re: [PATCH 00/19] KVM: PPC: Book3S HV: add XIVE native exploitation
 mode
To: David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@ozlabs.org>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190122044654.GA15124@blackberry>
 <2f9b4420-ef90-20b8-d31b-dc547a6aa6b4@kaod.org>
 <a420acfb9f375b27bc1203fbb15312a61eb0c34d.camel@kernel.crashing.org>
 <06b7c4d2-72ba-ca4f-aded-789280798136@kaod.org>
 <20190204053610.GK1927@umbus.fritz.box>
 <dc59257b-c780-7b81-f3d8-46269b834c2d@kaod.org>
 <20190205221315.GB29038@blackberry> <20190206011800.GN22661@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <bf3725b6-9881-74a0-ec4f-43ac409cb496@kaod.org>
Date: Wed, 6 Feb 2019 08:35:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190206011800.GN22661@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10251881604617046919
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrkeejgdduuddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
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
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2/6/19 2:18 AM, David Gibson wrote:
> On Wed, Feb 06, 2019 at 09:13:15AM +1100, Paul Mackerras wrote:
>> On Tue, Feb 05, 2019 at 12:31:28PM +0100, Cédric Le Goater wrote:
>>>>>> As for nesting, I suggest for the foreseeable future we stick to XICS
>>>>>> emulation in nested guests.
>>>>>
>>>>> ok. so no kernel_irqchip at all. hmm. 
>>>
>>> I was confused with what Paul calls 'XICS emulation'. It's not the QEMU
>>> XICS emulated device but the XICS-over-XIVE KVM device, the KVM XICS 
>>> device KVM uses when under a P9 processor. 
>>
>> Actually there are two separate implementations of XICS emulation in
>> KVM.  The first (older) one is almost entirely a software emulation
>> but does have some cases where it accesses an underlying XICS device
>> in order to make some things faster (IPIs and pass-through of a device
>> interrupt to a guest).  The other, newer one is the XICS-on-XIVE
>> emulation that Ben wrote, which uses the XIVE hardware pretty heavily.
>> My patch was about making the the older code work when there is no
>> XICS available to the host.
> 
> Ah, right.  To clarify my earlier statements in light of this:
> 
>  * We definitely want some sort of kernel-XICS available in a nested
>    guest.  AIUI, this is now accomplished, so, Yay!
> 
>  * Implementing the L2 XICS in terms of L1's PAPR-XIVE would be a
>    bonus, but it's a much lower priority.

Yes. In this case, the L1 KVM-HV should not advertise KVM_CAP_PPC_IRQ_XIVE
to QEMU which will restrict CAS to the XICS only interrupt mode.

C.


