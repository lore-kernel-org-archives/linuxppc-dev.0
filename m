Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3A6C282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 06:43:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBCB82175B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 06:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bIbSSDbE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBCB82175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43w80J6BDxzDqNG
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 17:43:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=66.111.4.26; helo=out2-smtp.messagingengine.com;
 envelope-from=tobin@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="bIbSSDbE"; dkim-atps=neutral
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43w7Hy31hpzDqMn
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 17:11:58 +1100 (AEDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 88477216C5;
 Thu,  7 Feb 2019 01:03:40 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Thu, 07 Feb 2019 01:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=kybLdcasHY90S2gQe
 i36OgIfnRf0JHFY0mLaV69S/wU=; b=bIbSSDbEykRBKdvpAhz3CA9JqcEx20ZAE
 T8521aL7zl1m5u+YKFB5FU6/Ga+uGdfI4TBZNiIJcg0YXOgSi68VU7eMp7BaAp9d
 dce1zoZkX1fJpcgvf3ohKtd2gEEvHHdvKP+Fc+w7kQLaYuMeGAiUVUJaVYBYJTFL
 9YqHZQVecGThybGf47+QtFkxDWvqzTAes+he97ON+gFyuCKaf0uwu0OBtgkuPpyz
 PvQj+KPZDl9QvSjLE3031gteT00L00Pf0uDlOFiXJUVcc4nhR62VxNc/rZsn6m3n
 arB1B34fe7vWKKdBlkiEdAsUR7I2xPvBvwP7Bb1z1COjtZUP2pMAA==
X-ME-Sender: <xms:O8pbXNQxXRW_JGGnLBL2cm2f55FS89hoXIwZh3PHYKTlho3QGt_hUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrkeelgdekkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
 tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffogg
 fgsedtkeertdertddtnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcu
 oehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecukfhppeduvddurdeggedrvddviedrud
 ejleenucfrrghrrghmpehmrghilhhfrhhomhepthhosghinheskhgvrhhnvghlrdhorhhg
 necuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:O8pbXKmDl-JDFGx9MRS7GaML-CMECMoGs0yccizsuJCPxiquSs-b1Q>
 <xmx:O8pbXL5E5tp68kdDK9BBZJ24pnoXFnmCL5_65xr2wyJ63kCySP4bFQ>
 <xmx:O8pbXIhU0KxtGkqmeu-hUmUpzEOXRFPhxQB-NyvynFtU6oWNx89AYQ>
 <xmx:PMpbXC_KwOcql2wyBTdngtge1TVuNP6BujYEbhVm5ATPOnU-E3HyiA>
Received: from eros.localdomain (ppp121-44-226-179.bras2.syd2.internode.on.net
 [121.44.226.179])
 by mail.messagingengine.com (Postfix) with ESMTPA id 32B7DE425A;
 Thu,  7 Feb 2019 01:03:36 -0500 (EST)
From: "Tobin C. Harding" <tobin@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 0/1] Start conversion of PowerPC docs
Date: Thu,  7 Feb 2019 17:03:15 +1100
Message-Id: <20190207060316.3221-1-tobin@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 07 Feb 2019 17:40:26 +1100
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
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "Tobin C. Harding" <tobin@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Michael,

As discussed at LCA here is the start to the docs conversion for PowerPC
to RST.

This applies cleanly on top of the mainline (5.20-rc5) and Jon's tree
(docs-next branch).

I'm guessing it should go in through the PowerPC tree because I doubt
you want to review this Jon, it's one big single patch (all blame for
that falls on mpe ;)

This patch converts all the files that do _not_ contain ASCII art - I'm
not sure how to go about doing those, suggestions please.

From the commit message:

 - Add SPDX license identifier to each new RST file.

    .. SPDX-License-Identifier: GPL-2.0

 - User correct heading adornments.

 - Make all lines < 72 characters in width.

 - Use correct indentation for code blocks, add syntax highlighting

 - Sparingly use double ticks if it makes the files easier to parse
   both in text and on the web.

 - Fix any super obvious typos (lean towards not making changes so that
   we don't introduce errors).

Edited as text files (obviously) and formatted as HTML to verify
rendering, no other formats verified.

thanks,
Tobin.

Tobin C. Harding (1):
  docs: powerpc: Convert docs to RST format.

 Documentation/index.rst                       |   1 +
 Documentation/powerpc/DAWR-POWER9.rst         |  60 ++++
 Documentation/powerpc/DAWR-POWER9.txt         |  58 ---
 Documentation/powerpc/bootwrapper.rst         | 140 ++++++++
 Documentation/powerpc/bootwrapper.txt         | 141 --------
 Documentation/powerpc/conf.py                 |  10 +
 Documentation/powerpc/cpu_features.rst        |  62 ++++
 Documentation/powerpc/cpu_features.txt        |  56 ---
 .../powerpc/eeh-pci-error-recovery.rst        | 319 +++++++++++++++++
 .../powerpc/eeh-pci-error-recovery.txt        | 334 ------------------
 Documentation/powerpc/index.rst               |  21 ++
 Documentation/powerpc/isa-versions.rst        | 234 ++++++++----
 Documentation/powerpc/mpc52xx.rst             |  52 +++
 Documentation/powerpc/mpc52xx.txt             |  39 --
 Documentation/powerpc/pmu-ebb.rst             | 148 ++++++++
 Documentation/powerpc/pmu-ebb.txt             | 137 -------
 Documentation/powerpc/ptrace.rst              | 177 ++++++++++
 Documentation/powerpc/ptrace.txt              | 151 --------
 .../{syscall64-abi.txt => syscall64-abi.rst}  |  80 +++--
 .../powerpc/transactional_memory.rst          | 259 ++++++++++++++
 .../powerpc/transactional_memory.txt          | 244 -------------
 21 files changed, 1460 insertions(+), 1263 deletions(-)
 create mode 100644 Documentation/powerpc/DAWR-POWER9.rst
 delete mode 100644 Documentation/powerpc/DAWR-POWER9.txt
 create mode 100644 Documentation/powerpc/bootwrapper.rst
 delete mode 100644 Documentation/powerpc/bootwrapper.txt
 create mode 100644 Documentation/powerpc/conf.py
 create mode 100644 Documentation/powerpc/cpu_features.rst
 delete mode 100644 Documentation/powerpc/cpu_features.txt
 create mode 100644 Documentation/powerpc/eeh-pci-error-recovery.rst
 delete mode 100644 Documentation/powerpc/eeh-pci-error-recovery.txt
 create mode 100644 Documentation/powerpc/index.rst
 create mode 100644 Documentation/powerpc/mpc52xx.rst
 delete mode 100644 Documentation/powerpc/mpc52xx.txt
 create mode 100644 Documentation/powerpc/pmu-ebb.rst
 delete mode 100644 Documentation/powerpc/pmu-ebb.txt
 create mode 100644 Documentation/powerpc/ptrace.rst
 delete mode 100644 Documentation/powerpc/ptrace.txt
 rename Documentation/powerpc/{syscall64-abi.txt => syscall64-abi.rst} (58%)
 create mode 100644 Documentation/powerpc/transactional_memory.rst
 delete mode 100644 Documentation/powerpc/transactional_memory.txt

-- 
2.20.1

