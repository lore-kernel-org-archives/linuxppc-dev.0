Return-Path: <SRS0=fNlO=HK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD38C433E0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Feb 2021 11:40:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C9BA64E6E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Feb 2021 11:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C9BA64E6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DZ3x63RB9zDsZ7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Feb 2021 22:40:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=jeyu@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ubHOUH2l; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DZ3rZ0s9BzDsYt
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2021 22:36:29 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6780F64E40;
 Mon,  8 Feb 2021 11:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612784185;
 bh=fBp9LiWsmCqhuaI9wcJM8SBAr5veZ226g9+wpY2pX+k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ubHOUH2l2tFZUF2ynWkVVod7BUYjSKuOSrCEIvHN0ZJyFeqBx8hPUkx8ibDvJM6cp
 nYgvBXrN7yP6JPyVxnB5Vl25KRr4gUYEtwf8ZWhdKErl70xdsLpHW/kxIlsvpTL2KU
 7wshBHn6WQ/X9D2rLICFJKJ6l/CWRLTblBGEIZjFAboNqwhE1W6cXhnVCMmg+s3RK8
 t3HE2TPmQBQPngHWdOQeK67EAanjk7crsmyGh7z9toVdi4bcIA4jwAmSMy7m/GHEBq
 aCd9u393CVZ+h6B9r1/Qqj4tW0JbbTw8jCs10nzwjrpRirqCtk8wVn3xF8/6XFQklM
 6j1XdiBtOr5PQ==
Date: Mon, 8 Feb 2021 12:36:18 +0100
From: Jessica Yu <jeyu@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: module loader dead code removal and cleanups v3
Message-ID: <YCEiMoWRLj+lpNqS@gunter>
References: <20210202121334.1361503-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210202121334.1361503-1-hch@lst.de>
X-OS: Linux gunter 5.10.9-1-default x86_64
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
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Andrew Donnellan <ajd@linux.ibm.com>, linux-kbuild@vger.kernel.org,
 David Airlie <airlied@linux.ie>, Masahiro Yamada <masahiroy@kernel.org>,
 Jiri Kosina <jikos@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 live-patching@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>,
 dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Frederic Barrat <fbarrat@linux.ibm.com>,
 Daniel Vetter <daniel@ffwll.ch>, Miroslav Benes <mbenes@suse.cz>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

+++ Christoph Hellwig [02/02/21 13:13 +0100]:
>Hi all,
>
>this series removes support for long term unused export types and
>cleans up various loose ends in the module loader.
>
>Changes since v2:
> - clean up klp_find_object_symbol a bit
> - remove the now unused module_assert_mutex helper
>
>Changes since v1:
> - move struct symsearch to module.c
> - rework drm to not call find_module at all
> - allow RCU-sched locking for find_module
> - keep find_module as a public API instead of module_loaded
> - update a few comments and commit logs
>
>Diffstat:

Queued on modules-next (along with the updated patch 10).

Thanks everyone,

Jessica
