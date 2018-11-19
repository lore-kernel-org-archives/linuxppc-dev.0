Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE8CC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 02:46:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 500342080C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 02:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TzTV2XHW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 500342080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ytWr49fDzF35f
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 13:46:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="TzTV2XHW";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (helo)
 smtp.helo=wout2-smtp.messagingengine.com (client-ip=64.147.123.25;
 helo=wout2-smtp.messagingengine.com; envelope-from=ruscur@russell.cc;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="TzTV2XHW"; dkim-atps=neutral
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ytSj1MMtzF3cB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2018 13:43:49 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 8617D966;
 Sun, 18 Nov 2018 21:43:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Sun, 18 Nov 2018 21:43:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=k4judxvnQqY4gxG2Ew236YLz5HTm5ZsyoOzfNiUOJ
 y4=; b=TzTV2XHWYVIJsqmbzmBruAIPqxv4EpAEqqsER9dF4KbOY2LcBjhVvxgci
 f7i3qraS4WEft9LP6r0IUkrkV8bswEYh3W1yciSzKNhUob907DZ68O9EhDdHNxxG
 vMZQxKttYKq5aJvBenrnmJAhtdbljZoafCQIFXFFTRT1ydPZBDYD07VFsH1gJUSO
 XFk3MJLlaX/OadACA4D25nbW2eOjCrSlAS6J8mi+icJJs/9eUaeC7cZ+nqsqi9AA
 sZKcrEa/Wd7R8wEW3ccWvKvUVtMUcw67KsXCU0ogVNauIysS0m1kQwYQfQICxeNv
 6VydGrgaYGnIUT3aroekuvp8iQXag==
X-ME-Sender: <xms:YCPyW_NzaXUvWQPMCU119xDrBiAdw5Pbi00uevVPInxyJ5rmkZznJw>
X-ME-Proxy: <xmx:YCPyW-CrCd3rBboaNnLDeX1Jj4bysAY_NtbdTupFL7jzT0bk4S3p1A>
 <xmx:YCPyW0TYi5o3qFujXfGdoWAiqqhXS_QxlBKxs-aVjxxc3E5nGt_HzQ>
 <xmx:YCPyW6Kstsg-WB_q2aFGceE6F87sWtBxi4zOqXkFblO7AIWtIjrSLA>
 <xmx:YCPyW95CxzJ4lq0vJJYdcnjAtNWUgLpYNEJTv8yMd2AypDGb9zFf4Q>
 <xmx:YCPyW9e9AG088DjA9MbyovugK4dG4oirRkI3_hePMeHXEqQpzjB_5g>
 <xmx:YiPyW63lxPywTu2Qbs8iIQiPXlsGkQjC_8hKVOy_mG_p8NFBs5ZrGA>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id C490BE405B;
 Sun, 18 Nov 2018 21:43:41 -0500 (EST)
Message-ID: <63177c72b94a653707d6b984ca789ecf8ebf0a95.camel@russell.cc>
Subject: Re: [RFC PATCH v1 3/6] powerpc: Add skeleton for Kernel Userspace
 Execution Prevention
From: Russell Currey <ruscur@russell.cc>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>
Date: Mon, 19 Nov 2018 13:44:08 +1100
In-Reply-To: <1b27e980fa8dda09955b35be09c99bb1e22fef70.1541568127.git.christophe.leroy@c-s.fr>
References: <ab8fcb458e1a6ad86382767b3ce7f7cc0d5b7121.1541568127.git.christophe.leroy@c-s.fr>
 <1b27e980fa8dda09955b35be09c99bb1e22fef70.1541568127.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2018-11-07 at 16:56 +0000, Christophe Leroy wrote:
> This patch adds a skeleton for Kernel Userspace Execution Prevention.
> 
> Then subarches implementing it have to define CONFIG_PPC_HAVE_KUEP
> and provide setup_kuep() function.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

An open question (with nothing to do specifically with this patch):

For what reason would you ever disable execution prevention?  Clearly
there must be something since "nosmep" is a thing, but I don't know why
we'd ever do it.

- Russell

