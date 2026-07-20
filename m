Return-Path: <linuxppc-dev+bounces-24451-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409E9C44524
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 09:25:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3Zqy4jpcz303B;
	Mon, 20 Jul 2026 19:25:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784539534;
	cv=none; b=MU3uLhihQGmEFKy6yzkT5ZnEx4iOf0gNYsYY9WvcdMrNQY0qstkXBXoM38zgULE9ULdy5UN8TB5ZynLl2ZEtABc5WgQ4EYB4WbscG4GgXYkYlzGal4F/6JgVOprLOqDuIkU8IE3IOJumXGsInLx+GzBSwpS8fmFLd9821/DeQI18q/wd/MPoxJrVWUOSwiz1C3LWON63VIiJ91CTJEiywkOuoAwNFpyzSn+pPmyn2c/2flNBPyZLBuaK0U8Q3IcfZ59Wx4dE8XIkyv7CVB7elmpETqaYZ6KaAzKORlMIJaeC1W+IDVgTF7+OpCLHaHFCv9E11CWgXO7aB3IC6nSvCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784539534; c=relaxed/relaxed;
	bh=pU1BTx3V21E1/GJSe0V/1tEDgkohw+OvR+uGXxiLMGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EnNp/poGvoXhfwTkov6mYCFaHw4A+3F4eVHkDVm+lNc3jXhNZE/eOiWbp4MR++FmgAiF6V1acBQblf0x0r+GYqMRVQc5THk5tE062xiWzN4cILm4K+KCULYWGUAGpe5MDn59F/o+NaIxq29J4nFiDJSsvgtiD883k+R6ml8Cpj4d04LFoocD8L0q8aVLicX26wYV8jOVP9WVPvl4TzDRCdOjxcqwXjDey0TpgvnIx3tPl/ZhO0zAANgXqHEptchVyf1uKOe75D65Whw8si9L2PT/J28cAsPEIcHV99asWhtvKWFcxwm6uWnNvKHGuxWnwWt5lIiXpasver4xXY2v8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XmLYFkPG; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ov51N//d; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XmLYFkPG;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ov51N//d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3Zqy0pMnz2xm3
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 19:25:33 +1000 (AEST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K7YDIB2043790
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 09:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pU1BTx3V21E1/GJSe0V/1tEDgkohw+OvR+uGXxiLMGw=; b=XmLYFkPGPsf1JkR3
	tHbXt/iv/+pOUgfX70ac9uIwEItjtd1LHmJy7mC1eSZFKYGF3Cq9fTHXUnzeGBmz
	/VpnGG8HVXTgFzokDnuIWnp/4QgY+Lym7qVOeGkqccLklVlAvdxRSc186WX967Os
	nQv3ErHC2dMMJv5Y18ebao6fJZe7c/O4EuVhqxjviEx1Y+Zv/YXuatd4CKMqt2MQ
	waHnfeTeuRLbF+uuzNmLuxLdE/BMUGw0uGWEbTBv/Tz1bdFMXvKyLy6gLTnuGrFx
	ua8/ok2FwFRPlkBqSWKOQDF82DjrDoF3J/6KMDzmBtC9ZBbMNao9J8UuO5FITvZw
	mJTiwg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfdcggsg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 09:25:32 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c110a3b6aso105723711cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 02:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784539531; x=1785144331; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pU1BTx3V21E1/GJSe0V/1tEDgkohw+OvR+uGXxiLMGw=;
        b=Ov51N//dsyl9kqzrs1lYvnFZTrN4v0Yrl7lwQqnp/zLFyfALUi0KaKA2m8rXGqfrcB
         creBUx3U/mosLFWOYDMf2/x0DnZSrw5yaIovNRhlysK6pjnPZ5EicOWw1S5/z3zEigFI
         Ypj8+Hif030PzPA+Oqf7nE7HFy2HSd6JwaVFDmaCwCvcs826YWn/mw5cPm/E7tHcJ203
         EKV4gPoFimz+n+0y+UPTzcnuWbKS4WmPD75USRejbCAY7EUPXeiQqqlDw4e4XWyT5fs5
         Yq5k7OpbM4VaJG3RNw7kXTlt6AipShWItzSCDuyvc5OYyKcwQiTZqZQ/j/B/pdCW/a1D
         F9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784539531; x=1785144331;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pU1BTx3V21E1/GJSe0V/1tEDgkohw+OvR+uGXxiLMGw=;
        b=hBUgRyO/bHtGHUb9cIVyiC0kDcxCY0dKdrRZZUEDVOvOYg++gvFaUgSsOet2NeK5Tb
         OKW7Hw0QyieiPvs3HUCuLwVvsZDNttYUdKEFfNt/tk+Y+qnnVCy859BKGxixU81QxbrW
         z2Bf2QXbHohiImVay4YPW+vNOdHHT0Tzpou3YGT+fEFl1KIsgwljhptUD5YONGzltxAc
         NkStPF8/3o8r6uu2x6eiNoBo1qNZiGkVajfabibX9OIjhVQ0SWQhoZHsRXO+0XYG/rHH
         2+QIU8ssOljsnadbhsFoZwofa/6FKBMEgGZZS5s9Bx8qiG+SGdIL/1i7VeSPOXkNhmoh
         u9jg==
X-Forwarded-Encrypted: i=1; AHgh+RohJh70Ohje2nWTqICjAIrsFRZHOO3xX3zEZM1LEuMI3ae29Y1Qr4OJY6xxpYAjnO8409yepCebmFe0tL0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yys8aDNeif1muvFxcfJ3J7QAaHFtVGnE35HPliCPhPobI1dRDUx
	YX5Fe33q8MEdMGcodgEz6GAt7sFGmtjA52yOlVKvGK/8Z0KPJoigcEX0S7zjUqca0iUhRrgaOXm
	yvqI05KgLMSyo9XXXCN36xLAmiALnr6p3yQfctr6/7SBUZ/N7vaKHd0Ak6Z+UGlv+OPDR
X-Gm-Gg: AfdE7ck+ua3tNpQ2GR/TzuiD9fHCtKTfBD3qORRZKv6nCNXW+CutgeJtSqn1QLdIywj
	VDSh5wr089q8CWbGstFRcfNLwlJLP1cCvqjkL3rg1BV/5qaSZTjQiwdpbtovpyLj/9wdAiwB+si
	ABbgibDdffVAGlLG5M0vKOg/CBgRFKUr/hurWFs1NlDbSlvidUDW/vsyEUXjJmoY+LLBjD6bTN6
	Mu4+FCWPoAZUjSadKL6QGcUVZHPRjb1KakFMSg2KhL4e42bORqvqVbX5Dd3QMJ+ODnn470A7CCi
	ePgwE91uI2bVNx4t5eAGdj8n0V3qEagvfWHtnX8jTVTfTpRVQssrpfCe3V/XGJk+W1AMIvafhHt
	/bWnPNgH14mmgcaM25A59eIN+K4yh/w==
X-Received: by 2002:a05:622a:13:b0:51c:12c3:efe1 with SMTP id d75a77b69052e-5213f66b7bamr122491331cf.42.1784539531250;
        Mon, 20 Jul 2026 02:25:31 -0700 (PDT)
X-Received: by 2002:a05:622a:13:b0:51c:12c3:efe1 with SMTP id d75a77b69052e-5213f66b7bamr122491051cf.42.1784539530849;
        Mon, 20 Jul 2026 02:25:30 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:65fa:60cb:c205:d511])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4955de88951sm62228205e9.3.2026.07.20.02.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 02:25:29 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 11:24:49 +0200
Subject: [PATCH 2/8] i2c: pxa-pci: use platform_device_set_fwnode()
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
Message-Id: <20260720-pdev-set-fwnode-instead-of-of-node-v1-2-2dee93f42c54@oss.qualcomm.com>
References: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
In-Reply-To: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=925;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=ZrUS/NnenvYCjb5pfCsn//onD0rmCvG2RI/jvr1V/hI=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqXel5RRr6FDYHe7Jyyb5uYqdruVF1jkNXdGz9x
 /SmPjU62fiJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCal3peQAKCRAFnS7L/zaE
 w4UfD/4hGqcnN4YJaIbxls3DUyM4NsWC4IFRTcQ2thdYEI/wUb4fhVe+TyZ7PrPWrKx17P3wNAc
 maYIRBGRspgJFSLrKzyw/l5OMrFyyVo5Z/pJ7Dk0uXIabGxiELqzVXgd1WoxDuuTW4tgZJQQsNz
 aya2utaREZyKIpaxj3Roa5oFmv65+HJQAYnFL4K5NgfQAiEczNPuLe2ohktx4SzYNC2lv9sJmm/
 DHA4nfXFpGMYRwQ535aVbihSHmr1VdH2kZH3C+G/WUXDG2zcXQbEDRHBEOhpmLhdbvqSBENsqcX
 fC6rJWBiX+4Se5NDr4QwWa19rVDA7zPjcdlpN9JcNkqhFi9xrmkRXzjDUdQKm8EIVdHu3coyLeE
 dfcxPzHCmIAHb1itlp1OLHnZ9DJj87OFgfHqY29oOKKtNW95J+QJtOCwUlVFNwHyuCYraWwRy+a
 812PKPLgPzRsVfXkL/L7lzI/tunY/GnBcfOwpqKIihhVnA7CJuOZOAOJf3NLzzZPf5XVTB5OJ1y
 Sm73dsM4snyIEvT5gwzRjiYfEdW9H3342ztO571XE3VibNZU1J0bAZ7SEJoJH5prDBaV/jdLz+3
 RWkWUsdJASZAhP7p9ua3RxQqAYNsUMW6PQtT0H5gB8zcpf6TwgWLDgOPI+3GVCrq/4qo8tigfGI
 atX2+rRaKYcbS+Q==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: wc1D7TWkyezng0PDIU7cbLMlteKDhFAS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEwNCBTYWx0ZWRfX7sMQ+cgEHcRd
 JV7aj+9322wvI99L8txt00tfXPnG+lJor0Ll7BfmZL7G3xtxQwwqeXnquEjCfr53yG9rFYE5Bzk
 dmtIdl0vLb9mNHtMrMmlgq7PnfRkpGjLTQgiu9q5sK4p7liSUwKSYbWibSevyv2W9jvr9B+lQcL
 mJ9HY4MDkYuL4WxUup33SlqYipDErOvfIumJZT31fv5T7JzxLmP7S0z67yeLz5Jr2r/fiE9+8aD
 7tLsMpP8wx70iFbqYgrltBJT4b5KLcp3J7/IrP94SY0mWLZGN8ztG4KQbAjY74bTG9giw3eWtOE
 b7Hs3OlRXv6u+p21gajVLUXZBz2gNVISubecC4ueWZpmPaGrhWUyGn2e+TMRNZsHNMM43zqOpLa
 VIChswcM1DrX1Ab1gICshiJ8aN2jVquEcHB+lzUVPAI63hsJRHaSQRRR87Do1G5XoNdnOMX8tAJ
 7XChvB9dqFPS0VbWcgQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEwNCBTYWx0ZWRfX26mVtVbGt0ea
 1TC34OxMC/4G8LxxIRPCzB/vv7e5Ex5du1C3kENSexcMC+xMielCErXa4Zv1NB+Hs2VlQ/5YN20
 V/CZPyzakeM7icvX0MN2xRM7NZD8rRA=
X-Proofpoint-GUID: wc1D7TWkyezng0PDIU7cbLMlteKDhFAS
X-Authority-Analysis: v=2.4 cv=bv58wkai c=1 sm=1 tr=0 ts=6a5de98c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=Dy7njVIJoQnLZkscNskA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200104

Prefer the higher-level platform_device_set_fwnode() over the
OF-specific platform_device_set_of_node() for dynamically allocated
platform devices.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-pxa-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-pxa-pci.c b/drivers/i2c/busses/i2c-pxa-pci.c
index 92a0647f08c69f841ca99caca757c1728b3f6fce..58532cf9f06d43a0f2173b962eb498c9e4bb81d0 100644
--- a/drivers/i2c/busses/i2c-pxa-pci.c
+++ b/drivers/i2c/busses/i2c-pxa-pci.c
@@ -77,7 +77,7 @@ static struct platform_device *add_i2c_device(struct pci_dev *dev, int bar)
 	}
 	pdev->dev.parent = &dev->dev;
 
-	platform_device_set_of_node(pdev, child);
+	platform_device_set_fwnode(pdev, of_fwnode_handle(child));
 
 	ret = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
 	if (ret)

-- 
2.47.3


