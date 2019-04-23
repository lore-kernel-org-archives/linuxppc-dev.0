Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF5DC10F11
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 01:00:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB7A720811
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 01:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=russell.cc header.i=@russell.cc header.b="hZQWDkyz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tidqTQ9q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7A720811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44p4qP0C4tzDqNw
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 11:00:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=66.111.4.29; helo=out5-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=russell.cc header.i=@russell.cc header.b="hZQWDkyz"; 
 dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="tidqTQ9q"; dkim-atps=neutral
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44p4nY0rBXzDqLk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 10:58:24 +1000 (AEST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 0269121FE0;
 Mon, 22 Apr 2019 20:58:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Mon, 22 Apr 2019 20:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
 LoaqsJ6lDoRZMLGFv3oykiBSMzlmNYu/hbnDoYjMlB4=; b=hZQWDkyzjljBHvZc
 rUE+4IlODbtaKWdiHefDQa144QTEJPp60ik/HX/menymg99Hk/PhB41AE19Y3CgO
 EyzTwgvWvpVmPNMn6JrPk1MJrtEIFMm8xu/1aNsxg2TDvq1CX6mT8sLg3nZXEo41
 7HcRhXpTuMKFLXnPkULXDLDRIWSEu/hY5ZnSQf4yqMim0A0qAftqMn+qfRpw380O
 giNQZ2sukUqTZM/SDdFGgg+yqxoemKaYPe6IsXHpb2St5Tsv4kxpE+Grw258TUpW
 Gb5ZIrZgeEjKFxdxfOUYuSsZZwNxGsJvdaDioaFBJ48vBIVeoFZvpZ4GPAgViDpY
 TILLlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; bh=LoaqsJ6lDoRZMLGFv3oykiBSMzlmNYu/hbnDoYjMl
 B4=; b=tidqTQ9qnisvU6GYXCrHZYZcNakIeMsEMrNLPBZR2LusfGfhE2gHMENOu
 HiGK5SchFnffnFh7pxG+CC+dBimMrV/PPyID1MVTO0X4a5F14ZN1Dtpf0ieoilEK
 LxZA8Ne/qbs8ErdogbflxtCtnvnOfjCrA7ovUflljB3eFmZuj9Wu+Xjj8c9h0hbf
 dXVsJ5i0SwJGqecahejVF5DFi+xrStryzLVsgNoV25ERwetgIqSWqd1rHwJ0vY3W
 wP58QmnIcExlAn58qnes0pTm4AAtrfVO2E16dcpt1/O5WEjVWhYvFaZgWufZ2m4d
 NkDBj10L1A7kE0J4wemwAtr7x98mA==
X-ME-Sender: <xms:KWO-XKRNBC9Fkc-6mWlow4gHGh9aRxxP9_f3r8A6-fLbzSr25W4bXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrgeejgdefvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
 hrlhcuvffnffculdeftddmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttder
 jeenucfhrhhomheptfhushhsvghllhcuvehurhhrvgihuceorhhushgtuhhrsehruhhssh
 gvlhhlrdgttgeqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddvvddr
 leelrdekvddruddtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehruhhstghurhesrhhush
 hsvghllhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:KWO-XP3HRht421o4rmRdnpQsyrNp9JsvT_MiJ1B8bpeMpCkzZBwg9Q>
 <xmx:KWO-XIVH3aFtc3_wSFvzkC1EoMnJp_Ejt0zi-cD3R1vgwwDP0_cCrw>
 <xmx:KWO-XMuqLD64DziVVNYI4X6vfRdKv_qLvmZG4YtDnXksrE4mQQ93dA>
 <xmx:LWO-XBQSix0By1T9y4TtEi167pX4xIq5AKV1IQ2cwLyD5wpk2sfAxQ>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id ABDFB103CE;
 Mon, 22 Apr 2019 20:58:15 -0400 (EDT)
Message-ID: <93b691b5c538d013717f9a9326bbf77e97b58a28.camel@russell.cc>
Subject: Re: [PATCH kernel RFC 0/2] powerpc/ioda2: An attempt to allow DMA
 masks between 32 and 59
From: Russell Currey <ruscur@russell.cc>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 23 Apr 2019 10:58:12 +1000
In-Reply-To: <20190412064408.85399-1-aik@ozlabs.ru>
References: <20190412064408.85399-1-aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1 
MIME-Version: 1.0
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
Cc: Alistair Popple <alistair@popple.id.au>,
 Oliver O'Halloran <oohall@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2019-04-12 at 16:44 +1000, Alexey Kardashevskiy wrote:
> This is an attempt to allow DMA mask 40 or similar which are not
> large
> enough to use either a PHB3 bypass mode or a sketchy bypass.
> 
> This is based on sha1
> 582549e3fbe1 Linus Torvalds Merge tag 'for-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma 
> 
> Please comment. Thanks.

Seems to uniformly fail on POWER8 and sometimes on P9 too.

On P8:

[    2.423206] Failed to allocate a TCE memory, level shift=26
[    2.423351] pci 0001:03     : [PE# fd] Failed to create 32-bit TCE
table, err -12

On P9:

[    0.303055] pci 0003:01     : [PE# 1fd] Setting up 32-bit TCE table
at 0..80000000
[    0.303119] Failed to allocate a TCE memory, level shift=30
[    0.303147] pci 0003:01     : [PE# 1fd] Failed to create 32-bit TCE
table, err -12

Is it selecting the wrong TCE size?

> Alexey Kardashevskiy (2):
  powerpc/powernv/ioda: Allocate TCE table
> levels on demand for default
    DMA window
  powerpc/powernv/ioda2:
> Create bigger default window with 64k IOMMU
    pages

 arch/powerpc/include/asm/iommu.h              |  8 ++-
 arch/powerpc/platforms/powernv/pci.h          |  2 +-
 arch/powerpc/kernel/iommu.c                   | 58 +++++++++++++--
----
 arch/powerpc/platforms/powernv/pci-ioda-tce.c | 19 +++---
 arch/powerpc/platforms/powernv/pci-ioda.c     | 14 ++++-
 5 files changed, 66 insertions(+), 35 deletions(-)


