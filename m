Return-Path: <linuxppc-dev+bounces-22722-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEEDFCD98E4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 16:31:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfsvH38FWz3c3v;
	Wed, 17 Jun 2026 02:31:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781627499;
	cv=none; b=GlMZ3UzAtfayZBX7RtF/gdpGWTtE9SY71d7kKJyd8+Bm0WSK8x5en6KWPx6hoAHZL3eAoLo8KxpZvSedwegVFNEAUrqD6XAJp630X+J6dw9ASVOzTNjNbh4DND2lUthCL/fD8+AcyvKWNs3C0JrF2hU3OOSLZPThJZ1x0t52WF4fs+4PDkh9sAsMjuSpGC6Es7aPrBCp4npww6imPmRMeGnrUMWS0z5eCxzYRbioDvvTzgAfTjl+e2U9PhLm+tXHy5lk+NTHeA2swTYNRGWCFJXeHq8sCr7A4pfsImnTOaog+E5q0IcxDXhW05D5MCyMaKiYA5Yhq3cfcMdjP0HH6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781627499; c=relaxed/relaxed;
	bh=Aozp2zOujumcKC8wqP2GFQ/wgspA7yyR0yTI4pEy3A8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YCvKQ5mzLDq8ng6Kpt8GKd1qpSYkYDXvVZJ8E23cZEDxbXBlGq4kBkAowtfTCdCwJ2SE3auLBc6CQUy7JZQ6977waaAvH5N/oCEtgEKANf2vzNkRolwA1pu8SkO7uQZnok5evHcqzWmMBKOjdS2rFBN/9b5FJSMsYTFol+OCaO5UrCDy8avBiCpbickr4s3VDJh2yzlRb7FfEeWrAjIhf75aqNuGFDC9fKHP0VNveMys1Pn3PInEM8yx/yy3EYX+G05qx4iRbIZOlfC4l57m+swu/O47hM9pd2MmfSd7jsbpAkRhBesf0uQqqxJofOsQv0qrvLlN1KHOKaONbRVgxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PeOtgSdi; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PeOtgSdi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfsvF6B0Tz3c3W
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2026 02:31:37 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id F3D336001A;
	Tue, 16 Jun 2026 16:31:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007BD1F000E9;
	Tue, 16 Jun 2026 16:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781627494;
	bh=Aozp2zOujumcKC8wqP2GFQ/wgspA7yyR0yTI4pEy3A8=;
	h=From:To:Cc:Subject:Date;
	b=PeOtgSdipUz/dqe4naZWkmAQOeCNzvh1py/zkymBX8MZu8AKlymel6AcpyGAOgS/1
	 fjFdjZqZ9ldDhL3U0F6LsVafxqeScMQbRTioRZ1Zf1TXd0C3khnuvtEEGH1N/nYGXw
	 M+2FMv6tTj0aAyaR8kV+1C55ettjtdzibRFOy9AwMcisxJiuhPuE8Agw2b7aHMP5Ya
	 0tWtSq+RH28C90yALpvPZqXJJtqDd8B9mBPauCCRpGO8mPF5n8+JDrh/rWzxM6usLQ
	 UidwkO8Ss7VvC1tBVLmcnNfeNmBmW72fTQoDLKH7KbaHHRFSK8kXg22YRiazdLIsJI
	 LyiJ4yGO7piKw==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 1/2] PCI/sysfs: Fix out-of-bounds read in pci_write_legacy_io()
Date: Tue, 16 Jun 2026 16:31:30 +0000
Message-ID: <20260616163131.2763281-1-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci_write_legacy_io() loads 4 bytes from the kernfs write buffer
regardless of how many bytes userspace wrote:

  if (count != 1 && count != 2 && count != 4)
          return -EINVAL;

  return pci_legacy_write(bus, off, *(u32 *)buf, count);

kernfs_fop_write_iter() allocates the buffer with kmalloc(len + 1),
so a 1-byte write to the legacy_io sysfs file allocates 2 bytes and
the unconditional u32 load reads up to 2 bytes past the end of the
allocation, which KASAN reports as a slab-out-of-bounds read.
Similarly, a 2-byte write overreads by 1 byte.

Thus, read only the number of bytes requested using get_unaligned_le16()
and get_unaligned_le32() for the 2 and 4 byte cases, interpreting the
buffer as little-endian to match the byte ordering of PCI I/O port
space.

The PowerPC implementation previously compensated for the generic
code's native-endian 32-bit load by shifting the value into place
for the 1 and 2 byte cases.  The shifts were only correct on
big-endian kernels.

On little-endian PowerPC (POWER8 and later), they extracted the wrong
bytes, so a 1-byte write wrote an out-of-bounds byte instead of the
requested value.  On big-endian, the native load also caused out_le16()
and out_le32() to reverse the user's bytes on the wire for 2 and 4 byte
writes.  The little-endian helpers resolve both issues, so the shifts
are removed.

No changes are needed for the Alpha platform.

The legacy_io file is root-only and exists only on Alpha and PowerPC,
the two architectures that define HAVE_PCI_LEGACY.

Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/powerpc/kernel/pci-common.c |  9 ++-------
 drivers/pci/pci-sysfs.c          | 18 +++++++++++++++---
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 8efe95a0c4ff..fdc57fa2ece6 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -626,19 +626,14 @@ int pci_legacy_write(struct pci_bus *bus, loff_t port, u32 val, size_t size)
 		return -ENXIO;
 	addr = hose->io_base_virt + port;
 
-	/* WARNING: The generic code is idiotic. It gets passed a pointer
-	 * to what can be a 1, 2 or 4 byte quantity and always reads that
-	 * as a u32, which means that we have to correct the location of
-	 * the data read within those 32 bits for size 1 and 2
-	 */
 	switch(size) {
 	case 1:
-		out_8(addr, val >> 24);
+		out_8(addr, val);
 		return 1;
 	case 2:
 		if (port & 1)
 			return -EINVAL;
-		out_le16(addr, val >> 16);
+		out_le16(addr, val);
 		return 2;
 	case 4:
 		if (port & 3)
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index d37860841260..b56000ba3a33 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -933,12 +933,24 @@ static ssize_t pci_write_legacy_io(struct file *filp, struct kobject *kobj,
 				   char *buf, loff_t off, size_t count)
 {
 	struct pci_bus *bus = to_pci_bus(kobj_to_dev(kobj));
+	u32 val;
 
-	/* Only support 1, 2 or 4 byte accesses */
-	if (count != 1 && count != 2 && count != 4)
+	/* Only support 1, 2 or 4 byte accesses. */
+	switch (count) {
+	case 1:
+		val = *(u8 *)buf;
+		break;
+	case 2:
+		val = get_unaligned_le16(buf);
+		break;
+	case 4:
+		val = get_unaligned_le32(buf);
+		break;
+	default:
 		return -EINVAL;
+	}
 
-	return pci_legacy_write(bus, off, *(u32 *)buf, count);
+	return pci_legacy_write(bus, off, val, count);
 }
 
 /**
-- 
2.54.0


