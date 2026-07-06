Return-Path: <linuxppc-dev+bounces-23619-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E1AC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 12:46:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gv3x71gZvz3c6P;
	Mon, 06 Jul 2026 22:45:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783341931;
	cv=none; b=X1Hobqrd/Iw4wwY1UnLVxsO5tgpTyKi1ajB2MyVJ3m1CSgICC/hcULNJU4ZvCwm/e0TSiiGXRdHHvmynjSPSAmFlZ00O22hDpQGOQ2DCsjiiBFRiRio7QpVJTr+wj1Nw0xZuknv2v62cfQoG1F2qlHrQdv4o8FrY9cn9Z0mSc4+Gu+/6WWfN0ZTGMvaGIYw4mSx5L1BI2GpFYM9HsNUeZ1Mtzg0ZWItwti3YP9Vu0NoAQCQKJA8A6s1vW4WPbGl4eGW1OUoFPc1QWhnThJGRx04U5RMofzh63DizflOXtl1e5ob9S3TCncFm0Mp6m4ank4xh0fUFBs1ESHheRMoIhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783341931; c=relaxed/relaxed;
	bh=a7M+qB1wtuA4e6xlSP5UxgmQli1U/aUaTG8atTWdnUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QguEQvKbTEs5rBW6eFlUHcwRep6LCn3QoSXFU+cEh0HSxbix2m1IxHcIUG30EoDT4plntyjSiZUueuKmgsMKheqUvSUS/XeGpIC+XlxUb9BlypSl0iKWHQgNcKf+ZaK2RYAC0jaUEYjgx6IQIIkPkoSbrex/2QKOOu9NtfLi2qJYeVi+B3fPzwncDEGHIbMnTsR9xLJCAUnKHqpc+OW0Gz3jowmP8MCRZ9jZqtfUAMWN9MToEJZUGpGVd7041bnzci17vpCHWMEulAUGx/LSShspvW9rN4VsHqTBhJ5qUzVsPHbqOMNThF1wpayI76SDK/D/DCn3cWEFoeMipaObWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mVsoom+I; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jSDegx2f; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mVsoom+I;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jSDegx2f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gv3x643Jvz3brR
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 22:45:30 +1000 (AEST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxLta218457
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Jul 2026 12:45:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	a7M+qB1wtuA4e6xlSP5UxgmQli1U/aUaTG8atTWdnUA=; b=mVsoom+I8UuemRAx
	R/ZfNmuKeVyyU7qCm1RkTJyHry5NQoN5fYILHYU8u/80eqT660jk7F2fx5b4fsG/
	zDcEWZhwaDjuE5F1BLo/UDOSyn5DHpnJGIU2GYWrZ2X5TlRuAkUa+Fmc/nZ6lZkd
	Czc0v7XG4Kfakwx1c8TbHIvgLVi9Ltj4g6JI+XTc9cNxLi7ext3cI12DYV/oHmAD
	2GDtb4/5k0DrTL7icyFt8bynGV5tAXp4iy0WZyNVK/xusG4kbML2949Yl7shJ2zH
	dDcWOaMsVzDH8ZQeS4yN7Coed1mAYEXBih29SLCoW9NzXF3aPqUjdRfp8t1v+uj7
	4pLhBg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hs93f4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 12:45:28 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e5e38fbc5so264130685a.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 05:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783341928; x=1783946728; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a7M+qB1wtuA4e6xlSP5UxgmQli1U/aUaTG8atTWdnUA=;
        b=jSDegx2ft/Nsa3IfswYM14cui5TftIUtexLZyYMhR314KPorypsIEx4d/uVd7PC04R
         t1wqPhZpFLyMQyHYYrjWvZO2gfLIBK0e2qMswpfYsVDJL8Eh3cDK1jlOZiJVq7Sunsqh
         6Sox9OiysnX0/GekO6huvtftRVM1CFWUoFKHPDhzyp7DZsvtYYhmO5fqmYcRI3dvNyLs
         dlgoCp/e6xcdAuPTJwYg9mpwePla+Kc8VuUTzxlLBT6y3IUR+Unw8F2QsMNWzi4Hv26V
         ApSHxIRnM9XczbOHhDXjzfNigFKaGejHG5yYxGACPDfBcEL70yna5Ux7H1SPBVuZxGIX
         QpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783341928; x=1783946728;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a7M+qB1wtuA4e6xlSP5UxgmQli1U/aUaTG8atTWdnUA=;
        b=qMo81T5EA6aNNRK1+VH7UvRAEAVukkluTruKqE0c6NOFBOnYpUaG0M+ILtWijGjn6R
         zh9GTTUYjhwu1pG69KXpCcqglIqVKQYEwvOf5fUB9EWafzps2waFikxZ8YjPTSieRl2U
         J6o39+ptOA1EQ8fCuWEVkVOCnFNzEn94BulTm1S1bNpfetBhJ+W+OnaXKQH4Pnd1lBkq
         f8ltfsI0rQYQqlv+7vddeQe7PtsKToNwgVwejSEc5f9siZDflOwY2zhmaOtduozfFON0
         YAEgxfLhceYjD20a8NiKd9d4WS7Q2yCzcOB/PF0j2b1Zj8V9StbgHiI+F5PPb8IOgn2Q
         l3qA==
X-Forwarded-Encrypted: i=1; AHgh+RrcELMPU5y2iJKXbskKxaGUq1jyotQIUkiIQO0SGVuJvY1eYcQxFhXvm7BOhm0Qa8K//HNLA/2b18v1qD8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxLhvYynO0xTREzLbREYniQKPalJkmd6IQp71UNyTwP3y/w+pDZ
	G6lpKLPDUThQtoglclhUuCKFV7cEDZ+serPhDaZhwdPmhb7lgIirexS/9o6FZwuKeFGNqZU22qi
	ZAojNI4OjED4S2XNZ4pCK0GrV7SX1g9Gq4OKHfoN83d+0e/Eez0x3WkA6Aw2ZaLsqZZBh
X-Gm-Gg: AfdE7ck2qj9ZaEp8h00RgocMUaBjyk6W6uE1nSjUehyO5bwtswFMlFsTqzweSzrGkXD
	Bp5kANS73NTw3UGPh36J8Q5BPsugMji6slP4FmqR/nSOSoINDMxT4MOcYVKgh/8pVEu6EMIqN8q
	ZmAPWkSl8OvBvfee7Ys4V6mZaYwIC/2bdKc2B7YtCbDwxSO9np/kuKEIqaCjH/bmNYYiSzIBMs3
	PA+Wsw8RB0fxVwueNPskhIOHuV5mRTMVRCA2l87WlGBrR9yfDaGWU38j/NDdw0mnIXnprhSorvL
	b3z4s7g5xXd46dur9OksueywASQHrxfWjyO4ask92QsLwBO0L0xJG0V2vOw9ID+4nKylqBQvb6v
	0Anh5k0q6KP+cXb0m9R2Ot/VmlXsEuIKbEG0UG3Io
X-Received: by 2002:a05:620a:29c6:b0:92e:45e0:2588 with SMTP id af79cd13be357-92ebb5903e4mr47956885a.55.1783341927391;
        Mon, 06 Jul 2026 05:45:27 -0700 (PDT)
X-Received: by 2002:a05:620a:29c6:b0:92e:45e0:2588 with SMTP id af79cd13be357-92ebb5903e4mr47947885a.55.1783341926531;
        Mon, 06 Jul 2026 05:45:26 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:45:25 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:24 +0200
Subject: [PATCH v3 12/20] mfd: tps6586: use platform_device_set_of_node()
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
Message-Id: <20260706-pdev-fwnode-ref-v3-12-1ff028e33779@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1025;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Zhi+F3sSWgohZECXWnDHQaM+wwr9Sm+ARxs2xrHRhPk=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6M4FydUTb0fLA7v8UHs4cH/yNkk78x4q5hdy
 wJhY/6umy2JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujOAAKCRAFnS7L/zaE
 w2xvEACFL1p1phfk9S+82M3HHVOICD8gtkblfhA2UFHpFsY7LhbJmM/RpC8etf2XcuDnH2Wjsaa
 7ugVGwdlyrP3oStrvCOD8hXv34YlCuu9r15uW7DIuBMUQ0lVsP5/RhYk6rI4lX2yJ4Mb61Yu4yk
 +ekCe2PEQIApK3zi45KvVkl+eD1Yz5aiXqc1aNNOVzgJVlYnGoowk8R2OceFSR9D/OSqK6etbgK
 Kg2OSZHlSosDeDMFHTbBcdfL85jRxwk2wyu2+M/V/7sFis5TmdnqjShyf7zAbDJVmKw3zdjM33b
 TgzYM80W7O0nZf0BT8iFML0Ky3MuTWgC8pt+K0WOjpadEZ3I5GmWZCRFFwbpJLIy3NXFM0Du8Zy
 DC4PlcROsGtdVB2hZRMg7Zy1kZXbx0x6NmiuaKrVjT43h8GUkrK0nG6Ap60o9hUG1/pm4deMDq2
 0nz9SGlgZKIm7UqZtXAYo6WvpHEhEswZBQXybaG6a8CaFgZCeitbc3tH1tofpjPSXP39Iqxq40+
 T0I2ZAKLZFj9oQfyLF86bX3ET1D7rwiFZXwxCvzfI/YomTynpdYJ53ELWCvRBMznaosXCTH3BE1
 /qjZfJ+jeUZHYjhdjxciVXxitOM0ZToEZzwj1w4IfNVjBkOJPCYMMfz2wrFiRzmUMDZrKrI4lh1
 J5/eCP0vP9uobig==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: yrOJ8keey56yi7HcAwU61LS9B8F0IGCp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX6w/zpQSSDjHu
 zaYvUm+SlO35LPNSEboc1qnTXMGhodbZ9gKdQOTaP8XVk0mYk4/tvd6MbSWktOOO/BaxKUvuDQL
 +F6hQaEt3b9CBYpTdKbe2JiZ6UOHavSCOXdUQDm2LbzW825fJ8fXNe0epRM4p+j38wNwuJsLicg
 /0mJx8C2QnDuSDXmPPS6hK071chQm1ZjszfzcW4WPeuHxYk0jnWWxBl/WzPfAICcL4LJfZq5wb5
 YuR7Iypb4bc4PAPsinuaC/GgU2da8lp/oDR/GVU6ce2Oz7sBh1sn1Aw0ku7FYTft7Enm2BEBrc4
 vd+MJb8MnL9J5AgOd5FzxCU42YeKbDnftWtl+L5eJ4N268UsJkxcgFMF9PiAzk7XvpqCK1rCncU
 2TZAkhR7c5IW+trwkoPWnORa1Fw9xkiiWtQ3/P6RGsgoC37oYfAtbjt64zuO/xWWyYkdXQLYbSh
 qjGDL/Cy0WQQB8nEo+A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfXzOVTCXLi65t1
 28DAUTe/lyb8lYSeF/kZKTxOWUwNvtLfORDp24N4uIdxG1odDUhy1+H49z+xzYGiOV6zbngERt9
 w77nlDlV7CAdOA+fFSwHvR2SCKPSyhw=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4ba368 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=ESSmVKC5p6WdXJfq0SwA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: yrOJ8keey56yi7HcAwU61LS9B8F0IGCp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060129

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Acked-by: Lee Jones <lee@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/mfd/tps6586x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index f5f805446603315ba76ce1fc501c908f1cec0d16..3cfd2f02b62f3cc370e0d970ec2643b638fd0fec 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -397,7 +397,7 @@ static int tps6586x_add_subdevs(struct tps6586x *tps6586x,
 
 		pdev->dev.parent = tps6586x->dev;
 		pdev->dev.platform_data = subdev->platform_data;
-		pdev->dev.of_node = of_node_get(subdev->of_node);
+		platform_device_set_of_node(pdev, subdev->of_node);
 
 		ret = platform_device_add(pdev);
 		if (ret) {

-- 
2.47.3


