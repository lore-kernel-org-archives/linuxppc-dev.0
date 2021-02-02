Return-Path: <SRS0=8mZb=HF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8A5C433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 00:46:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B377864F6A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 00:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B377864F6A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DVjfR6SddzDwhZ
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 11:46:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=mbenes@suse.cz;
 receiver=<UNKNOWN>)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DVM0x56M9zDrNS
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Feb 2021 21:45:53 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 27FC9AE8D;
 Tue,  2 Feb 2021 10:45:48 +0000 (UTC)
Date: Tue, 2 Feb 2021 11:45:47 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 05/13] kallsyms: refactor {,module_}kallsyms_on_each_symbol
In-Reply-To: <20210201162842.GB7276@lst.de>
Message-ID: <alpine.LSU.2.21.2102021145160.570@pobox.suse.cz>
References: <20210128181421.2279-1-hch@lst.de>
 <20210128181421.2279-6-hch@lst.de> <YBPYyEvesLMrRtZM@alley>
 <20210201114749.GB19696@lst.de>
 <alpine.LSU.2.21.2102011436320.21637@pobox.suse.cz>
 <20210201162842.GB7276@lst.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Petr Mladek <pmladek@suse.com>, Jiri Kosina <jikos@kernel.org>,
 Andrew Donnellan <ajd@linux.ibm.com>, linux-kbuild@vger.kernel.org,
 David Airlie <airlied@linux.ie>, Masahiro Yamada <masahiroy@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 live-patching@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>,
 Joe Lawrence <joe.lawrence@redhat.com>, dri-devel@lists.freedesktop.org,
 Thomas Zimmermann <tzimmermann@suse.de>, Jessica Yu <jeyu@kernel.org>,
 Frederic Barrat <fbarrat@linux.ibm.com>, Daniel Vetter <daniel@ffwll.ch>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 1 Feb 2021, Christoph Hellwig wrote:

> On Mon, Feb 01, 2021 at 02:37:12PM +0100, Miroslav Benes wrote:
> > > > This change is not needed. (objname == NULL) means that we are
> > > > interested only in symbols in "vmlinux".
> > > > 
> > > > module_kallsyms_on_each_symbol(klp_find_callback, &args)
> > > > will always fail when objname == NULL.
> > > 
> > > I just tried to keep the old behavior.  I can respin it with your
> > > recommended change noting the change in behavior, though.
> > 
> > Yes, please. It would be cleaner that way.
> 
> Let me know if this works for you:
> 
> ---
> >From 18af41e88d088cfb8680d1669fcae2bc2ede5328 Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Wed, 20 Jan 2021 16:23:16 +0100
> Subject: kallsyms: refactor {,module_}kallsyms_on_each_symbol
> 
> Require an explicit call to module_kallsyms_on_each_symbol to look
> for symbols in modules instead of the call from kallsyms_on_each_symbol,
> and acquire module_mutex inside of module_kallsyms_on_each_symbol instead
> of leaving that up to the caller.  Note that this slightly changes the
> behavior for the livepatch code in that the symbols from vmlinux are not
> iterated anymore if objname is set, but that actually is the desired
> behavior in this case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Miroslav Benes <mbenes@suse.cz>

Thanks Christoph

M
