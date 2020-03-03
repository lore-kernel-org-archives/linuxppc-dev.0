Return-Path: <SRS0=Civx=4U=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F88EC3F2C6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Mar 2020 19:28:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ECE42072D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Mar 2020 19:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ECE42072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48X6Vs2dwLzDqSl
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2020 06:28:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kaod.org (client-ip=188.165.48.182; helo=7.mo2.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 7.mo2.mail-out.ovh.net (7.mo2.mail-out.ovh.net [188.165.48.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48X6Qg2vWczDqS2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2020 06:24:40 +1100 (AEDT)
Received: from player799.ha.ovh.net (unknown [10.110.171.96])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 622741CCE0D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Mar 2020 20:18:35 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player799.ha.ovh.net (Postfix) with ESMTPSA id E981A1008C8C7;
 Tue,  3 Mar 2020 19:18:18 +0000 (UTC)
Subject: Re: [EXTERNAL] Re: [RFC PATCH v1] powerpc/prom_init: disable XIVE in
 Secure VM.
To: Greg Kurz <groug@kaod.org>, Ram Pai <linuxram@us.ibm.com>
References: <1582962844-26333-1-git-send-email-linuxram@us.ibm.com>
 <20200302233240.GB35885@umbus.fritz.box>
 <8f0c3d41-d1f9-7e6d-276b-b95238715979@fr.ibm.com>
 <20200303170205.GA5416@oc0525413822.ibm.com>
 <20200303184520.632be270@bahia.home>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a1570b0d-c443-3140-31f0-bddd9f31f54b@kaod.org>
Date: Tue, 3 Mar 2020 20:18:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303184520.632be270@bahia.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 12505088792497195963
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedruddtiedguddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeelledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehlihhnuhigphhptgdquggvvheslhhishhtshdrohiilhgrsghsrdhorhhg
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
Cc: aik@ozlabs.ru, andmike@linux.ibm.com, kvm-ppc@vger.kernel.org,
 sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 bauerman@linux.ibm.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

>> **** BTW: I figured, I dont need this intermin patch to disable xive for
>> secure VM.  Just doing "svm=on xive=off" on the kernel command line is
>> sufficient for now. *****
>>
> 
> No it is not. If the hypervisor doesn't propose XIVE (ie. ic-mode=xive
> on the QEMU command line), the kernel simply ignores "xive=off".

If I am correct, with the option ic-mode=xive, the hypervisor will 
propose only 'xive' in OV5 and not both 'xive' and 'xics'. But the
result is the same because xive can not be turned off and "xive=off" 
is ignored.

Anyway, it's not the most common case of usage of the QEMU command
like. I think it's OK to use "xive=off" on the kernel command line 
for now.

C.
