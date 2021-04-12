Return-Path: <SRS0=//ir=JJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5260AC433B4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Apr 2021 22:25:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1AEC61355
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Apr 2021 22:25:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1AEC61355
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FK3G72QD2z30J0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Apr 2021 08:25:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4FK3Fj6wm5z301B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Apr 2021 08:24:57 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 13CMLi6p013457;
 Mon, 12 Apr 2021 17:21:44 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 13CMLhsf013456;
 Mon, 12 Apr 2021 17:21:43 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Mon, 12 Apr 2021 17:21:43 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH v2 1/1] powerpc/iommu: Enable remaining IOMMU Pagesizes
 present in LoPAR
Message-ID: <20210412222143.GO26583@gate.crashing.org>
References: <20210407195613.131140-1-leobras.c@gmail.com>
 <87im4xe3pk.fsf@mpe.ellerman.id.au>
 <8e1ce7e9-415b-92ea-0437-a4331ed3c7f9@ozlabs.ru>
 <87ft01du50.fsf@mpe.ellerman.id.au>
 <21407a96-5b20-3fae-f1c8-895973b655ef@ozlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21407a96-5b20-3fae-f1c8-895973b655ef@ozlabs.ru>
User-Agent: Mutt/1.4.2.3i
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
Cc: Leonardo Bras <leobras.c@gmail.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, brking@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Apr 09, 2021 at 02:36:16PM +1000, Alexey Kardashevskiy wrote:
> On 08/04/2021 19:04, Michael Ellerman wrote:
> >>>>+#define QUERY_DDW_PGSIZE_4K	0x01
> >>>>+#define QUERY_DDW_PGSIZE_64K	0x02
> >>>>+#define QUERY_DDW_PGSIZE_16M	0x04
> >>>>+#define QUERY_DDW_PGSIZE_32M	0x08
> >>>>+#define QUERY_DDW_PGSIZE_64M	0x10
> >>>>+#define QUERY_DDW_PGSIZE_128M	0x20
> >>>>+#define QUERY_DDW_PGSIZE_256M	0x40
> >>>>+#define QUERY_DDW_PGSIZE_16G	0x80
> >>>
> >>>I'm not sure the #defines really gain us much vs just putting the
> >>>literal values in the array below?
> >>
> >>Then someone says "uuuuu magic values" :) I do not mind either way. 
> >>Thanks,
> >
> >Yeah that's true. But #defining them doesn't make them less magic, if
> >you only use them in one place :)
> 
> Defining them with "QUERY_DDW" in the names kinda tells where they are 
> from. Can also grep QEMU using these to see how the other side handles 
> it. Dunno.

And *not* defining anything reduces the mental load a lot.  You can add
a comment at the single spot you use them, explaining what this is, in a
much better way!

Comments are *good*.


Segher
