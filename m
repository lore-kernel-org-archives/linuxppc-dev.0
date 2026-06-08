Return-Path: <linuxppc-dev+bounces-22204-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDF9CD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:28:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYvXg2Rvkz30FP;
	Tue, 09 Jun 2026 00:28:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780928899;
	cv=none; b=C+ewOzVIHzsCOl/veA9XKz8dCYf+qGg66jtBGOHMwxsjVUWl1BVDNCmoyQT9OVbqjkk45Qs3uNZXQ33Bfxo7MnIWvyR2FX/VD4SAb56r7YAhICw522sYz+LCEQkOg1ngx0tuk+NZNJBtLw4L9YGqkiAesctM+0K5rhhnvZHiv3L5QpVU6AqoHmn5xJ9Z/6ndvNxbDMrNFRB0i/Mw4v00FhJZyTHkCc/MjJd4KYozil4qm/MK5Yf5+946gVajtBMdiMdcn9Uz+Lq7sABHWrsFvkT7ZEankoeEKKZc4KfwboHkvLmue45D+FxsbY11ZIEf7urAihpr4BLPmUIG1mzfFA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780928899; c=relaxed/relaxed;
	bh=VmsMCsySwkboeE/wYirejWrkdI8tJ+BFCA1yM7dXRi4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=aGeecVqGBefdRva3sre5pOlv7jOuqEgJZ+2QjS4+7Owextluvc01AXs5heEZe0KfAumATEV4LE9pMfVpATET6oavo4Wiwh+Xs4QbuQV/XJd+oKXLRtvR4KTmhEZJiUpwb7lHpS6KWJwgg1OIykf1wbJNDHRE0vuU0fQsHjItiAax503RHmIbdmOQN3yWsilNaulID4FAH83HHbtNMRwkesJq7ARktaPlfZc+b7a0SZj3ub/bN0PGOnHhLYNogZjcrPi/mgQgfgw1ILYUjAwQjJ7vUfdPe3x7opt47/XAbWF9uXgzplcAgQivurrmJy/Pz+t0EFzqfbwZVw3BtP0EuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Jtt96I9Y; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=iacobcatalin@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Jtt96I9Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=iacobcatalin@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYvXd5mgzz2yS0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:28:16 +1000 (AEST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4905529b933so47641145e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 07:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780928892; x=1781533692; darn=lists.ozlabs.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VmsMCsySwkboeE/wYirejWrkdI8tJ+BFCA1yM7dXRi4=;
        b=Jtt96I9YWA3nCbSr+txqDZSDAPZvF3d+eQPe+W1mn8jQzN2owhZ3yvLmZ+xn8K21NB
         znk3kJrR+gVsIcfRpbCR7btCv/ynzvsVUQM7JcgwOs3OGZceEFOfJJGD0nDb+1iptTcW
         r53DFTpJMbO+dxxrbm2MY9klt+9ltrvGRGTRi1nZUJ1EJAoaEyt3OJaXLR8b27MVXlYZ
         5Sn8gPGTJ9b2D62xsoyOm//XBM1nnWg60sEUCWgIhCoxR3RFNa5Yn7jXrqQMTbt+GaAb
         OCyDhYIGlJrtQ/3NKkEtYUy8PcIodKY412dgHHtMicW8qAAuXerzD+5gLAFju/Qx2SOt
         7IfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780928892; x=1781533692;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmsMCsySwkboeE/wYirejWrkdI8tJ+BFCA1yM7dXRi4=;
        b=dochuFhPuP9tyQWhm6txLDGzLfwbR59PIWd/HFp+U19jadCkSdXrjQI7awjJNAcA15
         W1BkT2kwCcDHpN3c1wpnAlMZy+gASKg3bznzO9198qhyIPscCGO/R1BA8FDJBE1au7ar
         eRD0nwsstFfykPR89+fl9H0tZf9KE/hnHRMpubO5QLvWpLSyqfrZn2B+n7bSuaF/Cc1Q
         w67L1VxduszryQntTctIjGWGEBpiXQJ5IgI6UfoLrZxMT8IuM/khoUzLFJm+EA3plAND
         MaYzNfA6NeJRYpvfzbLhdeT597Vxi+nFJ/C5eNH/E5L+ithxTIoiYVZcgBZi44ISZGN5
         q19w==
X-Forwarded-Encrypted: i=1; AFNElJ/irp5dOF2hssybHsQixxAL8vD9Ph8leT6mhd4VSvuOaxuv5AO8WoOp5R2IoH/nsbit0RPB79fpnuV+geU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzGh7fwdOibyEufvCoBrurkOJJg75NO20TxyCq8ILY9Q3PUT9nI
	ZEaSmoI2xbkXKvlvtccgzLoSKExsLUgjRxrkqz73rCHbGO+sej/L/5wa
X-Gm-Gg: Acq92OGbyYPf1IOIm3+d+OWfda9dFG3ZAN7slz8XbxZYIxsg+EOJgAjxqOVdvkX9vZS
	eo5kWgGJC2rfztLeskN01nYWSBlFwqFLMOG5eV0A00oAdMUhe0dBD44MBzNbCQC3cQETNu2U0l6
	m+mjhOzoHumOvObbUGN7MGOsBDPZtlJam08gIgySVFjB7keTZKSRhr2niCJhDmFCVuEIIaF6+5b
	36I0OzAbYE47QctEcremXnvQdz+XSHs3dWhtzZLR4H1cqEDpAnMb+sL9e5b1oB+B3M5H9OIytng
	lNM4wmrmwTVSl9oiujpRdiSP7qaoExnXALZE08OVhdVoRM3pw/cgukJ6avdS963Ra++5yNGPBEE
	Srq7D9Lq85g1SSkyntI6wQdmlb2sAFnkjNJsPhyNuYp+P109gHM/4WbzM6NdDGLhggoe8JYSafq
	UP4VIMYysFba+wRY4Lkl9aMgkg7NTvanzP
X-Received: by 2002:a05:600c:8b0c:b0:490:ba61:7981 with SMTP id 5b1f17b1804b1-490c25c1e4amr261216285e9.23.1780928891973;
        Mon, 08 Jun 2026 07:28:11 -0700 (PDT)
Received: from localhost ([94.53.77.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3a87dasm384624305e9.7.2026.06.08.07.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:28:11 -0700 (PDT)
From: Catalin Iacob <iacobcatalin@gmail.com>
Subject: [PATCH v4 0/5] Remove remaining references to the pktcdvd driver
Date: Mon, 08 Jun 2026 17:29:15 +0300
Message-Id: <20260608-remove-pktcdvd-references-v4-0-72f88b04cc87@gmail.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/43Ny4oCMRCF4VcJtbaGXCoBe+V7yCxiUtHM2BeSn
 qBIv7u0LkZmIbM8cPj+G1QumSt04gaFW655HKATtBEQTn44MuYInQAttZPWSCzcj41x+p5DbBE
 LJy48BK64jTY447S3kWEjYCqc8uVh7z+fu/4cvjjMK7g+TrnOY7k+4k2tv/90mkKF3lu3JRXJK
 Ls79j6fP8LYw9pp+ldy0ryTNCoMRFIrS9Ea/1cyrxK9kwxKZJ2kSwdiTvQqLctyB3V1sixoAQA
 A
X-Change-ID: 20260530-remove-pktcdvd-references-9d5c6362a5de
In-Reply-To: <20260530-remove-pktcdvd-references-v1-1-aa56941d4315@gmail.com>
References: <20260530-remove-pktcdvd-references-v1-1-aa56941d4315@gmail.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
 sparclinux@vger.kernel.org, linux-scsi@vger.kernel.org, 
 Catalin Iacob <iacobcatalin@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3149;
 i=iacobcatalin@gmail.com; h=from:subject:message-id;
 bh=+ZZ7cFq5dwFJfX2qzMhubJAhfsGyZm3Hq/4kBQpei7Y=;
 b=owGbwMvMwCX261qtXAKXKjvjabUkhiy1i/vDZ3kkXfQ6eyQ6d6J4Eb/bGbG7W3VcZA8ZBvt2Z
 ezoy9vWUcrCIMbFICumyPLi3PW2DXvOBNxLsmuBmcPKBDKEgYtTACbCm8rwTy9bLUjZ98ixmcoV
 jbfvrmcqDFy6bsHa0zufu5kynAsrNmP4xbxzhuSHTS1CS8RM37mtmmTYV/139uHnc4rvTq8MNdx
 RzwQA
X-Developer-Key: i=iacobcatalin@gmail.com; a=openpgp;
 fpr=F609BFABD84EB5C9DDDC37EDE89C6A3571CD0E33

Found this incidentally while looking at kernel sources to understand
what pktcdvd is

Signed-off-by: Catalin Iacob <iacobcatalin@gmail.com>
---
Changes in v4:
- Combined the removal of the export and moving the declaration to the
  private header info the same patch as requested by Bart. No code
  change.
- Link to v3: https://patch.msgid.link/20260604-remove-pktcdvd-references-v3-0-e2f06fb4eef4@gmail.com

Changes in v3:
- Split the defconfig changes in one patch per arch
- Add patch to move the declaration of scsi_device_from_queue to the
  private header as suggested by John
- Link to v2: https://patch.msgid.link/20260603-remove-pktcdvd-references-v2-1-c4402154d53a@gmail.com

Changes in v2:
- Reworded commit message on John Paul Adrian's suggestion to be about
  the removed references not the export symbol
- Link to v1: https://patch.msgid.link/20260530-remove-pktcdvd-references-v1-1-aa56941d4315@gmail.com

To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Rich Felker <dalias@libc.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: "David S. Miller" <davem@davemloft.net>
To: Andreas Larsson <andreas@gaisler.com>
Cc: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org

---
Catalin Iacob (5):
      scsi: core: Remove export for scsi_device_from_queue()
      mips: Remove remaining defconfig references to the pktcdvd driver
      powerpc: Remove remaining defconfig references to the pktcdvd driver
      sh: Remove remaining defconfig reference to the pktcdvd driver
      sparc: Remove remaining defconfig references to the pktcdvd driver

 arch/mips/configs/fuloong2e_defconfig    | 1 -
 arch/mips/configs/ip22_defconfig         | 1 -
 arch/mips/configs/ip27_defconfig         | 1 -
 arch/mips/configs/ip30_defconfig         | 1 -
 arch/mips/configs/jazz_defconfig         | 1 -
 arch/mips/configs/malta_defconfig        | 1 -
 arch/mips/configs/malta_kvm_defconfig    | 1 -
 arch/mips/configs/maltaup_xpa_defconfig  | 1 -
 arch/mips/configs/rm200_defconfig        | 1 -
 arch/mips/configs/sb1250_swarm_defconfig | 1 -
 arch/powerpc/configs/g5_defconfig        | 1 -
 arch/powerpc/configs/ppc6xx_defconfig    | 1 -
 arch/sh/configs/sh2007_defconfig         | 1 -
 arch/sparc/configs/sparc64_defconfig     | 2 --
 drivers/scsi/scsi_lib.c                  | 8 --------
 drivers/scsi/scsi_priv.h                 | 1 +
 include/scsi/scsi_device.h               | 1 -
 17 files changed, 1 insertion(+), 24 deletions(-)
---
base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
change-id: 20260530-remove-pktcdvd-references-9d5c6362a5de

Best regards,
--  
Catalin Iacob <iacobcatalin@gmail.com>


