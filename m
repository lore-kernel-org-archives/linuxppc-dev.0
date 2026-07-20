Return-Path: <linuxppc-dev+bounces-24450-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E54CC44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 09:25:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3Zqv6fN3z2yY0;
	Mon, 20 Jul 2026 19:25:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784539531;
	cv=none; b=aAmgpYfC9AhyFixJWIEExmH3eHX/Bxwtc8B6QRbJ/XV4l06HiT1E9f0iZCu6+IgY6eio9W+XVwhy7g8WfrVclNv3VfQYScFQYXfS6PQFY4H5M/U9gI40zUQCKQX6YvybQFwKcMk0vb1+3/MpknAtWQpnNJtTpSnJ5NuGUglvqXZAjcxIuHmrUAGO+7GMudIeN3wJploDrIAxUNzTXP3B7bkI/a9HbNKxfRlT9SfE+kZd9pRpvbC7mTdr0zIM0uVhE1fh4pFcn0UBAOW+EO5wL/6b50ndXX6F+Z178hHfnhQD9/f3mHA6XUVMg8Puyry/YNW1+2ZIn4yktwYjt4ULLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784539531; c=relaxed/relaxed;
	bh=AI+EfZ7yUUjRJ/yYVPoEI2N0HcqWmjq7EqyYmjIn1lw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IQNg6JR+6x6EAun0wMAlU+aNuvT5QJ0U8KkVlUh9GbYVJgGAfbvu+B9T9EmMekFp6lOjscGxaSV7MBZV3U49CngJYbPU75xhxgVosQH0wzxJi/aTwaXl0iRyzdbAzcdZOap/+ytAnFZS9ug7cLiiL8br0AmKAaMgmol7lbjW7SLQ0IeNihTDydN2qRBxfTJMw730RuVYzjlLUBNKA9010H3jVqI1UIB12e9Hx11xUKF22x8Hd8kNCjMevM42P1m+is0FeWK4pusi37MwhsSCQ1+71fBXW+dmxAhVih26JQ5duJhNoTwM0GMEncmeT7hnRK3JQQXV2oh+RKPV3oX+pA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fJtWX/f4; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=c8Zibudf; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fJtWX/f4;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=c8Zibudf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3Zqv157Gz2xm3
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 19:25:30 +1000 (AEST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K97YYQ1653514
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 09:25:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AI+EfZ7yUUjRJ/yYVPoEI2N0HcqWmjq7EqyYmjIn1lw=; b=fJtWX/f4Pep3nCDv
	t0l7qxrd7PP/pB2HZ9HkVtp29x85Der5J18aJuKzkok6pooxZYFA8Lm6LDHDCGZZ
	x+giSv7G8qFthdMi5GIv+8a8nKxnwzx5PpVRYDfvJfbh/yRbqr1r+onEP6AKMmc9
	xEFPtzMvhnGbchF6++xB8cDcp0xiSvd+d9maFoHbBycn1acsNhvtZ/IBa1J7MMj8
	w0lBhF6VlFeiOho+nKC9pmVYk4vXEWJCzSyFE7xCliPCyPUksUX4eFpDWGDmsmFT
	ZD0BB3+DYaqd3N1K1UqlOQ7Ohqg505rr5uvVmvirKZ6tOoDnPlAfLYBjl4bm533x
	EFD/Ww==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhgs502fk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 09:25:29 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51a87ef9713so47534621cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 02:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784539528; x=1785144328; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AI+EfZ7yUUjRJ/yYVPoEI2N0HcqWmjq7EqyYmjIn1lw=;
        b=c8ZibudfuevXYs2qRJzKfJcDa6NP+fWgXbbbOJ3qoMMgb9Mj7QSha4eoJh0VKTpMdu
         93leCNEYzOJxltYLjMAk7MJj46HP5tf0Oa59Toax9SoH+3v0JkW4bSEBIovVmrJCGgEZ
         IVfVoEXQOhxdtZlEIrdX8cPOX/9vj4Tq3GmytY3Nj+c4nc4lGp+xV+JaQqp9EKhbBF7L
         4kalLo8qO02eNpiyE7GYnD58lLw/Fs3t9gLNP9NMzmVU8BZhs76dnAGoEGvIlI0NLO9f
         SmeiKSujmHYPCpwO/oAPJNQOOnKqqKqaKdZQAtHA/VMA7W1S2tpjN3L30FJVmg0sdO4B
         gXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784539528; x=1785144328;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AI+EfZ7yUUjRJ/yYVPoEI2N0HcqWmjq7EqyYmjIn1lw=;
        b=hsg/jlQpan6jGpN4SkxGppN7f04HizewLENjCjdQ4VcZPJEqsbFDyigCxRKKUjNSF1
         bk79nz0I7eVA3UlZqSuoNL9sh52TBEQM+aJSUw4iQNVuDZLcKwAOMCBbXLhuR/gOvy+4
         N2lCdVr09SarqySUudZts2ZTa6Y+VihhXmVvd0pPQ4VcFMhcFwe77zHJZ12Ja2kdWQzs
         0WtSi8JWIhTffMsoJDtIKfEvSlVdrvTOiM5XMPGzpRh6WArc/rwEkrTV/dVoCQtLiDFf
         NM1yK8nijUvosU61KBGp50pGqviIfEK/LmxK9LG1RLDrxtNUCzmfuneqYIquNcr7fWCo
         LGiA==
X-Forwarded-Encrypted: i=1; AHgh+RqtZuDZpoc4Aaiz7CbwOcfb3EJDGloQxOk7q8m344tu+gYcBgfmH2uwx3jni4iXq7+giUQjMQic1EnDnIk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwHnnhGsYhEpsRn5bUkQ/RCAc0ASb4jHwutkTC78zUmh1uQ5p7s
	5Qq72PgPi222k1rB/9QHlOSpF9ovTUQAcnv7drFWuWjjbo0tTVpWv+Ues+jL+grzaVTgNOu0+np
	66T7Ar5rYwkThrfWUbFZ5O6QmNLVKRMobxiIj2XU2GPIu7LQqOPn6OBrAK2NCI7Fg2+zW
X-Gm-Gg: AfdE7cmZnB6vpdrkBMkTxATMDdLIKgSyWro8Vs8vIllfKH46XzK7eMQz/mPFCkm4WL/
	EDDZOEIRDFu0P0lYNYcGtHpT5omXYkYUYL0v+LK13ABvanFCuR2ofpKF6uvSZ24PWS+uSTz3djE
	HEE+IKxpEyyuDV05j5KSjVp+Rpqx7RYtUM+rAe0dI3MO3UXDoBqzx/v9h3dxLMCH1m1oVdi0ZYs
	C86PlRMQvof1jfPmCVl2eSuuadmzMlG67BsCwwBSxuAZACLGSC3OdoY4n7TmNWQIr+VhUDWBTNC
	udcq4ML8070F5Y5AaX6ZY9806VEEToDq9tjyQnxc7NNYnp5zI/O/4FR8sKlD17Elxl/BZat7FPd
	Hxlu20lIs4BCqNiQ13PBAMZSxQLlBXA==
X-Received: by 2002:ac8:5850:0:b0:51c:753:4679 with SMTP id d75a77b69052e-51fc129313amr171953441cf.28.1784539528183;
        Mon, 20 Jul 2026 02:25:28 -0700 (PDT)
X-Received: by 2002:ac8:5850:0:b0:51c:753:4679 with SMTP id d75a77b69052e-51fc129313amr171953301cf.28.1784539527779;
        Mon, 20 Jul 2026 02:25:27 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:65fa:60cb:c205:d511])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4955de88951sm62228205e9.3.2026.07.20.02.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 02:25:26 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 11:24:48 +0200
Subject: [PATCH 1/8] powerpc/powermac: use platform_device_set_fwnode()
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
Message-Id: <20260720-pdev-set-fwnode-instead-of-of-node-v1-1-2dee93f42c54@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1029;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=sj3G1vA76GGMvTxTrnIke6x7OVx8A1wtoaHoSynVfU0=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqXel4ao2b6PC8YcfYlmQvKjVNTYAN1ewTrHVv4
 VS/GA/4xYaJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCal3peAAKCRAFnS7L/zaE
 w3NgD/9l2EbcigcAHxvPVoK36otzZzzZAcLLE1rOxvRGlo6hSfTfqwyjacSMxamoCAzMy7RJjY4
 O1Q9Ez1UjISjLIv7zC2yWIvgwDNXQoqYzZNNPk0nE+DkNW5mh9IYSXJXoSWusyc33i9/0/0RHEG
 dHMiRRQ1Mrwm399I4y0GsSUsuCaB4vaNtyu724qEMD82zpNS2bhn37rTUp0ySxFBdnrFYjbHDh2
 ihyPtPJ2bV48l6uhV1ZWpQbnsiWKLrv3jq2ZvSLH2nwSMYEeor9SRF8DE9Ox/CMBlHs+x4BHcAO
 FOc9zwL/KMXVNgGr/v/x5tfU2uoYCOhSv0VbVg5tztPlS0Nytl8m7TbbYS338vEYXe9DeA+gXoV
 OlfG8Gh+v0cTkDkG7mjFAJ3cBxadQxInBHxvd2/ehlw/G7xlFJcxGEK9YPdqcV0X27XKvZdWAhC
 rLW9Hgvx2nHvvrwx5BwFbRBMyOGBIfmoyzp3OT8dkY9Af0TC2TTM7jQLdBo5pLVwhkEdvVdoR5G
 iizZ+VtdCoawhMt4eV6NqRz8JGdSfq5WVQiiPbPD4zkDOC+zTiE4k8YwxWGVkBs0DwhL61wlCWg
 3x6Oek9Hdyi64mhLonLyra44rbLzUixYPetQ31t2fI8SGC4jqzgPC2nEKFZ9JEaogvOH+qz+7l5
 cGgc2lbHIuybUhA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEwNCBTYWx0ZWRfX0ZXC85ZCuY6f
 zEbDKboN/+GDZeSRy4hikz0PAn1lySksksCqonpV0BT8CmCare2rJ5q1BwMpfDYuv3JFnOreL3y
 EGWAhZuBUn1WjWUfXlXRn+5/zz2pFiU=
X-Proofpoint-GUID: T5sLX552KQAHqdz1CzsfL1QrGWaQFJNr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEwNCBTYWx0ZWRfX8uLdg59nX+wX
 QhvSngJCQLRd0Q9vlTRF+I1P0rFBt0Asope5W5Lr+VEI0Y0aY7oG5SCIy1QL9JkwezoWcVTlI7w
 46CPHm30GOuTe/w0tqJ0+If75xGY71I/XMeDOJxrOWdsewNiPZsYFpmLaVVAb+JmqMyx+ZjrSSH
 dcwWtMd8ut/ZiWduFX5jZcnRxkHrXxkPWc1vGUyjMyKZrwgh+wPQ5IzxOF2CcSSCdG4tupMUMbg
 T+Uj2w9AWlRs8Xm4V1jmMtLqlTaGJQIGz7KvJEPD8HnHMlHjxbKtIuH22C4/WIjV2B9uGWsqfCL
 oCOhcJj7JNakS1myG4pbYKF5ZlyROr+dlwb1uBi0GiBKGQ7VxVDo33bXLGAP6x49+UcZdhaZp8D
 vjhnH8KUr2M30yPvDixCuSrW5mTC4jhZXzL6sNH9Sr6gBAzuS5h5O4lfOolW+kiDcNLD6Zvg0EA
 9qkWPl6ZtWlxHFMSGoQ==
X-Authority-Analysis: v=2.4 cv=CpiPtH4D c=1 sm=1 tr=0 ts=6a5de989 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=xOXlHDOaurapFSMEQ2YA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: T5sLX552KQAHqdz1CzsfL1QrGWaQFJNr
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
 arch/powerpc/platforms/powermac/low_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
index a175a32a222bab4cc7400f6ab6071f5630db2cb8..eda35534cfd72e828616f27b5f8319189d68285e 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -1471,7 +1471,7 @@ static int __init pmac_i2c_create_platform_devices(void)
 		if (bus->platform_dev == NULL)
 			return -ENOMEM;
 		bus->platform_dev->dev.platform_data = bus;
-		platform_device_set_of_node(bus->platform_dev, bus->busnode);
+		platform_device_set_fwnode(bus->platform_dev, of_fwnode_handle(bus->busnode));
 		platform_device_add(bus->platform_dev);
 	}
 

-- 
2.47.3


