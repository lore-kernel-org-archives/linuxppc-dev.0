Return-Path: <linuxppc-dev+bounces-23611-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97A3C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 12:45:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gv3wb6zydz3btX;
	Mon, 06 Jul 2026 22:45:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783341903;
	cv=none; b=mLmBX5D6q2H6ysxY/+8KFuXFaei2NKv/Gc+rl6yMNYgTNSubd8E0qJPW3yFT2Ia+OnnSBcLEMePUK2Iqdb4iQvmExeOuqfwicE0JOHzSO4TJS6hZyvNMydlO4+oFeWy01UhuYdH9G9uzjoJTEg8H64QoFkHzgXg0WsYJK6+yZ4IMbzauaOgb6gfUrIDdua6MPp3UoT7Us5gJ0nTXBIOKb7IK0GP+C075Hx3LE4FBKffle031Y80Fd0JxCVU3/EpBKt/r/5sZ71Yac6JXRxsXbT2NbjIEEXLWvtchYFvTAjUSb/6hcH4f/03DV0ab8qO/sfACcQBFUo8mhzHNfQfIoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783341903; c=relaxed/relaxed;
	bh=3+yUr04oywdz4IiOeMls1g7Xd5wgtPGT8YOwPRuyxOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZHZTb0vO61Gc8VkgLsD/rWDQonM002a8A/RRWpwtqbZQEohtRpHbaDh1zIlmkajJoYDjIz4O2tBJmUbUg9Qfyem8M1Zp+ISHQnT0NRJ6Uu0q82HFwhmeM0fmOqI7p2xqZjtr++NJjScyDjgJgVWTPGYgVAmx9zntSxn8+cKXo1RzdBrX+CSmiPtMJXdLM5LVQh2MZUHw/9OJWk7dV5r08VRr0GXNbZHr+zUmGirLFNnDxRrlUZT7ncPIwr9s7/rNhzO9jzXyfBpvicm0sey08Y4Bqa5+YePeuFGyuKg+kx+FmmuUzaehMu2EBnl8M6esylyUa+KgwlhQjHIYtF+NyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eMDmEatA; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Wz9QT6uC; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eMDmEatA;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Wz9QT6uC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gv3wb19c3z3bby
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 22:45:02 +1000 (AEST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxJQx387475
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Jul 2026 12:45:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3+yUr04oywdz4IiOeMls1g7Xd5wgtPGT8YOwPRuyxOQ=; b=eMDmEatA+mntEhDP
	hJg0kYY5ngJKUD2HA6tUAT2pLblN/xbU0CHq6sj91iqZnEeZnVgd4vAdeRzGzMWY
	uoo5jiozfbRr90ky/IFTfnLovnWUDoT7RUSNvkuDAZWQePbASpj3sw68yWJWM0qT
	0zUz2Wp5rOpE879XRKdogY74+OkmzM5N1apchnTZ+Nojt8ltOW3B/faaBbHJL9cG
	4jJVAQNmAfMRAxJpiGEgKfBeyWKKSI3b2Rw+EBZx7jY3ORuS44gDyPy2GjPlm6I7
	uPoAwm/ZJ1ggoI/y2XHMHjZvHWMWw8lpcFwOAfkpMuBrlOvDZchrNOk+iUe4/Jy3
	6voEyw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3r0mg9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 12:45:00 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8ef18406878so36163046d6.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 05:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783341900; x=1783946700; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3+yUr04oywdz4IiOeMls1g7Xd5wgtPGT8YOwPRuyxOQ=;
        b=Wz9QT6uCKRuzlN8nHHX2LpIKjYW9zu/3+gJZVhYBDm0El1ejL/1/LQPPc981vEMZwu
         3+tPPBiy4Bato7Dp15PngocbMLb6RYxcVDZOQuXEA521tNms2+rzBPa1OQikiwwImSXM
         mYr0/30DbPypgrcHKNDM1aQS7K9ivtFeUrurpR4KBHrRsk5K+vuCv8v3FRk/asNpH3TL
         crPZiqx0nXKQEX+nMw/HQ7OeKd0f42duvf5MTwDYjdK8FX47HM1Cs7XOt1PRUZbgwGCD
         HM1SGwDiKtxRlREmwoUEkOUf8KW5xGdaCRreHZHM+8zY4ZHh6O+61RNbYXeuhjVVU9W0
         1SaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783341900; x=1783946700;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3+yUr04oywdz4IiOeMls1g7Xd5wgtPGT8YOwPRuyxOQ=;
        b=EI1vMnMHXj8DNZG30BZVP73qAahNYWwNTtiBRw9eH40+HKbIbidJvEDl5zOA+D7Hqk
         B/x3iwasRkOFkext15Dk1opVq12rsQhBT54QpVZPJaCDfsk0W43cAuS4lstfY2mQJgXc
         o4JrgqklgOJGvwcIHK6DtUMzzktf2bOmxI0DXjEW4D2rFmTj1madaEAk+OEFOZlo7+TT
         UXUznaQ4Qkhff5UM/2hA80BmGz3ZaUPWS5FEvbMWp3u4AgaEnve8XCbMTeE8+I5I/lbf
         D7jCxYA+OnkhV09ypVqoqViG/5dshLAtwtgTRyuhXhrnMr2To3Ae6hLqjOoqIls7zHPu
         2cIg==
X-Forwarded-Encrypted: i=1; AHgh+Rrjn+DnSfCW6HzFY0kQz6JpYTNjIHTfSSqRD12cKHpSPFIVbPrEFY1rK2MOUyJWp4vVtqoMedoKBf4eT2U=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxvZQvhuvlm13c9xkccnrYoh0NWlx4NMC1S/l8kppXwj2Ph27DI
	SFcp9TOBLHW9ji8ftsaOO3nOfp1tTq/RmOyhQ3QPT5+2lI42qp4tVqHeFWULjAWi5+G0SN1ALJ/
	0Hf0PwWRa3WS+JgIWsds/TJaRv+1fh4ESGtlKX8MfElz0VIi3IYYmZp87KLPFcLwnSarC
X-Gm-Gg: AfdE7cmQ9sGzRvLYfRlSrA6rCN+ZQIsI8OQpzoJWTcyp1lOxnhLX8cMJFOOG8dKZ10b
	f6mOJw2x4JNhVz/A5ku8q1Hj6cVuDERrq+R17dqFSRa+dXE83ns3zqtvRd8aElQXdykmcswBebh
	I0jJxLxji6NOj1j5e2gRJxSQfnVoX3D1EkWwNfRgqRMQxC6V/jlJyCOHEUZHWkVo+8kLU1dXJce
	1PYF1iXq/kq0nL2zYC+sEppeIiEKfGFeCgBe1jOmkLwa/oN23LlBiE7HiYmaZXmXbPZRa2yeD+T
	O0RKgvGEd6Q8bGe/xZGloCS9FCze7XI+mgXMmt4dh9+egYT+nM46TuPP9Ql2cX2MKUc7xV8z89v
	0edV2FBMC7QNFBKbf+QXcokMTk8kpZldW9oMskD0g
X-Received: by 2002:a05:620a:3188:b0:920:6061:816d with SMTP id af79cd13be357-92ebb3a6413mr53862285a.0.1783341899699;
        Mon, 06 Jul 2026 05:44:59 -0700 (PDT)
X-Received: by 2002:a05:620a:3188:b0:920:6061:816d with SMTP id af79cd13be357-92ebb3a6413mr53854785a.0.1783341899137;
        Mon, 06 Jul 2026 05:44:59 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:44:58 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:15 +0200
Subject: [PATCH v3 03/20] driver core: platform: provide
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
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-pdev-fwnode-ref-v3-3-1ff028e33779@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2811;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=6LGnnQUilPleWEktfrY4MmM0pkVSQym5Tb6K8ulPQrE=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6MwrXJyI6RDGXR5NSdFZ9xrrITGBOlOKRSQ8
 YpbXqH2OJqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujMAAKCRAFnS7L/zaE
 w/sdEACHAvXLRsU5RV7NL57uR65UVTNYQntV6UGg875BqJxWEvlWfG5SidW+TTr1zGmNWyjwn46
 INxrqYMa02CNieMK5mjLiVaCZWsT1rjXF4OV7zMxUVU9DUkdO4QBiRa6mKZxZHP3qGTcCxK3Llq
 e36oYe9K/9tuGsUmHfogfwxzw6/UIy6Ka89reeczHeRntzFRJpF5TzeDR4T9Vn+z2COOIOy1TPN
 z0/I7QxhkhBmEIm4nhai3oxZGwahkI4CuOrWnohRoujcTlcqg9HHOX5WjfsVRtICbbKFPeQ2wEq
 l+ip9n1y1FL4wuvfQ7VWQigZelfqoka9z0v4ffxsbuMDuZeiOa8dQrBBYoKXZCPTQzX0xhte7Rc
 wLGFEQQnwWVRnmtBjioxssuPAjm/gcAb6ypAO0j8u3ia/6k8jE+6y0ZYpKaDgn7zijlJDPxnyO+
 XFuvWhjfn8yjrT3vF4AmdyxWAszTaUzOfOhTuKMT3cWnj8bJpq4U6GXpv5nztKgHa3iFNntWgl8
 EWhctNRgB+bsLrCzsSwhtoPFZghiAWba4tq8OYctcOhetLOekXjehwdI+MTyoHAYlY2O4bCLNyF
 uBpojQHZsf65MVPDsAHKEHy357eeHVezaSVNZiicNTo5wwdMB5ghmjRAg2WUP8MB1nXUoK2zDEB
 zgEguOOlSD8tZqA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX8vyl7K4m+1dm
 etMNnNCEKayaaBUkEpg9xtG9gisF4QBmC27rqiL8coTexrq0ErGYus/SQ5CrF/oH+PCSz36UWau
 EDBU04i3FaXzdKAnXRSXmQrPJXeoM7obD9AGQI3kOBZQcc4n1mDS5NzyLj6//e7KBV7ldY+ptwY
 uQuA2ShKpFeO24qr33UU+Pih+A9QkCsmgIurlTto9RGEEThIZsy2S6Kv7aSTviRfMKUIAsX+y8i
 +F2bRWzFzfkF7DMfYQTQomYGxulJDL5nAHWPlmiYtn22Q9BWmdI0co4bwsXyy7kzPG4lHwNXlVY
 DNTVIevSXMyNtuotxEPcK58Q5uzWYqZFVdvftNPVkj9RLyxs9vZg6w2Etb71ngpd+yzx2Jzj3Aj
 mVtlqYTFp6t0vBDDnqGz3SpZzSLkDVE/Flt+4s7zMW4/XOng8YUxEfsX0LyCxKVSPVtW47NhzDc
 nbpWNTseEscpk9bGtBQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfXx/QeLjzRypeT
 c4wpbIz9frT19AebCTMqfNFh8f2MpdejfX00V3XTwC9FSHfhNCasKmfTnLGLV0nOlSFhLi10Lg1
 f0fqcelilQZQuvq0/C1a0Fkz7YD4qD4=
X-Proofpoint-GUID: FrHsWnqHgdki3TcotXc3ncCwo5qlSt0i
X-Proofpoint-ORIG-GUID: FrHsWnqHgdki3TcotXc3ncCwo5qlSt0i
X-Authority-Analysis: v=2.4 cv=OKcXGyaB c=1 sm=1 tr=0 ts=6a4ba34c cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=7s1i5lxVbzGmBzMXG7QA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060129

Provide a helper function encapsulating the logic of assigning firmware
nodes to platform devices created with platform_device_alloc(). Make the
kerneldoc state that this is the proper interface for assigning firmware
nodes to dynamically allocated platform devices. This will allow us to
switch to counting the references of the device's firmware nodes in the
future, not only the OF nodes.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/platform.c         | 19 +++++++++++++++++++
 include/linux/platform_device.h |  3 +++
 2 files changed, 22 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 3188d5aba5f90622f821c695049cacda030204fb..6520b70cf3052d683a2ecb1a0dd7227575546ba0 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -711,6 +711,25 @@ void platform_device_set_of_node(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(platform_device_set_of_node);
 
+/**
+ * platform_device_set_fwnode - assign a firmware node to device
+ * @pdev: platform device to set the node for
+ * @fwnode: new firmware node
+ *
+ * Assign a firmware node to this platform device. Internally keep track of the
+ * reference count. Devices created with platform_device_alloc() must use this
+ * function instead of assigning the node manually.
+ */
+void platform_device_set_fwnode(struct platform_device *pdev,
+				struct fwnode_handle *fwnode)
+{
+	if (is_of_node(fwnode))
+		platform_device_set_of_node(pdev, to_of_node(fwnode));
+	else
+		pdev->dev.fwnode = fwnode;
+}
+EXPORT_SYMBOL_GPL(platform_device_set_fwnode);
+
 /**
  * platform_device_add - add a platform device to device hierarchy
  * @pdev: platform device we're adding
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index e9f7baceeb4c8269dbc0143c4d8fc9d73ba024ca..f037e4101c41dfdbf628d013348d7149ac519721 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -21,6 +21,7 @@ struct mfd_cell;
 struct property_entry;
 struct platform_device_id;
 struct device_node;
+struct fwnode_handle;
 
 struct platform_device {
 	const char	*name;
@@ -266,6 +267,8 @@ extern int platform_device_add_data(struct platform_device *pdev,
 				    const void *data, size_t size);
 void platform_device_set_of_node(struct platform_device *pdev,
 				 struct device_node *np);
+void platform_device_set_fwnode(struct platform_device *pdev,
+				struct fwnode_handle *fwnode);
 extern int platform_device_add(struct platform_device *pdev);
 extern void platform_device_del(struct platform_device *pdev);
 extern void platform_device_put(struct platform_device *pdev);

-- 
2.47.3


