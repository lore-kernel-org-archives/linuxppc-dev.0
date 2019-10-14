Return-Path: <SRS0=PY1v=YH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A3EC47404
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Oct 2019 05:29:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91EAB206A3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Oct 2019 05:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=russell.cc header.i=@russell.cc header.b="frWQEcn2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GCW3n7vi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91EAB206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46s6Ym31TqzDqN7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Oct 2019 16:29:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=64.147.123.25; helo=wout2-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=russell.cc header.i=@russell.cc header.b="frWQEcn2"; 
 dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="GCW3n7vi"; dkim-atps=neutral
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46s6NM2CsczDqW5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Oct 2019 16:21:07 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 574693BA;
 Mon, 14 Oct 2019 01:13:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Mon, 14 Oct 2019 01:13:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm3; bh=EhrH61vzh+La+AA9yvD4XTf/Wk
 RGulZxThOS+PjIlj0=; b=frWQEcn2VPrmJn0HFITZXxTmembBWzfYgE4Nps8uhg
 ZMLxq/6+vy5hEaZKgDsb+YceZm4A0PEMyQ74AJQ16j54G7D8cW7c9G3hARj+y2Z4
 3PSvxLqbz1wh46XGTma5HJEHvyo4yahqwaGBIVSrcvBf/47N82EAg7Wbxygfssbu
 5ylrTXIsrcj8C5BNS8k7ohGsc5Uc6dQ5ZkrD5kjJxQR/LVznFE9gBBN2d0gEA+By
 5czVd/s4RdxcLeMhQyHZZ+rJLS8w1H+g7WyWoQHO6lFfsO/t6CjKo2Qkm2z6LYdz
 3laTx9l8V7Tzq6F6a6KNOqVFYy5ZjSQ3JFMPUa5jgT7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=EhrH61vzh+La+AA9y
 vD4XTf/WkRGulZxThOS+PjIlj0=; b=GCW3n7vitd7TCZX+i0M1TjDfbCzz2957G
 M1vixDQY7i6X28p4axE2EXeFa/a5Zqco3oVvRJgZJU5tsWKVAwEqDNRICnO//GCl
 9I9FWNO5HIfcbXDQZE0DHn7tKs7P9jUb8im+E9Da0EqkRYbOnMI0eUuWiRS3aSdI
 65tdjObHkDjy7uF8TBe0qQa0AGpRfofLv/dcuQZxFkb1H+8hL/tusvhtfHxfA8hV
 a28DU4tbKmje9cfAviv+SC1IIx9iU6xQf33l7Dhqb1ue5wVgiG3/NNZjXmskxTEX
 emPAlyBY5qdkGXFqDduZhhSZVXYInJwSwfiQ+/417JCtObDXQOECg==
X-ME-Sender: <xms:CQSkXfKXcWaFfnUwPuTEY14HyfxWuiOEk--ofyNEasge29dZr8lFgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrjedtgdelgecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdduhedmnecujfgurhephffvuf
 ffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftuhhsshgvlhhlucevuhhrrhgvhicu
 oehruhhstghurhesrhhushhsvghllhdrtggtqeenucffohhmrghinhepohiilhgrsghsrd
 horhhgnecukfhppeduvddvrdelledrkedvrddutdenucfrrghrrghmpehmrghilhhfrhho
 mheprhhushgtuhhrsehruhhsshgvlhhlrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:CQSkXTSfiqZeV9Y5AIkJqcAionKagvnL9Kyxaxe004WL28NiezQHnA>
 <xmx:CQSkXfqK0b2vJjIWYWsYNiRSNflo33t-VSOEOP0B0qq7KIE0VS4gDQ>
 <xmx:CQSkXQqJu2KiZXKlg520ozGt0ka8VkSPQttqik6XE0dAwya0qQmHQg>
 <xmx:CgSkXZlELP-5Yo_YwyuERfKYQMyhkzoIV0JxiS5a9q1A_L4k7qJO3g>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id BE26D80061;
 Mon, 14 Oct 2019 01:13:42 -0400 (EDT)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 0/4] Implement STRICT_MODULE_RWX for powerpc
Date: Mon, 14 Oct 2019 16:13:16 +1100
Message-Id: <20191014051320.158682-1-ruscur@russell.cc>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
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
Cc: ajd@linux.ibm.com, kernel-hardening@lists.openwall.com, npiggin@gmail.com,
 joel@jms.id.au, Russell Currey <ruscur@russell.cc>, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

v3 cover letter here:
https://lists.ozlabs.org/pipermail/linuxppc-dev/2019-October/198023.html

Only minimal changes since then:

- patch 2/4 commit message update thanks to Andrew Donnellan
- patch 3/4 made neater thanks to Christophe Leroy
- patch 3/4 updated Kconfig description thanks to Daniel Axtens

Russell Currey (4):
  powerpc/mm: Implement set_memory() routines
  powerpc/kprobes: Mark newly allocated probes as RO
  powerpc/mm/ptdump: debugfs handler for W+X checks at runtime
  powerpc: Enable STRICT_MODULE_RWX

 arch/powerpc/Kconfig                   |  2 +
 arch/powerpc/Kconfig.debug             |  6 ++-
 arch/powerpc/configs/skiroot_defconfig |  1 +
 arch/powerpc/include/asm/set_memory.h  | 32 ++++++++++++++
 arch/powerpc/kernel/kprobes.c          |  3 ++
 arch/powerpc/mm/Makefile               |  1 +
 arch/powerpc/mm/pageattr.c             | 60 ++++++++++++++++++++++++++
 arch/powerpc/mm/ptdump/ptdump.c        | 21 ++++++++-
 8 files changed, 123 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/include/asm/set_memory.h
 create mode 100644 arch/powerpc/mm/pageattr.c

-- 
2.23.0

