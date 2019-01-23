Return-Path: <SRS0=6cb3=P7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107B5C282C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 10:32:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4702620861
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 10:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="CmYqR/UJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4702620861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43l1my1pFjzDqNH
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 21:32:02 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43l1kv4ZQKzDqKH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 21:30:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="CmYqR/UJ"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 43l1kv0w4Wz9s4s; Wed, 23 Jan 2019 21:30:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1548239415; bh=E9jhbke0ONEa9KRFA8tMqQVtg1nCTkEdmyAamgWd8wM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CmYqR/UJdoUIGevbgzvxg0kD6/8sBBn32/WNATH3c6fCIXpGZ0Y8I7EYgDnh+9W7+
 fDkyvnz7VhEwiZbvT52Sws2Y/KVCFY0ZuzV9lWYoGfSYTV2610BZOdt0Zp4Fgn0FZd
 7FO4yrJZOWO37tIlyeU+gFvlOsOJD4aWHEu5YPKG+Jo5l875LWZVF1Qk8CxLjlje8E
 VE6ZuSh8qjWm6CLNkOUxXeq/p/ejYcTI3ICpFu8zA2vYI2Gmua3mAShHF07J/4W+pi
 sZ8S3u52rbMaLK/xzLfswKvVhltZn9IiIqBywcMuqCDlf8N3C8CV/5b8FdFx/PPx9a
 UChxA2vFCohaA==
Date: Wed, 23 Jan 2019 21:30:09 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 18/19] KVM: PPC: Book3S HV: add passthrough support
Message-ID: <20190123103009.GB29826@blackberry>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107191006.10648-1-clg@kaod.org>
 <20190107191006.10648-2-clg@kaod.org>
 <20190122052657.GG15124@blackberry>
 <b3788899d86b1d3bb8d141f1126592e3593ac8ef.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3788899d86b1d3bb8d141f1126592e3593ac8ef.camel@kernel.crashing.org>
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

On Wed, Jan 23, 2019 at 05:45:24PM +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2019-01-22 at 16:26 +1100, Paul Mackerras wrote:
> > On Mon, Jan 07, 2019 at 08:10:05PM +0100, Cédric Le Goater wrote:
> > > Clear the ESB pages from the VMA of the IRQ being pass through to the
> > > guest and let the fault handler repopulate the VMA when the ESB pages
> > > are accessed for an EOI or for a trigger.
> > 
> > Why do we want to do this?
> > 
> > I don't see any possible advantage to removing the PTEs from the
> > userspace mapping.  You'll need to explain further.
> 
> Afaik bcs we change the mapping to point to the real HW irq ESB page
> instead of the "IPI" that was there at VM init time.

So that makes it sound like there is a whole lot going on that hasn't
even been hinted at in the patch descriptions...  It sounds like we
need a good description of how all this works and fits together
somewhere under Documentation/.

In any case we need much more informative patch descriptions.  I
realize that it's all currently in Cedric's head, but I bet that in
two or three years' time when we come to try to debug something, it
won't be in anyone's head...

Paul.
