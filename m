Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8495A606A32C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 09:45:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJkFn22VBz2xMQ;
	Tue, 03 Nov 2026 20:45:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=83.223.78.233
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793699117;
	cv=none; b=HTiQtNMlCekLtm9WRU26W7eSb08zU37BWK4rBMa6q/2V0rpLCNGe9vT2EqmYEHD5GA39J6QvpVDiccu+VJ/3olKkc5NDV9mUAaqo1P+QgRtrimk7UI8xcM7lorjbB5/DeUxxvFcSa4htqlqGNS76KfzEkTwTNtPyOr5Fufmp+Jb9o3vQakbhlaQnTWuwDvvd1J8DEoj5XnHiwEfnJruvcNiVDs99DUMhDayCwJVkphebCoNNOuL/rhedk7yeLlciL6UQmg1PIl4i0OftQgSbBQ/d5qRT0SvkNp9lZITj6p/xDoGS/dCCZuPoNX61ZEva/LBnZ+hTS9cmwa8+L4K0ig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793699117; c=relaxed/relaxed;
	bh=DFR/PANMtbsevfEku4Z3pizYVHHbGGcn40b739MWAyg=;
	h=Message-ID:From:Date:Subject:To:Cc; b=ohY79F72VQCLOa40+9MdXL3YIj+1nG4Elz3KgxlcNg4sOmRxVLnabaTZdOHsRx+fx+KhVH2ohPR7x1jkT4+xEBC7718Zz4AtkdMiEEcqwXerQH3OtxGk7gn5OkpsfsTuuHDatgDtIRNWjJO3T55U3Uz4HqvcGlT6YGMTo909Ug7ObykzLnwLs3GwfkOW3feYGk4SfZX3grhPRv7oJBynlkzBdXuDEPmNVefegC4AanOu7uVGtHYDZ9atOvO5E1czReOcePTfiCJ4FZOxCm9oZzJsmlHkbj2cE7NtuQ0GTFs0ym2vuwYEOKUvLByo69lRyUFBhncwg54qWx4hGn0YLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=83.223.78.233; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=83.223.78.233; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJkFl66pQz2xK7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 20:45:12 +1100 (AEDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 7CB471EC8;
	Tue, 03 Nov 2026 10:45:06 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6DFA661C2345; Tue,  3 Nov 2026 10:45:06 +0100 (CET)
Message-ID: <cover.1793697480.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 3 Nov 2026 10:45:00 +0100
Subject: [PATCH 0/2] PCI/AER: Improve Error Source handling
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, Alex Deucher <alexander.deucher@amd.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Keith Busch <kbusch@kernel.org>, Maciej Grochowski <Maciej.Grochowski@sony.com>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>

While analyzing log output provided by Alex, I noticed that the AER driver
fails to find the error-signaling device if the Error Source ID register
contains an invalid, non-zero value.  Patch [2/2] fixes that.

Also, a potential NULL pointer deref caught my eye in that portion of the
code which is fixed by patch [1/2].  I believe this is hard to trigger,
but the kernel should still handle it gracefully.

Lukas Wunner (2):
  PCI/AER: Avoid NULL pointer deref on search for Error Source
  PCI/AER: Check validity of Error Source ID register

 drivers/pci/pci.h       |  7 ++++++-
 drivers/pci/pcie/aer.c  | 35 ++++++++++++++++++++++++++---------
 drivers/pci/pcie/rcec.c | 14 ++++++++++++++
 3 files changed, 46 insertions(+), 10 deletions(-)

-- 
2.53.0


