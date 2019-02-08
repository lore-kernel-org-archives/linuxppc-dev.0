Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C445C169C4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 07:48:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1BCB21917
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 07:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1BCB21917
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wnNq2p2qzDqJR
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 18:48:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.39.154; helo=5.mo177.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 501 seconds by postgrey-1.36 at bilbo;
 Fri, 08 Feb 2019 18:46:57 AEDT
Received: from 5.mo177.mail-out.ovh.net (5.mo177.mail-out.ovh.net
 [46.105.39.154])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wnM52Qz8zDqW0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 18:46:55 +1100 (AEDT)
Received: from player699.ha.ovh.net (unknown [10.109.146.86])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id C0F10E298E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 08:38:31 +0100 (CET)
Received: from kaod.org (lfbn-1-10603-25.w90-89.abo.wanadoo.fr [90.89.194.25])
 (Authenticated sender: clg@kaod.org)
 by player699.ha.ovh.net (Postfix) with ESMTPSA id D296727DBA5C;
 Fri,  8 Feb 2019 07:38:23 +0000 (UTC)
Subject: Re: [PATCH 00/19] KVM: PPC: Book3S HV: add XIVE native exploitation
 mode
To: David Gibson <david@gibson.dropbear.id.au>
References: <2f9b4420-ef90-20b8-d31b-dc547a6aa6b4@kaod.org>
 <a420acfb9f375b27bc1203fbb15312a61eb0c34d.camel@kernel.crashing.org>
 <06b7c4d2-72ba-ca4f-aded-789280798136@kaod.org>
 <20190204053610.GK1927@umbus.fritz.box>
 <dc59257b-c780-7b81-f3d8-46269b834c2d@kaod.org>
 <20190205221315.GB29038@blackberry> <20190206011800.GN22661@umbus.fritz.box>
 <bf3725b6-9881-74a0-ec4f-43ac409cb496@kaod.org>
 <20190207025111.GB22661@umbus.fritz.box>
 <2d623da8-31e4-bdc9-c5e4-ea3689a795dd@kaod.org>
 <20190208050747.GC2688@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f4ec3082-2da7-aa36-678f-fec53e4496ac@kaod.org>
Date: Fri, 8 Feb 2019 08:38:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190208050747.GC2688@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 3600346430306225031
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrledugddutdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
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

>> With the dual mode, the interrupt mode 
>> is negotiated at CAS time and when merged, the KVM device will be created 
>> at reset. In case of failure, QEMU will abort. 
>>
>> I am not saying it is not possible but we will need some internal 
>> infrastructure to handle dynamically the fall back to userspace
>> emulation.
> 
> Uh.. we do?  I think in all cases we need to make the XICS vs. XIVE
> decision first (i.e. what we present to the guest), then we should
> decide how to implement it (userspace, KVM accelerated, impossible and
> give up).

I am changing things with the addition of KM support for dual mode but 
that might not be the right approach. Let's talk over it when you reach 
the end of the QEMU patchset.

I will keep in mind that we should know exactly what KVM supports
before the machine starts. That is : not to abort QEMU if we can not 
satisfy the interrupt mode chosen at CAS time. It might be possible
to fallback to XIVE emulated mode, I think that is where the problem
is but I haven't looked at it closely.

C.  

