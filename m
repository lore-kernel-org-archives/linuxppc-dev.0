Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BE3606A6FA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 19:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pojyfn1r
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jWQVz3y7Gz2xwN;
	Sat, 21 Nov 2026 06:33:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::b134"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795203227;
	cv=none; b=BsaExR5TGw+xk+ERbdcrn0ucK+H1FeGlQFCfHQjeWoCfWAJpSqRGYMbycJ+ymzKr76unLcarrw5jaaFQE+xXj3sfauG0WIDRTyvn+38asnS1LRp9gbX04roKlOBeu8vJRKL4Vu/c7/xf73UnG0mCs0lNZyy0AjazNEwdXKJ1eG7UDdCwgypnIFt09aiXdpZWgUQg3iJRerCLyx0CMmu5iEx6WHUttyFF7vp6XMZkICiy2thUOvmWIzxAj/pTAlZFIGuX3zdhOX/uY/19ok4AEUIwVkii7Vgz3vkQ3DgmlmohXQtsDu5Mt4Obfp3eWBQdXIodvDw4yfHj7km2raB/wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795203227; c=relaxed/relaxed;
	bh=fxCNuWQvzJYmgA8gn7P/jRBw4XZXA/JTp0X0Bgf58pM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hEuQgNOKMHMl/j+Z0eEQJ0Cm4fMb0yDf63apXKcop0kfGuun+58weol726hyLNWVpxMuZsra8gtV1AtYJi4WzKx3KEZjBjPnKLkq3yGIcrlb8ZuXvhyO7ulaZikh20aWptwDoYQF+qo+GwYqHx6Cnl6YOZKUDuyK98i6JtN0gB/87k9yQ2rxNqCGgDXPGfwPU3acymZzcvuPKfpUZLZFlyuTdos1lraSjGmXTDFWnHhwBN5mpKbE615Q0qVxpt/5TFuYagJl/17NVXyiC1rYMgK57pnPlyx/6j5plF4M5xmFMxgBtfwDE3TKyV0UlRu3hBHN+YGNP0sjFYGB2Nm/ag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pojyfn1r; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b134; helo=mail-yx1-xb134.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pojyfn1r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b134; helo=mail-yx1-xb134.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com [IPv6:2607:f8b0:4864:20::b134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jWQVx6QjBz2xpt
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2026 06:33:44 +1100 (AEDT)
Received: by mail-yx1-xb134.google.com with SMTP id 956f58d0204a3-67db0791748so1481645d50.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 11:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795203222; x=1795808022; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fxCNuWQvzJYmgA8gn7P/jRBw4XZXA/JTp0X0Bgf58pM=;
        b=Pojyfn1rmNtNgAB//ingPI36PFXHk6X3gPcYJcOVeopbR5KpfGBV2kuoW34Pxb1nIr
         GpJdKe+oYwmRqOZYsNpy31oD31JnLaL7V4FNvW7TenONlS+zNjpZKNt8Vm1o2U++GgRC
         0W3YXnb0BTVFjPaooIo6O7nuNb530kEvJrUOS3TO6BWQbXEVbZXJpMITBflZ3xr0ogWp
         Z96dUD4C5m8/D7XuoQrfISZPTkYbKie45ZHYSxeYVCrrLF6g1V/njeUwFnO56b3DnZi3
         mwdjybRWgmWxkoRczeyczDWog6vgDI7G8dw7i2v2AHDEZkufdH3JNRYpeL+CuSoQ+3x4
         cRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795203222; x=1795808022;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fxCNuWQvzJYmgA8gn7P/jRBw4XZXA/JTp0X0Bgf58pM=;
        b=nkV+tK6cMQDtIRp1PJTUqBXIaScGUL1aInHbwK8FW6Lq7/fcYBxpUNm0A+FW0ckJVb
         NNezJoySGqgpxK8V6HEqUoIP62m3IalPu3/kQ67F6sI24lWoV0oEl023pjyrZxeDmkM3
         w5cFgGihCSTUiH4EvpYJyfs/h0t4qeMnxF7zYq0XcPoCvVyfNfymJP+efKi3tgzf0QB8
         zs14n32WTlaVZGtnpF+Fk654JNto/WGj4dYk6CAQ1Eu9KYDNJAeUGaX/LWuTIFFvptdQ
         EVfgzIGLBf+LnL59B3IGDB/8XrJmIjC+4cN9OKNiHKusT1cI6/0lP/EOF7PS5BaAHgDc
         SSSA==
X-Gm-Message-State: APuU4Z9Q5hQ6H2Wxg3LAWB/pAoSGLBRWNLyeZDQxpo7SFQoCC2JoOCRY
	Jiti6xJF8WrVZ8Ibz6s54bLYv4siJiIUluf+SLPLrpIzB35H3MbO/XWa
X-Gm-Gg: AZFdTZfKioNC1cT2ujyyexo2WyZwIfcWr9NeLWmyCHAYFG+R07CHMpbD6SSShagD7ZY
	9rOXn8dYjzCya+pihFGa1UfUxsk+PWgacIfQ3n5sOW1nU0nCsxPF57pM18+hzHTCU1FZLOiGjDd
	j1fIphznDUTPQWITnwYreRaWL4Yedd6XnlkTX4y9lIkhVmaTKUS2nFFleveGuLkGA6R39ywva2J
	INfzMZz20gQMUmbLbQy9aq2+MAsSErhrlfoWyEsXE2XBGD/O1nqp9zJQkq7MaSyN0XJaSiGHZqz
	ABR6KaUAi9IHeuI4nhRg/hxk+AHMd+9vfhEw6ae7j5kM88YQ2uVrGiZy+qKDDzViXyupOP+DfrP
	suWktmBDDyZcLCTNFONvD4zmylTy7nba8bMPZyr4zgv7bMvdzdQKTPuy8aZRJSeT0VB0HgfcIh+
	7esLQ2pvxOuQCM0RaJAQTdLxvH/Wmua8dKSff+QY8n0WUjtxRDA8SiXaIIp9h2wn3lAMX8yR0oF
	HQ428pGN8Y+N5eyYGnwReJZ/6OqCZBNUHg1CgPU+Bfp3S9wh+5m18l58v6k+TjcjSSCChjYLssX
	a3YDlqq1YjqBgr7ur2RSMo0PIxyXah26m/nq2l8NbTZolBmi/VSHOUTX3LjpIH7I7iL34hMBJFR
	n20/jaQuLXpBwycajiyxBIK6qZE4wSf/PVLFCLxjD5ZR9fre64Q7LmMmQ60xuknQ=
X-Received: by 2002:a05:690e:d49:b0:67d:ebad:8cbc with SMTP id 956f58d0204a3-67df448e14amr1534819d50.99.1795203222177;
        Fri, 20 Nov 2026 11:33:42 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:66f3:d5d6:2d12:d460])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df337bfd7sm2146401d50.15.2026.11.20.11.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 11:33:41 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Subject: [PATCH 0/4] powerpc/32: Report MPC7448 L2 cache errors
Date: Fri, 20 Nov 2026 14:33:39 -0500
Message-Id: <20261120-ppc32-l2-ecc-v1-0-98fc8e6e0a32@gmail.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MMQqAMAxA0atIZgNNBKVeRRwkphqQWloQQby7x
 fEN/z9QNJsWGJsHsl5W7IwV1DYg+xI3RVurgR33RM5jStIxHowqgp5pUBIJqzqoScoa7P530/y
 +H9+5jD1eAAAA
X-Change-ID: 20261109-ppc32-l2-ecc-9217e1ccfde0
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, 
 Tony Luck <tony.luck@intel.com>, Matt Turner <mattst88@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-edac@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3209; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=z9yjhfg1WB5tn8m2imu7WOYSvv7f5xJsD5QGreVFmFo=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLIZFkyJ6DuQ2XZd79L9ug/9jRPeM614HLNnuVtQYre4z
 0G5vaw3Oz6yMIhxMcwUU2SJW6/IMqttx1Kf09K/YOawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyBDxygeIqfHoJFZXFyaWqSbVlDkkJdfkliSmZ9XrJdfkJpXkF6gl5aZVpKRkV9UnAo0Qi8vtcT
 U1dHNyNDAxNLRwszJwtHUxNnZydDJzdHR2dXJyNLcxMDZ0tHE1dKcgYtTAOaaFUUM/5P6VVTF3L
 IO3zP5J7Sie1F2SZbnietPS89qz+jcXRdsns3wP5eh/cNWWSkXmec54mFcS1IeJT/58fr0Yo2nc
 i8YmpZHMgAA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The MPC7448 has ECC on its L2 cache, but Linux never enables or reads
the L2 error registers. L2ERRINTEN resets to 0, so multi-bit errors go
unreported, and the single-bit error counter is never read.

Patch 1 decodes MSSSR0 for L2 and L3 cache machine checks on all 745x
parts, which are currently all reported as "L2 data cache parity
error". Patch 2 enables machine checks for multi-bit ECC and tag parity
errors on the 7448 and adds the L2 error registers to the decode.
Patch 3 adds an EDAC driver that reports the single-bit count, the
machine checks, and uncorrectable errors latched without one. Patch 4
adds error injection to the driver; it is separate because it is the
part most likely to need changes.

L2 machine checks clear SRR1[RI], so they are never recoverable. The
injection code masks reporting while it runs and reads the errors back
itself. Tag injection hung the machine, so it is not offered.

Tested on an iMac G4 (PowerMac6,1) with a 7448 (PVR 0x80040202):

- L2ERRINTEN is 0x18 after boot.
- An injected single-bit error is corrected and reported as CEs.
- An injected multi-bit error is reported as a UE at the target address,
  without a machine check.
- With the injection's masking removed, a multi-bit error raises a
  machine check, decoded as in patch 2, and the writing task oopses. The
  error in the target line raised a second machine check while the first
  oops was being printed, and the driver then reported both as UEs.

Suspend to RAM and resume were tested: L2ERRINTEN is still 0x18 after
resume, and injection still works. With CONFIG_STRICT_KERNEL_RWX enabled,
PMU sleep oopses in low_sleep_handler with or without this series; that
was tested with "powerpc/powermac: Fix low_sleep_handler with
STRICT_KERNEL_RWX", which is sent separately. No other 745x part was
tested.

Patches 3 and 4 use symbols exported by patch 2, so I'd suggest the
series goes through the powerpc tree with an ack from the EDAC
maintainers.

---
Matt Turner (4):
      powerpc/32: Decode MPC745x L2 and L3 cache machine checks
      powerpc/32: Enable and decode MPC7448 L2 ECC machine checks
      EDAC/mpc7448_l2: Add a driver for the MPC7448 L2 cache
      EDAC/mpc7448_l2: Add error injection

 MAINTAINERS                               |   9 +
 arch/powerpc/include/asm/cpu_setup.h      |   1 +
 arch/powerpc/include/asm/cputable.h       |   2 +
 arch/powerpc/include/asm/mpc7448_l2.h     |  31 +++
 arch/powerpc/include/asm/reg.h            |  38 +++
 arch/powerpc/kernel/Makefile              |   3 +-
 arch/powerpc/kernel/cpu_setup_6xx.S       |  38 ++-
 arch/powerpc/kernel/cpu_specs_book3s_32.h |  24 +-
 arch/powerpc/kernel/mpc7448_l2.c          | 124 +++++++++
 arch/powerpc/kernel/traps.c               |  28 ++
 drivers/edac/Kconfig                      |   9 +
 drivers/edac/Makefile                     |   1 +
 drivers/edac/mpc7448_l2_edac.c            | 442 ++++++++++++++++++++++++++++++
 13 files changed, 736 insertions(+), 14 deletions(-)
---
base-commit: d68ce4e71248e1ff5af9654b407541d9260b3ba5
change-id: 20261109-ppc32-l2-ecc-9217e1ccfde0

Best regards,
--  
Matt Turner <mattst88@gmail.com>


