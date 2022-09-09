Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8E6ECAAD3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Sep 2022 12:18:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MPFQf0PVMz3gWp
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Sep 2022 22:18:50 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MPFDr0Jymz3c70
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Sep 2022 22:10:20 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4MPFDq68V6z4xcg;
	Fri,  9 Sep 2022 22:10:19 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: agust@denx.de, paulus@samba.org, christophe.leroy@csgroup.eu, Liang He <windhl@126.com>, maz@kernel.org, benh@kernel.crashing.org, wangqing@vivo.com, mpe@ellerman.id.au
In-Reply-To: <20220616144007.3987743-1-windhl@126.com>
References: <20220616144007.3987743-1-windhl@126.com>
Subject: Re: [PATCH] powerpc: platforms: 52xx: Fix refcount leak in media5200.c
Message-Id: <166272522307.2076816.4288363534230982761.b4-ty@ellerman.id.au>
Date: Fri, 09 Sep 2022 22:07:03 +1000
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
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 16 Jun 2022 22:40:07 +0800, Liang He wrote:
> In media5200_init_irq(), of_find_compatible_node() will return a
> node pointer with refcount incremented. We should use of_node_put()
> in fail path or when it is not used anymore.
> 
> Don't worry about 'fpga_np==NULL' as of_node_put() can correctly
> handle it.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: platforms: 52xx: Fix refcount leak in media5200.c
      https://git.kernel.org/powerpc/c/593d7b89c6a2bf7aea2324c94f10ef3c21308418

cheers
