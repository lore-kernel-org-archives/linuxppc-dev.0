Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ED9606A88B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 21:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f7ryrZ6W
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPy725q7Lz2xmk;
	Thu, 12 Nov 2026 08:57:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1336"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794434254;
	cv=none; b=igD+vMdAiskGe2bhpw/ew65GSoImhdu1UF4t+Iteq19Q5C6yiog8HHXjGUeLnPCSt4eQMeh2jMm/MGWZ16FdNmoEpjzgPfWIeVLk7m+Gi6CzhpJsQDnZUD7lGdDf1BA5mL+8DJqafpifyJLTnvJw3KkJojn9kNPvOwPG2IA83gKaCInn2F9f9AwTJwy1TrtGNwitH4w+dQQ4I+Zi9lEMj2CfsWkMzzQcK+C9ECg3Aw0fgUOTz/ms51cEmo1ibbzPSPpZpGO1Nl/rH2FWP0J+GKOMML/HfWXyHDrwmBR3OVoJ3lY7GfqfEKUT9tfi+peypEF7ER+e+GUQuP0g0NWa7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794434254; c=relaxed/relaxed;
	bh=1ggCgsA+NJ3WO/E1t+Aq1JDPeicUUtkRHraZJ7K1wtc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CMQsoNVqm7xHIcN3D0CRa3zXCDm0MQIwdON5rZQO1rtHmYM2+eNok5p5QqhdYmVKhIPNDEimn7wUvmyR5Z8tYYShLCnzgPNm08Bs4JGLoqoCRSyx02mr0RuhTzJXeYxej2OhbZvOSW3V8XuYBFZ0TsNgrA7aEU6VW1OC7kAbozdGuXolq6xXiChyaFNY2btryERXlG1SoeQGbipki3PcIl/4Zrap+NSUIgjVKyi09hJi3khgtPsj1ZZ2HAks8sGFPPRYmXnWjHMM++jrVj/YJm+KB8lvP5+R6lmB+3DsRgFT/1HyY6Zl82WQk5Vg/UZPoT9zro0Wsxmc6MT0zqUPdQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f7ryrZ6W; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=dmitry.torokhov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f7ryrZ6W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=dmitry.torokhov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1336.google.com (mail-dy1-x1336.google.com [IPv6:2607:f8b0:4864:20::1336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPy7159wKz2xmh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 08:57:32 +1100 (AEDT)
Received: by mail-dy1-x1336.google.com with SMTP id 5a478bee46e88-3704d30b84fso4587075eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 13:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794434250; x=1795039050; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1ggCgsA+NJ3WO/E1t+Aq1JDPeicUUtkRHraZJ7K1wtc=;
        b=f7ryrZ6Wc76r1IxCOY9JTOsf7HGA/wo8vI9pjISgHD8NVcf1Xmt2c5iNcL0nFELPK9
         l+hKSwO+FiXCn6FFCtPpS3fqJuhiNiewXMOBUKuT5dXdiT2xnuy7TwUVC8+b0Ium6Ng7
         NQToXAY+53Nsvy87HuOsXVwJ0Ld1NVWMoQRj7Gdg6U6HpBtNqIBD0kGnf8EgfGPV95qf
         JHvUmwylaA7ZkHqAcWkPfA+hHXfWEvARD3jiw7noOy6VaRbNg+NI/mKb46LWTx0lPEd7
         ISH3eOcXqmZHDRKW2ETdJv2W6pjYMSM3eYqrFsjU+CBnwgPL7NmqWXXQueukQ2rp1hmm
         F3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794434250; x=1795039050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1ggCgsA+NJ3WO/E1t+Aq1JDPeicUUtkRHraZJ7K1wtc=;
        b=rC8NXOKtoruqATE0pu5G13t4bCnuABCYbJ4iHbYSRyr9nBdUbFiTrgF8bkx7+dJudO
         GN5akaAkfE9ryHWfXXCQ+BPdZR9n62Kk5LeUZdd1rIw/nhWgY7h2XkFjdL975Mr8BL5k
         9siLcATMCH/N/gjKfRdqeeQ92ZVy4mVHtMuShWwB5FkOtZmYO4RZBbxoPZz7IwkNVwOv
         nT1WcKMy6IElZnpt5UnOy32jFGRxF65VxHAhIpBN2Afl6Oapx1acukirSJYB7gQEGICW
         oUjtOfzn4fkYWukw2e41h3GU+EVIcHOxgJ0i0ZeqpxdmDRLXQnkPRzxHoMyRyChWKOXl
         iJvQ==
X-Forwarded-Encrypted: i=1; AL+hErGz4P1cq9V5ccDb2ViyIdNN/GoVDzZ/9aQ6YSfpfvNeYyfF6kELbQYPNvSzhwbNvZm+pdd4m3YVRc9bj88=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8bum9iv33Ivi9FNXbaxSPmt3VQ7dnH+6DC1CzdeFWcY5l0uKqK
	yqcwyUuT3UDI2gSCecfIguX3TIxEzPqSoI5QamQvs60FMEMAqJKzXDQp
X-Gm-Gg: AYBFou1jL8vezNITGm9QxhGpy8B5Ip1/HMJOycWcOsYR/vcG5X359r4t75/mShY3xpy
	E5kKwH7LaL7FWVoHQla6Z0x3FhHKo0pNtieBtWfeOOlGZKLwpm+uccNLp3uMrStmKl0af4J1v3z
	ZLrK1gab3du5peiHq7IBB1Ru14QAWLEQTb6giTk42xfSrMf3Ys8VkqhizBxN5O+lx5f8+StT3zK
	siRp2gdZfnxlXhjSHdSOdl5hiqTX8kGJdJiwsWEB1/ijjVegTXbaKysM1XCxnpGmzVXTM2Ro9Yu
	bNLEACzyInS/Q52pRiHGI/uDiwi9Q2ZSfHBvZuQ9/XHhXOLjtxVXFqm4UNI+Yu3pO0Enfd9A+rk
	q4CjYK0Ova30DfIuarDVZXEIz+Oe2ga+9rzteahR32nU9VRtkyCGqmMzavP2ATCoOCGM31GJrix
	2cXNgPCzvElOVMjwsKhIZ0fNtC9Sm87pW9DUGdDsELj+HqoxW8EKbJyAZO846oyIOKGFNsHYGlJ
	yBrP+T5fTpb+IHO8XqKZVU5Mh4Gh1PeWkcwo4D3vtZyQ+aX2efXndRptfO14SCTnTIeJPT6lgoF
	OfsTcsTR9DQdjc66IWl7n3UU+kng5HQ6bBqDB80cxZjCuzHzAGgtu6S9blouLP38XCu8CRvxWjI
	2E2ObjoDAn5t947yTtg==
X-Received: by 2002:a05:7300:2d2b:b0:36d:2704:6adf with SMTP id 5a478bee46e88-3768579df8bmr5681391eec.11.1794434249909;
        Wed, 11 Nov 2026 13:57:29 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:eb83:637b:7b26:8dfe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751dae6377sm17823523eec.3.2026.11.11.13.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 13:57:27 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Henk Vergonet <Henk.Vergonet@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>
Cc: Oliver Neukum <oneukum@suse.com>,
	Martin Diehl <m-diehl@gmx.de>,
	"Alfred E . Heggestad" <aeh@db.org>,
	Thomas Reitmayr <treitmayr@devbase.at>,
	Slawomir Stepien <sst@poczta.fm>,
	Jie Wang <jie.wang@intel.com>,
	Manuel Ebner <manuelebnerli@mailbox.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	usbb2k-api-dev@nongnu.org,
	linux-input@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Input: remove obsolete yealink USB phone driver
Date: Wed, 11 Nov 2026 13:57:21 -0800
Message-ID: <20261111215723.3802209-1-dmitry.torokhov@gmail.com>
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

This short series removes the obsolete yealink driver for the mid-2000s
Yealink USB-P1K (0x6993:0xb001) USB 1.1 Skype/VoIP telephone handset
and drops its module selection from ppc6xx_defconfig.

The hardware relied on dedicated userspace bridge utilities (such as
usbb2k-api / kb2kskype for the defunct legacy Skype desktop API, or
yeaphone for liblinphone) to drive its keypad, segmented LCD, and tones
through custom sysfs attributes. That userspace ecosystem has been
unmaintained for over 15 years, and the driver itself has seen no
functional updates, hardware testing, or new device IDs since 2008
while continuing to attract syzbot USB fuzzing reports and drive-by
cleanup patches.

Thanks.

Dmitry Torokhov (2):
  powerpc/configs: drop CONFIG_INPUT_YEALINK from ppc6xx_defconfig
  Input: yealink - remove driver

 Documentation/.renames.txt              |   1 -
 Documentation/input/devices/yealink.rst | 226 ------
 MAINTAINERS                             |   6 -
 arch/powerpc/configs/ppc6xx_defconfig   |   1 -
 drivers/hid/hid-ids.h                   |   3 -
 drivers/hid/hid-quirks.c                |   1 -
 drivers/input/misc/Kconfig              |  15 -
 drivers/input/misc/Makefile             |   1 -
 drivers/input/misc/yealink.c            | 950 ------------------------
 drivers/input/misc/yealink.h            | 206 -----
 10 files changed, 1410 deletions(-)
 delete mode 100644 Documentation/input/devices/yealink.rst
 delete mode 100644 drivers/input/misc/yealink.c
 delete mode 100644 drivers/input/misc/yealink.h

-- 
2.56.0.567.gdb80ae8cd5-goog


