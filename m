Return-Path: <linuxppc-dev+bounces-22031-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D110DCD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 13:19:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWQCY48rsz2yRC;
	Thu, 04 Jun 2026 23:19:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780579193;
	cv=none; b=VH131XHlWm5f0G0K8ydZWz24Q6k07V1EwWxyo/2iuZBSTq5mnfAz9ScZpVOpj1vjwgg8cyXGaLpbaizGNkkVeS2v9nNoAA0dSsXmZIR+A7o7cTJvkifcCeXT819JhmppG6T3SCpwvO4KrmyRYLuHj2r7Zvr63El9SPPzSRyprqmGiHvB84xIKj02F1szZmGRhnfSdwhOITH/FqzXyGlBaJvEcCWSxaHHOwnap+C+WYyl7fryfInbWCvQar9fRuRkG+5vG9AlWj/Zi9Qwxm9zZJD8WLWxu5Bi1PePcoZLidkWS5E63QnZFbPsSL9Al1SWriOvgq9mz2czVbK4fUA4Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780579193; c=relaxed/relaxed;
	bh=1xn1l2TJuksG9hWrI7UNiVITikDxe2DLajifMmxjpHU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=HSorddDlUV8Jkzi4wrBYbb4BrLCnqligGIwPzXU1AZlzY3oM5u1g9sb0JOJBLnruUyDde2PdWzMATo11IRp5l3OQD8L8FxiFMSCFmfOxTdOTe5OzGf5nf6XdN1ZBekTSecOmev6O+EyaSm3ChJuZc/i0lO8a25SDF+IaC6CI7U/0F71h1K5zThjB6iA6Q4NfzP/1JU70NNpJjdEANXxpgRIqrLHsbD4jhBuBH2fFDgb3ALIf9KREnUDTAUt6LwH866Pk0gneHd2FI9cPfL8OvUFKP7QcyCD8J/rlPZQ8SwfbPGZroVg7SiZwj8GWC6OSLwa7+qusesbZMhPdkEqv0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=isNoiHWw; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com; envelope-from=iacobcatalin@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=isNoiHWw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com; envelope-from=iacobcatalin@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWQCX07gcz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 23:19:51 +1000 (AEST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-45efa80e0afso600209f8f.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 06:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780579188; x=1781183988; darn=lists.ozlabs.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1xn1l2TJuksG9hWrI7UNiVITikDxe2DLajifMmxjpHU=;
        b=isNoiHWwiV3l16jufkogNJIhN9oJpyFxMCGNvUJxOHpElY0v4UqaUgutC/9CsB6D4G
         yOzNmI43JaO+5/GbEGc4pF7AB8tZFsAN0uDycbcd3Mn918HD4risdyX+q4ITj07Pypmr
         E491FukfFUVrQ1aNrDqv8PhOYrmr392qveyJDkxpfIJhRdE0SHB2lgChO7mZeNAEiaBE
         eAqzJvJTeIHiavy4hVjpCp0cccJWyPbsFu842qPwFxK+RG1Rx/USqpc5gn8V1SQgwIa3
         ejrOmeiVvKJCUQRDT/mSor8XosGNWdGALN9Qnpj+WmqsJqzKuo9J9k2FrbIjRFFOdk4Y
         +OnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780579188; x=1781183988;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1xn1l2TJuksG9hWrI7UNiVITikDxe2DLajifMmxjpHU=;
        b=A/9xIb5mZ76PoYRFmoxv3A+SJz+2APKvWfLTnu7lA64S3lTJrLseICnqMzp6DWAzmv
         +ifWb5QD2ChdmV7N3kJXiI5S/Jva1gIpsj8GeXSGIkYlE1icahC70Q5gSmHUVx9XeOcv
         bFf6U4NqWZVVrF8n0ibCwolvSbqbHaOuE0djakJWVqP/WXWhmwv2PwICnmvG2iyPsaHy
         xcZGmBbstcFoyDbBIcmg940WWhL1GWUOmfA9+Qw/gZmbtv0G3YxYpiU+faPgCWjT7+ks
         wP1STWod9Zv/7LNUHvRHjAIxXXUiFdS1Cz6ATNNBUyYc/sGLFgq5AsySS0GDoEZdg2e8
         xNfA==
X-Forwarded-Encrypted: i=1; AFNElJ/gM3MHbJeJBwh1qMOKtgUmRKPcs/CK8LE71QaCcdcW9otxOxKIJiCVtl58L/OrQmr6pHO1vU3wJCyWFX8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzcIyXmPgIwvGytd+0wNf6/YMsFattLvMz1+VdkCle/rnTaSOVS
	HG0uE/lr0Jyc5R4962ZJYSIu/KqJPtxioBm/LxxAgL6IVX0PpD2+PYXu
X-Gm-Gg: Acq92OExywMmnsqlgKusvlGiHopVd2pWxPn5ZaQVr2m6felVmf8yvJMReITN1iXYxzS
	CwZXz+guUrsuS1kEMRAmGVv8noRLH3+IyWQz7YyCfOh5+nqH/1EJy68HsAcfncp7LlPR2OX78BL
	413AOKqKca/PFbRIqzOe+yqyfsR2sMqXj4hlzUeYr3mbaO9iCHzbUMysh35Pgm8dQbH3flgxq4N
	JMZhkIusmQbQ1FtLp3hdDLtu9xZ6LUFSMc0OZg6c7BOUuVy7Fm25LwkOPRpr1hujgzGn7Y3fmMb
	3wi8qRutaX0JELu8vhDs20meWXSY7iA9UDMOAslu1Y23fAOKukAolq6N5ZpPUF5n3a+d5ZRtrr3
	SrgJJI0VPpDLsKgn5Uge5nobyzWpxiJmm4brxdcNq0fnR/hqUO7JIUEy+He1uCVbkEWfN1/wLPA
	yz55edvMSqmEXZrocQO9tSPymRlwtml2Vq
X-Received: by 2002:a05:6000:40c8:b0:460:1d74:a1b2 with SMTP id ffacd0b85a97d-460216e681dmr12313234f8f.16.1780579187766;
        Thu, 04 Jun 2026 06:19:47 -0700 (PDT)
Received: from localhost ([94.53.77.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2e4004sm16337889f8f.9.2026.06.04.06.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:19:47 -0700 (PDT)
From: Catalin Iacob <iacobcatalin@gmail.com>
Subject: [PATCH v3 0/6] Remove remaining references to the pktcdvd driver
Date: Thu, 04 Jun 2026 16:20:23 +0300
Message-Id: <20260604-remove-pktcdvd-references-v3-0-e2f06fb4eef4@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NzQ7CIBAGX6XhLIb/pJ58D+MBYW1RWxpAomn67
 kI96Ml4nOy3MzOKEBxEtGtmFCC76PxYgG8aZHo9doCdLYwYYYpITnCAwWfA0zUZm23BMwQYDUT
 cWmkUV0xLC6j8T+XmHqv7cHxzvJ8uYFIV1kXvYvLhucYzrbt/OpliirWWqhXUCk7lvhu0u22NH
 1DtZPYxKcJ/mVgxGSEIo1JYyfW3aVmWF8+MvUgeAQAA
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
 Jens Axboe <axboe@kernel.dk>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
 sparclinux@vger.kernel.org, linux-scsi@vger.kernel.org, 
 Catalin Iacob <iacobcatalin@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2996;
 i=iacobcatalin@gmail.com; h=from:subject:message-id;
 bh=R4we36p9qeb3bR5yeLPjWMa3iuESdosoLdNbQrwnbbw=;
 b=owGbwMvMwCX261qtXAKXKjvjabUkhizF6nWWTd8PNG5pa6ncseOD6qKrzIFOLXtr1v1hfSnD2
 7Kir3BaRykLgxgXg6yYIsuLc9fbNuw5E3Avya4FZg4rE8gQBi5OAZhIsCAjQ2tH5sHzGVb84Zqa
 1vs95lneP3w/Z7cBZ+JTpWcfsk4JCDAy7BLNvOpwTvaV8Czn9C3Pz2uIy76cJe3ct+IVW8sRo1U
 f2QA=
X-Developer-Key: i=iacobcatalin@gmail.com; a=openpgp;
 fpr=F609BFABD84EB5C9DDDC37EDE89C6A3571CD0E33

Found this incidentally while looking at kernel sources to understand
what pktcdvd is

Signed-off-by: Catalin Iacob <iacobcatalin@gmail.com>
---
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
To: Yoshinori Sato <ysato@users.sourceforge.jp>
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
Catalin Iacob (6):
      scsi: core: Remove remaining reference to the pktcdvd driver
      scsi: core: Move scsi_device_from_queue() to scsi_priv.h
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
base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
change-id: 20260530-remove-pktcdvd-references-9d5c6362a5de

Best regards,
--  
Catalin Iacob <iacobcatalin@gmail.com>


