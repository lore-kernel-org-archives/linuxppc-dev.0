Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47115C19F2C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Aug 2022 11:03:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LxsYG5xHjz3f4l
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Aug 2022 21:03:30 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LxsXT2cQbz2xGd
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2022 21:02:49 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4LxsXT0B3Tz4x1L;
	Tue,  2 Aug 2022 21:02:49 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Miaoqian Lin <linmq006@gmail.com>
In-Reply-To: <20220605065129.63906-1-linmq006@gmail.com>
References: <20220605065129.63906-1-linmq006@gmail.com>
Subject: Re: [PATCH] powerpc/cell/axon_msi: Fix refcount leak in setup_msi_msg_address
Message-Id: <165943814479.1061647.2007889797474531468.b4-ty@ellerman.id.au>
Date: Tue, 02 Aug 2022 21:02:24 +1000
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, 5 Jun 2022 10:51:29 +0400, Miaoqian Lin wrote:
> of_get_next_parent() returns a node pointer with refcount incremented,
> we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() in the error path to avoid refcount leak.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/cell/axon_msi: Fix refcount leak in setup_msi_msg_address
      https://git.kernel.org/powerpc/c/df5d4b616ee76abc97e5bd348e22659c2b095b1c

cheers
