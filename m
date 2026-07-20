Return-Path: <linuxppc-dev+bounces-24457-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99C5C44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 09:26:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3ZrN4WBlz2xlZ;
	Mon, 20 Jul 2026 19:25:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784539556;
	cv=none; b=f961axuXJ90ZlBYaPK6c3Mb35Uhv2N6+fFCcboaU/LkNdJMuZEr6rAUwQDXlphJ/C+fINem3mEZLgjxT4do8oIMS0ABqiB+N3QHnxfS5svcSzo6DllxlvqIRAuOl8BmpqC27nTs7d5kzBQQTuseIzGE5Ra9pFMtJwqibLaao7TVDhJEkiecs9tQT6resFw5PhySeibyrK15UhqOVdAqliisDtWbcs2VX+gaHz7RregAEzFfxmCoHThDpWT4DSZ+8jUDal8HWfuONonoAix8x8c7gJMhnjcVqSE8HxwvSN9QK42bXTgmS46nDWYPWv1XIgMwA5YMbpmE8+ErdgbKnHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784539556; c=relaxed/relaxed;
	bh=LRiqxWscnzoXzK5RzWgNrb1z34B4tTlhuTiV6c1388Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Na3r+736XNqxXuTScWqWqXG/uL0DpQq1gMGJSDNypOYTSynqf+TpzaqoyUDkyKcUc2uqrzZB1f2M1ENIJjb2VyH9C6YZ9UCOv/o6Xwn5xGi/FEDX+stbyO14UQ1x7QDYy4W1e2+aNEPxAxUPSi21lYGjs1YJsEWOjvIUM+y3oTNuC8QCcVTI5YDmk75HTsT3rgwSXfvBPhJ+FDASZcxkT5XXDs+qcGK8EM6YIqvvp8pKi3m+UJ6b0HtR6Xup3132V8Nyd+4nARRQu1SjnXmjStmCCXQebNJdD5pJbyJVU6G1nk3Of28KkgrVdToHMTJMZ3t/B0/7BHFcSdhQA1xdjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hQU8ohY7; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DND7qxWU; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hQU8ohY7;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DND7qxWU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3ZrN0NNyz2yYY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 19:25:55 +1000 (AEST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K97YX41653518
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 09:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LRiqxWscnzoXzK5RzWgNrb1z34B4tTlhuTiV6c1388Y=; b=hQU8ohY7JoqMaw2o
	gJQ8ERonvZCbG53rd6f9Hj6Cy0YgpXa0kbaTI5/QqqOon0C02V4LNJ2+EsdouW+d
	TTdw5/a4an0Mxixvb4u7sUgDtxyyaoLg4OGI+V4czR5cPkZVb0VZK2oZ8NKRrKYN
	HaV/bbPfTsJmJJOWjOy0oW6uywW1yCdiBV3uKsuJMdUsS5/OwiAbrrLMkLjl8pCw
	6PkjRX/plQV5ge+glDz88N4CyiChe2nKkBfMigG7FqSutZKY+CKqclYBBWtNiH3n
	aIzeYqIjbaH+v1wG+u5THy8VWCAsa18Pi8ZjeTQ4HFBwVptu8nrxT1cEE4jW/2xB
	ba8Jjw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhgs502j6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 09:25:54 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c1d30035dso127075311cf.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 02:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784539553; x=1785144353; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LRiqxWscnzoXzK5RzWgNrb1z34B4tTlhuTiV6c1388Y=;
        b=DND7qxWUQAs/WvB4sIu2OCbt6B87tfc1MAevwp+ZrEqy8mLH0SMov8HugYGzWPmM9V
         RR6awyOUjgLS3wnh/91KzJDZGUKyLZPnGZ8YKvCYoZtLOGx1OUMYRkqDxZU1U68mduzo
         s+ynwMYBvEVvHLE1PTl2vfGYiqoQdqrE/aWOWsvyMHhcpm90u7D7jQ9RZD4GruzmawSn
         BIsGiPU2oTJMU52TeS2vMyfg0yHG80Nn2d5xRx8MYxd850qu5j4c5/EqkdzCwxYV9EN1
         wso0VeSXMVi5UwVAb6BUZfMoDJRuQ5jNqV8tVowgFO4MPEA9Q3CWsjn/j8UlYzXocQgM
         BtHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784539553; x=1785144353;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LRiqxWscnzoXzK5RzWgNrb1z34B4tTlhuTiV6c1388Y=;
        b=L24G2kxCxB8+3sBndHfWgTuIZVwyYm1fv8+rbVvlYLEh4UHUSJY+9w2C9zBjYPaxhU
         DvMFoiInq9KuqiTnKOgMPPQIfNdc6QJ+p4Jo3weZlpJW45jiO5/cvKg8ZKAPRQS0KyBK
         kuZWtBSiF6Q53Faelkg7qAah97zGqca3NVaIv9rkGi5q51HZuT0+co0UE7Zq/f7YCj+C
         rfnKGAIgECpFqW6C5kvxygwuZN2X7vJBbeS9YGxo143MPYXi8+70Q3ANe7bUoJwtwfnV
         wrSsD3hTSNlhdanq2U6L6zNHAnFE9kup7eDHxVnBYA/j4Ay79IXdqRA5nk6IxWHSojW6
         fa1g==
X-Forwarded-Encrypted: i=1; AHgh+RoZO8l0zUuEcpaIp+QKpBmm1WeSaPVk70NzAB4BWZuN/uh6jOJeH/tdAL6KrrJveFbUR5WjTj6xj9WQvjE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyP7yL/v64W73zE1ajxFT7DpxdlJ4ub7R8U7qnqqxO/wOVrQWT2
	8QrTQpUsbYDMWPBRIFz4KMu9TZ6DAjPcOkxQuNHKm1B6r0zK1iQLp4SOMD2q9Ka8lszxA3oabfC
	1Rwl1YW7V2cTHEuvJostEHypq39Pt+yNV13IvPRtRQH2dbwsjYgFG608LEJKz815X3GSQ
X-Gm-Gg: AfdE7clQuK+EVUTKfVKOcR/8/zyV7LqiuzeJjM4tXCMt2anUaJ6iLJOrC8YUCLDfMN9
	1i6GLpRwLxgBzLBkaXSFt9eQ0vmEa7/PhnaQbMdjVHA8cH0prooJg9cWWD7j0IfWdIwpqXlUqZ+
	LK7QAzRMtN9N2tL+1npF7F2QhRCIPJXF76vOC2Tbd+zDW4/Zzt7JPHeXBQCl7zpxwzRt9GJqiJ7
	3L5di0wrtIcXfBwgDWkFTC+T1tdWrSIf5vi3GWrBnyMYTrS44yOa+NV3gachHzCeIEUyZQ6fIKe
	ZdeuIaN8D8FEtGkJXqrP1Eh9v57reHpP5mwZxf+ZccWVAVi/Jf4uluq2QKcrC3tSsERMzBg+gUb
	NsjIT8g+QEYYjm7wDbQseY+IHNlayHg==
X-Received: by 2002:ac8:7f83:0:b0:516:e062:1a83 with SMTP id d75a77b69052e-5213daa20eemr117920941cf.51.1784539553336;
        Mon, 20 Jul 2026 02:25:53 -0700 (PDT)
X-Received: by 2002:ac8:7f83:0:b0:516:e062:1a83 with SMTP id d75a77b69052e-5213daa20eemr117920471cf.51.1784539552960;
        Mon, 20 Jul 2026 02:25:52 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:65fa:60cb:c205:d511])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4955de88951sm62228205e9.3.2026.07.20.02.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 02:25:52 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 11:24:55 +0200
Subject: [PATCH 8/8] slimbus: qcom-ngd-ctrl: use
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
Message-Id: <20260720-pdev-set-fwnode-instead-of-of-node-v1-8-2dee93f42c54@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=900;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=5dZucFiY5F1RZ51PQHBmBTY1Q9tlwcM2jWxPuS3OYck=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqXemASNLxq4W2lq91kA9NcZIXQVZtNYnprewvw
 3yHlCsy3VqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCal3pgAAKCRAFnS7L/zaE
 w2uCD/wOU3cBVw4EUJf0UYoXTg1HPMi8P/ZsqqsWmYAwjo7fxHcTqJbrn0eiqRL4DGI4WMyvG60
 V+0SsJlynCdNE7f5EUlwizOq84HOSgkOFhWcy1qO9QHvA5ZUn3pD4p5P/apWnvlfSjMrCgfW6Cv
 j3f/kuCfwhE3zvoQiwbJKsw3Z5I4ZvzyAAKpuw1L2UnIz0c4PF3F3aM8KSrOJAkVj5uvCqWv1ec
 B/AYzpNDdlNiIKEr5nlz5onmZgVYEc488RYdR8D6I/WNggYPzyNFLoESaH43Vxxig+CyAwrsjzZ
 o8d6pZtIyZAaJbH+7hGLtVAdr8JNHyKtv2MeIkWDsOK5t4odmeepq+uGt4Z+wLL5txrMInQNa9i
 CpwMS1b5MsZ2Zzub7p1c+hjtTrFLAtSCsLnDpuZeM0kspndYPXH+9aJ1ikuDaIY8rYYY45PmfVl
 5IPBo0aXvFJ1cF+N5N/gFPL8eHrOSWBGQ4E+1GkdbYVljaIC1z2a0evNxWVYWUlYGAIygMAktf6
 EdLDOWEg9v5RX8qWkht3mSA1zTTRpZyQ2jiUBxOl5UDbZBOGIvc4w71t3cYV6WAk3qn92NyUB+W
 zTJ+U4R83omht6v8g6JVuiBdRHrh1ZIIR1GZDI77FyHqG14uso7dcBQnQYs2bVz/YkOSo5imubp
 GZ+Ni2cPpMJ3VIw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEwNCBTYWx0ZWRfX1/Bsieig9xlT
 CUJOTHyB7OZKTWhJg2jsynRb9kSAR1BzSbTBjy84HTPIwdAf0lcW5zqJfqnmzJFdVIbFOQ1ySMh
 XzZ8kqMSv8PUNVFLT0WX629l/u2uxD4=
X-Proofpoint-GUID: uYmwpfnODZtzqE8WIPRHMAZ4c5upJPUH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEwNCBTYWx0ZWRfX6OCNyv8yIEeR
 g58uufaBV5N58NR/gwru3iwLsvChTLQ1nXt+cWuh8VuMs11SEAwH5Gby0Jzsxfc9B3EgF+kwWOv
 ncQhzHC0fUPteKNZtqvhMkIHApgL7SfTaWJXCTtQCX3NeDEc04Z+59EWGoSUmLXiqzxbY+nZ+pu
 eyhgNWcme9yDpWF+X40p+Xj0r4wgapnIssyHHMg90Zqj1LekUmSBPdmQQD97Hcoy22SOJpdSs19
 S+RADhHtZpm2UGnuWenLZ0aGTLVId+NWF8Pm2vEwrTmYFPpvk/+WZZFIdEtE1gXWMYToYY7mhtk
 qSAMTxmoreNl6/YrFIfJtiybYIMvtNv3B77hxPiFiFUEeBBLs6LLMnXLzMrhbuFZntYB2THZyJN
 RPB58J8SfhEs1vr1nLd/kzIyM2+WOqa0IvcCeZTNLPYsKQvRY443AdC+I8rXCXHTgc+BeMUaGTb
 7RKlIisXZz3Yk/2H4lA==
X-Authority-Analysis: v=2.4 cv=CpiPtH4D c=1 sm=1 tr=0 ts=6a5de9a2 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=Dy7njVIJoQnLZkscNskA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: uYmwpfnODZtzqE8WIPRHMAZ4c5upJPUH
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
 drivers/slimbus/qcom-ngd-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 934c44c5bc1a92fae98f52bccd12ed849379dca8..bf077f47c9ddd484c11f98b47d2d8d4daf78dcb7 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1538,7 +1538,7 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 			kfree(ngd);
 			return ret;
 		}
-		platform_device_set_of_node(ngd->pdev, node);
+		platform_device_set_fwnode(ngd->pdev, of_fwnode_handle(node));
 		ctrl->ngd = ngd;
 
 		ret = platform_device_add(ngd->pdev);

-- 
2.47.3


