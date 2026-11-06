Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B52F606A32C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 16:38:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLlHM6J4Mz2xPb;
	Sat, 07 Nov 2026 03:38:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=83.223.78.233
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793983119;
	cv=none; b=hHE4hskG0ivX/qWmrEEydl0qGo0D9JAxMbqLqGkEUC8zTnIuyoSB4oFzjlujHNSW4kLvYpCswA8tVWKELfdXKybPM7+gz4ZnvMmGJ2JlLnEhaHJXHmbrfNVbHpTwgapMi2W99yCMasJXlaz8Nk+SqCKfChDGjgwTQQUz7LniH+chh8I44EvMOAjkCXwo7j+G9SAh71t4/wN2hdE/JTKxsxWSVyJAz2vmlxPn1Sxw9Qa+08LluTHmK7npYvZlbusBmolJfzc+NPCUinYsobQ6ZIKpvaNen0D2P5hdeYpbocY/rSXO6IP/56cX7fNThH14gsW7EwZNsKBPGh0AN14uAw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793983119; c=relaxed/relaxed;
	bh=jic80HyoFLmRco4YMHbShYG6FvjsucGi0Amdp6g1OKI=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=EfBGPRWQ7CWIdQ8iLkUIIIZaL3sZWFwPMXE51o+COAC1qb23Jkaidq6Dd0cNRF6+laZ3g92uikeBKP2++hoWbciFVUTfL73s8+/jLc5R7VDCkYf8s30d2Up7A0UuGk0S1e1omFmwEIEZaS0VRNF3g3X0Gl2EBQrOuBtYIAH5/jBHrH0CvsDOs8lytzY7DXG6v9xhIARllgTMWO7HDFIvWNRKyEoBzKnIIQufVu9nCkZ4hsN6+hOmp28vlrNolMAsf88n5njpi1XPKsw2TAsWybhOVWvo+XQMM6FhloIkvVOpWKu4XKNqnLAVCYOkWTeBDLkfu/QLWNHxsag6wLNWkA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=83.223.78.233; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=83.223.78.233; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLlHL5xKKz2xNC
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 03:38:36 +1100 (AEDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 6C81E1EE8;
	Fri, 06 Nov 2026 17:38:31 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 527E8602EB8B; Fri,  6 Nov 2026 17:38:31 +0100 (CET)
Message-ID: <cover.1793982724.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 6 Nov 2026 17:38:00 +0100
Subject: [PATCH v2 0/2] PCI/AER: Improve Error Source handling
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
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, Alex Deucher <alexander.deucher@amd.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Keith Busch <kbusch@kernel.org>, Maciej Grochowski <Maciej.Grochowski@sony.com>, Ilpo Jaervinen <ilpo.jarvinen@linux.intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

While analyzing log output provided by Alex, I noticed that the AER driver
fails to find the error-signaling device if the Error Source ID register
contains an invalid, non-zero value.  Fix it (patch [2/2]).

While at it, fix a potential NULL pointer deref in that portion of the code
(patch [1/2]).

Changes versus v1 in patch [2/2]:
  Reorder a < b && b < c comparisons (Ilpo, Bjorn)
  Amend kernel-doc of find_source_device() (Sathya)
  s/subordinate/secondary/ in commit message (Bjorn)
  Document behavioral change in commit message (sashiko)

Link to v1:
  https://lore.kernel.org/r/cover.1793697480.git.lukas@wunner.de

Lukas Wunner (2):
  PCI/AER: Avoid NULL pointer deref on search for Error Source
  PCI/AER: Check validity of Error Source ID register

 drivers/pci/pci.h       |  7 ++++++-
 drivers/pci/pcie/aer.c  | 37 +++++++++++++++++++++++++++----------
 drivers/pci/pcie/rcec.c | 14 ++++++++++++++
 3 files changed, 47 insertions(+), 11 deletions(-)

-- 
2.53.0


