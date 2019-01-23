Return-Path: <SRS0=6cb3=P7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B01FC282C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 11:28:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1191C20861
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 11:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1191C20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43l32b29pfzDqM2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 22:28:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=178.33.251.175; helo=3.mo179.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 3.mo179.mail-out.ovh.net (3.mo179.mail-out.ovh.net
 [178.33.251.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43l30t1HgJzDqKT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 22:27:25 +1100 (AEDT)
Received: from player711.ha.ovh.net (unknown [10.109.143.24])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id A792010ED47
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 12:07:30 +0100 (CET)
Received: from kaod.org (lfbn-1-10603-25.w90-89.abo.wanadoo.fr [90.89.194.25])
 (Authenticated sender: clg@kaod.org)
 by player711.ha.ovh.net (Postfix) with ESMTPSA id 041791E0B3DF;
 Wed, 23 Jan 2019 11:07:19 +0000 (UTC)
Subject: Re: [PATCH 18/19] KVM: PPC: Book3S HV: add passthrough support
To: Paul Mackerras <paulus@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107191006.10648-1-clg@kaod.org> <20190107191006.10648-2-clg@kaod.org>
 <20190122052657.GG15124@blackberry>
 <b3788899d86b1d3bb8d141f1126592e3593ac8ef.camel@kernel.crashing.org>
 <20190123103009.GB29826@blackberry>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <75762dbe-0f08-5b06-e376-744ff87ff4cb@kaod.org>
Date: Wed, 23 Jan 2019 12:07:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190123103009.GB29826@blackberry>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 5400378905615633287
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledriedtgddvhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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

On 1/23/19 11:30 AM, Paul Mackerras wrote:
> On Wed, Jan 23, 2019 at 05:45:24PM +1100, Benjamin Herrenschmidt wrote:
>> On Tue, 2019-01-22 at 16:26 +1100, Paul Mackerras wrote:
>>> On Mon, Jan 07, 2019 at 08:10:05PM +0100, Cédric Le Goater wrote:
>>>> Clear the ESB pages from the VMA of the IRQ being pass through to the
>>>> guest and let the fault handler repopulate the VMA when the ESB pages
>>>> are accessed for an EOI or for a trigger.
>>>
>>> Why do we want to do this?
>>>
>>> I don't see any possible advantage to removing the PTEs from the
>>> userspace mapping.  You'll need to explain further.
>>
>> Afaik bcs we change the mapping to point to the real HW irq ESB page
>> instead of the "IPI" that was there at VM init time.

yes exactly. You need to clean up the pages each time.
 
> So that makes it sound like there is a whole lot going on that hasn't
> even been hinted at in the patch descriptions...  It sounds like we
> need a good description of how all this works and fits together
> somewhere under Documentation/.

OK. I have started doing so for the models merged in QEMU but not yet 
for KVM. I will work on it.

> In any case we need much more informative patch descriptions.  I
> realize that it's all currently in Cedric's head, but I bet that in
> two or three years' time when we come to try to debug something, it
> won't be in anyone's head...

I agree. 


So, storing the ESB VMA under the KVM device is not shocking anyone ?  

Thanks,

C.

