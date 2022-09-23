Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7975EECAAD8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Sep 2022 11:15:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MYqMF6Szdz3fGl
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Sep 2022 21:15:37 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MYqLp0WlWz3f8M
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2022 21:15:14 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4MYqLn6M8Lz4xFv;
	Fri, 23 Sep 2022 21:15:13 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20220906010313.1296714-1-mpe@ellerman.id.au>
References: <20220906010313.1296714-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/pasemi: Use of_root in pas_pci_init()
Message-Id: <166393170145.499516.14147367798894411501.b4-ty@ellerman.id.au>
Date: Fri, 23 Sep 2022 21:15:01 +1000
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

On Tue, 6 Sep 2022 11:03:13 +1000, Michael Ellerman wrote:
> Currently in pas_pci_init() a reference to the root node is leaked due
> to a missing of_node_put(). Instead just use of_root directly.
> 
> Note that converting to of_find_compatible_node(NULL, ...) would
> not be entirely equivalent, because that would check the compatible
> property of the root node, whereas using of_root skips checking the root
> node and start the search at the first child of the root.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/pasemi: Use of_root in pas_pci_init()
      https://git.kernel.org/powerpc/c/c28c2d4abdf95655001992c4f52dc243ba00cac3

cheers
