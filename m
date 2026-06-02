Return-Path: <linuxppc-dev+bounces-21831-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A09DCCD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 05:01:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gTzFw22Phz2yRC;
	Tue, 02 Jun 2026 15:01:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::530"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780376516;
	cv=none; b=DMhED5hhLlY1CoPc9rrGa5hmSu6SZ29duP5pWodDn8Iar8zHSBwyEAVtEz0C7yZRxMlXYX0FFe0YTsmX1xyt82jp3qTmbkJc80A5wOHh9+4yEtzCpfkUIE9Jy6M82AwWHKBm/ZAB1ePERobmIJKCYT18W8nG+NYxDs93mLfpMKlbODQITNbceOpMe01QnzDiQDRuTzHzvBK8KY7cpC9kLjUoOYwBLaHkqwumb9jpGoLx4jDxuIVK5U1yYNuTaX/WybU+EZTjzET3lDJjev/wsApmwW6tiid8pF7zPOL4Y5dpfLg+QWGndgXMpyrnRcAht5A9ubnkuBWYvj1jx4HajQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780376516; c=relaxed/relaxed;
	bh=l9UBbJFTl4BJCNOtay024UeZbTsRkAab8z+DA8cu9aI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k5P6GekUrsxOxlQ/IH9b3FQi7PdIV43VaQ+TNXlIme88Kbx0Q1KgcH/PJqmWWO5jsX6TQufnYWxF4+IU/Ia6tmVatqfKtQWLC83X0/V5Cj8KoEpnpqTNe4Kj24ZyaTdOCIvTSxxxkjROcB3sY2nN0DfuSXufAme4thTBR1I0LsynOGJpI1I5VPh5QimwU69zQCU7VXhXnquwkG/qzzFH4SceTB0qsKGFQbyDga6VFahf80K7r1Kb6NaKek75Jnt6MnkPzaEORDXM3lTK2+/VdNJ0EhUIuFNIqIpKUATkPTRskgxbruOkOVrB7qYmDQgKx3uoL35SI2ilFR+/EkwXew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dtmiCT/3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dtmiCT/3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gTzFt4b6zz2xdh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 15:01:54 +1000 (AEST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-c8532ba6c95so3182676a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2026 22:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780376512; x=1780981312; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l9UBbJFTl4BJCNOtay024UeZbTsRkAab8z+DA8cu9aI=;
        b=dtmiCT/3oKDHsIgpMM8cviexC1VnJxLK4LHPF5ZWtYgAAXhRfCa9pIAi9BjNPvv040
         hJX8YrdUBq2um6CUsFsZXGMTALW3jjzh0azzXC/hTPLYDltYx2wAY7QswOwJEhreBUWp
         ID5MZGgcU4NJ+jbWZj4OTLRsHOKq0atx7ukHci7Z+AxfS3mMEbqOLp4sjncyZNXBrt3k
         9dxn7gm7UlXV+AWsjcHiV+0uguD6nvvFlPs/qZ8ev1HBugYTlQ6plLqxo/7FdudkFr78
         8kntpY9nBhE/Sf0zcsALYnKPBY89KXY1fOydoJv94GG9HIICQyyYTHoqyMshoeQvSwI9
         H3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780376512; x=1780981312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9UBbJFTl4BJCNOtay024UeZbTsRkAab8z+DA8cu9aI=;
        b=WAbMl65Rm94Dm06ENm0cN9zxZkIAx/0dBCvA+JFIStIXlyDlUrelycp5LCXCWnEApv
         IUODkCnoZkrlA7kQFg4a+Phu5manPFNTLqx+b4H8yiUeVehLOjp8/v8N9SMKwCvG9FlR
         ezhWAAgDeOwVX8d24IrK2/4tL9reuQS62bf/vo2/TOh/0/JV63j2vwLcxgztTTOow76s
         4zKuCeqv+B0OuFLGqMtdSlGAyTsvK9mbtgiwQfZ3t6UeyMkKPIYUwP1mmltYzjp/QSHJ
         kMRT5yq0hztlMEkKtpTLPwa+yy3eGRBH6eKm5d7R5NKhJZ2qdIv39qcUNy18fvnC/W1s
         vNgA==
X-Forwarded-Encrypted: i=1; AFNElJ9Vh/Vfsp5n4tohP1EGFH+P1tT093kXwiscwM1w4p/ddx/Goj/+3t5AavAlma6hbVPOyI/VK+oOCJSkabQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwC4hmTQd8X3LTQftn0wFk17xCWjJ/O/iN70yvReImgeiTEiSE7
	niGSsJao04ltE8Lvq0zlYKAp0D9aluqCN5o8xtu+tZprUJea4l7Hhh18
X-Gm-Gg: Acq92OFGhnjjO2R1tSbbOmiUj+z+DcX+KsrNT8DtXiBZz6PVnVPd+AaP18aAcYIFV28
	EzCrlVYtD6Y/jQW/X3/pN/1jomg4iUgiKPPeB9ucWICW7WR4JVY7RvE/25rwJZsk0yVAhfQvp8v
	xU+CDB3l30xqfdEB2E+D+50inG+oMc/leqV30SSD0QYWiFusL7IEjTRNzQ7y8aIor0HkPfSDPIQ
	sIcKqAboa7v5I9pA/h0IV832agw3OW0mLKkpp+R8/OzEC3UzVnFdzPMNZWIgMs5YXiOUMdbPHKM
	CrIqAXipDm0g/WG4pyt6pWsVUz17YoWj0Kfdpae8LI5PVVHWBVN4O4DKIjlYKN6z/Ip8eHlwIhv
	IcXm2oL7fkeofKMHBsIxxwDCzbV+ThYOKJ9q7ec9gIEtAMYxRK9c/nFC/TMRllmKxDgvUuN5oCQ
	Dv2GscvXsG9lxay/Po733XuRFj0PCBzgBawppl07/xmnq0Mp+1xGWZxlJYzSF14qqssJdpKf6Oz
	CzJR1mMVJ5OGd+6A0PqFSyDgIdNtMk8CPY0xAgfFOY+fQ==
X-Received: by 2002:a05:6a20:6f06:b0:39c:787:f197 with SMTP id adf61e73a8af0-3b427f33690mr14407222637.36.1780376511958;
        Mon, 01 Jun 2026 22:01:51 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8589d055c7sm8958467a12.9.2026.06.01.22.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 22:01:50 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-gpio@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/7] gpio: move ppc4xx driver to drivers/gpio and modernize
Date: Mon,  1 Jun 2026 22:01:24 -0700
Message-ID: <20260602050131.856789-1-rosenp@gmail.com>
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
Content-Transfer-Encoding: 8bit

This series moves the ppc4xx GPIO driver from arch/powerpc to
drivers/gpio, converts it to be a proper platform driver using
generic MMIO helpers, drops architecture-specific accessors, and
prepares it for module build and COMPILE_TEST.

Patches 1-4 move the driver and convert it to standard platform
driver infrastructure. Patch 5 switches to generic MMIO helpers.
Patch 6 drops PPC-specific IO accessors and enables COMPILE_TEST.
Patch 7 adds the missing MODULE metadata so the driver can actually
be built as a module.

Rosen Penev (7):
  gpio: move ppc4xx gpio driver from arch/powerpc to drivers/gpio
  gpio: ppc44x: Use module platform driver helper for GPIO
  gpio: ppc44x: Set GPIO chip firmware node
  gpio: ppc44x: Use platform resource helper for GPIO MMIO
  gpio: ppc44x: Convert GPIO to generic MMIO
  gpio: ppc44x: drop PPC-specific IO helpers and rename to ppc44x
  gpio: ppc44x: add MODULE info

 arch/powerpc/configs/44x/warp_defconfig |   2 +-
 arch/powerpc/configs/ppc44x_defconfig   |   2 +-
 arch/powerpc/platforms/44x/Kconfig      |   7 -
 arch/powerpc/platforms/44x/Makefile     |   2 +-
 arch/powerpc/platforms/44x/gpio.c       | 210 -----------------------
 drivers/gpio/Kconfig                    |   7 +
 drivers/gpio/Makefile                   |   1 +
 drivers/gpio/gpio-ppc44x.c              | 217 ++++++++++++++++++++++++
 8 files changed, 228 insertions(+), 220 deletions(-)
 delete mode 100644 arch/powerpc/platforms/44x/gpio.c
 create mode 100644 drivers/gpio/gpio-ppc44x.c

-- 
2.54.0


