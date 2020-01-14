Return-Path: <SRS0=enMn=3D=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B58C33CB1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jan 2020 08:05:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF2F42187F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jan 2020 08:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2F42187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47xjh20LTWzDqNx
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jan 2020 19:05:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kaod.org (client-ip=46.105.61.98; helo=8.mo177.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 602 seconds by postgrey-1.36 at bilbo;
 Tue, 14 Jan 2020 19:03:36 AEDT
Received: from 8.mo177.mail-out.ovh.net (8.mo177.mail-out.ovh.net
 [46.105.61.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47xjdN4vqPzDqHm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2020 19:03:33 +1100 (AEDT)
Received: from player793.ha.ovh.net (unknown [10.108.16.135])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 0CEB911E213
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2020 08:45:03 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player793.ha.ovh.net (Postfix) with ESMTPSA id B018AE3A23F2;
 Tue, 14 Jan 2020 07:44:58 +0000 (UTC)
Subject: Re: [PATCH] powerpc/xive: discard ESB load value when interrupt is
 invalid
To: Michael Ellerman <mpe@ellerman.id.au>
References: <20200113130118.27969-1-clg@kaod.org>
 <76f76082-81ee-4957-c45b-151f0cd6e6b6@kaod.org>
 <87r202alge.fsf@mpe.ellerman.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <5918d64a-8cac-c475-1bda-c0b37d49b47c@kaod.org>
Date: Tue, 14 Jan 2020 08:44:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87r202alge.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 8178255452192017339
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdejuddguddutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejleefrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtoheplhhinhhugihpphgtqdguvghvsehlihhsthhsrdhoiihlrggsshdrohhrghenucevlhhushhtvghrufhiiigvpedt
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
Cc: Frederic Barrat <fbarrat@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Greg Kurz <groug@kaod.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 1/14/20 2:14 AM, Michael Ellerman wrote:
> Cédric Le Goater <clg@kaod.org> writes:
>> On 1/13/20 2:01 PM, Cédric Le Goater wrote:
>>> From: Frederic Barrat <fbarrat@linux.ibm.com>
>>>
>>> A load on an ESB page returning all 1's means that the underlying
>>> device has invalidated the access to the PQ state of the interrupt
>>> through mmio. It may happen, for example when querying a PHB interrupt
>>> while the PHB is in an error state.
>>>
>>> In that case, we should consider the interrupt to be invalid when
>>> checking its state in the irq_get_irqchip_state() handler.
>>
>>
>> and we need also these tags :
>>
>> Fixes: da15c03b047d ("powerpc/xive: Implement get_irqchip_state method for XIVE to fix shutdown race")
>> Cc: stable@vger.kernel.org # v5.3+
> 
> I added those, although it's v5.4+, as the offending commit was first
> included in v5.4-rc1.

Ah yes. I mistook the merge tag of the branch used for the PR (v5.3-rc2)

Thanks,

C. 

