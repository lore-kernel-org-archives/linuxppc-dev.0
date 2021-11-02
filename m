Return-Path: <SRS0=jSa2=PV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E558C433F5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 11:52:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE84560EDF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 11:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DE84560EDF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hk7ZJ3R4Nz2yPM
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 22:52:56 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hk7GG2JTwz3cBK
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Nov 2021 22:39:02 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hk7GF3VQrz4xdp;
 Tue,  2 Nov 2021 22:39:01 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Wan Jiabing <wanjiabing@vivo.com>, linux-kernel@vger.kernel.org,
 Frederic Barrat <fbarrat@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Leonardo Bras <leobras.c@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20211014075624.16344-1-wanjiabing@vivo.com>
References: <20211014075624.16344-1-wanjiabing@vivo.com>
Subject: Re: [PATCH] powerpc/pseries/iommu: Add of_node_put() before break
Message-Id: <163584789302.1845480.1021784539653281831.b4-ty@ellerman.id.au>
Date: Tue, 02 Nov 2021 21:11:33 +1100
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
Cc: kael_w@yeah.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 14 Oct 2021 03:56:04 -0400, Wan Jiabing wrote:
> Fix following coccicheck warning:
> 
> ./arch/powerpc/platforms/pseries/iommu.c:924:1-28: WARNING: Function
> for_each_node_with_property should have of_node_put() before break
> 
> Early exits from for_each_node_with_property should decrement the
> node reference counter.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/pseries/iommu: Add of_node_put() before break
      https://git.kernel.org/powerpc/c/915b368f6968122fcab31fd6441ed4ba7cc7574c

cheers
