Return-Path: <SRS0=pFgb=LF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB25C48BD1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jun 2021 12:37:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 217F4613B8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jun 2021 12:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 217F4613B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G1gN16PkPz3c3Z
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jun 2021 22:37:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=2peLsmD6;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3v38kvCK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.220.28; helo=smtp-out1.suse.de;
 envelope-from=dsterba@suse.cz; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256
 header.s=susede2_rsa header.b=2peLsmD6; 
 dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=3v38kvCK; 
 dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G1gMT0GH7z3bTh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jun 2021 22:36:52 +1000 (AEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 035D321A48;
 Fri, 11 Jun 2021 12:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1623415008;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WbubFKHB1YFq8+cLZPFZsL/iGgDagPXwRBHcKJ3qDmE=;
 b=2peLsmD6OKg84vX05jlKeSSzhc+WJwWLotAAvUINC/onEs9TZQ3AbPHeWdfS+bddiLLzh6
 0c23UqVPl326Qf2GLCycEtdoY9uZtjge95WU9F1EOEMHDadCrMP+/1vg8CqJ73tLjxiDvw
 Lz8qAG0S58lqlW3qCvtVoDZc1BMWInk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1623415008;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WbubFKHB1YFq8+cLZPFZsL/iGgDagPXwRBHcKJ3qDmE=;
 b=3v38kvCKiCtteusW+zZk3tG/vFy89Y7uWUqGSygE7PibOC0N0H5mMQie3rH4X648s2bwn9
 4RHgSq2/8HIoKtBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
 by relay2.suse.de (Postfix) with ESMTP id ED944A3BB1;
 Fri, 11 Jun 2021 12:36:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
 id D0B2EDA7A2; Fri, 11 Jun 2021 14:34:02 +0200 (CEST)
Date: Fri, 11 Jun 2021 14:34:02 +0200
From: David Sterba <dsterba@suse.cz>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] fs: btrfs: Disable BTRFS on platforms having 256K pages
Message-ID: <20210611123402.GD28158@twin.jikos.cz>
Mail-Followup-To: dsterba@suse.cz,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
 linux-hexagon@vger.kernel.org
References: <a16c31f3caf448dda5d9315e056585b6fafc22c5.1623302442.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a16c31f3caf448dda5d9315e056585b6fafc22c5.1623302442.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
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
Reply-To: dsterba@suse.cz
Cc: linux-hexagon@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, linuxppc-dev@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jun 10, 2021 at 05:23:02AM +0000, Christophe Leroy wrote:
> With a config having PAGE_SIZE set to 256K, BTRFS build fails
> with the following message
> 
>  include/linux/compiler_types.h:326:38: error: call to '__compiletime_assert_791' declared with attribute error: BUILD_BUG_ON failed: (BTRFS_MAX_COMPRESSED % PAGE_SIZE) != 0
> 
> BTRFS_MAX_COMPRESSED being 128K, BTRFS cannot support platforms with
> 256K pages at the time being.
> 
> There are two platforms that can select 256K pages:
>  - hexagon
>  - powerpc
> 
> Disable BTRFS when 256K page size is selected.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

With updated changelog added to misc-next, thanks.
