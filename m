Return-Path: <SRS0=+v6T=6S=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F369C3A5A9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2020 21:51:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F1C62075A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2020 21:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="K3BUKLXF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F1C62075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49GGkw5bqfzDqWc
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2020 07:51:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.microsoft.com (client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=prsriva@linux.microsoft.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=K3BUKLXF; 
 dkim-atps=neutral
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by lists.ozlabs.org (Postfix) with ESMTP id 49GF7R5ZrhzDqVr
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2020 06:38:40 +1000 (AEST)
Received: from prsriva-linux.hsd1.wa.comcast.net
 (c-24-19-135-168.hsd1.wa.comcast.net [24.19.135.168])
 by linux.microsoft.com (Postfix) with ESMTPSA id 6895820B717B;
 Mon,  4 May 2020 13:38:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6895820B717B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1588624718;
 bh=6P2paN9NO0FWx6B7UbSmB/LcZk3eOjU9tLNhjVjgu2E=;
 h=From:To:Cc:Subject:Date:From;
 b=K3BUKLXFPzHk5/vc18E2X2yGYsVoVrEVR3Bjxnk0kkNoK1RyGJF07VpR4jNjPdswq
 PTdElXCTeIvlEoVsKZH0Tk/UjQ3124JQLUs2fMp9IFj0dQ3idwPz+efdmEETdAO+dm
 kf7mZQNd1GyWhA36D3uKZsPysbTHSk1ty11ir9Jk=
From: Prakhar Srivastava <prsriva@linux.microsoft.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [RFC][PATCH 0/2] Add support for using reserved memory for ima buffer
 pass
Date: Mon,  4 May 2020 13:38:27 -0700
Message-Id: <20200504203829.6330-1-prsriva@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 05 May 2020 07:46:27 +1000
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
Cc: kstewart@linuxfoundation.org, mark.rutland@arm.com, catalin.marinas@arm.com,
 bhsharma@redhat.com, tao.li@vivo.com, zohar@linux.ibm.com, paulus@samba.org,
 vincenzo.frascino@arm.com, frowand.list@gmail.com, nramas@linux.microsoft.com,
 masahiroy@kernel.org, jmorris@namei.org, takahiro.akashi@linaro.org,
 serge@hallyn.com, pasha.tatashin@soleen.com, will@kernel.org,
 prsriva@linux.microsoft.com, robh+dt@kernel.org, hsinyi@chromium.org,
 tusharsu@linux.microsoft.com, tglx@linutronix.de, allison@lohutok.net,
 mbrugger@suse.com, balajib@linux.microsoft.com, dmitry.kasatkin@gmail.com,
 james.morse@arm.com, gregkh@linuxfoundation.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

IMA during kexec(kexec file load) verifies the kernel signature and measures
the signature of the kernel. The signature in the logs can be used to verfiy the 
authenticity of the kernel. The logs don not get carried over kexec and thus
remote attesation cannot verify the signature of the running kernel.

Introduce an ABI to carry forward the ima logs over kexec.
Memory reserved via device tree reservation can be used to store and read
via the of_* functions.

Reserved memory stores the size(sizeof(size_t)) of the buffer in the starting
address, followed by the IMA log contents.

Tested on:
  arm64 with Uboot

Prakhar Srivastava (2):
  Add a layer of abstraction to use the memory reserved by device tree
    for ima buffer pass.
  Add support for ima buffer pass using reserved memory for arm64 kexec.
    Update the arch sepcific code path in kexec file load to store the
    ima buffer in the reserved memory. The same reserved memory is read
    on kexec or cold boot.

 arch/arm64/Kconfig                     |   1 +
 arch/arm64/include/asm/ima.h           |  22 ++++
 arch/arm64/include/asm/kexec.h         |   5 +
 arch/arm64/kernel/Makefile             |   1 +
 arch/arm64/kernel/ima_kexec.c          |  64 ++++++++++
 arch/arm64/kernel/machine_kexec_file.c |   1 +
 arch/powerpc/include/asm/ima.h         |   3 +-
 arch/powerpc/kexec/ima.c               |  14 ++-
 drivers/of/Kconfig                     |   6 +
 drivers/of/Makefile                    |   1 +
 drivers/of/of_ima.c                    | 165 +++++++++++++++++++++++++
 include/linux/of.h                     |  34 +++++
 security/integrity/ima/ima_kexec.c     |  15 ++-
 13 files changed, 325 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm64/include/asm/ima.h
 create mode 100644 arch/arm64/kernel/ima_kexec.c
 create mode 100644 drivers/of/of_ima.c

-- 
2.25.1

