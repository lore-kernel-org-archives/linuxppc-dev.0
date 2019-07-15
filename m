Return-Path: <SRS0=O2mS=VM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD38C7618E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jul 2019 07:26:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45B1820868
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jul 2019 07:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="YFqEOcGW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45B1820868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stackframe.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45nFT12cdGzDqVc
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jul 2019 17:26:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=stackframe.org
 (client-ip=2001:470:70c5:1111::170; helo=smtp.duncanthrax.net;
 envelope-from=svens@stackframe.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=stackframe.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=duncanthrax.net header.i=@duncanthrax.net
 header.b="YFqEOcGW"; dkim-atps=neutral
Received: from smtp.duncanthrax.net (smtp.duncanthrax.net
 [IPv6:2001:470:70c5:1111::170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45nFQg3H9hzDqHq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jul 2019 17:24:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=duncanthrax.net; s=dkim; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
 bh=rJOzvThKAhSey0b92P8NAZRn4VdLP1TqiehK4IVayo8=; b=YFqEOcGWCAHFtbAJMhFMhm7/8R
 /TmcGqLnhjzHJu82HlfaQVwobhpiYa7LPbqlKebrckdseI5hsGfBU7nWKFzTRfdPTB2OoXffd8jF/
 jKFHPr5yLk6gHXEiZ8+HOOY3slLgXnkTFgUdxk2iF1nCtF9419sD0fqUmJo8kpvBEM4w=;
Received: from frobwit.duncanthrax.net ([89.31.1.178]
 helo=t470p.stackframe.org)
 by smtp.eurescom.eu with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.86_2) (envelope-from <svens@stackframe.org>)
 id 1hmvLO-000310-Uf; Mon, 15 Jul 2019 09:24:19 +0200
Date: Mon, 15 Jul 2019 09:24:17 +0200
From: Sven Schnelle <svens@stackframe.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 5/7] kexec_elf: remove elf_addr_to_cpu macro
Message-ID: <20190715072417.GA25659@t470p.stackframe.org>
References: <20190710142944.2774-1-svens@stackframe.org>
 <20190710142944.2774-6-svens@stackframe.org>
 <49206784-009c-391b-5f9a-11e9b1de930b@c-s.fr>
 <20190710180518.GA6343@t470p.stackframe.org>
 <871rywhlq4.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871rywhlq4.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: kexec@lists.infradead.org, deller@gmx.de, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Michael,

On Thu, Jul 11, 2019 at 09:08:51PM +1000, Michael Ellerman wrote:
> Sven Schnelle <svens@stackframe.org> writes:
> > On Wed, Jul 10, 2019 at 05:09:29PM +0200, Christophe Leroy wrote:
> >> Le 10/07/2019 à 16:29, Sven Schnelle a écrit :
> >> > It had only one definition, so just use the function directly.
> >> 
> >> It had only one definition because it was for ppc64 only.
> >> But as far as I understand (at least from the name of the new file), you
> >> want it to be generic, don't you ? Therefore I get on 32 bits it would be
> >> elf32_to_cpu().
> >
> > That brings up the question whether we need those endianess conversions. I would
> > assume that the ELF file has always the same endianess as the running kernel. So
> > i think we could just drop them. What do you think?
> 
> We should be able to kexec from big to little endian or vice versa, so
> they are necessary.

I'll update the patch to check for a needed 32/64 bit conversion during runtime,
so we can also kexec from 32 to 64 bit kernels and vice versa. Don't know
whether that's possible on powerpc, but at least on parisc it is.

Regards
Sven
