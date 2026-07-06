Return-Path: <linuxppc-dev+bounces-23624-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28453C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 12:46:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gv3xL10JNz3brv;
	Mon, 06 Jul 2026 22:45:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783341942;
	cv=none; b=bQXqGS5NIb9rbpIcbkoW9HNpp+SyEp6MI0ozkcuozJAOvFnJP2CQLdgay4Ob4kZK+eOCQOzyDoF/9ihgzFOEwAIEkzdGY4+oSxKHnLpYLo95vhz9pvT58wa+IXKIh42hhQzcC9ySGkzPk2oFo4yfn6ES3k7Tyhp9wOQns+xWS897ODAA0yQ4p2jn1EWb0ujla1F+GOGNzuZRhJfP4U86MftusKLL8QB0hcUW5vAMXhwaISGkoxj0jRpjQG/eHK7QZ+jPFQKHO8448OUFanHbcVEk367lvgiSdmpBho6let1E9aiLvUhRmGeIv6nqzb4uXe1RsJxzrDSOSV3x2BWMzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783341942; c=relaxed/relaxed;
	bh=p51jH23aSJ9P4hgPBVXfrJf6rqkVYzBZRhHms1xVt08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=daOakojO6s0ctOd32EHUkXUGccaFKOLpnZPuB9ufcBD5nJA7jyrc/850sgeXrkL3LXU8hn+NhJb36rUQYZEoPlyDxhK9KReCllSp5P5s1M7EQkbExf2qhFh7Wpq+iNdZnukpD8VG19HJyRoWO0iTAHxzPpZ8arWSfoM5AbhWhqrlymXFzDlQbGZ1wSEyR0mQO4Nm9mv3znxYk+Rlz7mdBW2u+T9BwPKmGQTLuH09rHO/UPQubOW4v7YpqBPNb1cUpkyRrHxglOWRDzvGqbqsfup1i6yeElIv4rRpga/yiBY/KkpXqzEU7ZUYc7+/QEJrXTZgHyIikkZt1xYoK1pnEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gJh35zU1; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XfhMN+Sg; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gJh35zU1;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XfhMN+Sg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gv3xK48D5z3brB
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 22:45:41 +1000 (AEST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxDbK238262
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Jul 2026 12:45:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p51jH23aSJ9P4hgPBVXfrJf6rqkVYzBZRhHms1xVt08=; b=gJh35zU1SYc059Mf
	kDmzOcoi8OfW6ne7PvGIDiA0fUt9s1YZpBnz5nVNLGXFepzjq+wO6cJlTtHczuDD
	ZGqYtYQUPKB+pVGNdLRTXkKNfZAAbm4v0ug8pX8PFkIaNGBY01+7NSHsN/u2HN5Y
	tbm72Yl/fWB/aTmvseGlpzcobggBnxVRm4q0Gog3CtksosQwpxEDcARFFDPfPkpg
	ChwullFaVKNGGJR6F92cq9S6BLPebAuiOUtq4Iz38rx+/oWMW8Ott0xZJiW+0YVd
	2dbOKMC0L9HHcKIfxWOq/UqBsRV7quCnrptznzywqiW0Xb9yNcRzTdtOklJNiczb
	qZigqw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88t89023-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 12:45:39 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8e9489f62bfso3675636d6.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 05:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783341939; x=1783946739; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p51jH23aSJ9P4hgPBVXfrJf6rqkVYzBZRhHms1xVt08=;
        b=XfhMN+SgGH0UeMz4bXhX89ASi9RRJou6rYJQR2tcObQC2Laufjj7y8aJSzZuezPg9a
         4dyBhNvYAo0L6P7b/HiyAthJQ3T+OAJBCSSWomGLuDe7cqF+1jlQHcWsikW2aLDA9Jc8
         upWgVWlpPzc+jAV3HfDnEYwLeV7vlr37vf0EKNkXCttAGJVnmf467FACtktTBMVdtHpq
         0aU8v60gFcm7KZyyvy2A5S6uO4kk8qGXHO85L7iBxZGFKOOwfAs5wDoz3EF5oaG58p5v
         rO1U80qvcZltB5ElvndUo6S3zcnFd1plGZnoNCeB7RxyW2BaXGp7zOZDlpZ8qvCCom+J
         6+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783341939; x=1783946739;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p51jH23aSJ9P4hgPBVXfrJf6rqkVYzBZRhHms1xVt08=;
        b=sNGycpsbAtNkY4qW903IPNt/+UDArfGI/TnmovyXf8J/vdzyFwWwAyBhWe04x+ZYYj
         w2fGto7mEDs4GJSSuQK3YoFhh6Vr7wRoZs8akH4dWUxtgXdyz7ZvGtzNp9+vg/o3Paix
         K3CcBlwx16ghqeIUEcsmuQSrJzkNf7uiyU0Aji71kBg7kvr36d3QCkUVy8TCN707diEU
         X6M5yr+zYrcbEtKlNTLy8CB2DxOhTY8PYUc/Rjr7uwR0TBQDUslAVW05tCowHTOpTY2v
         qcFAEj7jS7p65y5k2NLJCZwE+u8IqAuvWtxpm63+5br3zDGAW5QY/Zcd7VRRhV6lBKLn
         vg7Q==
X-Forwarded-Encrypted: i=1; AHgh+RpIQTwT9UkQtQNiLKL6pfWI/kLPC/oFH3RqJTLrcUz2Bvqw+jj0aphCyx1z+LuoekSG849Scp4mA1Ypeyw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyVKMOYL4+YB0ghaHZO0/FPdSQApFLXzdWyDuCp1nSaFv7X/GJh
	Xmo3rNRNKCizs1qqk6PBDbMbmNOTL868fN/i3DE6MW/OV/KNoj2QHilbE34KNCe2Pn/UNPpKDbe
	xULBtUKGUOesbu4TqZUkibfA+3/Y2QefdMB2wJ64CVQRMPXvQTKhZGl7sFVUqlfms/q3Xlz5vaL
	gO
X-Gm-Gg: AfdE7ckcPf8YXEMRPHSF/7CfWjJQoYnJiVy/SeJfFOyJ9YJNZpn7lMfB13iWqSi4LHv
	CDKaueLFC0xO0Y9jxce+I9gQKZYUQmaIrAfKhvHwA5+CCqK1wDJCdOnAFpHEkr2UpMtQOm6QHwA
	czRFW7aB+gUwxzs8Zm0MYWNqK66ulIs8OBSngH6hYumBGJns24no3ya9iHhreI/l4S8khtxYEP0
	tgzwLhxQdmA8HgErdbNdMkhkbtZXxwP4TcdIM0Ekp+XgXKjKCg5FVRLAJvPicyMPxl9tb4ZHCcH
	7sAP0RRlIY4gclgK9nn19TIZ81lUKnd4mN9GxkbqW1TOP0RR312cLXmK3VaLgOKA0l5pSArNATg
	BCG1NyELVuJHhqL110ltkccdGAJCch8EMoP82UseU
X-Received: by 2002:a05:620a:1a20:b0:92e:4b7b:b509 with SMTP id af79cd13be357-92ebb71dd15mr45115285a.70.1783341938828;
        Mon, 06 Jul 2026 05:45:38 -0700 (PDT)
X-Received: by 2002:a05:620a:1a20:b0:92e:4b7b:b509 with SMTP id af79cd13be357-92ebb71dd15mr45109985a.70.1783341938396;
        Mon, 06 Jul 2026 05:45:38 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:45:37 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:28 +0200
Subject: [PATCH v3 16/20] platform/surface: gpe: use
 platform_device_set_fwnode()
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
Content-Transfer-Encoding: 8bit
Message-Id: <20260706-pdev-fwnode-ref-v3-16-1ff028e33779@oss.qualcomm.com>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
In-Reply-To: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
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
        mfd@lists.linux.dev,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1014;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=dJOOLkzsh6Wqn9Xl+Q2MUEX+fF/xdnyRuGBTZrS3poA=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6M7vyboAnx1GXm4N71aps9kZIgDjWS536X7B
 R0DvjC/PLmJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujOwAKCRAFnS7L/zaE
 wxGND/97BgjATyNhjWpgHVy2n/eBlvyk9m1ACiooUS3Aa21bdFHgaiofDxBxF2cMiA2c0EhNy/t
 yCcK3JPuDx80ppfSjGwmjnCJdeW76uOUgrIR9fEkRhfl5uXDdZ1UuNvgSgWqWLPpP7FiX6sQISU
 ekCOzOUytlF/cDiDZmOMYv1swMV7subHOQoxVfhIDmwL/RnlsR3WOql3VY6yXb48yLv1lXH+B1J
 yrWVkN8KdzQRCrBmBxI6FV2+Slzy1n9it28F0VGGE9eLn7HC+steWu0qWnNh3Df6XBggoSSSgD4
 EV4WaMWdLM/lWmxcqjsEOYh7A1HPAhrpPOfeelnV7dj7Q7t3fD3dF5G9ToZyjI1W/NybHHU2lum
 LT58xttRQ4UNCfwia5kKUaz6cTYDVIucBYOQyaiGnyC6BMlWkY4JjkrMp2YuEdsSxfG0+btmhsX
 lpyOd277A8TCDmgWDOzZ/8tOKvnV2sKttsOGgUMIWaihJYfQ/aS2xnC1dEAChFukUZlIWWWm3Qp
 JHwEuPx13B2be7HKRm6PQil7pRAJHYi9tAmAp/de98huRMq7OQpOJeR3s6aJtjpd+yrRyoD71Q9
 7X8ByYmBR/0kT9aixxj5YiEcTcNcX1dbwkXRGocTR+zDiXrImgKkI99Z5SjhG1gaRZAbVFTqEAX
 XDRBrIltqvBZ+0w==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfXxT/BmJ+gFySo
 HnJNWok8OONP/xRl7hy7tsBVbKurz61aAZ10NBddyoHJCet+b8lKAY3UvCAMGVeWSBmczLZWYaB
 YmhAjFS8OlDgsrt2Rjj9xhOHw6M02lo=
X-Proofpoint-GUID: fz_7H4BCixHlULFPdISiqINWaMmYPR1x
X-Authority-Analysis: v=2.4 cv=C6zZDwP+ c=1 sm=1 tr=0 ts=6a4ba373 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=PjYnKYjuuXkzxcC25kYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: fz_7H4BCixHlULFPdISiqINWaMmYPR1x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX3qXHXsnhcAHJ
 4VX/BuuxbEMz2u6ytbg2b2KnnZkD9G5OdOeEHaiy3LpQTzjcQy+FcstTgfI511fwcpoDiZWKA4E
 WjJN/W6tUpjLoEAUKFUWOa61/bG2l0is8yfutxioZW22fEiHo+2LdxUm5sHC657+4Bk6B0Mf/17
 QHJqWWfVXU9jLgSKdBI9Dz0XvEdWdKmutt2zfpQ0aAPoJ4gBzTKR5niiwz+vFJvqOUnGiBBhpnV
 9Meb3PHIddCjULH9r+A2xX3IIPys3+cUH0n6MaDcFTVPByoTQYCGfq3hUTfSkTVmt+0R/AcvkoS
 IC4K55OOOCd3r9kS/bcgBkp6lPDQbmv+DFYwfDCD5Lfoi5OKq4vDHP+yr1ZgkuDsvF8l1Xhyfcu
 GNFJ1bwHyTpHL8azV5q/DB2yB1K/L+fTg0Ab5lxWEJgjV38ELG5Bd4hMQTHbxpsu0597IOlblE8
 RciGjNB7DOW3CXG5tGg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060129

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the firmware node for dynamically allocated
platform devices with the provided helper.

Acked-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/platform/surface/surface_gpe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/surface/surface_gpe.c b/drivers/platform/surface/surface_gpe.c
index b359413903b13c4f8e8b284ef7ae6f6db3f47d72..40896a8544b0a4da4261ea881b1eaed62d93b32b 100644
--- a/drivers/platform/surface/surface_gpe.c
+++ b/drivers/platform/surface/surface_gpe.c
@@ -317,7 +317,7 @@ static int __init surface_gpe_init(void)
 		goto err_alloc;
 	}
 
-	pdev->dev.fwnode = fwnode;
+	platform_device_set_fwnode(pdev, fwnode);
 
 	status = platform_device_add(pdev);
 	if (status)

-- 
2.47.3


