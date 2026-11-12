Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BAB606A326
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 00:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TIj5o05q
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQ1Cl6gHXz308H;
	Thu, 12 Nov 2026 11:16:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794442611;
	cv=none; b=cyujpsl61vaTh4uPtJF6ehdwvHuTTZiRu0EPiH4VIZ2N0g4ECLagGiCSqlmhQsfWCutHKSWh5LqkELdBOEstirICLybSn4bReU+kIbZDikirGv1/uTtzOsKN76/6WsdCnUu/yxh1/XsuYda//TbsmXa9omwelcbijOO600KSBSM2fmB6drYCDdxesYPLwtTL/4cw+DNspYYCN8xNsfVpULpugRHjCPu6K8y/K0q6kHpYK6t9/nnG6FDpa1Pbd+535iPVNJoEni+uMEiXnHYdafU0lsliQmPAVzceS59L4jnrDcYxfw40C1rultijL0wJcqDAOffl/09W6OTtkXN40Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794442611; c=relaxed/relaxed;
	bh=PGexwgK5GsfrYlYAzT+bpSfeXRNUax72AD2f2NRfT8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q/Qu8XmszWVnk72lS55+Cl76PFBPSm4JpeDuiOTBi7O/QDGCuAiZ6lUZeujxp0hSQ8RgHudvzn3Mi7ZXnYq4S6oghDz/+HkTXwZLUQwZYoE6h79NvNED2qtjrGwVmxI5K/DGCbgQ56f0+HOuBUQqXqF3ra8+DhfoqMfwv8C608y6ah199YzJCM28PGf8ix7lxIS8b49Nl2TjRvmhHzuphCNo5xaOgae4Fj3ouRgOJqLXbbLP7H5pZT34CTwaRViv/cvmAK8RVpVHT9TyNI4NOJqu99vwm1cj3VuFgUmVGUPWZhQjEGavUYKzVKoHfyRnOtEOywgcs/tDc2atv6/pgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TIj5o05q; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com; envelope-from=dmitry.torokhov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TIj5o05q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com; envelope-from=dmitry.torokhov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1333.google.com (mail-dy1-x1333.google.com [IPv6:2607:f8b0:4864:20::1333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQ1Ck4yB3z2yqx
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 11:16:50 +1100 (AEDT)
Received: by mail-dy1-x1333.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so5614244eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 16:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794442608; x=1795047408; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PGexwgK5GsfrYlYAzT+bpSfeXRNUax72AD2f2NRfT8M=;
        b=TIj5o05qWuVPEvhOxcVA5AYVCkM3nC5f1fxDhDClTMlWWwTLTnlDycyCId404qyVz8
         otGgEWuHjI/h+TfsOsKViwt23m74I274D+kfDs3l3XRcJLdEkyl1VqgxSqXMzaSsLCF5
         TwRh2/cjlVBFNTGuRLuGi4a/v9F8aGaK+uQvccM7CDQCafo3p81wo9eQC/272f8ZxvTU
         8Jflf04jG7xRknfphwGWFixD11NNu5x/7Om80U+v+QfJVJpavelwhOBxon+2BBFAr7pv
         X7DIJ59udZNNEW8tDQ3x8bDWsr3pWRuKfjP9UtYyY67qRIMATsu+IOEE7+RsNb817IgL
         a30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794442608; x=1795047408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PGexwgK5GsfrYlYAzT+bpSfeXRNUax72AD2f2NRfT8M=;
        b=SnEGNNLzMKOdri6cfdeQEefk8sXkqrijuVzlDtr7h+3dWqbdmfmh5vo3YzLha3upiw
         khi2FxkSq61Phj+kXHCE5Oyrz+U4AkTlKzI+1mpPrt33PnrLwO1Im520dGyvHHGHdSkh
         9vg0gPpLbNVQ5wQBaBCu84FCAeXZPHlvWhI156F6+zIKwxYIlaZF+0weS8VHfIpKV3wb
         00IxwYbwbQ6rhyHZVfjSNHn8of21RI6stvdz+dcEwxyKtVybwOwILGcIzPYzk6G3yRBm
         UO1qxGkaFck+sdgzdpTgpBAZH9GG+GIJrA2fMhkq4LKYVftyNfBaP6PoV0mrsjzPIJbV
         3RLQ==
X-Forwarded-Encrypted: i=1; AL+hErGISDwmazZ+ANazVkHwACIXUNieuDnxjTwvwiJYiliEDTaZ4vJB5H8YwPNphXxooJb70aehyIbVLFl3Wdo=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8DFA00TqOBkkzd+j0+YOsvVPvNfQXvzOCq49/rF2KmX3PU29a6
	I+60aI8+QLmIS/lKg1XPdY+8RR/s+lD0Kb7omvrIGwyWQNhML0GF9mEV
X-Gm-Gg: AYBFou3lvYtwNEpuZVeiZCB4s8EWYZUyq88TW6gVEJJ08tlBSReqthZgy4bIR4abiKl
	rbC/rJVHiTRRbMCQrhlCix47yhmpW+Qm0bAOC+gYIEt7DpFgDYZD1uJWQr8AYkIcJ3ilfWyY52n
	/feDOoc966uNr7bUW63ZOR2IgXiKoif91TQPLsVs5Uz080GNlU2eod84ga+85SBD+rmPDy0rHnN
	lCWxLaj2DmA1tLKXUoU45pQQlKlin9iIOOPP35XnF/xyzRjTlgjaStlqb9taOy2DuIn2UV52eqN
	PifMV5hNKV34Ya/DvrY+SiqXYq2daZggHm/joLQfn36zcFUV8h62Baw9cni9CPSUFyl/cvYMy5+
	avG2sPo9Oe3ehriUZ9norXNV2RqV/vYqw0bMVbTawNSJ8gn6ogBRM1GuZMKkXBCmwZXnq15eofg
	diUWnVci7qv24SUlxssIg9tCnlE1O09hz2c5XB+4FIRPVgAqZ6NtJgzI89LeGchPhjleyryHGCP
	8lgN3mOqMci6K3uL0VhszVdvw6hbQIRP6wCwefjrS7e74MblbfJzJFPE+ERDSIUVWt5EFZN+R8y
	PJZnR9By5ETkhyJb5WlGkLrIYSLsFTy0dBoSNfGA2XrUtcAGdnt03LodJfmcLzGgUqj+ZtfvyAO
	caZX7jUHgkhOMfGDV
X-Received: by 2002:a05:7301:514a:b0:36a:7b3c:4e0a with SMTP id 5a478bee46e88-3768675676dmr4358326eec.24.1794442607773;
        Wed, 11 Nov 2026 16:16:47 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:182d:659:ffce:39a4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520bf3e18sm40492697eec.16.2026.11.11.16.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 16:16:46 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Alfred E . Heggestad" <aeh@db.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>
Cc: Oliver Neukum <oneukum@suse.com>,
	Thomas Reitmayr <treitmayr@devbase.at>,
	Shaun Jackman <sjackman@gmail.com>,
	Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
	Florian Euchner <florian.euchner@gmail.com>,
	Johan Hovold <johan@kernel.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Xue Lei <Xue.Lei@windriver.com>,
	linux-input@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Input: remove obsolete cm109 USB phone driver
Date: Wed, 11 Nov 2026 16:16:40 -0800
Message-ID: <20261112001642.243554-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This short series removes the obsolete cm109 driver for mid-2000s USB
VoIP/Skype handsets based on the C-Media CM109 USB audio and HID
controller (0x0d8c:0x000e) and drops its module selection from
ppc6xx_defconfig.

The driver was written in 2007-2008 (modeled after yealink) to poll a
4x4 phone keypad matrix and toggle a buzzer wired to the chip's GPIO
pins across four phone models (Komunikate KIP1000, Genius G-talk,
Allied-Telesis Corega USBPH01, and ATCom AU-100), relying on a module
parameter (phone=...) to choose the keymap. The mid-2000s userspace
VoIP/Skype bridge ecosystem for these handsets is long defunct, and the
driver has seen no new hardware support since 2008 while continuing to
attract syzbot crashes in its custom URB state machine.

Furthermore, because 0x0d8c:0x000e is the generic default C-Media CM109
VID:PID and was added to hid_ignore_list[] so cm109 could claim the USB
interface, cm109 actively interferes with non-phone CM109 devices still
in use today: amateur radio interfaces (Direwolf, AllStarLink, SVXLink,
UniPager, Hamlib) have to blacklist cm109 so usbhid can expose
/dev/hidraw* and so opening the input device does not pulse the GPIO
pins and key the radio transmitter's PTT line, while standard USB
headsets with 0x0d8c:0x000e can bind to usbhid directly via the chip's
standard HID Consumer Page volume and mute descriptors once the
hid_ignore_list[] entry is dropped.

Thanks.

Dmitry Torokhov (2):
  powerpc/configs: drop CONFIG_INPUT_CM109 from ppc6xx_defconfig
  Input: cm109 - remove driver

 arch/powerpc/configs/ppc6xx_defconfig |   1 -
 drivers/hid/hid-ids.h                 |   1 -
 drivers/hid/hid-quirks.c              |   1 -
 drivers/input/misc/Kconfig            |  12 -
 drivers/input/misc/Makefile           |   1 -
 drivers/input/misc/cm109.c            | 940 --------------------------
 6 files changed, 956 deletions(-)
 delete mode 100644 drivers/input/misc/cm109.c

-- 
2.56.0.567.gdb80ae8cd5-goog


