Return-Path: <SRS0=6cb3=P7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9B5C282C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 11:09:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA1DF21019
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 11:09:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA1DF21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43l2c050CKzDqLH
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 22:09:20 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43l2Yv4gdczDqHx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 22:07:31 +1100 (AEDT)
Received: from player159.ha.ovh.net (unknown [10.109.146.137])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id CC946112547
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 11:49:05 +0100 (CET)
Received: from kaod.org (lfbn-1-10603-25.w90-89.abo.wanadoo.fr [90.89.194.25])
 (Authenticated sender: clg@kaod.org)
 by player159.ha.ovh.net (Postfix) with ESMTPSA id 11A7D1D63EC3;
 Wed, 23 Jan 2019 10:48:57 +0000 (UTC)
Subject: Re: [PATCH 11/19] KVM: PPC: Book3S HV: add support for the XIVE
 native exploitation mode hcalls
To: Paul Mackerras <paulus@ozlabs.org>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-12-clg@kaod.org> <20190122052346.GF15124@blackberry>
 <de777e750665d92509b1487a90acb79d70854cf3.camel@kernel.crashing.org>
 <3ada7c25-c671-32d2-4c91-dd7e84c29e48@kaod.org>
 <20190123102603.GA29826@blackberry>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <97b30c4b-acd0-13fc-9a9c-82e99a4ede71@kaod.org>
Date: Wed, 23 Jan 2019 11:48:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190123102603.GA29826@blackberry>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 5089349058135100295
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledriedtgddvudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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

On 1/23/19 11:26 AM, Paul Mackerras wrote:
> On Wed, Jan 23, 2019 at 09:48:31AM +0100, Cédric Le Goater wrote:
>> On 1/23/19 7:44 AM, Benjamin Herrenschmidt wrote:
>>> On Tue, 2019-01-22 at 16:23 +1100, Paul Mackerras wrote:
>>>> Why do we need to provide real-mode versions of these hypercall
>>>> handlers?  I thought these hypercalls would only get called
>>>> infrequently, and in any case certainly much less frequently than once
>>>> per interrupt delivered.  If they are infrequent, then let's leave out
>>>> the real-mode version and just handle them in book3s_hv.c.
>>>
>>> Agreed with the exception maybe of H_INT_ESB
>>
>> ok. 
>>
>> Some of these hcalls are really simple and only getting local info from 
>> the host (h_int_get_*). I thought handling the hcall ASAP was a preferred 
>> practice, even if the hcall is not called frequently. Isn't it ?
> 
> If we are going to handle a given hcall in the kernel at all, then we
> have to have a virtual mode handler.  If we have a real-mode handler
> as well then we in general incur a certain amount of code duplication
> with consequent maintenance costs and possibility of bugs.  So we
> generally only have real-mode handlers for the hcalls where it is
> critical to minimize the latency.  From what Ben is saying that would
> only be H_INT_ESB, and maybe not even that.

ok. and yes, even the H_INT_ESB is questionable as this is really a rare
configuration. 

> If H_INT_ESB is only used for LSIs, then is a guest going to be using
> it at all?  My understanding was that with XIVE, only a small number
> of interrupts that are to do with system management functions are
> LSIs; all of the interrupts relating to PCI-e devices are MSIs.  So do
> we actually have a real high-frequency use case for LSIs in a guest?

The guest should be using a rtl8139 or a e1000 NIC under QEMU/KVM, which 
is not the common scenario. 

> For now I would prefer that you remove all the real-mode hcall
> handlers.  We can add them later if we get performance data showing
> that they are needed.

ok. I will.

> Regarding whether or not to have a given hcall handler in the kernel
> at all - if there is for example an hcall which is just called once
> on guest startup, and its function is just to provide information to
> the guest, and QEMU has that information, then why not have that hcall
> implemented by QEMU?  Are any of the hcalls like that?
> 
> For example, if H_INT_GET_SOURCE_INFO was implemented in QEMU, could
> we then remove the VC_BASE thing from the xive device?

Yes. H_INT_GET_SOURCE_INFO looks like a good candidate, all info should
be in QEMU and there are no OPAL calls, and we would get rid of the 
VC_BASE kvm device ioctl at the same time.

Thanks,

C.
