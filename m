Return-Path: <linuxppc-dev+bounces-23071-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA3EC43602
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 09:45:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gphGV6XDHz2yZZ;
	Mon, 29 Jun 2026 19:45:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782726322;
	cv=none; b=aVFcFZhNMkXjNd6/qXLqh0CFBMnqZ0Opfs8scu0415O13rS6zhppnisiIxbo45yO9COwy2pexfyhzf/gegAIahwjQiteltxhaj5D+rZ/S4szGj16Y4r08HKN9PWZv2shraOoZmmGmml5fmURQG1Ao6G8Q52hyhNhJjkjWBRbw8cBOwiLJ0lv6pZZ1DXJwmWSa4edJ1XSkF6GLCeg2JE0JPZdnIwk0c8kz1v/wx0CZ8A8T31T9SPzeKaxnyvfCuVQiwUvmjg8R/MhdroF4bFc3Iq4PQuoBIXTpCWig4bts1+WjP3gC7WQwn4TwhsWxwZJOXrhyudgLSpC5P+5zxMCTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782726322; c=relaxed/relaxed;
	bh=/bwPG08eA+O+tY0emjmLQ5tYr9hdOkJorHPeq+vKX9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MW/bMZGn5Vo7uN7tQ+iLDCUzpbbAoBXhzo600d87+58on092b3CEiCNFIj00Xqh7pBAvP94+K4BGulIjlaivwr/l1sPsPl0vU47w68FTpX/88vRQY5NLyEui/td7h3hVJ3ezHdLu99SlVtmtvxD1mfLsGZwGzv15Q4llHKxZf0t42PimxmSWYs2ENhLB9gdwWTA4Q3NV/q+VBCFYHIz03vxDqUTnMP0EtRcp5V/lPB8cAj1HMXYfc0NGLv+eMlK/p1s2wDJv0K44nn1E23R3QrpzGU/AwK8V59j3Wvb7/obsdU8T7OHb6a3e/ZAoyXyJUI8BJLEFRh6B9aCXXJf2SQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cejr7DNW; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fxHZqSCq; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cejr7DNW;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fxHZqSCq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gphGV0sM7z2yZ8
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 19:45:21 +1000 (AEST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6r1ph2076291
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 09:13:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/bwPG08eA+O+tY0emjmLQ5tYr9hdOkJorHPeq+vKX9o=; b=cejr7DNWhZEH0b4b
	znkSo96hIsO6dDYQWfJ8576Gf7MAwEr/pqbsotQIRB8AFrf4Mxh9BT8gkaAkdUD5
	dpvW+UEbT0ACo//EVQ3r6K1qH5JQZfEcEXBTHzPGKUMxO/12ItZmXxDEP2Vc1wM0
	vkdRhJlb3sbgETbu+C7irkyQehfu/fQgz9AzLdbU/rwcY0r8FnAuf+yWmzmMHXhT
	Fd1yVRYlEkw+OrGBVfRZXEg/DVE+38M4YVZ6Rp7k1FfsFqxwcxVHEtTwn3cffnyx
	PK6GfFuDR97gVlODkbnBdzMUTK0oudEiqK528VXPciKcOdMa5ndkl62VTdcv5iou
	gaKnsA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kp7gkqu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 09:13:46 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-91931144870so666783885a.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 02:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782724425; x=1783329225; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/bwPG08eA+O+tY0emjmLQ5tYr9hdOkJorHPeq+vKX9o=;
        b=fxHZqSCq3MybWKYd6rMZ7ErjwdxmMPF4TWvrm7dlIoT+nyRNhC3m0yPPDQntuPD4GH
         kVM9lJxz04GNCy5kHnOEeyH6J3rfRrdtckw+e0sUGMlY5rZiencGg0saqV22lAtUtZSK
         mOoL1clTVUXVQvccITSRvKqz1GK1zSFqRtKhb+sho4XJbeVdjFFxgQO0BzratzJmwY9N
         WWLXcEcPxtZe51wrjlC2yMtSFPoqv0yHRPYVLITC2/UCwC8QbMe4xb8vL8ogoRSjobt5
         YAub2QCU3iAs9MCmiUiRAmTT3p6fdopP+YWPepBZLT/VV0S3NVDcZ8QVqyR4HNdjJkvA
         Bmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782724425; x=1783329225;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/bwPG08eA+O+tY0emjmLQ5tYr9hdOkJorHPeq+vKX9o=;
        b=mqYGvH473lt1P4/vtB9JIf1TLTByGh4ocbmv8VTQRyWDXrms3GcVibqECORpfelKbV
         bN4t/aP/CSdynIlnlE/JAcMp0wJGUdhtCYY0TwCQeVjh7B8JS6rN/cjOq6Ba3EqN/9YZ
         pP3noEGqtIfjBC3qJFhJZBz7qioF0Vtf/MbuMhSDsyie5Whi9Lhs0SkrDFh0OPl9NE71
         LrgTyYgcJZVnWovghafAEuDBsmRHdF4Ua/PlX6jEc4/jmlU5qoh+lQALU4WY33fpcPiu
         CkN05hO9jVjecp6mcPOUkW8OnbGBx5CAYg89jpVbclyYXLmDNN/J4piYWAS6yMxwkrNT
         9W2Q==
X-Forwarded-Encrypted: i=1; AFNElJ//5/ks2PLn2HA+LMqEJWv30NsK60FK/ITkdW1ktJLAiNHlIHjoCYvqAuMmn/5sdyNMexpCZD6/XCc9a8Q=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxGYG9WGXxf+/3xaANBtejVrpzFF8XTAxL+uWyfBBFJgWvGMpZh
	sS/JjhsgKNx39jEhhW2fCbp2HHS7RIqBSJoK6LK2wmoZ5hbQgqsM6GCrWezGe/LlDwM7Qo5gzaG
	tCSr/1yXOwjU6AKAo35Pq9Tzu4eh7mierk9S98bxdBhtkNi2n6nchn2w7xiRQbDexdwAI
X-Gm-Gg: AfdE7cmHe0LNngkYyo2jpfscg3ds4UTQpsEjj4o2YFC/GtKX+CcVsnNsCF1fCgBGnEh
	bKmZ7gD5sASeNR04DM3bh6yckhPS9JhyhG2q3a8Z4nuvKwl7CNcxDFkPJ+GURP3FiuDIzubLUyZ
	Y+hoR6sBO5Mv4kKl8Aj3WgA90BEb0Xk1MO1l8O8Q9mi25sYGEGG6Oc4XhI0iBXVBpwchSzvOuIU
	BmukQeSLWZbxlE3UMuXqKe1Oy7HJnGYjX+/uG/PwIIe4z/8uskv1/Q3NNTsY5y/7IzXoM9PCq2c
	xFKc6V5d1nqRAXHe6wfwfe6jE2YsHb5ILM2a5ltg9jIii9MVAEYZ8cUI7fcha0b1px03rRoreKr
	dG5sWJycBzyUYF8ctiHsVCaV+Y4HAYwSlFIZuX86U
X-Received: by 2002:a05:620a:4142:b0:92e:4927:2002 with SMTP id af79cd13be357-92e492736dbmr624554585a.39.1782724424990;
        Mon, 29 Jun 2026 02:13:44 -0700 (PDT)
X-Received: by 2002:a05:620a:4142:b0:92e:4927:2002 with SMTP id af79cd13be357-92e492736dbmr624546485a.39.1782724424493;
        Mon, 29 Jun 2026 02:13:44 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-470f55acda0sm20109240f8f.23.2026.06.29.02.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:13:43 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:12:38 +0200
Subject: [PATCH v2 15/19] platform/surface: gpe: use
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
Message-Id: <20260629-pdev-fwnode-ref-v2-15-8abe2513f96e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=948;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=y0PJDyn5BtOol8KVSo5zceqlnjltVLUQGrxeuNwB+wE=;
 b=kA0DAAoBBZ0uy/82hMMByyZiAGpCNxPIX7sO2Fb0OtIcCoatdP5jodxjCxsQU/1YqFPwbJedd
 okCMwQAAQoAHRYhBJHlEy3ltUYde6Jl/AWdLsv/NoTDBQJqQjcTAAoJEAWdLsv/NoTDHfEP/10Z
 21j+qEaic68CLQuNBgdz4qIRaZIQyRi53HdUwXT8kM6isFULDu5pDNwbBcED/OoC7ALIIyXTpaF
 vEGkyDXAVbzZh5Fpx1BIslvGuXi2wklBdo6eTGN3vz78IUpeb4d6m4VLnRWlfT36IHUS6DT+1h3
 6FUzolZExDbTRa8eUKgTHsZueNoWqtMjRD/6q1ABfXaSpCv5DTIxIqYPnLe/GIZLGFRIV1ivNXX
 hHJYwFz+c9Mz6JzWVJMLuE+fp/iaLBprk8wKW6WLOydKvpF38shDpUBrmdiQsye38mT+aSlL1sE
 Wfr0pqU/u4DS00d6i696v5TbTwWv8mMfteA9JBoEWjLN43gkhGSiRMceHcM27gfGmh4eklHUhni
 BnpeGsmGkYrGhdToZhNobNNjt8LhsrwfY9GQJGpctK8hCY1Eq4RQcHJTuIBLCGFU9PB42Jw7x4K
 XUL4XeOH6TyhaaGfNIVyz/ECTSBWXCOd5Ar0s92Twtl6rjLacXc9B3VPQBabDnNvh9UKshVwjaZ
 kugbHG30Vv/wx4wJXw//jwQ+EdJsZqJkqBZjyrmFdB2yL/M/0/DXU4l9FGFfciBSZGNqtCHNKzc
 d3ts2rLnwq6iYVMApbO94BjIvXf7W4Rpp3GbYF3W/H5y8m4f20s7uAqcwXkMY2RAz16tHXgSG1L
 WCwgE
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX42j6pjpPJgej
 ZY4Bhh9ZeI907Yc0xMCxVDrsi44JFeGVEFRALgp5lGVbfRM6uZAnoVBx6E6+MxM/nEC8Hb+kzmI
 zMnzKZNGaDMD9JvMR2DRsYIQYJjgf64=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfXxTalwDkWY+ac
 tJNzOJRPjcxfMN4mxj5eJ3F/QVe0YkNEdlmnQ3Fy4RfjxqiUv6vmt/WAtz/wE5IV7/tfLbzghjQ
 sy0/SLoeZHS7IufxrfAYHDZ3OGNq7GaSBvhhuDsi6rKoNbNfyX2U5KXKiK8wMV/cXsSsZQzXHDg
 4yulcAK3xdC5+8yjdjYVxBJZdYcTbfWLEdSGH67LIwLYXrDjl9VfG0qNI3XShKCaZ/ybhklEJi0
 3GZ7S8NJUgom9yzVSczBLSZ+GQc65rNekdGiAgmvX/EXgOedQn7FVjJQLdS+4UblZomQ3hFSLHj
 XO2gBOw53GUyEZPMvMqdXEEL6VUTuM+eOluEPtjOc+qwYQqT2JlKeUHjxCpbR6JeIu+FsO0axOv
 gSCX6cLl/vR0dbr8LEHwOpNhNxdEtKCs0Tn3XY1ClYaPK7kQM3yXFnKgbfUJPh/ME3FTiGv3oA2
 jn0FNcJM3WFKWZOtAGQ==
X-Proofpoint-ORIG-GUID: BMoag4hIiAGCAjsyLRGamAMi7uiQR3Pa
X-Authority-Analysis: v=2.4 cv=MZJcfZ/f c=1 sm=1 tr=0 ts=6a42374a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=PjYnKYjuuXkzxcC25kYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: BMoag4hIiAGCAjsyLRGamAMi7uiQR3Pa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290074

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the firmware node for dynamically allocated
platform devices with the provided helper.

Acked-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
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


