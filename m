Return-Path: <linuxppc-dev+bounces-24453-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A47C44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 09:26:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3Zr51QgZz30Cj;
	Mon, 20 Jul 2026 19:25:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784539541;
	cv=none; b=WtWADIUlA0VQvPOCxdOshxlxSZ/GRpcUAsiTt3KrPd3PxwJ0HRI7lYf2AHuaWTMYVDB4Pv2unDRh5uyw5il5aGXy0rDxptxMGMNbbUXBQwZz7JlcrWdaUQng1rOu+uVfkwTIxcZNbjScDmEG16UE8L3QR5jeY0fLsA77tEktXo5ZbDxyR0t97+85mG6ooL1cT6v6B0SRDte7iuaI5W8gL8gzTLR2isXRKjjeczBMyAjiaR90k2/7thhcS0a/jK/IHy1DLN6HJkS0I1iwskyrRAeN1aFVbdNkbK7xFYiIvLmJlpUoU2gunDLRH1qkaajqCrxm1BqGPbXZmzWYCBegWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784539541; c=relaxed/relaxed;
	bh=7yyISHBDW6HtabJ1pV9A/MMaSyWcRa8ODURQFtJ8g18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cIETewkpLF8fRkThiqkYVu/x0qKeYvLkR9el5EncioavT2JDZ9pX/yvojT7fJHt8M7HMRITZYimPEvy2MwrUi1uVWiS1TYjT3T+f7D8eC9ow46cd9tBP3MdKO/VzShc9iXYK2OO8S3HPElJJVca7q0eXxySEc38D9cRl8hYCENs62lrtNZ8G0k53t+KGXxfxyTw/EFAmOxTgHYzbucBMebGBC4ss3PVSKxlTiIf1exvg5iR9WwacQAO97I3dT+cKn01Z+GVqv00Fov2AtTQyEpFNJIItMrb1PI2HCW3Nm0fxZH+pjWbKAdfN4G693nQjwVWQYX+8fcTFo3wQRAzz4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Q+znHmvo; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hAnEknqS; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Q+znHmvo;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hAnEknqS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3Zr44fH2z2xm3
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 19:25:40 +1000 (AEST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K97Z2v1653541
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 09:25:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7yyISHBDW6HtabJ1pV9A/MMaSyWcRa8ODURQFtJ8g18=; b=Q+znHmvoeBFyZJiz
	uYyIo/u7JSU0yCc9yH/0dG9iBQoOzXGKf66qCX2LGTIH8vdhy6poPAKixz8wCUAV
	KTDo6Z/e0bN22d29hD6Ab5TbhyJYi5NSEcD7bDAXdKeg9Xnal8iSk2Ya6g8f/epE
	jPxQkaPvzUqHBJP7vM/totBYHOKQbJVgV6CI5Oo7y35sP3etT0a3C78UR+VUw8ZP
	XkUpepdM3SVL86oMT7rcUZ9K5pBGNh2uIHqe+KjQ0UiVsZPCkcQv2OTj5kNSvgOE
	gL/r4U8CuOzJa1KacsHYz6LQoZYRoab5n1oX2yg9p7uj2/RMt9fkip3uLlLNXMdj
	9MTabg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhgs502gq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 09:25:38 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c0408254aso82760711cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 02:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784539538; x=1785144338; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7yyISHBDW6HtabJ1pV9A/MMaSyWcRa8ODURQFtJ8g18=;
        b=hAnEknqSPlKayjfOKm8u/5dJ28OVKx75lsxAVKH2fg4jqH/WgruGKa63bSMvNYPOq4
         WxxTmoOYaXzNRT2X3XGXEgfzpSWp8nKaMm/di3AQwUW02R9y2bdeeNiyfr8LKnfNjLbk
         8H0EwSpUpKTPEWurCvp2hBdQbRPOln6HdCLQkQddPVKfzUZWSvawcl/wQRvQ6tkeBRnC
         5SpqVTgrXsKINM0kGFdfbyIznU4D0nus8D/S+21GvJf5FpdggzVE8l52+7yLKnARELTf
         m+UG6rbVlfy9Z62yjbP2RXz92tJzDstnFu8jUE1rVqwRib9GlROzB9AIVsPmZQkPExZ8
         7n8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784539538; x=1785144338;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7yyISHBDW6HtabJ1pV9A/MMaSyWcRa8ODURQFtJ8g18=;
        b=hhIgpUkHNcjGSyEgzK1wjfbChy2Wb4Y9OMnLAxkqwdiTzM7uAISeRLK6EDZfpOMdhZ
         AiFdEWM+2wt9udQpFqi/KZ7EwXRcLXqTL5X6N4aU4LSl6T8O5vm1DJugTwUnCtKHgRPD
         7F1LwUUNvNFzsYw19DjLLGl/ppry4yimwcW0lvBO+LEZcgc+ynMD/7JPNpUE59rZTXpQ
         dUng/5DLMctTvvmBE3PMjLzjhvz4KvBB3yg5+VBPbKv+dzYXokKQ6QzN6ZThXlwgVEF+
         FJUiWW5q15QfmsK+NQwqfQ0CHe9oKERllnvYxjnXPtUQkF20SaTMn8cluAR+F5d5/Jkw
         +1Xg==
X-Forwarded-Encrypted: i=1; AHgh+Rqmp46lsTmVpk79OAIt4WvYiR0dMn7X49J98OxTmZChu7TQLx+s1SUELeYLGs4QnJ9AAxD11n8nPfEaQkM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyObuP3Rs6XfV+ZxajKXauCOG/2AkIg/YT4q8+mbHnmhvPIuobY
	A7Py7NUQixgR+3x7s3oPIcCq5YId30nRLgsbUKjg7LnGRv0lpJ12232R/jOFP6DGU1a+ODYGmWr
	jCOHKq4F1J0LNH+gZ1JEg6Q6fJPVoJwP7976hZ2phWWppFMAk5zB5qeKXaMaoIbG+eICp
X-Gm-Gg: AfdE7ck7UNJbKj2OV7iR4qKNeqO6XlplUN24IErRY0eG44/O9mEKHg7OcFtCdZrpcOy
	lAm9lQUpF6prQ6GzcYjPUUyL454UK4v1bSIj4IH8OQMa4t1OkbXMF1/5lmOM7qh0WgUPGlLWDDg
	VMv4/5F8yM6e4Up00td6J846BAc+NiaKXR6vuJ/M+KCnIl2jqtV5PmSsJQjODCsCWEJtqdukC9V
	aN5i637s10OQQouiCGJfVCjwhEJQ8FjcivOoD8GbLCXBvE1HALMOgoHELU3RAG8KmJAAvE/AwTM
	O/udlsktNQcVSmWpkMw/nqrjfJt86z/mY5QFcXpYQQCJNHdjvu88m+4ywXG9tLY3JkxPOcXlycL
	35V+F+HFVsGrNY16Ut2qsvCPUSWLBqg==
X-Received: by 2002:a05:622a:190c:b0:516:5019:d27f with SMTP id d75a77b69052e-51fbf8bb3b7mr165219811cf.18.1784539537869;
        Mon, 20 Jul 2026 02:25:37 -0700 (PDT)
X-Received: by 2002:a05:622a:190c:b0:516:5019:d27f with SMTP id d75a77b69052e-51fbf8bb3b7mr165219341cf.18.1784539537361;
        Mon, 20 Jul 2026 02:25:37 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:65fa:60cb:c205:d511])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4955de88951sm62228205e9.3.2026.07.20.02.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 02:25:36 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 11:24:51 +0200
Subject: [PATCH 4/8] net: bcmgenet: use platform_device_set_fwnode()
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
Message-Id: <20260720-pdev-set-fwnode-instead-of-of-node-v1-4-2dee93f42c54@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=999;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=e/KidaL4wAeLOYzpEup79QBE4YB3GUvthnfa0Ew8sdk=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqXel7DPUjBAYpcf7niyv0je5wGjcw6b2KYr8sT
 XuTSwpcWaWJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCal3pewAKCRAFnS7L/zaE
 w0tjD/43qo3abkR30JWubh7GVIOZEwMy6gwIxxGEFh+64tlAWfcLqoTyNpfDWe9lZeBbZ1iltc4
 zfcV7M5oRVFE0KyZ1Yiwjib/cZWQi7vhxVQ0bePCjlyvllspMWyUfr2/SK5xFC+j0/xnhBPSZlR
 9+viBjtr7I4qZYIhZm0nDKPPboq2KqPcCQVdb2n0a1lqMrj56FTzTZy8qRlBH6opmKTsBPUpdah
 YLEWRScnyMfdm23dhcA1j3g0+OXu36onH8sy1uxZ8HS56kcQKURCK6m18b9e2VwiDIk5akIlAKH
 V/USnZ6vRpNl9XMir6bi1QFnNSAVYa3aSWMKPaJxEBtdaRbfDNNHlw5qYfeLonJF9XAEw0JQC/b
 iMMQCIj4eH4u1UrMdLCmzYF72Xw2Scjcnet4fqyBDvs2XgopXv3XXF9gVioCPtg47IwWemXcXjE
 23HIm9UdkNPKhC0YIr+CQwopylJDyKj9XiX62XW3GlesyySsJMBx9wxHwjPr0TesTOZp9LJGAMX
 kWuqevBo1tEoLu92X/0LJpXlKqOFqSsW/M3tCXsvF0fRgu8DvU2Kyyl8AoD1vJsyeN8EGBj3uiN
 KP5T0cPG/maBIKrbh5yP8+K9raSK9x3Zyxd32E+i9tJZK1Bm3Dj8ahaq+83dmJNnSW5e/7yRqQs
 rTNxmSOpcUPV51Q==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEwNCBTYWx0ZWRfXzG7tpIDX33g4
 vMH+4ETv6cOcOiIJzGALxTweRV4tTPq24ybeAXd0NAuQktaQJ1RAWykv4AMNZ7oHcRB7CCMksrJ
 Htb+ccYTe7Jb9IBbkWal+ZgMR32d280=
X-Proofpoint-GUID: sqTNPkLF9sD1SvCQhTwY3G7VFdg5HdrD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEwNCBTYWx0ZWRfX6loSnHo27tVt
 GOiy96GVqLvcXAVfHYgp+NQQBN7GiDkAiYT3jWxUP4z9d1pzf7mD33OZ8GYmWhzB2MiC5u+BDZP
 Ul3WlxszMd4YRKegQQLSxBxN3pZT4wVdn7oW9sSEICGjCZdGlTsMvZ77GTW1diBB91kNNu0BTXW
 1NibJieloptiL+h0fGQXcjp02gghVbpEf4oauOCEX3z/nX9Gsu0ui7khLXlmeh7I4LWcrfmkeZK
 AlRVKnK1O14L/OTsY0CRAAC65frTJdiJ+hVyfXRhAJhP9yG4p8fg+e8Pj6ZDm/cfBDj0M2ZANxW
 EHXv2UY/Xk4i+lZPxAtq3aNfK4qo+JxlRzApbjAQOWoGZ1uwDBPFhrJDHtHza4NMPD5qzKsYQnf
 lbzahC4QyiX1gqqOFv79ZgVWV/ffx1nspYHLyGgQ1GCk5SpsDrxSvP+cwrRfEyJXcHbnQ02QkwC
 h50Q4buZuIy7ywO2Fqw==
X-Authority-Analysis: v=2.4 cv=CpiPtH4D c=1 sm=1 tr=0 ts=6a5de992 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=cykPYtnZiOmdoJCT1yAA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: sqTNPkLF9sD1SvCQhTwY3G7VFdg5HdrD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200104

Prefer the higher-level platform_device_set_fwnode() over the
OF-specific platform_device_set_of_node() for dynamically allocated
platform devices.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/net/ethernet/broadcom/genet/bcmmii.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 0f0dbabfaabbce3469de79af91d7731b8476709f..6f471723bd53f454e4b0de1716977b4382013429 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -492,7 +492,8 @@ static int bcmgenet_mii_register(struct bcmgenet_priv *priv)
 	ppdev->dev.parent = &pdev->dev;
 
 	if (dn)
-		platform_device_set_of_node(ppdev, bcmgenet_mii_of_find_mdio(priv));
+		platform_device_set_fwnode(ppdev,
+					   of_fwnode_handle(bcmgenet_mii_of_find_mdio(priv)));
 	else
 		ppd.phy_mask = ~0;
 

-- 
2.47.3


