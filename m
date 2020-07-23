Return-Path: <SRS0=Lnkm=BC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE62C433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2020 18:37:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ADF820737
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2020 18:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ADF820737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BCLfW2M8BzDrSt
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2020 04:37:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kaod.org (client-ip=178.32.97.206; helo=19.mo1.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 4574 seconds by postgrey-1.36 at bilbo;
 Fri, 24 Jul 2020 04:34:35 AEST
Received: from 19.mo1.mail-out.ovh.net (19.mo1.mail-out.ovh.net
 [178.32.97.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BCLbH5XlXzDqyB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2020 04:34:33 +1000 (AEST)
Received: from player726.ha.ovh.net (unknown [10.108.57.76])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 89C251D1E1D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2020 19:18:15 +0200 (CEST)
Received: from kaod.org (bad36-1-78-202-132-1.fbx.proxad.net [78.202.132.1])
 (Authenticated sender: clg@kaod.org)
 by player726.ha.ovh.net (Postfix) with ESMTPSA id 31C2D148D3F16;
 Thu, 23 Jul 2020 17:18:06 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R00656480056-5979-4c0d-b1fd-dc0742c8c4b8,
 0360426414082D1FC3E0C3FF9A362FC9406E86E3) smtp.auth=clg@kaod.org
Subject: Re: [PATCH v2 0/3] powerpc/pseries: IPI doorbell improvements
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20200630115034.137050-1-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <7ff5bf9e-4a04-a773-86a7-73076936819c@kaod.org>
Date: Thu, 23 Jul 2020 19:18:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200630115034.137050-1-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 14291891945715960791
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrhedugdduudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefffdvtddugeeifeduuefghfejgfeigeeigeeltedthefgieeiveeuiefhgeefgfenucfkpheptddrtddrtddrtddpjeekrddvtddvrddufedvrddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjedviedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehlihhnuhigphhptgdquggvvheslhhishhtshdrohiilhgrsghsrdhorhhg
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
Cc: Anton Blanchard <anton@linux.ibm.com>, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 6/30/20 1:50 PM, Nicholas Piggin wrote:
> Since v1:
> - Fixed SMP compile error.
> - Fixed EPAPR / KVM_GUEST breakage.
> - Expanded patch 3 changelog a bit.
> 
> Thanks,
> Nick

I gave the patchset a try on KVM guests (P9 and P8) and PowerVM LPARs (P9).

Looks good.  

Tested-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C. 

> 
> Nicholas Piggin (3):
>   powerpc: inline doorbell sending functions
>   powerpc/pseries: Use doorbells even if XIVE is available
>   powerpc/pseries: Add KVM guest doorbell restrictions
> 
>  arch/powerpc/include/asm/dbell.h     | 63 ++++++++++++++++++++++++++--
>  arch/powerpc/include/asm/firmware.h  |  6 +++
>  arch/powerpc/include/asm/kvm_para.h  | 26 ++----------
>  arch/powerpc/kernel/Makefile         |  5 +--
>  arch/powerpc/kernel/dbell.c          | 55 ------------------------
>  arch/powerpc/kernel/firmware.c       | 19 +++++++++
>  arch/powerpc/platforms/pseries/smp.c | 62 +++++++++++++++++++--------
>  7 files changed, 134 insertions(+), 102 deletions(-)
> 

