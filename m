Return-Path: <SRS0=8MIQ=RP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4099C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 14:28:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 790392147C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 14:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 790392147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Jclx0VZFzDqD5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 01:28:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.72.238; helo=9.mo177.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 9.mo177.mail-out.ovh.net (9.mo177.mail-out.ovh.net
 [46.105.72.238])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Jcjv5205zDqD8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 01:26:58 +1100 (AEDT)
Received: from player761.ha.ovh.net (unknown [10.109.143.232])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 54572EAFFD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2019 15:11:08 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n0.emea.ibm.com [195.212.29.162])
 (Authenticated sender: clg@kaod.org)
 by player761.ha.ovh.net (Postfix) with ESMTPSA id 4EB6239AC984;
 Tue, 12 Mar 2019 14:10:59 +0000 (UTC)
Subject: Re: [PATCH v2 03/16] KVM: PPC: Book3S HV: XIVE: introduce a new
 capability KVM_CAP_PPC_IRQ_XIVE
To: Paul Mackerras <paulus@ozlabs.org>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-4-clg@kaod.org> <20190225003527.GG7668@umbus.fritz.box>
 <20190225045931.GB20501@blackberry>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c574ab63-32db-5404-f201-ab9f9becc311@kaod.org>
Date: Tue, 12 Mar 2019 15:10:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190225045931.GB20501@blackberry>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13689816968766589831
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedutddrgeekgdeifecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2/25/19 5:59 AM, Paul Mackerras wrote:
> On Mon, Feb 25, 2019 at 11:35:27AM +1100, David Gibson wrote:
>> On Fri, Feb 22, 2019 at 12:28:27PM +0100, Cédric Le Goater wrote:
>>> +	xc->xive = xive;
>>> +	xc->vcpu = vcpu;
>>> +	xc->server_num = cpu;
>>> +	xc->vp_id = xive->vp_base + cpu;
>>
>> Hrm.  This ties the internal VP id to the userspace chosen server
>> number, which isn't ideal.  It puts a constraint on those server
>> numbers that you wouldn't otherwise have.
> 
> We should probably do the same as the xics-on-xive code, which is to
> put the server number through kvmppc_pack_vcpu_id(), which is a
> folding function that maps the QEMU vcpu id (which is the server
> number) down to the range 0..KVM_MAX_VCPUS-1, and works for the
> allocation patterns used in the various vSMT modes.

yes. I will see how it goes.

Thanks,

C.
