Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EB7C282C8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 04:45:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 288B32148E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 04:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="SE6IvZnl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 288B32148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43nxrt0k3ZzDqH1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 15:45:34 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43nxq40dX7zDqGG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 15:44:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="SE6IvZnl"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 43nxq35PmCz9s9h; Mon, 28 Jan 2019 15:43:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1548650639; bh=rZXeLdle11Nu0cnAoKMY8iCqG06CO6P+PyqEsnI0dtY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SE6IvZnljgA0FTh6HV9o8v4FXxvgN/JPDlrFXezwUAYT1SYy4rtLuwxYwY6yy1r4H
 g2J+CY1RXBgp3G/oMb79p80T8z+X2WFeBCQdCummvumo04OwPHUSuvXlnNv6R8NmFQ
 1/As9Cnr6PsfaEWpFaxt9pbIcXd+8ZfIFvKUHQMYBISFez23wv8ADugAr9NkAR+434
 0Qju37M5xdSiMu9AOVAuN+LHGXiWJzYzH/VLeEy5/z2ziAWR+eMsp9grC1711ij8qk
 g50g0cNCZgu3LN5Zu4yxncL+aQdtb0VKJKpBE/RkaLu9M+eiwm0gzhRy9AbjQE0k2e
 OGx3XWlthaffg==
Date: Mon, 28 Jan 2019 15:43:54 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 18/19] KVM: PPC: Book3S HV: add passthrough support
Message-ID: <20190128044354.GB3237@blackberry>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107191006.10648-1-clg@kaod.org>
 <20190107191006.10648-2-clg@kaod.org>
 <20190122052657.GG15124@blackberry>
 <b3788899d86b1d3bb8d141f1126592e3593ac8ef.camel@kernel.crashing.org>
 <20190123103009.GB29826@blackberry>
 <bcb5d487547503ceaf0aefad4a63889a52ea0a02.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcb5d487547503ceaf0aefad4a63889a52ea0a02.camel@kernel.crashing.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jan 24, 2019 at 08:25:15AM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2019-01-23 at 21:30 +1100, Paul Mackerras wrote:
> > > Afaik bcs we change the mapping to point to the real HW irq ESB page
> > > instead of the "IPI" that was there at VM init time.
> > 
> > So that makes it sound like there is a whole lot going on that hasn't
> > even been hinted at in the patch descriptions...  It sounds like we
> > need a good description of how all this works and fits together
> > somewhere under Documentation/.
> > 
> > In any case we need much more informative patch descriptions.  I
> > realize that it's all currently in Cedric's head, but I bet that in
> > two or three years' time when we come to try to debug something, it
> > won't be in anyone's head...
> 
> The main problem is understanding XIVE itself. It's not realistic to
> ask Cedric to write a proper documentation for XIVE as part of the
> patch series, but sadly IBM doesn't have a good one to provide either.

There are: (a) the XIVE hardware, (b) the definition of the XIVE
hypercalls that guests use, and (c) the design decisions around how to
implement that hypercall interface.  We need to get (b) published
somehow, but it is mostly (c) that I would expect the patch
descriptions to explain.

It sounds like there will be a mapping to userspace where the pages
can sometimes point to an IPI page and sometimes point to a real HW
irq ESB page.  That is, the same guest "hardware" irq number sometimes
refers to a software-generated interrupt (what you called an "IPI"
above) and sometimes to a hardware-generated interrupt.  That fact,
the reason why it is so and the consequences all need to be explained
somewhere.  They are really not obvious and I don't believe they are
part of either the XIVE hardware spec or the XIVE hypercall spec.

Paul.
