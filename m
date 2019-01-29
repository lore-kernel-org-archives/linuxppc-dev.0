Return-Path: <SRS0=r5zj=QF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A64C169C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 14:04:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4908421473
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 14:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4908421473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ppBx2z9NzDqPm
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 01:04:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.76.148; helo=9.mo179.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 668 seconds by postgrey-1.36 at bilbo;
 Wed, 30 Jan 2019 01:02:27 AEDT
Received: from 9.mo179.mail-out.ovh.net (9.mo179.mail-out.ovh.net
 [46.105.76.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43pp8z4McwzDqNj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 01:02:26 +1100 (AEDT)
Received: from player738.ha.ovh.net (unknown [10.109.146.143])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id AD81B110579
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 14:47:11 +0100 (CET)
Received: from kaod.org (gbibp9ph1--yellowicen11.emea.ibm.com [195.212.29.58])
 (Authenticated sender: clg@kaod.org)
 by player738.ha.ovh.net (Postfix) with ESMTPSA id 907A82433C77;
 Tue, 29 Jan 2019 13:47:00 +0000 (UTC)
Subject: Re: [PATCH 18/19] KVM: PPC: Book3S HV: add passthrough support
To: Paul Mackerras <paulus@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107191006.10648-1-clg@kaod.org> <20190107191006.10648-2-clg@kaod.org>
 <20190122052657.GG15124@blackberry>
 <b3788899d86b1d3bb8d141f1126592e3593ac8ef.camel@kernel.crashing.org>
 <20190123103009.GB29826@blackberry>
 <bcb5d487547503ceaf0aefad4a63889a52ea0a02.camel@kernel.crashing.org>
 <20190128044354.GB3237@blackberry>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <0b053855-1f96-2614-b958-eb6720aab69b@kaod.org>
Date: Tue, 29 Jan 2019 14:46:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190128044354.GB3237@blackberry>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 6439865994449750919
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
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 1/28/19 5:43 AM, Paul Mackerras wrote:
> On Thu, Jan 24, 2019 at 08:25:15AM +1100, Benjamin Herrenschmidt wrote:
>> On Wed, 2019-01-23 at 21:30 +1100, Paul Mackerras wrote:
>>>> Afaik bcs we change the mapping to point to the real HW irq ESB page
>>>> instead of the "IPI" that was there at VM init time.
>>>
>>> So that makes it sound like there is a whole lot going on that hasn't
>>> even been hinted at in the patch descriptions...  It sounds like we
>>> need a good description of how all this works and fits together
>>> somewhere under Documentation/.
>>>
>>> In any case we need much more informative patch descriptions.  I
>>> realize that it's all currently in Cedric's head, but I bet that in
>>> two or three years' time when we come to try to debug something, it
>>> won't be in anyone's head...
>>
>> The main problem is understanding XIVE itself. It's not realistic to
>> ask Cedric to write a proper documentation for XIVE as part of the
>> patch series, but sadly IBM doesn't have a good one to provide either.
> 
> There are: (a) the XIVE hardware, (b) the definition of the XIVE
> hypercalls that guests use, and (c) the design decisions around how to
> implement that hypercall interface.  We need to get (b) published
> somehow, but it is mostly (c) that I would expect the patch
> descriptions to explain.
> 
> It sounds like there will be a mapping to userspace where the pages
> can sometimes point to an IPI page and sometimes point to a real HW
> irq ESB page.  

Just to be clear. In both cases, these pages are real HW ESB pages. 
They are just attached to a different controller : the XIVE IC for 
the IPIs and the PHB4 for the others. 

> That is, the same guest "hardware" irq number sometimes
> refers to a software-generated interrupt (what you called an "IPI"
> above) and sometimes to a hardware-generated interrupt.  That fact,> the reason why it is so and the consequences all need to be explained
> somewhere.  They are really not obvious and I don't believe they are
> part of either the XIVE hardware spec or the XIVE hypercall spec.

I tried to put the reasons behind the current approach in another 
thread, not saying this is the correct one.

Thanks,

C.

