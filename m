Return-Path: <SRS0=LxjK=MT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE46C4338F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Jul 2021 23:18:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02C7460F57
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Jul 2021 23:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 02C7460F57
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GZCQn35w5z3ccL
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Jul 2021 09:18:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=benh@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4GZCQR1P1hz2yxT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jul 2021 09:18:21 +1000 (AEST)
Received: from ip6-localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 16RNEnV7020682;
 Tue, 27 Jul 2021 18:14:52 -0500
Message-ID: <3661999754da1a5e5c810fa669654cc7db95b059.camel@kernel.crashing.org>
Subject: Re: Possible regression by ab037dd87a2f (powerpc/vdso: Switch VDSO
 to generic C implementation.)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>
Date: Wed, 28 Jul 2021 09:14:48 +1000
In-Reply-To: <a273c619-9258-e29a-24c3-ea47a13c4817@molgen.mpg.de>
References: <a273c619-9258-e29a-24c3-ea47a13c4817@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Cc: Derek Parker <parkerderek86@gmail.com>, Dmitrii Okunev <xaionaro@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2021-07-27 at 10:45 +0200, Paul Menzel wrote:
> Dear Christophe,
> 
> 
> On ppc64le Go 1.16.2 from Ubuntu 21.04 terminates with a segmentation 
> fault [1], and it might be related to *[release-branch.go1.16] runtime: 
> fix crash during VDSO calls on PowerPC* [2], conjecturing that commit 
> ab037dd87a2f (powerpc/vdso: Switch VDSO to generic C implementation.) 
> added in Linux 5.11 causes this.
> 
> If this is indeed the case, this would be a regression in userspace. Is 
> there a generic fix or should the change be reverted?

From the look at the links you posted, this appears to be completely
broken assumptions by Go that some registers don't change while calling
what essentially are external library functions *while inside those
functions* (ie in this case from a signal handler).

I suppose it would be possible to build the VDSO with gcc arguments to
make it not use r30, but that's just gross...

Cheers,
Ben.



