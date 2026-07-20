Return-Path: <linuxppc-dev+bounces-24455-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97549C44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 09:26:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3ZrG0kq0z2xm3;
	Mon, 20 Jul 2026 19:25:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784539550;
	cv=none; b=WPGXhIU+VMD4zD15AIz+pGVHyh/RliUYNERjQURUhcWmUAjmT5U0d6lkttIqtYOwqArd4YUuyb89S11KPyRH9tQXBEhr6qryxF0SZEZbzh+W0fUp13G/G/dALHc4ZxAWqkvGq7peUxY2mxdsOU5mM0srP1jRGsqsPnd5aJXORj9cm841nRwulIfcxrFJi5EWE695hR4CGzaw4jQC/Uqp1RcTHOnfPyFDUMFqIho2jKseHYtc78E3c1yiK1K6bZW9n9MRY9CSzfK4/PBD8aFikvZY81dwMFZBsqE5FGRP6cmiecQm8dQSA/h52IaZMqCSRSKIn90fIaMhytix6iMzcw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784539550; c=relaxed/relaxed;
	bh=azoonAs2rZvyyYgYMRjUol9O+q8eXf7OwF52OR7cKds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ndZAq/k6P5oeaUO2KNxaoEErolP8uHD65lzSYmI2DZ7hfNHTaNhfkyLKbPi5gKqPRy/0YcE/SnXTEz80dm3Qcs3Pgp8aFpMAHTJMJ0P+flBO+UsNyl+bkrOFAZ0PyCvBJV9+6Kq6G84H7EnamJPOpPDzUoM8iDny6TDP364foXGEJ2Km9LTc5DESr1d1kPRDVVq5Q8p52cf79Q77VmbX1mfd+pOgj8bMh/q+dVeqONMMMsXhD+Ufq2uvWXOrhXQv4sNeKGNduKLLeWhd2j3tmLQmBb0gjgRpQOqYv3AvEzU6nyia/Zxk5KnjZBn4/aKE0QFUHcnNIWc4Y9GrODUK9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jTX3r2ny; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KC/gB8Ca; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jTX3r2ny;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KC/gB8Ca;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3ZrF3nP3z2yYY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 19:25:49 +1000 (AEST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K6RV1E1420166
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 09:25:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	azoonAs2rZvyyYgYMRjUol9O+q8eXf7OwF52OR7cKds=; b=jTX3r2nyWsHMgzxn
	8FiVrwsN9vBocFeW49l7ldKA5XAZhAJvTnfLaGPyMqjBxsPnKZBOPmOYXmAuXLVY
	4sWAiXGaTX45boKk1A3m8XsO7Gmxi/ELddH67Z5gVDiX05ykqVAhWHKtR+3LGKie
	veQisNX1QTgE8ROX03T0wNSpfnKt6iykthul2wHTYqiKsUZQS+FSKYyXOCuBYwzx
	FP7tPplooLKcPdtEWKezKg9RXkJ/Rf/nlqNN+bdT6uAg8a8my1SerICuKrd5eD+U
	UQmT5/Vq/x0vfqtNbWmWRgO1GD1kO9nqhZUuC2tvSRXW5+IyGky9YO1InCixmuof
	tFEEDw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2s7wjs1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 09:25:47 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c0ab07320so136279171cf.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 02:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784539547; x=1785144347; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=azoonAs2rZvyyYgYMRjUol9O+q8eXf7OwF52OR7cKds=;
        b=KC/gB8CaoOrWlJYkqiuzDY2EGih6EJ0wwUH8DTUp78fKrQXvkUtpHWeWy8TaMK+AFS
         ciJJtk5X46c8yT+uIYkYYIQOX1ssp8MsyCllb4ey7HU0tEpkfloW6xoCmpsmWqOm8Uu1
         uG59U0OgJxslxtEvu76ri9xD7N50+G7sd8b0s0I/hjkq3gD72RUdJGIcs/S0O1QkJhfI
         /djkAoGwCybbp7USN1J34rIk5PI6UKXmSElQwqxIvgzLVmR/zNUo308Zxc+mhLsDHDiD
         UEELh+a/lt2s4xfhZwnN7nAsl69jG0GsktvgwcxqcbPnqMsvEYQh63HhaChvtEYBwyCG
         QybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784539547; x=1785144347;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=azoonAs2rZvyyYgYMRjUol9O+q8eXf7OwF52OR7cKds=;
        b=KYx0FGtiDu/aINyJVLTw3JrI14SB+3oT0LIV90K2WZ9bRMIh1JtJD7Xx2SFQ9QTh9B
         ICOCp7r4kIfjTD1+L7nKrGlMAVNYjx3NmoKzBFMcBLXkp5s+gTtfyE6JQB0Mmp4tJ7U4
         N8miuYrGhXE4QWFKuYuPEuVzsbqzVZ4t8lZQQljitIqB/uAvl2R3ABthfxTHHdy7Y3bx
         Tfcf4ekwv0umbB71W9AgFtamH830nROg4Xkbu+LBvjOgeujxMci+Idubp+o9xahkraJ9
         ym1tzFWznFa449lb2d9+I0tphXnWZgvYdjeRcQY2YIXvoTrIYLyOb8ZtVEek6YxcJJNe
         nIgQ==
X-Forwarded-Encrypted: i=1; AHgh+RpwLPP+mm1abdlW26i0jpBncykPLeUguSYNVLF7/poShZVRqFeKN4wwrV7vInxfswOtSwFTCFN3Pxn8vkc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YygVp7pZ0V61chjC9s8XjwfpjylhZFzgNhhQebXB9tlbBN6jxbS
	iMd1TBoWPLWTdmMevwFGqKu6c7VXwqNzfq2/Ccnj7EC3fSZRshcVNZhrf6FwTMbMwC2BHWb7lAh
	feO3Wfy2cIz3VSUorRBAmDceG449ON8MMYPPXG//u6cz52R3y3vnHLHv1Z96bIKDB7C12
X-Gm-Gg: AfdE7cljosr2nI5jIsljRmOzfqM2PqrU2bdixLOqYRYnp45y6k6FnmR+zgl0JP8VRXU
	fa49Vn0qVQAY6XZxTlfXQhveYJGEfIj2oA/FcfNc9XCf9aPXebGeIOzoA+hHkC0bDhI6BnD4aeB
	CrUleCnV3nOkCi8uPRQDB61tPVlkTiTAim5Ji+iVjUcQyETk0+Ic3+RLpHLXJDvY1HKNQqfFgPD
	9TjvjQZ4zhf8w2R+aIUTuIQgF1aOo0b/BpzwUxmdPC6Y8qbnp1KFGcej/OlgcinyXOVdDqa17d2
	Alq6kNG8wUgXaU8eu+7E1S/iUFcWKCx861ufb8Qo15hhYA/ERxpRLTuCY5iGDno83uVZBdR9PMe
	0aMF55edP6vAUvEQ4O6ez3WjALzfaiQ==
X-Received: by 2002:ac8:59c5:0:b0:51a:8c9b:649f with SMTP id d75a77b69052e-5213d0c7347mr123946721cf.67.1784539546640;
        Mon, 20 Jul 2026 02:25:46 -0700 (PDT)
X-Received: by 2002:ac8:59c5:0:b0:51a:8c9b:649f with SMTP id d75a77b69052e-5213d0c7347mr123946431cf.67.1784539546190;
        Mon, 20 Jul 2026 02:25:46 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:65fa:60cb:c205:d511])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4955de88951sm62228205e9.3.2026.07.20.02.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 02:25:45 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 11:24:53 +0200
Subject: [PATCH 6/8] mfd: tps6586: use platform_device_set_fwnode()
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
Message-Id: <20260720-pdev-set-fwnode-instead-of-of-node-v1-6-2dee93f42c54@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=907;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=A6rTQywiVuri+akWPu8ZuzmrgFMwkmEBL5RABzyTsAA=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqXel+JVh2LLebfg0Z60TjK/ZqooFO/E063bUsn
 DcFFoaXAHyJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCal3pfgAKCRAFnS7L/zaE
 w2/uD/0aPKY8tpTuQyVi4bVwQxAwSe5GwjC2DtgnMo6nh/diKnBHmP8CrS17h3oxzaLBbpoQsyv
 Sz7j//KhI2uvM/6lsN12ObBAmWBE1OIY2cI2EITf9uARRqijYfV+vh3K099Z2WSPyIztcA7JV1a
 LXzZb7ugoqz2dMzT1dYxuTYTKlupbAIUqn3iCnldu412Ogk7U1TlAiPXUx8NUiwcSTgNJH6JtjG
 ybhBOe1z5foPXCLYPHg/mB/yn58+1Cndf7uN6COgbJKsYybBcSfm7GwhrfIR3kOESCkTPUQ/wKa
 CtSLDtJYyB3h0iOJVjA1wxmvViV3DncYABZdM9JhjlGr5xekEnOEIkt5J6dyoA6W3qAdQfM+wDe
 WHnnp/KwxzQBF0DZMHAzzpoGyj4CiF+A0L9ufwf2uDn/Gr6QSF3i1uh7g3B9Au9fYk4fZJVPzjL
 EreBD5gpBiQV4/muSmW+73v2B/YzUR/9/++LXGtpFgoyz9CAYZz8Hc2q0lwgczqGG/yerhUZ7Iw
 2svI6neY8mLXD64gJd+3QIabFLBehBoppvlO1WSrRtFtjFWC6wlYnhuX3lwh2ugV3XC2oWE+fzO
 N24Bq1v0R7mTGsTx4YHFYiArfM737K0E9k47o1YA1cm04PfUgXMiuD7g5S8kXEV39VNN8Mvf0py
 8hgioC0XlGh1TYg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEwNCBTYWx0ZWRfXyYNYURm6XAVs
 I75sjnc4hGUJZ26hAxESdHpZ55g8MyEDrpQgXLrmsxX5zLiRSRVb3YNme5oVWWnZSQLQC/24czx
 UqJ16eIlMYfhqNXnMQONn/eHELjte7jkLZQHaajs151VK6/3a+ZFwygYyeIiDQDtCLU3wiWrKvj
 P8cyCMJH8TeU9VZC4YTdzvg5nP/Z696OP4O5l3IZ9CozEsSWYQaV5DIozapMZn2nAMyBVpy+y/w
 3FWzdVp02a5xXJiQsCmftc3sopXbtXZjZW5plaPJ4975ncEwZSLWy5HfCH2i8zDOkmvOKRnS0p+
 61C1T9NqJEj3eooydcksran4fYamaeZoRFKogPI25n9UJYBiGekNmCwHCzxJuSjYUZyweJjrWIu
 h5LiimDzk38FL0lFCd2tAt1/q+25I5v0EFWrxKlqZemIXu8JWGAtra/5PCaZ8an9vi74+xaOKnY
 5048S0GlY4bJHT5rhbA==
X-Authority-Analysis: v=2.4 cv=eKsjSnp1 c=1 sm=1 tr=0 ts=6a5de99b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=s4_jwgGKpBPlvUtSdncA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: mua_O76ePUjfRY1mtXV2n3B4CqpKjE6u
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEwNCBTYWx0ZWRfXw4gGllXoiyKK
 j+4Gt9DYoZYOyoQD7x5V/aSjuf8+WYrIZJ4B/CVEy9XQ58TvK/bV3qF0m08B27i91gFcKlGNXtg
 NCg37LfNDMjxK9LNecR/myyxS/8JpyU=
X-Proofpoint-GUID: mua_O76ePUjfRY1mtXV2n3B4CqpKjE6u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200104

Prefer the higher-level platform_device_set_fwnode() over the
OF-specific platform_device_set_of_node() for dynamically allocated
platform devices.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/mfd/tps6586x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index 3cfd2f02b62f3cc370e0d970ec2643b638fd0fec..fc7c4b55c385416741925904abae4fd240f55b13 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -397,7 +397,7 @@ static int tps6586x_add_subdevs(struct tps6586x *tps6586x,
 
 		pdev->dev.parent = tps6586x->dev;
 		pdev->dev.platform_data = subdev->platform_data;
-		platform_device_set_of_node(pdev, subdev->of_node);
+		platform_device_set_fwnode(pdev, of_fwnode_handle(subdev->of_node));
 
 		ret = platform_device_add(pdev);
 		if (ret) {

-- 
2.47.3


