Return-Path: <linuxppc-dev+bounces-23627-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E32C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 12:47:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gv3xW4yXsz3cYB;
	Mon, 06 Jul 2026 22:45:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783341951;
	cv=none; b=XovCbtrUzy7TzHMCmuIASiSlwohxb1zCsJ3PjbMdEzjjJ5l0IrsGnqV6GIOjMkC5d/2gBP7Xq5LgrtjluhQpl09EdOc1/vIW2fFreWZn2fw7UpjWV7iqZDa2V1pTR3Yla8iDYH/Qp2mNrUWv8TYT/uZrnSEyaqvLK2AnLY/gsl6PATpnK4PLlJX3B693Uch7oaO/1qsdEO3r+Gb5wNQMGS/vL5WIWz6IYv2IQNQ+HAxbWMbi/UJZUr33Aq5DAIZ7gApSy/0z0HwGQQh26rkmehyadoFwp772UNeVh1QSsaFJUswWI8vrhVKQ6zR8unm8KVzhe7LvlFnKr89lbj2CPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783341951; c=relaxed/relaxed;
	bh=yNrkEZw0kMBOjM8rF7wKaiZMIgE91+zaRIL+Y+aqlVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eZpgaXK7exh3twd09IudvEg+WnLB0/PgbQXEr93li3J4FGXzVpnrlbJTSx27c+nh8Zfb3mxR9evEQ4DI86lFhdtZHrY9ivlW2gvyayXQcedepfUhsv+0WvYxdSWniBwQMnByznLH5gbsHIYHbgjLR+zKeevWGK6yomDX7GKmEJkKyZrd9nYPp0xKNmuCyOw+7IZ1AXVnv4Ik3IbZ0NsR2UyfhfdpgzkQNPkEg7L6iCc/J9RD2Um0DmZQ7jaFr40cjR3WYh3jcSSH+K4Z+rCzXWiJqpsBFwP7AznL+PRIs5MQj7errjwY93vp8GWhYVEum/XYaO7hvauI3dUT6pf5nA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JFClRWJO; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XzdQ1Y+0; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JFClRWJO;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XzdQ1Y+0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gv3xV6bJdz3brB
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 22:45:50 +1000 (AEST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxTE5175044
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Jul 2026 12:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yNrkEZw0kMBOjM8rF7wKaiZMIgE91+zaRIL+Y+aqlVA=; b=JFClRWJO/YlvKXxt
	EPTan7Bb2wCcvP3ljtvtZjzTtxn9X/oJo2TEJ/HAmb+pQSKwSEV/Z0gNUsAg+HGp
	w6HgyrZUxnRD3q+7IWfDH5X62RGexHSNLTGzOUeq2dL2LoPSNk6QlXIjpQSF+Md5
	flrFBt6s2fKpQdszOkYGsCYuJQ5ovRF9aZdMY9Ly4KS9iJsfekBq0woUOh8k3cMV
	/RkmkqR4WcSAqZVtsYNjEqAk0a4iS4q0boV4t8SF1Q5kKlnTaNhLXh+6stEhQhqA
	eEHt6s2fdNhYEpAikHChcGddJF0Bgf8WoJVvm1/XIKUhDGVcw0Vt2kksgIYSgQFG
	fOJZIQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87rxs9bn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 12:45:48 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e695a3b28so387903285a.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 05:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783341948; x=1783946748; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yNrkEZw0kMBOjM8rF7wKaiZMIgE91+zaRIL+Y+aqlVA=;
        b=XzdQ1Y+0hXuQepwnx44xH0/U16qv53944vSI/ZhZnrQCVV9mI/Q+hA+XfoIFO1Mj9T
         cRa+Ms0N53iz9rn00AfrwIOAHX59k1VFVrdV2Oh9QWEtP/fgSXM6/HBoc3adEglnNnw2
         40MjmtdsRiCKAmkFwnq4saVIh3W1KL9BI57KbznxcWM40eLycgJLHaex3S3NBsrOnn0Y
         nzWu8LRIS1Ny6qDZv7RfZ3vqVs+frsfk97L9wbSQwvQkyc1eP8NMC8LPwDDpBr07jZpW
         viohalyRWJnKaTSQP2IQQpWwfxlpVie6kaVPQWyzPfXBcvTw6av2cuHLgO9Fnd5ztC+L
         iTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783341948; x=1783946748;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yNrkEZw0kMBOjM8rF7wKaiZMIgE91+zaRIL+Y+aqlVA=;
        b=B/gg2HK/JzJOVa5iwOrzaQAkAxKQy5U5b+tG+rm9Zs21t49a1wZsqhxk0wqWXsNPiP
         LpsVmKni6O2j5Nc8lSqWaZkSi7pcyY2rkCaerFDH7+t3tDOpgZhLCNxzY/B7lIuFyEEr
         2zzyNYvQkpdrh+CMMFH74HQwJvxaGVtd7bJqTVXnJ8fR7K/ajAqin63vAj4s5OCfVuYA
         KCcLeQ0Dykw4mpNRBUKTmUAZXAV9I8ALdlPKG7ZqbynwIdmBPkEQmgB7JP6JBLtlbo/3
         oTydd8BvwFI3yufkl3dtzor/aA9csar/1HEbyun4ZdRyrzAHCNrhaDe8Sk33QEpTZXss
         f/SA==
X-Forwarded-Encrypted: i=1; AHgh+Rr5Tifh9HC6/TJCHO+EYajunf5ojwA8iCupCN1uZCnzSmK+uvq2bjdFOC4CjQ1XVrVyU0H3qAcF3npYdBo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwSq5poH+ZbVsH6Bcv54pUiAi9sXOzxkjV3UyxjiGxQRnerh5AE
	azeeS4XewAPbACQxP4AAEWeGG2wm/EKeJocLIylTkzEEN/dz5F4DPSPcWd/9usjo2Yg8hwtOgmh
	MTpKuGM1w5wspYpQn1u/Z7Jvqg4sZV3ywoLugy5SK3KauaX/dgoneHnTCU+8QxqqAGtFq9PiNad
	eZ
X-Gm-Gg: AfdE7ckWnofyaQzTml0YE3ocZwy2Syxh21bo7Na7H0PMljUhVCKjh6u25TEzMNmxQLX
	2YrDS8LOsPf9qVwrAEoSXxnJiwC5KnBnrCSCv+OX9zoN/O4DpyrDlgqlghR17bTRb/sJiyt8CkZ
	g8PS8NYzBCRwH9SxlsC/5GcIJ6jQvm8+Vk4XwwnbL2nvGB8cIY+GFu9uXUKXNPQ75ZirZMDBsfw
	CbjYDQBkWPRCrqEv5UFJAMG7yQg7GnvqBklwK1gk1BjPY3oJb6feQuSHoDeOUBXhNCgxHzD5T4Q
	jXYWAjb498Rv4ebC9SqFmSDjNvX00dINHI0eKlPl81ur6hAzFAx4ibo/QUiC0eMgYh7v6svrzG1
	kjtyYhDkLnwnHsxZkkc/IAxF4OaV3PZfpZtFEQTW6
X-Received: by 2002:a05:620a:4554:b0:92a:f74f:904 with SMTP id af79cd13be357-92e8b25f4aemr1773305685a.1.1783341947858;
        Mon, 06 Jul 2026 05:45:47 -0700 (PDT)
X-Received: by 2002:a05:620a:4554:b0:92a:f74f:904 with SMTP id af79cd13be357-92e8b25f4aemr1773301685a.1.1783341947497;
        Mon, 06 Jul 2026 05:45:47 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:45:46 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:31 +0200
Subject: [PATCH v3 19/20] reset: rzg2l: use
 platform_device_set_of_node_from_dev()
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
Message-Id: <20260706-pdev-fwnode-ref-v3-19-1ff028e33779@oss.qualcomm.com>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
In-Reply-To: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
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
        mfd@lists.linux.dev,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1119;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=HEn5owEzeJIUYkdvn4DQSoUKQdn9M8eLHqPgfVbyGMo=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6M9kHSk63/qP+xgNz2Y9PQyDSmFph3tQ8AC4
 5AtD4YK+kuJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujPQAKCRAFnS7L/zaE
 w8S6D/wMyo30+5v8CLZilNJ79Z7wMDPBUG9sj14/UZP5eZoRp91qLsVzwolPCsq5U/qTKR3y/WF
 pZFakCrbpsJGqVqsKttIhxt2XpF4S1KfN1qC8pASBve+FNz8ZyKWhKOa9yoA01qpm32vrU5UPS/
 6u2lJxL4o4/rLQx8CT4xqgdtrSqHYMAonkNf5DACLGhTdz4ZNLZuCIo8GsF2zwWIH+cAxzjYd3E
 qqZHOI8wr8R2KnXC7H+MD0fJGcu5uQ+1j45nmYvg5cX3ElUN9riw6pLBLgO57aJVoCo/ucH6xOK
 GI4rJ/08Hr3PNBYdbcQEJMNE9yYMkjxiudHvOq8R4g0BwEVtdO1A8jbTcho0IUz53pA59iFnjyM
 ttMlMjXQhKSGu1dFNK6/elGJLMXC6E4nbUKvbby/LEHyHwLU0algPpHe9UPUYh3l/DrQAUt0udl
 +zNN2SMUOdAze/pIW2+l5sftft9+laItqGcD5M5bJTp7tPjVFcDskDf/PioUl0vtokzCPuP1F3s
 zP1G38H9ILdgjRhYpMdqqolRWhSDfehH//GwZSZfc6zSynuMNLzcAlJbgXUXpTthmlBlksAjYqr
 pTM9O9ZbxdBxzavLzPTTt8/695EpXxnwsMZ87oi6uApZGTqb0upieRcXVikiyju4bpSHudD6VYO
 /G0MaTqKJntCfNg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: Md_9kTm5GOU-8QoNxlmG1sI29Xvb5YZe
X-Authority-Analysis: v=2.4 cv=Hv1G3UTS c=1 sm=1 tr=0 ts=6a4ba37c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=kq0kPlqncbyAjjsh9XUA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX5cjP2LPGSbXR
 A5eH3h+EpmYS9qpukuqXQCGX5XJ/w9oVQuWXCPtSYj97FcqnkEKP/1H2xcPkQ1tz2nLScCuzl/B
 NxoouUUjw+E8mXwyMDxONGOA9dkiixA=
X-Proofpoint-GUID: Md_9kTm5GOU-8QoNxlmG1sI29Xvb5YZe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX2oEl+6QprsMA
 xf+R65EraUmT0sD0Enk4cuSEVWvBf0auZ4IurHwjW/so69RyiyOpcoKxsl4K0x5NuIz/kpLoZWa
 8aosnmoq1S452vlnVYAE6/f8SQJPcaffLK6/OY7nDxTXNE08sgOM6exthUkN+RyyeRvtOZ++QmT
 6/4wseAAF5hbWCY8QLZlEalUuC/mW+r9/wi4ung/8EoZdfH4gN8n6Ae4IfDQXXoIHckxuIFSPEo
 fszT+co7d5gEpxlg8SXqH8vQXSv7iir7YTmLs2OYVkoiHgbeBq0pElcBXdqjIsXbHozm3SEW6EP
 GVSV28Uk8Xe4+MvVT2h1IzhQ8/lJpR8P72A1SLKeUHTYtB+IlUKRpmtd7arV5fw6Pwl5y/O5/nC
 ISJyvz4+ZMR1Vm0wh+s8lgQwIrLYNPH88329K1etoAHo0lroRQ3NuiDdaUuCqZoT8OS3NT80nm2
 r0RozyQFRgijhinOgDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060129

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node from another device for
dynamically allocated platform devices with the provided helper.

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/reset/reset-rzg2l-usbphy-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
index fd75d9601a3bfde7b7e3f6db287ec8c5c45a20ab..f003b360629c90bb37ed0ade7a675b5b0f28fa7e 100644
--- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
+++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
@@ -249,7 +249,7 @@ static int rzg2l_usbphy_ctrl_probe(struct platform_device *pdev)
 	vdev->dev.parent = dev;
 	priv->vdev = vdev;
 
-	device_set_of_node_from_dev(&vdev->dev, dev);
+	platform_device_set_of_node_from_dev(vdev, dev);
 	error = platform_device_add(vdev);
 	if (error)
 		goto err_device_put;

-- 
2.47.3


