Return-Path: <linuxppc-dev+bounces-24452-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E02C44524
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 09:25:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3Zr224Rtz308f;
	Mon, 20 Jul 2026 19:25:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784539538;
	cv=none; b=NoKXzRsrEeqc1BhRZUlxxQ0xu4ieF1z5oBV0dh1cVxSEfz+IDl+ZNV72JlyFng/qP/IADjwxFH2N0OTj0d1vsi3YRTtTtBe+4hvGwnHGF/gyXvzDOihD1mGgJifcsWdqeDmBe5gNeVfkgVuiiDmM9yZGXTYfM+9FO+jQQdSLIJcXUcs6SmevUx/3whj1fjfrXZIgEHbadTYWEsx08dVjVqcVxLvZKDx53EXhCfBCGP0/9APgcgej/EZU4+l4DFuGyjZd+uKD3Eg9YYLx7LpLBzD45uK1gb3L8tsxrcuC4K+4F9dnxUSKbeti3uj8c8L4Fl1ySOM4fHO41eiDFMnNrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784539538; c=relaxed/relaxed;
	bh=UIZ+VAsVn1SNZ95QGAq5L0m52yqYtxRT1a/8J3q9Pu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RZuj2VvIY3+fMhT+eyygxnVPKwjiZnQtGp+EWQ5myf766iYC6KQqHeo9lCmIT0nXU7GCBGTfypSzmAfn1nB/vWdf8ACnKZLWhZjySSvt+1G0lKivKhKTKAtwr2VLmhQGF/3uMbEji7U11aAA9yrft6ZLICv/SbNocp6qDP36SDbZjXInCZ/pJ5Lq7JOyU7GEVeAJ8TcD82n/C8ynMuCRJqhdNbl26qkHGNLrVARdiJ3XkZITHTDA4Yf1m1/ML18WXYH9hVgYvn/gtTK2MFnehDtLwbCOTTO4ENoQIezlLlk5Hm6buxsbfWkloWzea59no0kcYZ29UuNT+Obi+NuKbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cdsk810P; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iaEYCy/v; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cdsk810P;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iaEYCy/v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3Zr14J7Fz2xm3
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 19:25:37 +1000 (AEST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K87P022000634
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 09:25:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UIZ+VAsVn1SNZ95QGAq5L0m52yqYtxRT1a/8J3q9Pu4=; b=cdsk810PBp7g+01t
	jtgsGaB6bqe7awz+CHFFzkkzoLRYq0k1QLv8MuSjFV4W5+7SdbFv/6T4M9/nmTqb
	9hSzA+WUDlYFsy43Oe2BJmMUGoCTsH/SbrIid3297qp8o4v+URjLubzvWI99IWpk
	bQBxqlqdsY65+HrEd87wxvATZbN4vLF86FWV2YI+1BWihFWMUsi++2WKU4Ew6MSG
	i3twBcvytFoyV5dmENS0paEGxzTC/InElCdcYbKTpIlG5PY1LYSoqfDZ3pI9zXzl
	thHjSjWosG9kmlp7yi+JysDF2XXnIdixKlp1Ltj19pyBdQ3sg6xMQVDoV7w9Y2Eh
	60oT1w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfvxgcuh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 09:25:35 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51bff5c7035so86656541cf.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 02:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784539535; x=1785144335; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UIZ+VAsVn1SNZ95QGAq5L0m52yqYtxRT1a/8J3q9Pu4=;
        b=iaEYCy/vtZNV5OdmQ0vMPjfbf/legM+ILnxsrAHJW64N6/pMEs16xLU7rMQM3uU0nX
         Ou0JK+DXyOPQ6H4VhDHjtGyg3ZOoDR/p+/rdF7Db+NTlHMe6+r8599omqGCREE87ttcw
         tmvqaxqpO44YqxHXRGsUIcIfY4NsQs6bipy2Z17tM6ka/eKde74BYdoO866aHz54Rz0V
         7BK85VjDnL3ejuNu5aggIxuco1tWHH9ruXm58pks8Yg6slV71OzQZQBpvICB0n8LYS2u
         DO2eFttJ9FBO47w95t9XbuI3W2fx4oD+Ki67EQqfg5GoYglHnqRNsQOrV5Pl68X55OMM
         B0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784539535; x=1785144335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UIZ+VAsVn1SNZ95QGAq5L0m52yqYtxRT1a/8J3q9Pu4=;
        b=rKa9W3jJecWH+TtIGHn9KQwYXWetQCO6QM0mUD9jng1Ph7SMIywk86X7Da850Vh6wI
         gLG5GuSI+4L67f8XzLjNR5RQxMx1gH/8rgGgnOfgR+i+323L5njxp+CZvGos8nPlFtay
         ySE4ClgkgaTUREWILjOR4LBHWcM4d6OjthqhiAp11pAPdl28TMUe3cqnH/wbgKQzL3BU
         mxa5bAUjRM5v2Hsqz3Erf22u6qCjOn4vnn20BIZOGjNS0NfSzSzFdrA/Trn/xxOewzld
         NdtKFWe5d7EwQZYG8pCdgBxc4vqvQ6WT7vvXIBcEF5vF5J9W4x2DdkgFmo2KbeklKhka
         En4w==
X-Forwarded-Encrypted: i=1; AHgh+RpUP8p4fI8YjrNObXp9jne2MBLd35pVVENgsaibl89mIhnoJ+fSUKG1qutyc/jbe1qqnfGeJMKRjVJbESo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz1JO4opNFBTBLT53+4IDTKVt8BvbwwJa2b1MQJ+UCMA8kClG4N
	CZcCX3nLPDFkmxB5pLVkH3FPfcrYwDllcyYmaG0mnZeZq6uQ63Zv4E+z17BPD7xkNmHMbmK7Sph
	+kGhiae7JmPwhGdmIBrgUEiUVRAo/cY52xgvlDZcOhOOfMPP095ndoGFQYl4hckAqaqtC
X-Gm-Gg: AfdE7clApATx1lR7Uk6jUZM7tJ2QKd1J4KdT8VhTscahU/t2c22FqyoxSzNbrYTInma
	6AYSUUZ6mGy5M+EQeIP3iJiosBpWcGKffeF/4fKPG1Qigu3skVAubgOD56L38jbYI6AsrvvbqeW
	QqR9wnh8uHmAAsKBeQaN7GNazH6kQFWDohJyFnKcmqBeAvUx4P7wLB3Xl6Gr1o8rHKYd8QxegIz
	LZLEmZhzl0YX/bZV7ihSMG6xKWtyPzRFY+4oXB+HbuNkl/tXH0uVa+LAdlR5IQh5BqkOwYUEdfe
	Rq5hFCqIldmawf7VhDm4jXk22P/YdJLJCLMn7PILzXyi4NaRPAmKynj/PYr35M9zUBR6rWNl7z1
	m5sNf7KlYNWZQ6bd1VZ1h1n6/oSmRIw==
X-Received: by 2002:a05:622a:8405:20b0:521:8ef0:b4e0 with SMTP id d75a77b69052e-5218ef0b690mr68227231cf.17.1784539534890;
        Mon, 20 Jul 2026 02:25:34 -0700 (PDT)
X-Received: by 2002:a05:622a:8405:20b0:521:8ef0:b4e0 with SMTP id d75a77b69052e-5218ef0b690mr68227031cf.17.1784539534544;
        Mon, 20 Jul 2026 02:25:34 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:65fa:60cb:c205:d511])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4955de88951sm62228205e9.3.2026.07.20.02.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 02:25:33 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 11:24:50 +0200
Subject: [PATCH 3/8] iommu/fsl: use platform_device_set_fwnode()
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
Message-Id: <20260720-pdev-set-fwnode-instead-of-of-node-v1-3-2dee93f42c54@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=800;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=ngE1ViR1uejC9qMYv5QiOE7AeBgS+j6esA02JjCNPps=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqXel6iXQzzX/uv/M9gp2dgxe5JJKBdP3GI+hsF
 3nTXeFE5ueJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCal3pegAKCRAFnS7L/zaE
 wyjWD/9xXLl+a9ATQzUTmx2pnk3PM2p8fPrhJGmTlsNly3ZXJZphk+eDGVbTZjMKzCAO7n+1MYv
 KC3P5qWxuw82fl5Mbg02h92WwZFcK2jLnAt1fEaQoLmiwKYIglZlCzdDXqh8SF1Ko19OroltKBU
 jwvYBAr3Ie5QCwnDEs0RoHKKubZSQ5mouhqfRrd7qbgG+uDXDg5XpHtk0rDJ5FnPKp4X8W/XhTH
 3GweCttfjt4t/fiwM2j6KmWcSD5TJ+hjv/5KeJZf2QB1Eb0Dzv22Jvlb2raqCQJUCcCg4JAK5g3
 JCWI7Te3zkgFGiJSn9nc5Z9P+Qzwms6BXzpM3qfS5u/Ks7wgnRpq+urnXYHHPlZR64p/nNNQDkV
 xrsRgx0q3ZOgObWODPSBLq7wPynL4OPLsZv9GtIVxxegKpC4h/+4N/6JMo5EzkA79PuYLzxx6DJ
 pb+qZwcXPvSLXNg6IPVLewi3QQIB2HIny/YXxqUAipY98m3orYwhyp0sHs7WLviD4uxwrtAKbjX
 zyNGMpy9b7hxIWjIDa5PPa+q68hJILk4PDf6cQWZ5PiRB+ISL4CPpMGtkvCEcAEiVOQ+rhH2bPm
 DD2NrOLMt6pvLTRgLX3Vj54Vvcw3gI3OzMXg3zRQswULvjd4UuArBK9wB0sB4LT4S9trCF2QCem
 /w1WqggZz70S85g==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=HKLz0Itv c=1 sm=1 tr=0 ts=6a5de98f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=le_mMX733WJEbBjyejwA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEwNCBTYWx0ZWRfX+ywIjYaXmnM+
 cQsfBSlgwK0SBYFIWif/x6s6pSDznxtULqqnmGmOVCJKbBVfUzVwtvXdz5FHZ3EEJM46u/b+LDZ
 dMpjS8nxhHPm0hoCW0NHhF5c7dy8n6Q=
X-Proofpoint-GUID: qQRRS6LrN6TZqHxTv1FnR4Z7Rm2lf-Uc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEwNCBTYWx0ZWRfX2jH7PdAxQXya
 rQ/NOMN3Z/OnSCY3IZY+2OEu2fnXBrZ80RnHvAZjIBNT7UF5e42gYEZQgIDXRDZORL+BCoURpS7
 lUWQLDX9Kq7CzM/G+LfZaKdmtxpKfJq8Qq0gTP+yw3+EUPcGvQ+w8as8gn5jMPJ8onfuP3edzRA
 viytYvhLZt1ZSmSHZ1zTKtv5g4q4tjlfE3bkFFX+sOrJEsVtNkDFwxchfmYKrh6AiYYx3ea45ng
 mmlo2amBlp0iNWP9h1udFacmzNOxQ91h1T+J59iBr8fw3xAxZ9Y4M1a7pqLW5lGd6S8LGqkPg8y
 V6NT+puD6KW+/k3doijFsUnQqa4PlihuRd2b1VdKsNz57iRo/3yUL2abDdcABFHKv+K1qh47kCi
 WdhJGMQ/q6WWAXDvss3k+hXk8EHJB3YRlQn7erKmt09Nr55UsuTIQ+no/EfRh0gcR1FsiMuCr8H
 d+NHYXnf+aPzoyT3miA==
X-Proofpoint-ORIG-GUID: qQRRS6LrN6TZqHxTv1FnR4Z7Rm2lf-Uc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200104

Prefer the higher-level platform_device_set_fwnode() over the
OF-specific platform_device_set_of_node() for dynamically allocated
platform devices.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/iommu/fsl_pamu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index c83bbc3faad56d6ee1c89b0a7f74028af02c81e9..268a1f752fbceab4fd24013aeea5df1b6982fbb1 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -975,7 +975,7 @@ static __init int fsl_pamu_init(void)
 		goto error_device_alloc;
 	}
 
-	platform_device_set_of_node(pdev, np);
+	platform_device_set_fwnode(pdev, of_fwnode_handle(np));
 
 	ret = pamu_domain_init();
 	if (ret)

-- 
2.47.3


