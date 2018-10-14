Return-Path: <SRS0=geFq=M2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01089C6787C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 07:44:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B8B520659
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 07:44:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8B520659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Xtr136QHzF0Vv
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 18:44:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=newverein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Xtld0dc4zF1QT
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 18:40:27 +1100 (AEDT)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 2E8B568C75; Sun, 14 Oct 2018 09:40:24 +0200 (CEST)
Date: Sun, 14 Oct 2018 09:40:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 5/8] pcmcia: allow PCMCIA support independent of the
 architecture
Message-ID: <20181014074024.GA17216@lst.de>
References: <20181013151016.31674-1-hch@lst.de>
 <20181013151016.31674-6-hch@lst.de>
 <20181014054252.GA24103@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181014054252.GA24103@light.dominikbrodowski.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: linux-arch@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>,
 Alexandre Bounine <alex.bou9@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Oct 14, 2018 at 07:42:52AM +0200, Dominik Brodowski wrote:
> On Sat, Oct 13, 2018 at 05:10:13PM +0200, Christoph Hellwig wrote:
> > There is nothing architecture specific in the PCMCIA core, so allow
> > building it everywhere.  The actual host controllers will depend on ISA,
> > PCI or a specific SOC.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Looks good to me, though I'm interested on any subtle (build) breakage when
> this gets exposure in -next. Will you push this patch upstream directly, or
> should it go in via the pcmcia tree? If it is the former, feel free to add

The patches in the series depend on each other (just in terms of
context).  I suspect the best would be to get it into the kbuild tree.

It has survived the build bot, which found some interesting issues in
the other patches (as well as the !UML dependency), but if more issues
show I can keep you in the loop.
