Return-Path: <linuxppc-dev+bounces-24788-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC21C531FA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 15:07:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h6BDH3KqRz2yFg;
	Sat, 25 Jul 2026 01:07:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=205.220.168.131 arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784905631;
	cv=pass; b=EYD9FhbbI1xBDfpeZOI35hO3gOR4PbOCc17RyPB9VMlsDY1aV2F/CKH25CcB+9CQShEzhiiNZ4avmrteZcIOr4yZgS7UjXoZUqWNiqtybKdkcCA/eIvZ/5q87MhtWhjPQ9TdE+migum1KQMPrk25VRw5BQbyCsHT5itfyBsb02j39Hlgb50Rwn76jCcavmF+KxBDRPcN5sDVhFEEdJgcMC7U5ANnzwfSihFtyNYPNrGrVix+m9ZTZXuxceFkyarP4pdnmwsIsHBFkW+Ok9bycLVYLq3c06ZUmMNJ9BD+p+aWlypKQqZgootTtjxNKHuHeRm1HNqDQd5scdaGI8P+bg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784905631; c=relaxed/relaxed;
	bh=6iZwoWyplh10gQFqizgnNT67wlnEGukSQwIPfNxV3K4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGLyCqAMUBjLcawJU7+1hZXzWnAefYMoa3TieZlH7rprMzU4n7KDJ8cg1jWFy08SSv6XbQhD8SRxCqcpxRnPDlITg0/bFGBjBC2JuTgF0MUnXo+Ofv+AlW/TvZyhRlaQOZvnQtQtCA57jHy0byELsa3uiZwfefKinU/kr6YJLb9iSFrnQSQo94Do/ZOlPdxQedXByrSdI189GR4EgKbHSOInZzxNSnSznF1o/xJEaTIICNnQ8tpq6gOyNOeMcUD0EYCB2DGbM4fu5DwlXa9EbYDn1dKlq2oDSaBC+TeMhdix22JjXJkPx/0Nc4QV5vvRBIISVpdwUyQmBu8kt7tOcA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CMNYH8YK; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AmBRbyd3; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ulf.hansson@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CMNYH8YK;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AmBRbyd3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ulf.hansson@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h6BDG1QcRz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2026 01:07:08 +1000 (AEST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODbZt82710974
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2026 15:07:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6iZwoWyplh10gQFqizgnNT67wlnEGukSQwIPfNxV3K4=; b=CMNYH8YKsP0vLnKa
	kg5kejSOcOGDDykg6w4NaAMhIZjMwg5Hvpg2qVVAeGFA6SXIkFXHAI/V9jYZZTSy
	RttEgtp4bwm6aE9p1KGLNE0/MB+O/oivlVfzYqqXeDZ/TYz39Fv1fPEUWjQMmKmB
	ZOhZL4fM89UgzYGiONz5xZQQ8LEp9cpVqsU7E9WNOiG8/iFseatouKgfxZnlVqh6
	rWFhOjCyVDJkJyyzui4Pk9uGykx+T9GFLHJOTV+t4bciz5za3v7JZndxoHiqDk4w
	c6pEZ4xZYfHEQPLIJ2zTQeesRUAuDTSkH8JP6vyj4qfAeEMOO27lPxff5lNMPRVs
	QuKvrQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm8cggh6u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2026 15:07:05 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e8004d60eso84896285a.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2026 08:07:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784905624; cv=none;
        d=google.com; s=arc-20260327;
        b=NZ2Cb7coBcwftRhZhVRgHXebNf+RApEHYVOAvRIof+lm8yfcrYpSmdt5cGEH+bToJS
         Jnf3A7VcWwlP1KAUbLqt4NqAzUZXqRD/vD/VYUeFOd7ngjjtkNh9+oVq/xegMTYhiJwB
         lHKvw1ldL7iotbfSYt7XDOEeMaup7wYi7Q8jE/W92UCBa/bZ+M6DGsmaEtTlwfYjHCJJ
         BOUOxeyoMgZTA4bSWz8dgNkBZ0hvWa1AEDkj1tLyghXB4sAiYwkLehhrw/iiULHZxHsZ
         UWH3iJ23vIHJfx2pkc9np3ldwQv7LAcoPT8CP8tkdRZi7W/eTRrbLOrRBw9RiFzOMEsw
         /96w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6iZwoWyplh10gQFqizgnNT67wlnEGukSQwIPfNxV3K4=;
        fh=sZbL7zci9jZ/4VebYmxkh0f9Z/B4Wh6U5dFS4BpEdig=;
        b=GVg8tz6d/cfFYqkUAsuLtzXOX7Q3FjqOFVuKyFHKJrvDb6cFrQq7Qw91mXxYLNxsxh
         GiSutP4dNs5xd9SiS6vskF3dXxovRDpvkxYqWuGQoy2bxJOdRZS05Rrv3ljkLmPqtREy
         KFF3d69AgvfpWXHnBWeoY5SH5+tXyRu4NFHNW2hqYlxNziiwOtz+zmM+hzjFIG2inVh9
         lVo7EZpedLkKcCkDY9UYgHHlNVZg9MHmlgCPcXnAIzscsuKys85i9WOOqVLoYuXKwEOR
         SV2fGVQzq90TWANUIJExWsmxq4/m3zn9ahC1Q4nZ0iqb688HlwjRwjelbGH49KXKJ7dW
         6ebg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784905624; x=1785510424; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6iZwoWyplh10gQFqizgnNT67wlnEGukSQwIPfNxV3K4=;
        b=AmBRbyd3ELoW1+sjJs2RipPNoSwZw5LbsDbdZ3U6KUDuQQC5eqQsejTOOKFOzv+I3h
         bx0Z7h+rH1PXrXCPOTUSLVuk+zNY+hSnMoya6W0a9hkKBAMlPdaHe7vYmZzEwNkGVtyx
         qCp90v9ttKUicN2QS+EhugRKGYiONT3dWKm9gQPahftgbnpsAAIGYv7FrbptD+2by+f3
         Qw6WfYZjHDypwE4CoJNsY4Pqpj1GcXa6IeO5cCaXcHuUI/kCgXlLMTFFsHymG8if9ZrB
         e3H2GLFfqM4nA2Dx6mWsZKmS78AyEvcxoGzm+JRol0FaaPvp9Cwu2+v08HW/t4HwzOku
         J0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784905624; x=1785510424;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6iZwoWyplh10gQFqizgnNT67wlnEGukSQwIPfNxV3K4=;
        b=L4S8Yjuz30sWAcr5RBa73x04va9Qt57jdl9/kWba/GOWmZkmjuMWvOq360FWQ1bb2N
         GTTL3cYea1maLtVwV5rQw89Apoo40ugAHk4Jf3S+2L4FgGhz1UoalzabFU1+1saf6GGu
         8WR+ZknPpG5NW9NnVY9LZIhjjR4rvdPLg0Oa/kSj1uXLnFqOnUHf3FY6rmXcxh/hjiyZ
         ClOjATHoCmTiV7CZbuFHnlqwBcJwsWG1k8tBw+Hqz3PVYQNbJpebCwWLWom+fIEiTWQV
         mNnWvDMhCzXVE048FyenWDxYRlH8huP0H5U7csTobCra3ddrihU2xwgG6KTbAcT2EbWX
         q0Xg==
X-Forwarded-Encrypted: i=1; AHgh+RrKm+DbBioyyuOQ0e/UNl3yZ47TfrCuMY3iC7M4qSR4OHjKZ5qwM6NXhouQ1j+OBUsRoZA3JGdYp91T94o=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyCaOyq+XM8241PtQMHm+2gGugJ428IfJ7+U7JlhXTGE1/WnH3k
	pW3hyasMj5bFIz4s2aMudS7026j4QMXS7+dzNTqhtedM7hi+P9Of94x90gWJio7IU7S+t2rHada
	NDa5Vj93egKzsKyz3wZye9v6lL2ty8+KE5O/Pg8hk28qmYJQNE/10lIA5kS6pRIigyovRPJKrS9
	0pJVFBVz0/BTLMcWHODTIVptjmJ5Vk63XT7qbVyFcCbeA=
X-Gm-Gg: AR+sD10DcLPG5aGcnNpPNu+skRTBsUips3SnN5W0nzNOuQvHzL1Zj7g9y+UOE8n4mmh
	7DqGkfrpltX+e0W4okBxfKeiymtQY4FiIa6lq4EWbS+62mOgz/vsQ9Ab9B+YfMZAnQDGonXrJFD
	TFlodv8d1QNM63cinYBWk6dPc44cLWeB9xwBJZk23KQwfnXq6YwpQmtEEQgg==
X-Received: by 2002:a05:620a:1b81:b0:92e:c118:18a9 with SMTP id af79cd13be357-93103a65117mr772238085a.92.1784905624088;
        Fri, 24 Jul 2026 08:07:04 -0700 (PDT)
X-Received: by 2002:a05:620a:1b81:b0:92e:c118:18a9 with SMTP id
 af79cd13be357-93103a65117mr772229085a.92.1784905623517; Fri, 24 Jul 2026
 08:07:03 -0700 (PDT)
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
References: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
 <20260720-pdev-set-fwnode-instead-of-of-node-v1-5-2dee93f42c54@oss.qualcomm.com>
In-Reply-To: <20260720-pdev-set-fwnode-instead-of-of-node-v1-5-2dee93f42c54@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 17:06:51 +0200
X-Gm-Features: AUfX_mxUpEE-_djVPIMU7ZvWbbzhCFmItK3_9wrfK5-RcRFUSwGHiGhMmnFjL0c
Message-ID: <CAPx+jO9=HWwr4jGoCcWAM6fKTTrg3TphgPiNX+4yvfnyEZa_pg@mail.gmail.com>
Subject: Re: [PATCH 5/8] pmdomain: imx: use platform_device_set_fwnode()
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Srinivas Kandagatla <srini@kernel.org>, brgl@kernel.org,
        driver-core@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        iommu@lists.linux.dev, netdev@vger.kernel.org,
        linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, mfd@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=JOMLdcKb c=1 sm=1 tr=0 ts=6a637f99 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=RwuSGLWl7VkFDbmKPUAA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: Xr9ph3f15q_3SCZ_BatBgUcBwg31NC-M
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEzNiBTYWx0ZWRfX7H3yNG9dUnhl
 2MMwWCJpPgCHYGF2jGZ7v3XeSNRk222O61vCh7GBr8ZvkS/yNdlknGGxoqS/21zhVIc5c6YT7WC
 SFiT62uijznUHBYmL4c0/XEk+ASbTCY=
X-Proofpoint-GUID: Xr9ph3f15q_3SCZ_BatBgUcBwg31NC-M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEzNiBTYWx0ZWRfX6Ou487AroOR3
 0kLy1vEOqmsFQ33qrelM160zzndr7amvot+ItwoR26TZMKktigcfoUZBSuhGbDxvPqWLryqPP6V
 xRZFb/raiKlRv3auAJsVQcaryqyknbaHu4/ayza0ILg43vWd3vV1Rgbv3/CNXW5wZJCUMDI71Zw
 7LW+eVt5GfPZT7bC7anp22iEnOuT0HkGAKvVQlAp40Zw0Uy8CzlZJ8UJfF4754BvfJQmlS2S7+1
 nKF6zW3jPVmK3J/1M315p5EjaSUDRSQgoTDLFs37KiA4JwREw1sARG+psUIMNJB7V6iQrcpvjGx
 EGbmvIGg+f+I9biDO379J2c6CUeJ2AGWPvM09/Lhdw68YNez8HZR7dS/0Xs+BJ198mudvtmxl+4
 opJZEjktLCVHv+uy4td5mKsD0rr133pdg6D/3ALZREyXne457jTOpycjBmqzKWPa5rJ3882P3Br
 Bq4lpGNUPJti/E5SV9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240136

On Mon, Jul 20, 2026 at 11:25=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
>
> Prefer the higher-level platform_device_set_fwnode() over the
> OF-specific platform_device_set_of_node() for dynamically allocated
> platform devices.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Acked-by: Ulf Hansson <ulfh@kernel.org>

Kind regards
Uffe

> ---
>  drivers/pmdomain/imx/gpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
> index abca5f449a226fbae4213926e1395c413160c950..c147eaf048ba2b79a744ec870=
29420981581e48e 100644
> --- a/drivers/pmdomain/imx/gpc.c
> +++ b/drivers/pmdomain/imx/gpc.c
> @@ -487,7 +487,7 @@ static int imx_gpc_probe(struct platform_device *pdev=
)
>                         domain->ipg_rate_mhz =3D ipg_rate_mhz;
>
>                         pd_pdev->dev.parent =3D &pdev->dev;
> -                       platform_device_set_of_node(pd_pdev, np);
> +                       platform_device_set_fwnode(pd_pdev, of_fwnode_han=
dle(np));
>
>                         ret =3D platform_device_add(pd_pdev);
>                         if (ret) {
>
> --
> 2.47.3
>

