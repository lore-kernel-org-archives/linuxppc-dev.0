Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2ACC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 09:30:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 039C520833
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 09:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 039C520833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dhpx4gGlzDqJ5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 19:30:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=87.98.172.75; helo=4.mo2.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 4.mo2.mail-out.ovh.net (4.mo2.mail-out.ovh.net [87.98.172.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dhmS4sNLzDq77
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 19:28:21 +1000 (AEST)
Received: from player731.ha.ovh.net (unknown [10.109.143.208])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id DE37518298B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 11:18:15 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-40-22.w86-201.abo.wanadoo.fr
 [86.201.133.22]) (Authenticated sender: clg@kaod.org)
 by player731.ha.ovh.net (Postfix) with ESMTPSA id 16273474C1A4;
 Tue,  9 Apr 2019 09:18:08 +0000 (UTC)
Subject: Re: [PATCH v4 10/17] KVM: PPC: Book3S HV: XIVE: add get/set accessors
 for the VP XIVE state
To: Paul Mackerras <paulus@ozlabs.org>
References: <20190320083751.27001-1-clg@kaod.org>
 <20190320083751.27001-11-clg@kaod.org> <20190409061916.GA3429@blackberry>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a81828ff-54a9-91cb-9ca4-a88fa819e469@kaod.org>
Date: Tue, 9 Apr 2019 11:18:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409061916.GA3429@blackberry>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 7158190136511204285
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudehgddugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 4/9/19 8:19 AM, Paul Mackerras wrote:
> On Wed, Mar 20, 2019 at 09:37:44AM +0100, Cédric Le Goater wrote:
>> The state of the thread interrupt management registers needs to be
>> collected for migration. These registers are cached under the
>> 'xive_saved_state.w01' field of the VCPU when the VPCU context is
>> pulled from the HW thread. An OPAL call retrieves the backup of the
>> IPB register in the underlying XIVE NVT structure and merges it in the
>> KVM state.
> 
> Since you're adding a new one_reg identifier value, you need to update
> the list in Documentation/virtual/kvm/api.txt.

yes. I missed that file.

I will keep a description of the VP state register layout in the device 
documentation file : 

  Documentation/virtual/kvm/devices/xive.txt

I don't think it belongs to kvm/api.txt file.

Thanks,

C. 
