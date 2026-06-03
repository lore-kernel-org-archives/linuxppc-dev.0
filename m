Return-Path: <linuxppc-dev+bounces-21974-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540D0CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 12:29:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVn895bs6z2y1Y;
	Wed, 03 Jun 2026 22:29:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=205.220.180.131 arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780481739;
	cv=pass; b=j/rFOFGUyOc6f7fIYLhe2x5QUxADYFhxmFsRfWNMbyQyQWUZtNrlYlAcy9M5jE7rD0Qmk2UI+aQywm4pnC8wGG02WEGIFFNTUPDaSTMqtWLx382gTNsiPYcVrBq5hvpujGaRfUll+BXi/QEAF8XA3snRt93ox2LwQiaiiGKIYWgvwfBBL4oKN0fAzXLlgiFSmwccSgcsAkeSPt4frnO/Tij1+t3u7N6ndt3Dk2+LLoojEDg+12e5xxPH2J2S8V6Re0PLmS+W7xWHkry10HpjQTR3mOnYKBgHg/rVA8D6RcShQtbHU3jPiq12E14PDRpxEtM+l3BzDf8s+zIujU4AhQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780481739; c=relaxed/relaxed;
	bh=9n9AHlZU6kUO1j38Uc9X0HmM7AR04hZBNstxafGjgo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HM0bP2KCRr5lDZ8cehAYkKVJlsqQEwW/88zq91437atcrRTSZ2T+Bh7CtBvrQwLez2Nii0k9abP5RFxFEhz0dTO1UBMKvm8oxqEo7SRgAoO9NQj7r5NAvkYEmGs2z9v3KOhCZHdtujoYIr4lrOmFm6biNCLpNuYKmbJDzlDOu1pgQ5b2ddjuCROOB8Pp3mwQDVI6NL85eD/vFBIdbjURAPGTXV/WEMcP07vNwZHRGKnGGWbmwnug/xF+VyBWIxVUtX3LQ9OLwhXa94ahhjyZt6IV3UNnSel/2aHaodroCWKPiM47ec193w6C3EWkeDKf0HqIYYKMtpBC+Br4rcd74A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RV/ZBQBW; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WLORXsIQ; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=ulf.hansson@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RV/ZBQBW;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WLORXsIQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=ulf.hansson@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVk9Q4dCHz2yL8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 20:15:37 +1000 (AEST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6537F48V1956966
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jun 2026 10:15:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9n9AHlZU6kUO1j38Uc9X0HmM7AR04hZBNstxafGjgo4=; b=RV/ZBQBW1Gz7WB7g
	C36gOhNhdL+lLAmqQlpap6noJbbxHcrt5EIxi83XQdvwRajDeMt1YFcY+H3mGLXT
	9XatmhW6r/yTEhIszMkIGbMkNaO+fyhhVMzwIGL7bcpZ9ReeDX5jEpLuRbcstKSQ
	YhnhXEg7Vp0lJ0rPhBLgdWq78t4NPOsw/LugKMhQPSnThw01mcIgA9my3R2A/CFD
	SMxSsEToum0RhiBvscPxkFsFs1FxqjfwWOQrc5lvshnJbrHXt0WtI8psq0P5nZyX
	LEs1LzosAOE89oi/Bezr5wGe+ccK2iGDRjqfsqOH5hQOImzaSe/nMOk3SRXe02I+
	vbBXAg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejfqc0r86-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 10:15:35 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8ccd719a2f2so84536756d6.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 03:15:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780481735; cv=none;
        d=google.com; s=arc-20240605;
        b=iHgF8edn/HMBvjYO9gxoHME8QwjwpzJDMP7bE32Yaq2TPx7VmphUFpNN5T+lwTj5hR
         txmJqqkIPPUJt+vqjfsp0WANGnH/2OUO9bLLV87VHzJKQf/diAbGIdSDm2NzVv+MP5r0
         UCreZNJU9aywnIvZ0/QmPE/7/Z95jvFNhSi/+Sc/hS6IkZQNBDiULdnACjMoZTj5N9fH
         D2zNXvPdUx96uHLfElahsdul/wlXWKqn8++fBmR7+YGH23wCJxAfkYLam4Q7zfVAhQYG
         qRLAyqqA7egZhDP5fytiT0EcIFPTKZ77vj6hgrtx9aOLxcDsOg9XJ4cqe8+5rX51RnAd
         Eomg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9n9AHlZU6kUO1j38Uc9X0HmM7AR04hZBNstxafGjgo4=;
        fh=8Kjg+AVBA5u8tVgWp0Yn4BALJNaOd2kbok+gVUpnsHk=;
        b=SvOtEqJyQlQ/56uS343I6fbr2sN11bnBNY29G9Bxh9MRKfTPGiiv4NJJGRsSP6W1kK
         BGer/BZp+e0u3N7Lc6swR5fXIFRbSeMsFCFNQlQf7g/EeF6b7NmfHCfbUXwJvUKu953N
         Mx1L3noZuzqeyLqNt6XUkxl5svsmq+dwB9CGLrPbx/hcFQmSZQSgWoz+iLOYiYhT3bPv
         uUmykBlCEPwMvg0z5eYq32SDSLWkaGbppgxqx1DrKJhk1HUa51XNGcVVWhFnEzYfIKYw
         51VpnEd8NF7CIVxxy5c2ZLrueD0cQtEmVx+/NgL2iRApgI/9iHGH0eGmeAY3x7saULMZ
         GswQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780481735; x=1781086535; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9n9AHlZU6kUO1j38Uc9X0HmM7AR04hZBNstxafGjgo4=;
        b=WLORXsIQnIN6Dz35djDKQu8pPsY3AdreZX8oXA93nJ3rp/znC4VX0jgMJm6J7KFatg
         8MpLJMt4vSo5lcfVjAv8PwpSetpqzMUDGegKBzRTlk8bA3OtZbXLvrEkYWII8LfW3M1s
         i+VpSothCzg37jmehvk1yoBrIYbp/e6iLNIKG0JaYhK0dGtj8RMPsyYmzBgf/HOqjc69
         wu4UjSUKYnEU86aR2iZ9vcw2vtRtZ5BcKAzZytoW6PR+O8oG1p5F1n6WtnN6bEclhY8K
         yssiV2SPK5h5aqEaBMWwYsGQtwMXkd4xLNySzpMFtNu3ng2nswCj0aR+jpljRoCfYM7h
         zq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780481735; x=1781086535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9n9AHlZU6kUO1j38Uc9X0HmM7AR04hZBNstxafGjgo4=;
        b=KhKyafNyEAjfoyF8Xj5jNw6YRVctSO2W6Jef1dQJrpPg8ByPxtdXSW3toBKKAuV4FZ
         r3PAA2KG9z8yArEkvjKbUYQgfQRC0ExxvBOKhVa4TpSBXUAcTu1WUJQvPOx1+U8LZFyk
         pCsMH7OEoPpRKWgLdq2EvMr1xyDB0KXocwxNvmdT9jKYN25kZ3D76qoGhaS7yuCMLy69
         5CMyxBM0QahqZiscvmXT2OurmoyXpvcfhRA0AWMPD40fzPYXNR+whPG9fZtK2qFs/HGb
         hZoaEjnlRvBkxZvaGTTaSoNJ0KGMrTLBveyCAWPbAJ5mxZkvZOufRX3mel0rkv6Mn7Y/
         Xw9A==
X-Forwarded-Encrypted: i=1; AFNElJ/g2PE/OQc5urn310+G+aT6BTrdSBUpb8ZcMZdYyBZHm5hiierVa1nHoQy9amOpez3QUf2DC+c6p3/QIk4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz4TrCSK5ItGvvFhm6MV4kVgjj5ptsHWlGMGZNoeq9ZkUUuf9dd
	b1DZ6/hV9BhXXubygyGuQjD/+F9Ff0nDXWsxjqG+3mt6Nef8JChxdd7bgk8e8FyNSy9XzNmOJoX
	qH8DSJGs01cKSla65LuiK+Y/E1MkAiZrBfIHzLKbjcOO4fkEvoKOydjCWn3Een5ji2lvDkXh4Bp
	robqsV+Esu0KzYmxHA7Zn6NQVI7BmdvxmsyBjbCOYJ5r0=
X-Gm-Gg: Acq92OH+tsNH2IA2es9dWxwBNIbChtII9LTRn+JDlx8Xu8B9lRoQ5A8XKboS2IVLGLq
	Ygu9RV4n3A7UJAwcBuVDa6P5feov39uOFJDrfYOWPPqffYLpRm4aPD8NAJu0+JHXGbqVXEDYlti
	Yb3cFKRpMNXWP4gwkb8K6jjKUv/0RvyllF405HOWcHWkR4a5DqzcBPivkWC4kDEEGe20u5NOVc0
	IrFTvOVnbiOAkGX
X-Received: by 2002:ad4:4984:0:b0:8cc:6c08:552f with SMTP id 6a1803df08f44-8cecdc03682mr27951516d6.9.1780481734726;
        Wed, 03 Jun 2026 03:15:34 -0700 (PDT)
X-Received: by 2002:ad4:4984:0:b0:8cc:6c08:552f with SMTP id
 6a1803df08f44-8cecdc03682mr27951226d6.9.1780481734358; Wed, 03 Jun 2026
 03:15:34 -0700 (PDT)
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
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com> <20260521-pdev-fwnode-ref-v1-4-88c324a1b8d2@oss.qualcomm.com>
In-Reply-To: <20260521-pdev-fwnode-ref-v1-4-88c324a1b8d2@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 12:15:23 +0200
X-Gm-Features: AVHnY4J4K5UzPNs1yW8q3X0LoIQq3c8UfPuD4kHDjf5PzjApCRf1PSF1rlsmtoU
Message-ID: <CAPx+jO9iJBx6Yifap55NOhn5YZk8Bbwpnk+aeH+0PgYuMxke1Q@mail.gmail.com>
Subject: Re: [PATCH 04/23] pmdomain: imx: fix OF node refcount
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>,
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
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Peter Chen <peter.chen@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hansg@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>, brgl@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        driver-core@lists.linux.dev, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
        iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
        linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: i8ZUDHu-aRW47dsbuZTkVnY9zsM7I1dv
X-Proofpoint-ORIG-GUID: i8ZUDHu-aRW47dsbuZTkVnY9zsM7I1dv
X-Authority-Analysis: v=2.4 cv=e602j6p/ c=1 sm=1 tr=0 ts=6a1ffec7 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=RwuSGLWl7VkFDbmKPUAA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA5NyBTYWx0ZWRfXyCw47njA4hul
 PJeJquRwQXPK1r22NaywMqvj73h1Y3P2qBSPZO7YwiXoKec/GNynlIkZHl5mn3UdDTW5qcpQ4vl
 KX/yvt+Ae2Y4LNNghmfRdk3IElMicUb3iSD/PgBnfS2TPX2oxVZKpB7hQMtb9zs9yJb/bbhGXAK
 /Crx1uxOAhDQ/2SFdiKJzG6n8p8nW3GOOVFuFfQ58UTwDSPQ4drOo0M8wvk6XA0o4q2UOv3nGtZ
 jTtLzxWNRRQrnwPHuIsKHSWz1ppR6m1fRs5a2QDwR4E+7bWZna7iUlOb+LObdRVRXYbcerIqGSt
 vKgfrRlt+cT+H/CnNKBEik7d75E7eJYPBLPMaLhTMxjvsxYLKcTvopRCWJW9uSUBHlx16Xfgq3z
 uoZkH9AlGI5MF4+iYo0t1JJgRqyzHYLt8ovCaftUAY6i6Ql/uMFui5kZm5A5tkhp9GWCu8LScHm
 mKYyasEnkakUBLIm9QA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1011 suspectscore=0 adultscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030097

On Thu, May 21, 2026 at 10:36=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
>
> for_each_child_of_node_scoped() decrements the reference count of the
> nod after each iteration. Assigning it without incrementing the refcount
> to a dynamically allocated platform device will result in a double put
> in platform_device_release(). Add the missing call to of_node_get().
>
> Cc: stable@vger.kernel.org
> Fixes: 3e4d109ee8fc ("pmdomain: imx: gpc: Simplify with scoped for each O=
F child loop")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/imx/gpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
> index de695f1944ab31de3d37ce8000d0c577579d64f9..42e50c9b4fb9ffb96a20a462d=
4eb5168942a893c 100644
> --- a/drivers/pmdomain/imx/gpc.c
> +++ b/drivers/pmdomain/imx/gpc.c
> @@ -487,7 +487,7 @@ static int imx_gpc_probe(struct platform_device *pdev=
)
>                         domain->ipg_rate_mhz =3D ipg_rate_mhz;
>
>                         pd_pdev->dev.parent =3D &pdev->dev;
> -                       pd_pdev->dev.of_node =3D np;
> +                       pd_pdev->dev.of_node =3D of_node_get(np);
>                         pd_pdev->dev.fwnode =3D of_fwnode_handle(np);
>
>                         ret =3D platform_device_add(pd_pdev);
>
> --
> 2.47.3

