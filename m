Return-Path: <linuxppc-dev+bounces-21302-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34063CD5BAA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 08:39:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLhck3YXFz3bpt;
	Thu, 21 May 2026 18:37:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779352678;
	cv=none; b=oDCZvatcCHspziObdhSA3+kz5stcQ73mCfgPLF8UPwXcEK3NPaQ7qnbm2r6G+eYmWyqZxkd2SrtswrIW3XvGpwFJRzJboRLtZHcr6PzGoLNM8AehYCYIW0zodZMnCDOaUTNVhn12MV7TIoiMq/p9wWThqViki96B3bC0JTx4R60v9P6/KOVlZbd0Jlcy2W3OIQfLMssPCaAfUDaIxx3QR2JIqqGebd/YGK2UCkN2F0y9RLPk7/BEv68BN3VcBcDQrWGHr64mA/TtMlA/HBgYAFOtZtxz1UXCsB8E+8u9eoPsyqNO+dqnaBAPNw2BrOuYFTspxrCiljjJJMZI1PXKQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779352678; c=relaxed/relaxed;
	bh=JM5WrS8FsL7s/NkKefUF2OuGPRtsF5B5mOOL733hTA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GFGefmrTVbcD7tGA0t9aOTTQdwdk2jU04lh9UxhOGH+VkfSxCSh7ypUb4sOr3Rpsndfhf7r2XhinZJY3r23ec1M3z1oBjO8oYj4o143wpOsomvA+JfxynTwKgx/1shAXqgsyvDdkMHv/npPSuDfGD/nkI3bfJI5oz0iH/Aj3HkzWwYna8hD06jP6Mgf+Gm3AhvZVvov/vz/uf1nvkIMWqthORpXlPoRSdfrLuwoK9dPGSnYX25EvkuPYJsbd8BuWKqU9sGUBJkzEJhQHa0CnUQns15GCmwjdNeJTFZepl614EyVXCAMEkoatOBRWFVdLnFkuuEMfzvITP9xJG/K23Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fw8QZ03A; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I0Rt1h0m; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fw8QZ03A;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I0Rt1h0m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLhcj5vN7z3bps
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 18:37:57 +1000 (AEST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L7M9KU118986
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 08:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JM5WrS8FsL7s/NkKefUF2OuGPRtsF5B5mOOL733hTA0=; b=fw8QZ03AavUTjU4Q
	S3ZEST3b2vZi66clxpJ7YbdOzT1lEy0sb6r2I1Ck3VOlZOg4M2Mztk6W82f4Kvvs
	jZLIPlVuoO4nlh7Wqs+/c66Ab49g+3nB89mZqp1gAF8ahSngzWbMG+7on0fZ9YlP
	96r5mc8tTOfipeRDNZsYPXCC8PdK+rWZbnqbtYn/5kAO/MBO4CryrO30EAeszdvq
	4MNvuFSZwHrrLa7k/HvIZsKbSBTRGeglcQQwOd4iQ34Ehsq+6T3FuycqAhEzco02
	gXt4uUtg8e4RrxkRcrjBU9zhs3CpOqq7eZvJiw0NZKgu57dsDcb83OskcsFqwSkK
	FOUi9g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ee8c1ea-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 08:37:56 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50d890580e1so127512901cf.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 01:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779352675; x=1779957475; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JM5WrS8FsL7s/NkKefUF2OuGPRtsF5B5mOOL733hTA0=;
        b=I0Rt1h0mgWztkDXF3VN1mrZe7brxrk36DXulsuHh3pwaXwkcKvztHfQRgYTjQGcDLn
         grDAY6oBG2UveSUUXoCUulmziCHivYyhVlFeGnppLYIMdQZP/rzdFFO3lCAuUxdLhR6Z
         Y7DnvMJXi0qS56dghu8xL6EVnw6VaSE568ra5ycHpe+YaM2BB5avVqmh3cka5pzNHaMa
         fntCc0xY42es2CNMcshcV9C/0uGqH2VlEZc0CxRNxeVIzhirSK0CL3wo043Sip7MSCi1
         vo0YnYxa5er4K9P45kz7tt6kKOCjNtpHMN6f4oT86cWjP8yPnyxai3WP1E8cFwkYKJAv
         gOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352675; x=1779957475;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JM5WrS8FsL7s/NkKefUF2OuGPRtsF5B5mOOL733hTA0=;
        b=Bqcx6pN+/dEsF+FE8jQ5AVq8yVUapZVo5zTaXGLWHdWw9WI76pTly2VH3jfPpyUb4G
         qcEY+ilLAJzS+crdx46CrG6nILyK/7MmJFA+KBc21Ms9IpKECkk32fCynjDQxylXpoAl
         mcxh840c/GxLvVtXhxkfFvRdySvtj07T9pegH/RuudH3onlcQfrRZjGaGHs2osERtonu
         kfsQWUxjgA2yec0HN+iOfCEk8LFNf7Cr/ogAx0RuqroQ4a2t/78/Sxvr0os/grKczQ9S
         NpGdh+0XbZTDGDVpJrhwK8lyby7R0VXPPfkhZGM/Pfpe2PVLHhWMUsSWNdYDvM33QsiM
         S/nw==
X-Forwarded-Encrypted: i=1; AFNElJ+P43Oezgqz5BbD2/RO0ghQTS36w1ItJxXHExyj0/AVdM/e8GqS9tirpJ/N3s/zhkv7819zTr7aUBqSNFU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzrP8EldVJ3SWb5ORagy1EmTBn3U5XY9JhfJhy9I0KX3E5ZGWGT
	mcg1aN4Pz2PhbYqaka7HCnEKJtyd6gufCIRQzWgzaVHAHTETvGmqQZuZvQ7xmLp+9z+DbThfcur
	V0RH/Ghpcxh+HYuS0uZ9w5DTZPhxvxnz9ihLixmfOA+zV3hY1xkEMrCJ+VWYVNlGPDSFA
X-Gm-Gg: Acq92OE/uTbIpG9pUT+GAEKlD5DxL9d5zxTMpxR9LXJILIbfe2zPXqafAGLRueyp8Nb
	9AxRG0ZTzoqbxRGBG7gKfVajy2XH0WfgkC6fW5gq40CbGYhsIyS7rSby9/t2ospdQXEdamiodqZ
	Po1Je883uhvQAxgQ3secB96QLP9uRcsEOe3zSL4i/9U2CeK/vjLKkaTLlG+gGt5Qo1YbXYNetHp
	pwC9NMgx8JwA3YZ2TQ0DBHFEeAXG1LJKB1LPe4I8WrWJp0B4sEGdVbOt+/e0wXRSqqINNhyO9qT
	yOph5GIMRiEzpkBG0aFI4b9uuKQSAwKsQQA3vChdeEWK02fkJNZye9t0tmKeTS9AqNfaK5+SvCm
	UvXV7RPufkXKTCzD5zHv1V9CWHe7rUDBPlB4vT201v2oWlcTKVUQ=
X-Received: by 2002:a05:622a:8418:10b0:516:c92e:68a0 with SMTP id d75a77b69052e-516c92e6b34mr7156161cf.60.1779352675116;
        Thu, 21 May 2026 01:37:55 -0700 (PDT)
X-Received: by 2002:a05:622a:8418:10b0:516:c92e:68a0 with SMTP id d75a77b69052e-516c92e6b34mr7155691cf.60.1779352674619;
        Thu, 21 May 2026 01:37:54 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:37:53 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:39 +0200
Subject: [PATCH 16/23] slimbus: qcom-ngd-ctrl: use
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
Message-Id: <20260521-pdev-fwnode-ref-v1-16-88c324a1b8d2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=914;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=WNjV02xlopOt/yCOR6c1PBVV+f9PcccL6Myit6QlqNg=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQraq494NpNjsZdM6B5yhOMPpc0+cpQHRIzk
 BziCgGQMEmJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7EKwAKCRAFnS7L/zaE
 w4jTD/4l8BoivhRf297UcPlBF2FNgHn3SoPDZT2tcoCJ4pwYH2iOy+vtLErAAScTa0i+1UqBq12
 r/vnG58789VM/bZsVlX58HBBULss6RrXsI0b1xw8EkCBAbZgWviONlZkPl0INnnV/NQary8Ou61
 HS+Z9Bx2tUipQMxu1TR8k81/EnWgFAvXN2yn6rGm6KlEZGdPPoy+xyAPIudQCSPKNiItdIQy4UW
 L69otnhA4ShEQ1sNMuTK8FbfYGh60eKt7KSdIYr0joMsQqIDzR9lXGYSWsm6AkMFlZSeSDfPzec
 cbKOHBaPD/LZwggKavKmoyvpCN4R/mhifGK8vPPc+GHXXtl4NtFIzFPGDF+P09BUDdBTekpHXKF
 QdwNV1cr2r5NDEAGEz3fzJwU8AlGjoP67Fs3SG1KKOHS6JGuLDV5XEoMu2ujeF9D0wftPdbBnXE
 0XaON/q+Bo68CpJTJ/AKWzJGEasq8K8q/cZQtsbgg5p4M4Mc+Lh2mtvDp4O5yiWshRKBIKs5vvC
 P1+9Sr7JULlC9oNSLKd3qQazCwSqYr8qkLS4hpmeKs22LIastCqlnU5Icf8DpLIDThbnJftTd8D
 mlxLqdCStPGfHY0hJWWilamRC/5mefu2XlUg8HkNToEyOLkmMsb2VNO04VxVf3nl2joirLMPZcg
 tH1KDuWnTXUMHCQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: XatrzVKKGUqOkpTiB3-00Rnfd9M2qM93
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a0ec464 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=zjndn8kAT0tTeq3eajEA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfX2LhcLKXpjVIl
 //zpWDa12cEvhGCFHj1QT7J/xsEKn1NmymYktMuhwtxDKj+RY3eNzXDMh8C5CN8KFtVcQpEut8b
 ELf/ehHEv54aq+HwKR7DQ4kWZUvLz9w3JrPMyBBU/9+1f4NlaXpLStCjGTAk3cvD9szIQgAZ7O/
 5kl5vtT6KFSyA9FLduAfl+mp6qvnjvb/nxkpFXz6olfRpF1vbn+FTnwb/faagR+CNId1FwKT26+
 wyIqlbFdexLlVep3c0MlMRQxB1aV+1j/YMSua5xa099DxLwW7LDygBK05ws0cEIAGPwzSvqTal2
 e6J1Y58jDwTBbGsCMtmxxcNzTJP3Y86lfmIG0iPEQauC+gijRTO378fbtQ8u60572kSVGFWfC8i
 /RaQ3U7+x5niC2txP/AUq/kl2CXV+SOJUf7740XxLYjOsywprdBE6TX0LpkJWmsBDDmVlBUIVzw
 zcTEh0KVw8zKMoccFvw==
X-Proofpoint-GUID: XatrzVKKGUqOkpTiB3-00Rnfd9M2qM93
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210083

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 428266949fdd07ac13c5553bded891225c6e1a16..70f06981533237cb5de47a855462220050f6d82b 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1542,7 +1542,7 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 			kfree(ngd);
 			return ret;
 		}
-		ngd->pdev->dev.of_node = of_node_get(node);
+		platform_device_set_of_node(ngd->pdev, node);
 		ctrl->ngd = ngd;
 
 		ret = platform_device_add(ngd->pdev);

-- 
2.47.3


