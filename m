Return-Path: <linuxppc-dev+bounces-21292-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A590CD5BA4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 08:37:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLhc94kKYz3bwX;
	Thu, 21 May 2026 18:37:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779352649;
	cv=none; b=eoDvCkkQtgu85LiauSYrsQnwmBtBbfht+ASR5K6ngp98aRXASTdWIY/+a+6MNvqtQSdyY9hQ/9v0++UIS2V4iWieek7xTbhtpCP9h8HbU0QUM14bmtQmbCCFyhvdBPxT4UHDbApVt/CNJC8czNErjJOWrKUy4RPT2RWn0zqBMI08uyfjQx2CU76vlWVVvG9Zd54a0d4SBxgyQyOIUfH7So0sVH57HXpu84KnWYKZ0Kt9b3oLlEj0l74++wrzqtzrLfNQN9psc5c0n7SW9KxKxFUyPj48kFi3hb947HVmUDul6tAJP05dhL/vBAiKG2rtzMQUpTb2KxazEeRDu3VJQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779352649; c=relaxed/relaxed;
	bh=m0PJY/EBXaS+NGqlIlXtzUywSQPQ33CG8O0mf5HsOtc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NYlsy3tSOOZ+/11Hrc66I2jdCp3OxIb0U4hhj6B3Z6nONAsOm8XCh8NiqdR0uc91JpTFCvCLJ0f7ww603J/yuzE4QsVay8Z/UGuCRdMnyQNrpNe/qY0/qfhZsWbC+BULHl63ywd/62ZXp+JSKxUJRDogo/yNkz53IWvEQcIGaGg7bdG9zvGUrVWDbuFx5ooxPX2bDvvOaVQu0m69e1TUuFhr3aFCSlkZMKZ0H8S8eoEaGglxoiqvrdv/Aj3BPZv1F3eapzUZIgIC8oqRvAfYQa8j/QPiu17OHwhkEu+ezbGqE+YuY+GOXS8vUR6f9REwZQZNDGvVXS+LAVH+tQT2jw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TGSv8YHH; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=c/YI8ZuX; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TGSv8YHH;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=c/YI8ZuX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLhc903jCz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 18:37:28 +1000 (AEST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L8KNpt748568
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 08:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m0PJY/EBXaS+NGqlIlXtzUywSQPQ33CG8O0mf5HsOtc=; b=TGSv8YHH2HHm9gce
	LO05rZSE6dZib/XINNl6hu/QvmGJtgVvta9prqDrYEhZLuap803BPNi5UJ6pclC5
	8u54UuNFHHifWzorPhqhoAujRKyfX2pOVUtZwN4/RWtZiEIMKIKCbjA78t55rW4j
	NeAm+13eASkdx3gOsHfhlBsFIp25sLXiXlSJKlr4hMmSH+3icRb13RT2tf2A6xfl
	Khpg0wQCdp2jMuElLBz/vJ1F4RrRglBsQ+G+9NE6yUo2soHkDy+sOzVG0O6oTes+
	tevab/rwt7fnTEpBxDXzs7qe82eYsaXRep86pEQUxvQmJYEi3ALTpInszxXfFbG+
	FnGD5w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9fb6kj6q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 08:37:27 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50fb3403e99so50212691cf.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 01:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779352646; x=1779957446; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m0PJY/EBXaS+NGqlIlXtzUywSQPQ33CG8O0mf5HsOtc=;
        b=c/YI8ZuXg5/hCesCIpGKtaUov/ww+bWZN6MHKRrbQomUTtU04vJBg/JAB4Kuc5Lrwt
         Roef3S4OSXDZ6n1SMHiNhyyjAs60dc6d0QiOMwAYlt1IdJ0YTmGmsTP1o10OBTx2JVjv
         aRn/A4onPFPT+h3dZ3fUKGXcUUAPR49lPGB8zhRQc9W0pFWC4uhCSqOQSQJrMOFeugDR
         NY5pmU2De2e1qwjK72VMNG59oogLp/GtA5RcwrIPTRNicSIYbarcRsANEOtSI4kyqwvQ
         U0SuzYt2C7Et9NE/rGQb83iotD6yjpXRTVI+0xQ0T7p4fBBrkm5K/H35t6svi9p7KeU2
         rx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352646; x=1779957446;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m0PJY/EBXaS+NGqlIlXtzUywSQPQ33CG8O0mf5HsOtc=;
        b=SFxLiD3A0JPKjsfc9ljH6uJ5zhmqfYFHLkRBItRb2g1qFgCO4OeH1jMilI0sWduSUi
         VGZP6mtY/OOMTcXgeptkBV+HgKk6Ui/HOh5fN5VUxgRrl3Jpehd6QZ6AHw3i30bSuTs7
         c6iRNjPGwTyYBoshk9SI4KYf0Rvg14d9fTkxo7XRf8BJDEVyLwynPjJyrNIgrjCS6r1D
         rt0pOYRFu4KRZJjrAtrtB8+9QpWB++XnlpSAWZfxoodRZajWML53n4dHJYd8wbTjuGUl
         C2VOYFGbUELu2v7Sh8boTLKm04RVCgAcgUwQFfkOGJDrWR1LzAdYW+mdNfwv71CDs25i
         qa+w==
X-Forwarded-Encrypted: i=1; AFNElJ8kEF0admZOTQFEfoxxbKHzIX9OMT05fLO9YiPirwGxP0vz7DxiI4XbYofZqZ1hrteZNPxJvdSDLIT4b90=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxrmw8qGFOkLdyBKRxHQbgpVBKLK3imxGHXk5mCn8qLrDlLIszN
	jH72n76RcKrTjI52s9L4McviDqpc/7vDWR/4K+26dlJtYzPM/XeiR7D0xZAD5+oQANbPjaDo/A2
	BqxY6xmRQHdhW8UlE4epfG5CaaK+VjNyxwxreXvovqYINbBTCV+d+oCkNdONNc1uHirk7
X-Gm-Gg: Acq92OH7nI5KRNfPYvRkPETVjk/7lNB6sf3VuWxMENuxaD9Tu+87h5phVKwo5Fj+rHl
	juSLHBxWCT+JV9sCbjvtoY61YZjtfZSPUsTN/cB9CgU+gV0f+R7aFiJ1RLxqYL+64cVHeapnHhX
	rfAou90bLZWsq45d8B92ISOiqQHtm5Zsu5DIIdj+0FDP0tgHIOgDTi2kVJYsIBSO3vHq5poTz+K
	tz4Hni6JE84bysJf8NufTdbDIJEpVNUNa0aNSmY5ATHDpOIb4IxxqBRQ5xOXK3k2A7cdjwdG/LQ
	dbHIvjlwY5DJkpqK5AJqODHD+91iMQiOt96MzNv5tItPp7ZVDY8Wk1emYEF6JxclS2cjZ9iw5rm
	S0LVcJggPM5QZqPd7cM7oggi+927HVWt3n/ZzTCZobw2EYuP5UDg=
X-Received: by 2002:a05:622a:5588:b0:50f:817c:2fe6 with SMTP id d75a77b69052e-516c53d8aaemr28109001cf.2.1779352645836;
        Thu, 21 May 2026 01:37:25 -0700 (PDT)
X-Received: by 2002:a05:622a:5588:b0:50f:817c:2fe6 with SMTP id d75a77b69052e-516c53d8aaemr28108511cf.2.1779352645294;
        Thu, 21 May 2026 01:37:25 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:37:23 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:29 +0200
Subject: [PATCH 06/23] driver core: platform: provide
 platform_device_set_of_node()
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
Message-Id: <20260521-pdev-fwnode-ref-v1-6-88c324a1b8d2@oss.qualcomm.com>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
In-Reply-To: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Thierry Reding <thierry.reding@avionic-design.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Matthew Brost <matthew.brost@intel.com>,
        =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Peter Chen <peter.chen@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hansg@kernel.org>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        driver-core@lists.linux.dev, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
        iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
        linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2715;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=wZzo4F+iEv+cqnjZacAyiOQUCIfz9BeD5LEdTUENfEM=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQjLvHgEkgDUYcyQqS+YI0tDoWCf94BkOfk6
 vDphiey46iJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7EIwAKCRAFnS7L/zaE
 w10mEACuBjw1mRfWGN/zZYles7aGCy04DbiAjWjYefDvcAqjwNHVbQPGTfR9vvDt9Vt3opZlUfJ
 1ytnUuq6dFumO5reYJ78tEy9o+PkI8VY7UoUHI9DX2cKKEeA6fkKzjp3sYJvTgqJELasQOkPH8y
 PlZgKzt0c0z6CLrSP/lqxiiyL6Roc+RIVEg6THFxHR5OoOrX4+KXE7TpYW/+9R6Q2BP2a5mjGKI
 I8sHIVxHMgpemPUcVLU4/uTLyuQeLaADPratIxqvFuTx0AW6AOYaFvaamCkQMd//4qESASqVPxq
 Iqc2iJqP6r0b+IvjJO1nHSUPlB1yTjcDLn+baiOlmwj1skALP2IMeucYdve6oLVmXSGYq6qAYq4
 gC7R+np/sgYQ3f5xLBo/KtwsaKQb6TSf+ZaoZnYHVqW+A9akzduAnNlWFKW0UODQ9PcBDZadov/
 3mRLrzwuMo293FdKXtsUcYpBMNIX1XEo5vV2REkvT+e4lLq2oAkW+Y6KmtTYYkzZs+myeRmoTWk
 ebeqMSKJ7NApWk3IX+x4SN84ESMRkBiuAhe1JJ+h0WQ/IOtxcd82UQCshyJxQ8qXTzoFMc2kEEB
 3KNvxUJHXaBt2BDRHwinv0uRBTS3Qwt835TjvmqeqIrB1g5DU3xqpgR0Yja7mcdp35huKbkn9rN
 lHge5prVxo4DdaA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=do/rzVg4 c=1 sm=1 tr=0 ts=6a0ec447 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=Q8RKEeUEMY9O-VPP2I0A:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: Vct1wJqJIyNGkU5V8dANTTq2Rg9hXXsx
X-Proofpoint-GUID: Vct1wJqJIyNGkU5V8dANTTq2Rg9hXXsx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfX9TK2H4Fu4/7N
 852RVvScXAz7Bln2mk1n7nkhwZVbbWu1/DQJFVWVgMeKiJY8snKANJDYYtCB7tf3UKAmCttpFNh
 iI+OYAtCQn4faz06M8Xs8C9u4Jeu0PC6SbjCSQQczmnLuH5YCXuNKQ0IwpQqUIb0PjJO97Pnf1J
 ps+fwmHQRsBSkFo8ShuLVTEeqQk+6TPqEuyDbKlHrNx1YbKjOrXiV+aHPnXCl7sf6gzDUd3f9p0
 GOGXoto4JSndcWMSGsZ9QopDQC2Cne8AuTiuN5SDVxt/k1jMHaeE8cc20EGLD8k6o03DRMSG1fo
 Pu+pzlzoa8fZ24AfLB1E42EDET6l2UycHRo0nFrJfhdwUipTEGanYl0zGsxvWUJ65cLOEIaPlbi
 iLacTdh2Of5HFnsnYGZopdn2tIF6tqtbhh7a3aocB3HZ2NYn4yG0Upu7nF1It0NI82EZh2rn6L5
 f8ZoiowwkOdfwmkhwFQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210083

Encapsulate the reference counting logic for OF nodes assigned to
platform devices created with platform_device_alloc() in a helper
function. Make the kerneldoc state that this is the proper interface for
assigning OF nodes to dynamically allocated platform devices. This will
allow us to switch to counting the references of the device's firmware
nodes, not only the OF nodes.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/platform.c         | 18 ++++++++++++++++++
 include/linux/platform_device.h |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 4824d9a2edbe9ff86cc9893cd74688e9cbb6483e..ec53383fa17ac29ea3b15b61f97ae65ae8ca22ac 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -693,6 +693,24 @@ int platform_device_add_data(struct platform_device *pdev, const void *data,
 }
 EXPORT_SYMBOL_GPL(platform_device_add_data);
 
+/**
+ * platform_device_set_of_node - assign an OF node to device
+ * @pdev: platform device to add the node for
+ * @np: new device node
+ *
+ * Assign an OF node to this platform device. Internally keep track of the
+ * reference count. Devices created with platform_device_alloc() must use this
+ * function instead of assigning the node manually.
+ */
+void platform_device_set_of_node(struct platform_device *pdev,
+				 struct device_node *np)
+{
+	of_node_put(pdev->dev.of_node);
+	pdev->dev.of_node = of_node_get(np);
+	pdev->dev.fwnode = of_fwnode_handle(np);
+}
+EXPORT_SYMBOL_GPL(platform_device_set_of_node);
+
 /**
  * platform_device_add - add a platform device to device hierarchy
  * @pdev: platform device we're adding
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 975400a472e30e2f98cc8f13bc36a63129bd4fcf..21f7d8a7f4b5c9a47d56d80a69802b3f84457ef7 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -19,6 +19,7 @@ struct irq_affinity;
 struct mfd_cell;
 struct property_entry;
 struct platform_device_id;
+struct device_node;
 
 struct platform_device {
 	const char	*name;
@@ -262,6 +263,8 @@ extern int platform_device_add_resources(struct platform_device *pdev,
 					 unsigned int num);
 extern int platform_device_add_data(struct platform_device *pdev,
 				    const void *data, size_t size);
+void platform_device_set_of_node(struct platform_device *pdev,
+				 struct device_node *np);
 extern int platform_device_add(struct platform_device *pdev);
 extern void platform_device_del(struct platform_device *pdev);
 extern void platform_device_put(struct platform_device *pdev);

-- 
2.47.3


