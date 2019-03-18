Return-Path: <SRS0=3pJc=RV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126C1C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 14:59:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 575BB20850
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 14:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575BB20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44NK832gg1zDqKg
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 01:58:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.63.230; helo=7.mo68.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 7.mo68.mail-out.ovh.net (7.mo68.mail-out.ovh.net
 [46.105.63.230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44NK4k3tTszDqHr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 01:56:02 +1100 (AEDT)
Received: from player159.ha.ovh.net (unknown [10.109.143.145])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id BF35911DF92
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2019 15:39:04 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n0.emea.ibm.com [195.212.29.162])
 (Authenticated sender: clg@kaod.org)
 by player159.ha.ovh.net (Postfix) with ESMTPSA id 433F03B041B0;
 Mon, 18 Mar 2019 14:38:56 +0000 (UTC)
Subject: Re: [PATCH v3 06/17] KVM: PPC: Book3S HV: XIVE: add controls for the
 EQ configuration
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190315120609.25910-1-clg@kaod.org>
 <20190315120609.25910-7-clg@kaod.org> <20190318032348.GH6874@umbus.fritz.box>
 <8b3caeef-8750-b8db-d516-c722bc08c535@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f41e9305-5185-9a04-4de9-502d252a8231@kaod.org>
Date: Mon, 18 Mar 2019 15:38:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <8b3caeef-8750-b8db-d516-c722bc08c535@kaod.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 12503962892625349565
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedutddriedugdeijecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

[ ... ]


>>> +	page = gfn_to_page(kvm, gpa_to_gfn(kvm_eq.qpage));
>>> +	if (is_error_page(page)) {
>>> +		pr_warn("Couldn't get guest page for %llx!\n", kvm_eq.qpage);
>>> +		return -EINVAL;
>>> +	}
>>
>> Yeah.. for the case of a 4kiB page host (these days weird, but not
>> actually prohibited, AFAIK) you need to check that the qsize selected
>> actually fits within the page.
> 
> Ah yes. sure.
>  
>>> +	qaddr = page_to_virt(page) + (kvm_eq.qpage & ~PAGE_MASK);
>>> +
>>> +	/* Backup queue page guest address for migration */
>>
>> Hm.. KVM itself shouldn't generally need to know about migration.
>> IIUC these values won't change from what qemu set them to be, so it
>> should be able to store and migrate them without have to get them back
>> from the kernel.
> 
> Euh. You are completely right. I don't know why I kept those around. 

No. I do need these values in patch 9 "KVM: PPC: Book3S HV: XIVE: add 
a control to dirty the XIVE EQ pages" where the EQ pages are marked
dirty for migration:

+		/* Mark EQ page dirty for migration */
+		mark_page_dirty(vcpu->kvm, gpa_to_gfn(q->guest_qpage));

We could change the kvmppc_xive_native_vcpu_eq_sync() to work on a 
EQ basis and not on a device basis. In this case, we could pass the
EQ guest address again. That would change a bit the save sequence.

C.

>>> +	q->guest_qpage = kvm_eq.qpage;
>>> +	q->guest_qsize = kvm_eq.qsize;
