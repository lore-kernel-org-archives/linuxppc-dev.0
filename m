Return-Path: <SRS0=UfQ7=QC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93527C282C7
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Jan 2019 10:53:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D15E0218A2
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Jan 2019 10:53:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15E0218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43mt6Z1gHyzDqNt
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Jan 2019 21:53:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=178.32.116.78; helo=8.mo5.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 7803 seconds by postgrey-1.36 at bilbo;
 Sat, 26 Jan 2019 21:52:18 AEDT
Received: from 8.mo5.mail-out.ovh.net (8.mo5.mail-out.ovh.net [178.32.116.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43mt4y1XyGzDqLl
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Jan 2019 21:52:15 +1100 (AEDT)
Received: from player735.ha.ovh.net (unknown [10.109.160.244])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 75ADD212016
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Jan 2019 09:25:16 +0100 (CET)
Received: from kaod.org (lfbn-1-10603-25.w90-89.abo.wanadoo.fr [90.89.194.25])
 (Authenticated sender: clg@kaod.org)
 by player735.ha.ovh.net (Postfix) with ESMTPSA id 3230A213CF25;
 Sat, 26 Jan 2019 08:25:05 +0000 (UTC)
Subject: Re: [PATCH 00/19] KVM: PPC: Book3S HV: add XIVE native exploitation
 mode
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@ozlabs.org>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190122044654.GA15124@blackberry>
 <2f9b4420-ef90-20b8-d31b-dc547a6aa6b4@kaod.org>
 <a420acfb9f375b27bc1203fbb15312a61eb0c34d.camel@kernel.crashing.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <06b7c4d2-72ba-ca4f-aded-789280798136@kaod.org>
Date: Sat, 26 Jan 2019 09:25:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <a420acfb9f375b27bc1203fbb15312a61eb0c34d.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 1831557675011115911
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrieehgdduvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
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

Was there a crashing.org shutdown ? 

  Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by in5.mail.ovh.net (Postfix) with ESMTPS id 43mYnj0nrlz1N7KC
	for <clg@kaod.org>; Fri, 25 Jan 2019 22:38:00 +0000 (UTC)
  Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x0NLZf4K021092;
	Wed, 23 Jan 2019 15:35:43 -0600


On 1/23/19 10:35 PM, Benjamin Herrenschmidt wrote:
> On Wed, 2019-01-23 at 20:07 +0100, Cédric Le Goater wrote:
>>  Event Assignment Structure, a.k.a IVE (Interrupt Virtualization Entry)
>>
>> All the names changed somewhere between XIVE v1 and XIVE v2. OPAL and
>> Linux should be adjusted ...
> 
> All the names changed between the HW design and the "architecture"
> document. The HW guys use the old names, the architecture the new
> names, and Linux & OPAL mostly use the old ones because frankly the new
> names suck big time.

Well, It does not make XIVE any clearer ... I did prefer the v1 names
but there was some naming overlap in the concepts. 

>> It would be good to talk a little about the nested support (offline 
>> may be) to make sure that we are not missing some major interface that 
>> would require a lot of change. If we need to prepare ground, I think
>> the timing is good.
>>
>> The size of the IRQ number space might be a problem. It seems we 
>> would need to increase it considerably to support multiple nested 
>> guests. That said I haven't look much how nested is designed.  
> 
> The size of the VP space is a bigger concern. Even today. We really
> need qemu to tell the max #cpu to KVM so we can allocate less of them.

ah yes. we would also need to reduce the number of available priorities 
per CPU to have more EQ descriptors available if I recall well. 

> As for nesting, I suggest for the foreseeable future we stick to XICS
> emulation in nested guests.

ok. so no kernel_irqchip at all. hmm.  

I was wondering how possible it was to have L2 initialize the underlying 
OPAL structures in the L0 hypervisor. May be with a sort of proxy hcall 
which would perform the initialization in QEMU L1 on behalf of L2.

Cheers,
C.

