Return-Path: <SRS0=8mZb=HF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7755C433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 02:37:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9F8D64E35
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 02:37:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F8D64E35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DVm7S1M7czDwnN
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 13:37:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DVTZV5WtWzDq9s
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2021 02:41:54 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4164167373; Tue,  2 Feb 2021 16:41:49 +0100 (CET)
Date: Tue, 2 Feb 2021 16:41:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 10/13] module: pass struct find_symbol_args to find_symbol
Message-ID: <20210202154148.GA12433@lst.de>
References: <20210202121334.1361503-1-hch@lst.de>
 <20210202121334.1361503-11-hch@lst.de>
 <alpine.LSU.2.21.2102021504550.570@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2102021504550.570@pobox.suse.cz>
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
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Feb 02, 2021 at 03:07:51PM +0100, Miroslav Benes wrote:
> >  	preempt_disable();
> > -	sym = find_symbol(symbol, &owner, NULL, NULL, true, true);
> > -	if (sym && strong_try_module_get(owner))
> > -		sym = NULL;
> > +	if (!find_symbol(&fsa) || !strong_try_module_get(fsa.owner)) {
> 
> I think this should be in fact
> 
>   if (!find_symbol(&fsa) || strong_try_module_get(fsa.owner)) {
> 
> to get the logic right (note the missing !). We want to return NULL if 
> strong_try_module_get() does not succeed for a found symbol.

Indeed. Fixed for the next version.
