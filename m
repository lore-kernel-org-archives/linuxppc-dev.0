Return-Path: <SRS0=6cb3=P7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2900C282C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 16:30:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5825C217D4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 16:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5825C217D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43l9kS1NQQzDqM7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 03:30:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.73.241; helo=10.mo69.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 10.mo69.mail-out.ovh.net (10.mo69.mail-out.ovh.net
 [46.105.73.241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43l9hn73GbzDqK6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2019 03:28:57 +1100 (AEDT)
Received: from player691.ha.ovh.net (unknown [10.109.159.35])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 80CD73AE50
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 17:28:53 +0100 (CET)
Received: from kaod.org (lfbn-1-10603-25.w90-89.abo.wanadoo.fr [90.89.194.25])
 (Authenticated sender: clg@kaod.org)
 by player691.ha.ovh.net (Postfix) with ESMTPSA id 8DC1820D85E7;
 Wed, 23 Jan 2019 16:28:46 +0000 (UTC)
Subject: Re: [PATCH 05/19] KVM: PPC: Book3S HV: add a new KVM device for the
 XIVE native exploitation mode
To: Paul Mackerras <paulus@ozlabs.org>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-6-clg@kaod.org> <20190122050520.GC15124@blackberry>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <8c34931c-d2b0-0e10-20fd-adb05a86ed41@kaod.org>
Date: Wed, 23 Jan 2019 17:28:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190122050520.GC15124@blackberry>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10828060880614951815
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledriedtgdeltdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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

On 1/22/19 6:05 AM, Paul Mackerras wrote:
> On Mon, Jan 07, 2019 at 07:43:17PM +0100, Cédric Le Goater wrote:
>> This is the basic framework for the new KVM device supporting the XIVE
>> native exploitation mode. The user interface exposes a new capability
>> and a new KVM device to be used by QEMU.
> 
> [snip]
>> @@ -1039,7 +1039,10 @@ static int kvmppc_book3s_init(void)
>>  #ifdef CONFIG_KVM_XIVE
>>  	if (xive_enabled()) {
>>  		kvmppc_xive_init_module();
>> +		kvmppc_xive_native_init_module();
>>  		kvm_register_device_ops(&kvm_xive_ops, KVM_DEV_TYPE_XICS);
>> +		kvm_register_device_ops(&kvm_xive_native_ops,
>> +					KVM_DEV_TYPE_XIVE);
> 
> I think we want tighter conditions on initializing the xive_native
> stuff and creating the xive device class.  We could have
> xive_enabled() returning true in a guest, and this code will get
> called both by PR KVM and HV KVM (and HV KVM no longer implies that we
> are running bare metal).

Ah yes, I agree. I haven't addressed at all the nested flavor. I have 
some questions about this that I will ask in summary email you sent. 

Thanks,

C. 
  

> 
>> @@ -1050,8 +1053,10 @@ static int kvmppc_book3s_init(void)
>>  static void kvmppc_book3s_exit(void)
>>  {
>>  #ifdef CONFIG_KVM_XICS
>> -	if (xive_enabled())
>> +	if (xive_enabled()) {
>>  		kvmppc_xive_exit_module();
>> +		kvmppc_xive_native_exit_module();
> 
> Same comment here.
> 
> Paul.
> 

