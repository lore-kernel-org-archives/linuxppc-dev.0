Return-Path: <SRS0=r5zj=QF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEEFC169C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 14:29:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EF8B20989
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 14:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EF8B20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ppmc1LVWzDqHJ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 01:29:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.56.136; helo=1.mo6.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 2465 seconds by postgrey-1.36 at bilbo;
 Wed, 30 Jan 2019 01:28:22 AEDT
Received: from 1.mo6.mail-out.ovh.net (1.mo6.mail-out.ovh.net [46.105.56.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ppkt2pM1zDqHJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 01:28:21 +1100 (AEDT)
Received: from player687.ha.ovh.net (unknown [10.109.146.137])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 573A31A6C33
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 14:51:14 +0100 (CET)
Received: from kaod.org (gbibp9ph1--yellowicen11.emea.ibm.com [195.212.29.58])
 (Authenticated sender: clg@kaod.org)
 by player687.ha.ovh.net (Postfix) with ESMTPSA id DDC7821D42AE;
 Tue, 29 Jan 2019 13:51:05 +0000 (UTC)
Subject: Re: [PATCH 00/19] KVM: PPC: Book3S HV: add XIVE native exploitation
 mode
To: Paul Mackerras <paulus@ozlabs.org>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190122044654.GA15124@blackberry>
 <2f9b4420-ef90-20b8-d31b-dc547a6aa6b4@kaod.org>
 <20190128055108.GC3237@blackberry>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f2e9a801-d0a9-bf29-7b3e-29269021ecb4@kaod.org>
Date: Tue, 29 Jan 2019 14:51:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190128055108.GC3237@blackberry>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 6508264413267528583
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrjedvgdehjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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

>>> Another general comment is that you seem to have written all this
>>> code assuming we are using HV KVM in a host running bare-metal.
>>
>> Yes. I didn't look at the other configurations. I thought that we could
>> use the kernel_irqchip=off option to begin with. A couple of checks
>> are indeed missing.
> 
> Using kernel_irqchip=off would mean that we would not be able to use
> the in-kernel XICS emulation, which would have a performance impact.

yes. But it is not supported today. Correct ? 

> We need an explicit capability for XIVE exploitation that can be
> enabled or disabled on the qemu command line, so that we can enforce a
> uniform set of capabilities across all the hosts in a migration
> domain.  And it's no good to say we have the capability when all
> attempts to use it will fail.  Therefore the kernel needs to say that
> it doesn't have the capability in a PR KVM guest or in a nested HV
> guest.

OK. I will work on adding a KVM_CAP_PPC_NESTED_IRQ_HV capability 
for future use.

>>> However, we could be using PR KVM (either in a bare-metal host or in a
>>> guest), or we could be doing nested HV KVM where we are using the
>>> kvm_hv module inside a KVM guest and using special hypercalls for
>>> controlling our guests.
>>
>> Yes. 
>>
>> It would be good to talk a little about the nested support (offline 
>> may be) to make sure that we are not missing some major interface that 
>> would require a lot of change. If we need to prepare ground, I think
>> the timing is good.
>>
>> The size of the IRQ number space might be a problem. It seems we 
>> would need to increase it considerably to support multiple nested 
>> guests. That said I haven't look much how nested is designed.  
> 
> The current design of nested HV is that the entire non-volatile state
> of all the nested guests is encapsulated within the state and
> resources of the L1 hypervisor.  That means that if the L1 hypervisor
> gets migrated, all of its guests go across inside it and there is no
> extra state that L0 needs to be aware of.  That would imply that the
> VP number space for the nested guests would need to come from within
> the VP number space for L1; but the amount of VP space we allocate to
> each guest doesn't seem to be large enough for that to be practical.

If the KVM XIVE device had some information on the max number of CPUs 
provisioned for the guest, we could optimize the VP allocation.

That might be a larger KVM topic though. There are some static limits 
on the number of CPUs in QEMU and in KVM, which have no relation AFAICT. 

Thanks,

C.
