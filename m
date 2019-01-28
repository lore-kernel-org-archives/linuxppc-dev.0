Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A80C282C8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 17:55:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A92420881
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 17:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A92420881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43pHNK0GngzDqP4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 04:55:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.61.149; helo=7.mo177.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 7.mo177.mail-out.ovh.net (7.mo177.mail-out.ovh.net
 [46.105.61.149])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43pGxg6lktzDqCc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 04:35:48 +1100 (AEDT)
Received: from player746.ha.ovh.net (unknown [10.109.160.253])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 62E13DCC28
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 18:35:44 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n0.emea.ibm.com [195.212.29.162])
 (Authenticated sender: clg@kaod.org)
 by player746.ha.ovh.net (Postfix) with ESMTPSA id B3EE1235086B;
 Mon, 28 Jan 2019 17:35:34 +0000 (UTC)
Subject: Re: [PATCH 05/19] KVM: PPC: Book3S HV: add a new KVM device for the
 XIVE native exploitation mode
To: Paul Mackerras <paulus@ozlabs.org>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-6-clg@kaod.org> <20190122050520.GC15124@blackberry>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <d21664e5-1d9c-5a55-5b83-bf5e6247917a@kaod.org>
Date: Mon, 28 Jan 2019 18:35:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190122050520.GC15124@blackberry>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 4427038436812229511
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrjedtgddutdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
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

So yes, I gave nested a try with kernel_irqchip=on and the nested hypervisor 
(L1) obviously crashes trying to call OPAL. I have tighten the test with : 

	if (xive_enabled() && !kvmhv_on_pseries()) {

for now.

As this is a problem today in 5.0.x, I will send a patch for it if you think
it is correct. I don't think we should bother taking care of the PR case
on P9. Should we ? 

Thanks,

C.
 
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

