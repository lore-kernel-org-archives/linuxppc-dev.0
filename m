Return-Path: <linuxppc-dev+bounces-18736-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27302F54ADF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 17:01:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgGWz65yzz2yqf;
	Wed, 25 Mar 2026 04:01:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774371663;
	cv=none; b=IZkc3B7WVdnqiLlSjjdkF6a6zUltVLMZwytZ9MA+dl4M/TuQ2OILPf+svpeoe+nsCvG7LtUbd6y0vk3lApz9NvUJIb6cpeYU3dd4DHLpw99jaftpmdeJycauWIuu57yyBJHPn6WaEiRQBJfsFBWZtY6l+cBdciy1aI9XQA2jnpbLTVwhSw1AEGNlmOp3pZtVl/kXx2CD5UGYBcmCTfmYVOXhuIQZ7H6VtXniW9xirTjhfdVdPz6htWuWb7EypRa1APaLP+vclCJrZojOXqaALaIC4O8+j8bdJvPmcTTPcEMz0E17a+PPxg10+i8gosfXJFDItdj2GeqiZCaf+nFyrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774371663; c=relaxed/relaxed;
	bh=M0mN/BEfaeUwfXAKratLMt+/jZUNWSL3bKgrTzmMNj0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J1I0sMc9kASNfENj/pcgvp2pgtpe5zW2qTE7g3vblxwWvUNkVmov1zqxZtGzfvN+IjuyJlaaY2ndcfVVu8mPkp3NmU3rUeastrkyQr3VR0PZFN5c8HLt5OV9IUie0zdGOLpVPCRZXVsBwSptO/G/F9l29h4Eh8Kv9UmWUqBVjPATw2rP7yR+/mOzpBpocGGbbD/wT77r/ozxlaMfGTTkQFp4pnaR2CM6WIhMB1AuWyd0GULzW9dJUz75XXBQNgfciyYZZNcHwUeYOZIzKJmzSxOXE+QKkQatKzSgQW17Qjp59QMTJyjl9vXmI9EYdJjnTar2dguNmVCiQ4g0TPLPWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CHEtpaS7; dkim-atps=neutral; spf=pass (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CHEtpaS7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgGWy2JGfz2yng
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 04:01:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774371663; x=1805907663;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=9odwDAEObJO7qnios8NXzgvO+dTMZAcsFe/K0R+E/MA=;
  b=CHEtpaS7gicGyHG4ytDHRlOhnfgxoA8TcIJ/BFpkhm4bxWEGPqi9V+4e
   LqCoE6kGbvnPBXfTKGagetYVwQb//hgP4vNCleL+gijrvBttABg+smD+2
   ayyGp3KJV5ENNdVi6dP+jAiubwIZAZV54RFSDGSUvdatDWZlo5FOV5rp3
   9UiIB+C2CRyXuxOk4bSRBiqkFLPIwcdIKBlvFn9cHn8dga6lIDgqc+otX
   +n0Nh0nDCGPslTscaUiYx5+1ra6tWNfe9Hr2xg9KDQvzr+WI9a0rPr1rI
   VS1kyXeb7DT+Q9caINTA/pjDHGwFzi04OK3e5p6fOz7drr8Z/aVmVzlB/
   g==;
X-CSE-ConnectionGUID: QgNdc3L9Tlu4wqSiur9l0g==
X-CSE-MsgGUID: JH7xqPZBQ5qvD7gyAbs12g==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="78991854"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="78991854"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 10:01:00 -0700
X-CSE-ConnectionGUID: hHMisBSDR/+i1mWAm9Fh8g==
X-CSE-MsgGUID: e4f6sgI4SzaAnXpv3WumJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="254912161"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.217])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 10:00:51 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] PCI: Fix alignment calculation for resource size larger than align
Date: Tue, 24 Mar 2026 18:56:33 +0200
Message-Id: <20260324165633.4583-11-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260324165633.4583-1-ilpo.jarvinen@linux.intel.com>
References: <20260324165633.4583-1-ilpo.jarvinen@linux.intel.com>
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

The commit bc75c8e50711 ("PCI: Rewrite bridge window head alignment
function") did not use if (r_size <= align) check from pbus_size_mem()
for the new head alignment bookkeeping structure (aligns2[]). In some
configurations, this can result in producing a gap into the bridge
window which the resource larger than its alignment cannot fill.

The old alignment calculation algorithm was removed by the subsequent
commit 3958bf16e2fe ("PCI: Stop over-estimating bridge window size")
which renamed the aligns2[] array leaving only aligns[] array.

Add the if (r_size <= align) check back to avoid this problem.

Fixes: bc75c8e50711 ("PCI: Rewrite bridge window head alignment function")
Closes: https://lore.kernel.org/all/b05a6f14-979d-42c9-924c-d8408cb12ae7@roeck-us.net/
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index edc0d682dcad..e5af8799c36f 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1333,7 +1333,14 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 			r_size = resource_size(r);
 			size += max(r_size, align);
 
-			aligns[order] += align;
+			/*
+			 * If resource's size is larger than its alignment,
+			 * some configurations result in an unwanted gap in
+			 * the head space that the larger resource cannot
+			 * fill.
+			 */
+			if (r_size <= align)
+				aligns[order] += align;
 			if (order > max_order)
 				max_order = order;
 		}
-- 
2.39.5


