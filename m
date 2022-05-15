Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94EAAC433EF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 May 2022 10:17:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L1JGN0gdLz3f7R
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 May 2022 20:17:16 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L1JCD6Sptz3c8d
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 May 2022 20:14:32 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4L1JCC4Hgsz4xZ3;
 Sun, 15 May 2022 20:14:31 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: arnd@arndb.de, alastair@d-silva.org, ajd@linux.ibm.com,
 Hangyu Hua <hbh25y@gmail.com>, mpe@ellerman.id.au, gregkh@linuxfoundation.org,
 fbarrat@linux.ibm.com
In-Reply-To: <20220418085758.38145-1-hbh25y@gmail.com>
References: <20220418085758.38145-1-hbh25y@gmail.com>
Subject: Re: [PATCH] misc: ocxl: fix possible double free in
 ocxl_file_register_afu
Message-Id: <165260953458.1040779.9899337864192630526.b4-ty@ellerman.id.au>
Date: Sun, 15 May 2022 20:12:14 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Mon, 18 Apr 2022 16:57:58 +0800, Hangyu Hua wrote:
> info_release() will be called in device_unregister() when info->dev's
> reference count is 0. So there is no need to call ocxl_afu_put() and
> kfree() again.
> 
> Fix this by adding free_minor() and return to err_unregister error path.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] misc: ocxl: fix possible double free in ocxl_file_register_afu
      https://git.kernel.org/powerpc/c/950cf957fe34d40d63dfa3bf3968210430b6491e

cheers
