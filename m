Return-Path: <linuxppc-dev+bounces-23070-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2FEC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 09:44:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gphG23p6wz2yZ8;
	Mon, 29 Jun 2026 19:44:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782726298;
	cv=none; b=aagPDTAc4SgP7y13qjonT/+VdjmNGqdquBqpRggOOY1aO4GwUqdtDbAqMHzNOwgTF24MwhtksxqulAP0KZM7tQRMxyYUzxJwetQNpALCa+njLZ6/f8dFRyHlv54KGej9zNi+t63EfPqG9RYS6cvfC9XEfF/3MgPGvDEKO1boSpPNdSMeQMJp24Or0mFj3ixI7zNLwZuKNjxocz3Gwo33YlSappGbTzpKrDwvAzA65FfQVNA7mgof1LEwD0Ojz0A6qj5In9eSrdIsXi/kLr5yz8wcq0nOsoxnRJpSRP9smj+bK5GZ09nxTLxZV4ENgLvDg1b4w9VNVjAshhJ87kntqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782726298; c=relaxed/relaxed;
	bh=BmmK6vf3xg5kSs+g+NySw3CxCiN6R9NnyD/njOvPVjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b72Rjg8tWlvQafSFFeTz2QLjGhNLqe/3Tx2XVbfsB8WqOdNiDN5eLS+0td7Y5/vgwqg4Qd2I7i0SnjKidg+SiyN7mlkNLCjTf7ckPlda1rk5w85v8DVBwoTFmKvaimD89QmvWJ9PJAKlpUBAXM2YwqlbAgjH5CxFFEDoT6hXQTdNTvAXi2Hah5xDQHB4xzrWYb2LVMvlxae8LaCm+59fWxDxf6OKWDfyI20uk4HWbL5N7yFh/Z1vlVfCs5wFx4nMcmpnQNpRTzRwgG3/K420U3L1rpWlhy5A0HP+skHlSoEaqFI+8XRebdtUXizSAKXM/QXBIU2n8sHNNv5ylA+qXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lka551JY; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Llh2hrTX; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lka551JY;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Llh2hrTX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gphG15yN0z2yT0
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 19:44:57 +1000 (AEST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T91ONY2400910
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 09:13:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BmmK6vf3xg5kSs+g+NySw3CxCiN6R9NnyD/njOvPVjA=; b=lka551JY52AAQD0N
	E1nsTsclnKJB9amehHdeu7bzmvQhFFyH9jnIDHlkrxX+7hSdRvhB8oznWibv1n47
	TQJ93IOSM+SS3HBW6OhkTYu/8uBEGRh96wB+2s3baNMiaHwcod7+emf0GARrG4dG
	ujmpsZ/GRFx64Ut0bLqS/upYq5ytq9s48TVwl7RViMDdtwEFBTi3PdvLviVP2MFm
	YTUb+PFU9akJEbNi8hyUgnaCeAdALfzfFj3s7iFe38BNuMC+pavQ9JJtRHyTehT1
	FLI6q2M9RNjFVtvofU3cjlu0pDwZzcqZgMmAje0zblGjFrXVez6nANvsIq9pnj3H
	KnpFzw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nq881m2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 09:13:12 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92229624a71so571577785a.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 02:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782724391; x=1783329191; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BmmK6vf3xg5kSs+g+NySw3CxCiN6R9NnyD/njOvPVjA=;
        b=Llh2hrTXjs45VOyppf0S5YGEKwRgmw096o7T4vxcyPLGeePp+vsDxvk0K2/KCSDusZ
         UlWskx9Q+EOCakMzZ3GgLZxE+tqvn1vv7PkqETufd6R6zFUkt/6w526nXLASI+5N8TBu
         KEJtISSBCoCFwP+Sg74wIV7FjmbdOwNt8oihyPiaafjrVGRVXrtTHtf5nlKPUKLA7TlJ
         L7q6RbA10XBSIN2plYtgxllFVMOMUHEqEpPh+Kf+Caf2nQLqRDINkzyNGt+PC4SqeET4
         mr6McIi0wfPC4dc0/pSsyCC1jbwPG+09drsextSbsui9W/d8p34VfyDLNzvO7oG6Kd2B
         b8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782724391; x=1783329191;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BmmK6vf3xg5kSs+g+NySw3CxCiN6R9NnyD/njOvPVjA=;
        b=owHpuhJiz+RdqE3WpdAcZDoXxDidrudNechFpw8IjhuQNC/KU1HRJl4RDEXpv6F/CF
         aSDQCGC+EmXSF5BzliGKQbUZIqWuyxLTkwAbBGBFv0z0v1EoDyvQ8zCOmhnskQSUXPTC
         AZSMh9njYNhJqI98F721PU7B3yK2f0SgnhnGtb+/0y0glj6tdZusAvGsEYIgIOJPg2yv
         uYs0+n6p8dXgfPJdi80w9/oRYnGoL6BhGFTVqiOBK0nizJ4eGP10SQbMq8DVW6ndkeMd
         Cj0v6W7UNrP3QkpKiYoBpLbtf4I/BUVs0Mt+EDE7C+tGjgMnORG/9a/oEmUYlU2WBBGE
         F6nA==
X-Forwarded-Encrypted: i=1; AFNElJ/1cxESxow41npScjy+uKRcy7gj26j+oGDS1dObyJgsI8RjMYQoXDNC/ozYN8gLJrucriGGZQd/71h8nYI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy5ydupDdG6C7xmrWCBHEgKuaxfoXImKAlq6tk9dVTHW0Y68ND0
	wlTxF1WmEbSx1tLycwrBv+JNziF//3+K5jQwigW+d01huOVkIkWS+ymObF9suALDkr1j6a0SItT
	uRLpr+1nJp9vK7kCpBQV0FcaBgAskkZUYr3bn/wtgYqZ0iC106KZYAG+TD/IBXkvm+whZ
X-Gm-Gg: AfdE7clIuEqMkGaj1xobJj1gmC+w/cJw/5seRYI44ZW0ygawGq3z+RMKH7sEveocqIl
	z4WFI7YSno+Sg2rVbxi4uciezCvzYQhpOOKZ3k4eFzpB0MpRvctFD3+9S7DtQW5xjFsZRWIbjOe
	RQDliPp5hLOhVZ4B6fP4wH7wBa+0Iwh8GVpC0VSWwN64vLg7VO9vnNuVuFgYGfIwYy7tLU37CKA
	aERnTMihLjH8EzTRMY8dnr7sBUHbbyS5+4uFSY5nrzwdxUhWXfWrl+ftgiaZ8JoTud+YsDxt2n/
	SN8KX7fcIbKomMvnkR1skAhnMrZ+Ww3nXieehjrHJxK/NluelNqzIpt0t+W0JGM7rfQOIFhgCwa
	Med9UUKK4WLrmzdk/PbqB1RWD67sHFXPvTLAfXJr0
X-Received: by 2002:a05:620a:a195:20b0:92b:4ce5:6390 with SMTP id af79cd13be357-92b4ce57573mr1026442285a.25.1782724390941;
        Mon, 29 Jun 2026 02:13:10 -0700 (PDT)
X-Received: by 2002:a05:620a:a195:20b0:92b:4ce5:6390 with SMTP id af79cd13be357-92b4ce57573mr1026435185a.25.1782724390191;
        Mon, 29 Jun 2026 02:13:10 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-470f55acda0sm20109240f8f.23.2026.06.29.02.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:13:08 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:12:27 +0200
Subject: [PATCH v2 04/19] driver core: platform: provide
 platform_device_set_of_node_from_dev()
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
Message-Id: <20260629-pdev-fwnode-ref-v2-4-8abe2513f96e@oss.qualcomm.com>
References: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
In-Reply-To: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2284;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=4Xem2fZJuhLkEpQ8AuCHhmO9dgYwD7FFiD2wwhhVUBk=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQjcKKhTwBlGLPKN++MiZnFDb7ToqrUhpCsLFF
 bslLR74S6qJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakI3CgAKCRAFnS7L/zaE
 w/b0D/9hlzF+MuyoI63nIic0Ze6VbI7qxNCbhn6uZeyniPLgZtbwhc69m2JUdgrAsHuQj0IpgJ5
 RCEa24lCvBE2SclclefxC17v1wor7uj4mUrvqJAsmjgFueZdPPr1N600723ruBzPxuJumeQzssh
 jlRIYTX7/407wi5FmqwD448VpGUlB7Pa8NNjN4IxiVGs5XNbGOoj/im/ZWZEqGnDlSu01mcNJ6H
 iCfItNYSQATbNs8tXytgXjr2lFulGi9myKKDBQTaxbB5YtuL+8nWjUC+8o8kzBnw0EB5rK2I3RZ
 xOnAwjeUNAsnoHP1h5Zu3bola+8Dt77547fO6ziravWksfKzGMhGBTDYqtHYdVBNiSbOu01mOhj
 wW2esT/uXcCEuSBCz5c6WMXwwp5oY07WTlwLR5FKetn3Nr8g0u7Jct0e9Ae0Mt7+sOKVLeVMy6H
 VRRwZ02oyzNv6rvb2wurGxqaqfrcXzQuJCOYNJ3jXfPXjuhBl0/jsf/Mh+jygRzqUCoxEpt2gB4
 VgJ1DsNmgpFosrKXs4a3l3flS+45sPbHJm3BdJMiIo/xXOgRhIEL8CNJjywDB0OugyemEEIs2ih
 rS4p2TSq2yTzG7YADPWUwWt9NpbmH36Qfqd4amAhIgP0uFrRnLP+2T42NgZ8X9f7xOLG6mDeruO
 VLhlU915iOWWEBQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: yTCjxZvf1GdE3wDQUIX5RWvXfM0ZpztG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX/WJmR2CKmOyN
 FWmL1mmYUhbuWbsTC4s2DD1OdBVZt33Yaq/SLgaQjjN7HA6ewC9i7hyrC+cP9z5p/H0Taa3Hzwm
 5hQmGFkTNjsW4zdxpyMXVwpb164cUfk=
X-Proofpoint-ORIG-GUID: yTCjxZvf1GdE3wDQUIX5RWvXfM0ZpztG
X-Authority-Analysis: v=2.4 cv=PqSjqQM3 c=1 sm=1 tr=0 ts=6a423728 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=hkCPowqfBUTF6yk2FrcA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX6PiVU2NB+DC8
 ErObhcyB+XVjbeQ/tKqRKm5MmWCLK3z/jwIlcLOPG26B4urkaNWlOk4In99w52hQxyvE7p+ViTu
 8iXQcSriqpjqlsSXHI7TI9D83IQJybTeSVtqcrYY230/J64Ui0ea+NDChqHt07ng6a2IcZ2OkS+
 70zLwBbfUc3Nc/BKMQlmty24foZYtS0MvcC4yclEA2OeXdxPEGCnGrnZxw/J/6xfCBbqE5WMv+c
 MVnc2SXUvjSwsHtl+G0NdlS3SpvG5WK2TpIRBUeQqW4q12VIQiDAmqmVU04UQW9okT2/GIoLlE3
 dlDr0p6QJjoq2UjVTlgR8gVacf47xXsdON1KmckpBm92xpZ0ROsOq2pnY0xf+ow2bCwu3bWs8RW
 tO3USKXDrkmh6PwInWben4YthnzQAPCXpTclhaHGQbdSVhm77BTxkHMZws7xWcsUiXoZYlhvTez
 8NvkF0Qk7xJwvXxwweg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290074

Provide a platform-specific variant of device_set_of_node_from_dev(). In
addition to bumping the reference count of the OF node being assigned,
it also assigns the fwnode of the platform device.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/platform.c         | 16 ++++++++++++++++
 include/linux/platform_device.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 6520b70cf3052d683a2ecb1a0dd7227575546ba0..f24a5f406746b53ca9eaab9472f6dd1345e04ad6 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -730,6 +730,22 @@ void platform_device_set_fwnode(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(platform_device_set_fwnode);
 
+/**
+ * platform_device_set_of_node_from_dev - reuse OF node of another device
+ * @pdev: platform device to set the node for
+ * @dev2: device whose OF node to reuse
+ *
+ * Reuses the OF node of another device in this platform device while
+ * internally keeping track of reference counting.
+ */
+void platform_device_set_of_node_from_dev(struct platform_device *pdev,
+					  const struct device *dev2)
+{
+	device_set_of_node_from_dev(&pdev->dev, dev2);
+	pdev->dev.fwnode = of_fwnode_handle(pdev->dev.of_node);
+}
+EXPORT_SYMBOL_GPL(platform_device_set_of_node_from_dev);
+
 /**
  * platform_device_add - add a platform device to device hierarchy
  * @pdev: platform device we're adding
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index c463d46b7b9ab6b891df1ca9f0c98608d2bb140f..94b8d2b46e913ebcdbdaa3710f008f478b59d7b4 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -268,6 +268,8 @@ void platform_device_set_of_node(struct platform_device *pdev,
 				 struct device_node *np);
 void platform_device_set_fwnode(struct platform_device *pdev,
 				struct fwnode_handle *fwnode);
+void platform_device_set_of_node_from_dev(struct platform_device *pdev,
+					  const struct device *dev2);
 extern int platform_device_add(struct platform_device *pdev);
 extern void platform_device_del(struct platform_device *pdev);
 extern void platform_device_put(struct platform_device *pdev);

-- 
2.47.3


