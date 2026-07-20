Return-Path: <linuxppc-dev+bounces-24449-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B660CC4451B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 09:25:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3Zqv5m2kz2ySN;
	Mon, 20 Jul 2026 19:25:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784539531;
	cv=none; b=ehr1TQfCQS6r5JA3LapjlgxAtltuiG/zYrZwdEfefDH6L2AWctO1M/vcIfgLw01P0d1INdShqRESIvjZQn6k6/F6gF1CnqDJDQwit2Ec+6PBXc0fCIMl9HHgwWYoUv/3yvR0Ff4dGA/J+jzImkf9kAx0/F4UIcBO4KtNmom7XSVRFGprd8D8fv9vXq+mu+mzo3OiFwTLf8LX1/Pge/GrqAoD+B35vSIhPWGqT0K/DYR7xxnspHxqxe7BlBtK0V81xkDVeKoS5qzWkf0WokwFC01O7u9zozHpcDMFKyns8N3kSPydVXFLfEY6PYuCNuZ9GHIDZ3S72cUkPKYSavLtDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784539531; c=relaxed/relaxed;
	bh=LemIgIdjk5eM3AXQKute2fWvk4y9PhORePmOHO5weFo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Iu9V+vIvgX/FDLmKUxyHEEROsGUQHV2mN2bQRgeNl3LeQ80uMSXsoEj1/fRDzBE+68AH57iN/llTGSxO4fJX5tgDvBraVpiXcAl67xarDQFXQB/P/olXTey10C7HOYvwtgbU54kJB+xJhkDHabcKMheIuYhYjZgYOeFt26CbagqzjfNgAAhrrAAmrg0jjvtcS/5diJI74Gf122SojoonRVozZl13OlozZCHDcrVjmm5YtNm3pLJv1DNZ96lNWy4RlKyGqsBNwzEmn6NHepFLKIiObXAyXID6R9MJ8Io5fRvz9mR8Fd0J+EemNJh0WD/IClOctA+rTIP8Kjd1TN3RHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RhycOz9Z; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aQG9zl/y; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RhycOz9Z;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aQG9zl/y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3Zqt1hsNz2xlZ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 19:25:29 +1000 (AEST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K97db31653624
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 09:25:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LemIgIdjk5eM3AXQKute2f
	Wvk4y9PhORePmOHO5weFo=; b=RhycOz9ZM0sBTG+JXF14kS7s/iqaTNli8PXQKJ
	C72kD/luWZS45Go3+a4DbMmI4SDf2il2GgK4FwpqIcWEAz55lViHRkySGBPuPOsY
	IUxnfqfr12rU5+egoIxWfhubYRyJ/AMPdL2Lz70pptI5AwygrnUPRzfl50jRkev+
	lOhWY1hAqSk8fhT3+/pogMIioSoDehy8uDJTmwuGXFf9Pu/cJ6a8gZpATQETlZL+
	z5xtt8+URVfsZWGAdcCwZmV491HqQxz1dKgxV5ERPyXQCO5Vtdz6uxI7zUwgPL+5
	y57TYAujaast9gunXtb+8OzA0tHevb0p1pH9eJ1FO99Kbnwg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhgs502f6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 09:25:26 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5174a236220so183715271cf.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 02:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784539525; x=1785144325; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LemIgIdjk5eM3AXQKute2fWvk4y9PhORePmOHO5weFo=;
        b=aQG9zl/yvLwP7Re6URyBgDtlouQh+7ldBzA1/9UmanwxFAtGqvVzEiWK/ATNzNMdrs
         w9gzZP+mQG7PMH1NBDNO4K/1b9xEYQRkuqLQgSnOee6q07MwuSIITd/zHxaoB/V9EBBV
         SW9hTYKteOhBAINDEdX6+8f5nUt4nCg+8Ro7Dxd6E1LhEEDP1MzmzuuauHHFiaZ2wPkn
         /aUPwJSjqdPlriB2Xuuum4NDOKhBVpOk3Cfk56qe5NymusZ+HoD16cWcG7D+pudQWnXa
         TCD+JhRmj0yHfT6DFn4QGbf2D0AB3+uzygUpbob64Gqqr3MBi9ImBBULPL56AN03P7Le
         v1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784539525; x=1785144325;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LemIgIdjk5eM3AXQKute2fWvk4y9PhORePmOHO5weFo=;
        b=GoX2Tt9KdFG7Syb5kcZypgwCc6Dk/QE1WTJw9ml7b3v0QaiWRGzoLaT2Akn7FCyGoC
         1NrUfbcICM8F3DOopTAixJuQeBzsj1F8NlbQso6nA38rr2E3TjR2S/IQYuyR72ODeLjC
         otyZYpV9k8HSVTjOnyzyyu6+Huh7UWQLyoh3wAX0lq4dlltxdtOjWS0TuQbofoz+gkuN
         T23fw0d9LdOPu1zaDGKkeY+YQSUUdSPbViqiXzdCtnP1Y8q3OCkejNZHLs29YeytzLpA
         vx7VdwYuK0KmX70/gSJ79X7wJg0tyNRSJYmKsCApWxlsALNtwJ5SxmCFWeO4GnDqWcR/
         zx7A==
X-Forwarded-Encrypted: i=1; AHgh+RqMoXdlgUBVdBPAH1KRYJW5UDMN+EW8+1awF3aOkvqH1Y2mfrlf4hMbEH3qzde9WHsK+DxdZcZNLqjj8jY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwemftdahesByKone6+ZvkgeQfqJBGcUHFv3RjlS61MoCvoc6q8
	bgxGSY/+Q7ESmxQWJIOV8SPSXGuKUpeaT797ZvIXNNJD1Oldc49e0t01EdWjTXesxdehO+A34W2
	aXu2lknko15UqO0qnBHfvircBrsqswTYU9suwPhJfkRXS1coQj4F7KQX8h/VaKF+jXg8Y
X-Gm-Gg: AfdE7ckncKPCKeESea2u3p5K0I/1u2r+7HoEs/yCJeR9BWRSG0fhdFZy2lDNR8EAujb
	kzEya/b0SzDCVjNTbM+lZFz929PNZ8BLlZtx6ILv1MCVrSCn5edvdOtrA3G41t6cwYhhQmFqnLU
	AsUCRkpAMfkPMrH2nAq7EYM1Tg8tmIuAtt+FRhb7UwjP83W8JLOFXVqBuy6ezpsnULXoX/qXdty
	NyRwBJwuN5T4QqUnPH810jYsptzFO417gME36/Y3BV+KbTnpbPFzV//87gncJCwdbde+/tQnTWu
	eoDeQicpT1LqiOC4tT2XMT7l2aK08+TIysCI1E6cvmcvTPvn2mS3RDNYdmpFgylhxTWbhq4IKbq
	zALxn9xeL4ckewo2wqRlf8wWAv/Pkcg==
X-Received: by 2002:ac8:7f8f:0:b0:517:8011:3a4b with SMTP id d75a77b69052e-5213c7e50cdmr116347261cf.21.1784539525020;
        Mon, 20 Jul 2026 02:25:25 -0700 (PDT)
X-Received: by 2002:ac8:7f8f:0:b0:517:8011:3a4b with SMTP id d75a77b69052e-5213c7e50cdmr116346691cf.21.1784539524509;
        Mon, 20 Jul 2026 02:25:24 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:65fa:60cb:c205:d511])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4955de88951sm62228205e9.3.2026.07.20.02.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 02:25:23 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH 0/8] driver core: prefer platform_device_set_fwnode()
Date: Mon, 20 Jul 2026 11:24:47 +0200
Message-Id: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAF/pXWoC/x2NwQqDMBBEf0X23IUYaVP9leJBzKTdSyJZUUH8d
 9PAXN48mDlJkQVKQ3NSxiYqKRZoHw3Nvyl+weILkzX2ZZw1vHhsrFg57DH5oqOumDyn8E+t8O4
 wo3Pt0/RUhpaMIEc9+YzXdQP5bB3HdAAAAA==
X-Change-ID: 20260720-pdev-set-fwnode-instead-of-of-node-e83ece371509
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Ulf Hansson <ulfh@kernel.org>,
        Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Srinivas Kandagatla <srini@kernel.org>
Cc: brgl@kernel.org, driver-core@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, iommu@lists.linux.dev,
        netdev@vger.kernel.org, linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, mfd@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2116;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=y+3A5/VLvAorU5dstuzQ20g0vs1cTbJrLg8xUVeJe9k=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqXelzKWZE6870gD3WWYpCRNtH/x/7TnWJA+MWI
 +18iI+ok1yJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCal3pcwAKCRAFnS7L/zaE
 wwVFEAC39JKLu5OuBinyDLYXI20Qwbj5iJgddspKDBrIHwzbE8GYvwxR4tbccRRa382Fmzdct8y
 EzujI9HvhuEvuRGbzYN7nXKISM2Di8/vbjW+fYvgUH0d61sNqxWxNpyhA+RjY+bO2ovYCYgitp4
 KAuedXV8aifMRqUntG8OUyDK7/pRU/OYeBjdQqP86+KfJROziANbRE6R13AsREnvOsOpXp5rxyf
 Nt6Hq0D2M1mUJWKYKcqaBHXnY9HMNXXOzc+1UK6ohzMTFcE+JjZXbkZpOBfkNqimGJXIfXglvMO
 vQyEV1EzrURqAEx+qx4RAqS1LAMEjW6NWVmfKZwViSO4RFnifrncA74OhKxw4imku2YwssQ1ZAT
 X1fkgdX8b5xMz70t2a3rvbGmwvSksfSCz2RzAbhkD2CbvxkaN6/J7yDasBLy/iYvfmCsDWt0g+o
 lQe7N4WegbVPHnOq3qaCeCE1A7AeqAPWEDnzj01qMuNcvv6BsYMBI5+5nWHFw2X5pFbGQntKtIE
 y2IHrZix8Z8c+8zw1ZC6CCaW/8PZ/bZt8nHiPN97ndbD6joCGFMKOo1R/yAr0eychf3fUsa34MQ
 543Wud8L0J+bI8TjoQFUK8AhP4uQe4aVi0URHHakNa+jsR5rhwd9SKHNKnMG95SngYBbKD8g+Vf
 pAe3KSxbxKULFDg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEwNCBTYWx0ZWRfX0T+TdJIzkYiq
 Vok1sc0E+d4bp1AKSa7N52zMAHn9beYhBHAHcf3R+E+ZR50nIYQS1+K7wTqO5RPeiUHq1Me25jN
 bzCoqRoJAp/cVIponmg/XnQZZCUbQjY=
X-Proofpoint-GUID: nD_6ZPdcINL4R4wDB6i9-XPfZdM5pI3K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEwNCBTYWx0ZWRfX1iwwwcLfIVb5
 rBZK2qB++hesAzLA72/VU8Er6x6fVa1de25FQ14GdPILaUmIzhJMGqRUqAdryt5NlnzIK60WGAk
 pUhrLLMAxv93qgORtW0E5mfPRnR+smN3kiUSaDS0qLXg1IFO7UyqchuLxITsDhlg2/gvfHz0XkI
 anrbZ6ryjYL5cc3lUGAjCzl9DKKmsBcsdNR68bUebX+XBcYQVeNi+1EbUDt5MluzslG3z7RgFKw
 eqXFcfrj9UUgzO33T2a0/ZPnm7N20IkpOvJPusrxFtRhVoelrz5z6yi1eQLfdkUDlTePU+aDuoH
 3g0gH5XcteQdYDDnF2+fPH5oZ8GPHUw3rhTl/8c+sM7hGI7wIVurv2vkjYEUPHWsWGlPXx+bjgM
 3b4eBtNMB3w01/K0ByBDTtcvRyg3C1K140baVG/wrAXoA9WhfBtYL4Ns/kNSSe67TAdWC82KquK
 B0k7+822XBdg80P6u3w==
X-Authority-Analysis: v=2.4 cv=CpiPtH4D c=1 sm=1 tr=0 ts=6a5de986 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=dfxIzRrD6tu8yhXxuZUA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: nD_6ZPdcINL4R4wDB6i9-XPfZdM5pI3K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200104

With the final platform device and software node rework changes having
been queued in the driver core tree, Danilo pointed out that
platform_device_set_fwnode() is no longer used and should be removed. I
argued that instead we should prefer it over the OF-specific
platform_device_set_of_node().

This series converts drivers using platform_device_set_of_node() to
platform_device_set_fwnode() and does not intend any functional change
as the semantics of:

  platform_device_set_of_node(pdev, np);

should be equal to those of:

  platform_device_set_fwnode(pdev, of_fwnode_handle(np));

The prerequisite changes are currently in the driver core tree so this
entire series should follow them as well with Acks from maintainers. If
it doesn't make v7.3 for some reason, then I will resend these next
cycle separately targetting individual trees.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Bartosz Golaszewski (8):
      powerpc/powermac: use platform_device_set_fwnode()
      i2c: pxa-pci: use platform_device_set_fwnode()
      iommu/fsl: use platform_device_set_fwnode()
      net: bcmgenet: use platform_device_set_fwnode()
      pmdomain: imx: use platform_device_set_fwnode()
      mfd: tps6586: use platform_device_set_fwnode()
      net: mv643xx: use platform_device_set_fwnode()
      slimbus: qcom-ngd-ctrl: use platform_device_set_fwnode()

 arch/powerpc/platforms/powermac/low_i2c.c    | 2 +-
 drivers/i2c/busses/i2c-pxa-pci.c             | 2 +-
 drivers/iommu/fsl_pamu.c                     | 2 +-
 drivers/mfd/tps6586x.c                       | 2 +-
 drivers/net/ethernet/broadcom/genet/bcmmii.c | 3 ++-
 drivers/net/ethernet/marvell/mv643xx_eth.c   | 2 +-
 drivers/pmdomain/imx/gpc.c                   | 2 +-
 drivers/slimbus/qcom-ngd-ctrl.c              | 2 +-
 8 files changed, 9 insertions(+), 8 deletions(-)
---
base-commit: 27edebd505791748a77703e311d76f0f55a8d7ec
change-id: 20260720-pdev-set-fwnode-instead-of-of-node-e83ece371509

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>


