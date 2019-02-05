Return-Path: <SRS0=EZew=QM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0ADDC282CB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 11:34:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 417D520821
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 11:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 417D520821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43v2Y41zJ7zDqLb
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 22:34:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=178.32.125.228; helo=12.mo6.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 70702 seconds by postgrey-1.36 at bilbo;
 Tue, 05 Feb 2019 22:31:44 AEDT
Received: from 12.mo6.mail-out.ovh.net (12.mo6.mail-out.ovh.net
 [178.32.125.228])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43v2Tr71GwzDqJ8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 22:31:42 +1100 (AEDT)
Received: from player787.ha.ovh.net (unknown [10.109.160.93])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id EE9E11AD5E8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 12:31:38 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n0.emea.ibm.com [195.212.29.162])
 (Authenticated sender: clg@kaod.org)
 by player787.ha.ovh.net (Postfix) with ESMTPSA id A6B992798E0B;
 Tue,  5 Feb 2019 11:31:29 +0000 (UTC)
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Subject: Re: [PATCH 00/19] KVM: PPC: Book3S HV: add XIVE native exploitation
 mode
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190122044654.GA15124@blackberry>
 <2f9b4420-ef90-20b8-d31b-dc547a6aa6b4@kaod.org>
 <a420acfb9f375b27bc1203fbb15312a61eb0c34d.camel@kernel.crashing.org>
 <06b7c4d2-72ba-ca4f-aded-789280798136@kaod.org>
 <20190204053610.GK1927@umbus.fritz.box>
Message-ID: <dc59257b-c780-7b81-f3d8-46269b834c2d@kaod.org>
Date: Tue, 5 Feb 2019 12:31:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204053610.GK1927@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 8365999261958310791
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrkeeigddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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

>>> As for nesting, I suggest for the foreseeable future we stick to XICS
>>> emulation in nested guests.
>>
>> ok. so no kernel_irqchip at all. hmm. 

I was confused with what Paul calls 'XICS emulation'. It's not the QEMU
XICS emulated device but the XICS-over-XIVE KVM device, the KVM XICS 
device KVM uses when under a P9 processor. 

> That would certainly be step 0, making sure the capability advertises
> this correctly.  I think we do want to make XICs-on-XIVE emulation
> work in a KVM L1 (so we'd need to have it make XIVE hcalls to the L0
> instead of OPAL calls).

With the latest patch of Paul, the KVM XICS device is available for L2
and it works quite well. 

I also want to test it when L1 runs in KVM XIVE native mode, with the 
current patchset, to see how it behaves.

> XIVE-on-XIVE for L1 would be nice too, which would mean implementing
> the XIVE hcalls from the L2 in terms of XIVE hcalls to the L0.  I
> think it's ok to delay this indefinitely as long as the caps advertise
> correctly so that qemu will use userspace emulation until its ready.

ok. I need to fix this in the current patchset.

Thanks,

C. 

