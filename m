Return-Path: <linuxppc-dev+bounces-23623-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A494AC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 12:46:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gv3xH5DNcz3brt;
	Mon, 06 Jul 2026 22:45:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783341939;
	cv=none; b=cb2ab/sAq2aonwff7sATWuxtTiePQ+V8HR1G3JoDuzYEcjv3O9QLqaF81D2mhdiXpK1G6KLNYTSYnlQU1WRRfyOO1bSfZmbnMrqe5+USlteXcKFeOVoc12rH6sT8YeY0UyKoYsz7TWk1f78ShlqEijLzHXXr6Kx76qX85Dxga2l4/gUo30nHUKJ28gP41NnpLfh1SbbYbGfJJtDMg+wbWOC4Whv9H7vz6ctdbqRZWSWcCcYJuZwwp6DK30bpdpfoackWPkS6x8ihoOY7xCe1KIjYt2BDQBJWqjBqq4ohuoY+OgI5QJZLQKEF/+jSnJSiax2niyaCuryGsrb6nv9fUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783341939; c=relaxed/relaxed;
	bh=zax1X4XbzWPUvVXMfqloW++pJk2JO1xOHc7DAhzePfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZjAZS2/KjT7WrKv3djqOtmnyG1HYEoDtt3eEc1V/H2FUdaCh7Z8sxLssU1l5v83CATK1NsZFlwf2UwZBYSCCXw/rzxuBXzgEEMWwe0+UwshPC+f9/lfHNtewkvni1WeM9YgwW1cMpCiFpKXxknE82904amU8N5oMqAmrC+cwIMU5PjJYu+5p6MOMgg7nd62NPzFjgRu0nNrueNnTkouSBfk2v6nFZTcaPVcNobvzZFyK7Mzqd9E291pEEPgn3wXQyFqDNs1Q0I1UXzXoqUwgtFA1HnPmUoADGmRf09gp7R5rnVk3exPovs/LKo+fiAV+IzaoSV99RYAAPLCpgcbgtw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WzwPlfeX; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QL1s+PKg; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WzwPlfeX;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QL1s+PKg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gv3xG6F7kz3brB
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 22:45:38 +1000 (AEST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxLti218457
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Jul 2026 12:45:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zax1X4XbzWPUvVXMfqloW++pJk2JO1xOHc7DAhzePfo=; b=WzwPlfeX2hhdhkII
	9mnkZNBd8gqlVcTDS+eavPmnbC7oMoyBni7znpijGAwUU2FZu9zSDwwLl1iAYZ0K
	joB+HxaCm+VAbrupM2n2A/V5ikNIeDfyidY4PqG+PZFZ/FOU3Hi45HGVYbBYL/d/
	y8TbNGeskzt/7YM9d517vcR3/L0dhwC/CKql1pMbkioLHRcLDrpOUb24jUmBTzae
	cm0dQ8l2vMPwZ38md/dVJErOhBAPAyq1GQDdUmXsHYvppqFuSWBLop/RmoitVyCW
	fbEl1tKap1vDrMh6A71dJd/+N4ZEq3d4RSqsPDBlUHc5UfeCROUdWNOdgxxJiuSx
	Ug9/YA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hs93gw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 12:45:36 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e9a2b95b5so463831985a.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 05:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783341936; x=1783946736; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zax1X4XbzWPUvVXMfqloW++pJk2JO1xOHc7DAhzePfo=;
        b=QL1s+PKgLb7J4Nvf7EvOo+M0OEL9F3HXDzDV7cfg5HY2UyvciFrxLuPRNdgx0Kz6Du
         XRb86UIN8G+bfd2rEuL2T0uBGT+7N8UPXbLXs+sbO1hl15YtJ5DD9xHlbLNGAU5WmM84
         B9qWNaQqdFVFaKXeWxV0XtYTsi/ty15yAOGLmdtUtmHc/lGpGDbNtfDHjjw93fzWHwyE
         qzUnRcF2UoDBL0hlTXPz7weL/vyYqdcuDjBbUCsWYEOgdaBxAHFgLts/9RTnwYmhwcFW
         23tKxoBjp+U8avtAvSSS0VQ4muV1Fe2GL65Di8NQSehUsi058oZ6g4gYqRM+StHKSCyN
         X5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783341936; x=1783946736;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zax1X4XbzWPUvVXMfqloW++pJk2JO1xOHc7DAhzePfo=;
        b=mBH3L44ODu51MQsuv1RxKUBTgHdrcouCagmgdqa9IrDwgwR3baJN7neqcv4rx8GaeR
         EH1671D7zUPutOVkz7H87LzBpK5loBjZkXP5QoF27SLqVbpVWgIHsdTImOCHA1RtUw3z
         LEbD3yNAyqZzx99Zn2I7TEhlf4gmo/JQgH88YbqHyYq9yJYb1YLLnuSRxqQy/6Ef6GMi
         Mkz5OsC9+Uot+Icnd2FQ1WUxYDuMzzOJvN+yEnRAdtx+XoF059GANEm9LwL3noBZoo0Q
         3v/CVR9VAc0A77/3sDzO0OYKjhMcSvth4qUdh4yFfuVFdF2qFHGeymstRM5blACZuLYK
         BkIA==
X-Forwarded-Encrypted: i=1; AHgh+Rpo/DfyjLuMpp0VC5d378/c1bPOJ/xIchDgrEH7JZ5/+8Gx3vIfx9NmWN/uYRel1+IW+wxETeI+sP9ucwA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwSICiO45UAeLEuV52Oq3IYcDqculV5nbdpxzcgfYEX/hqHYHPL
	zWDGNfvI+Jz78oYM3B7d/Kg/Wh50rXZsGEzXtolCHK2CnSpjdiKkfH9MYeDrfVM9Vrh6dNcmKpM
	tNOYtkDlvCzUAOC6z6ouyflYRitHE3DYQCNHWbyNp0fYkKUeAclujOY0sDyggk1imbJTW
X-Gm-Gg: AfdE7cn4tid77REnxRZusHigQmVCNArzhXg66hq2EJTTVDFRzcWEgCZ7T7VR0AOE+IT
	NlPbzqyjU322NnYMal0pbjGcqy5YfAbRmSRff/kiN8Wbg5Dxd0QISHFJGrp1U8U7ta3XAZFU8Cb
	uGy/ceDiE9/D9w1OWfnromTwa9RimiasVwqIdoK/KD+KdEwGyE4osVm1uK87Q/R0IvXNHiA/oF/
	iU/iXIvoDdzIjMafyqkZPLuUcMiBbfX55v05IUxUqoZzGd2adU7hDrmt1TpXPN7P6Ane47mbMSL
	q6r0VyQD1xdkM1ge3muS+lBixJ2hldivrMI4kAKT9DPpOcAIf61GqQVkWpl9UzOlOiQz2hFIY2o
	7SkX5iZRLNuFRnXm2YH/rxslmwOro5jvUP4gZSbpl
X-Received: by 2002:a05:620a:6888:b0:92e:76a1:96e2 with SMTP id af79cd13be357-92ebb5dd29fmr49713585a.43.1783341936087;
        Mon, 06 Jul 2026 05:45:36 -0700 (PDT)
X-Received: by 2002:a05:620a:6888:b0:92e:76a1:96e2 with SMTP id af79cd13be357-92ebb5dd29fmr49704185a.43.1783341935528;
        Mon, 06 Jul 2026 05:45:35 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:45:34 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:27 +0200
Subject: [PATCH v3 15/20] drm/xe/i2c: use platform_device_set_fwnode()
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
Message-Id: <20260706-pdev-fwnode-ref-v3-15-1ff028e33779@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=929;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=uLXyFApgr30TTHInPgHtMrjb0JTo4ifQAXB9pVDm0JI=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6M6Q7+TAJQm5eCNk8IdPrpLpvdQnPdPUQTjL
 v3En+SR8n6JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujOgAKCRAFnS7L/zaE
 w8sVD/9FSqpOFwI9xNUjUgfMc/OBmnlJ/oPR6pweDlgzV6UYHA7LfN0Pjqwd4sMEmMh6Wsnob5d
 k5RtgQ5z9XWNhsvHI3l87qGhsD19PPPZHOFoiCxPJH260MhNlWPZYBx2yweOyn0bN/V4wFf9g8E
 WRkPyr25sOK7K/X1ANFFS59a7tIa8LC9kv9YjPcHIjH1uFYiVkWjnW9ppECk8kTdvO8SWTFM7nI
 8WP23VpiT5mCUgLu55gknhLZB/psW83c9DQEEkuIrb0z/cGLCuYvEzVUn0XKpc6p7P3YAtGeRnl
 2rKPZu0LokRJGIl8gLTIMk0QIaIpPpX6qBRIVqQ200ie5Fkt1vDv1j03XvgAsNfgd5JmcOmDq39
 ANn6wdh+tlp175G5+WK1dITngNhOENduAlOc76s0TszKG/mEZ6hhU/iuqddrZCHMf4UezBFdFuo
 DHZaI8xhaz9Xh24q/ti1OQO4612k/L3WtW0Wy4N5V4C3miPGqdxvznUUccBigJrbmEXGqBe/vWN
 5ia+ZsPJ3kddXqmkVou5nmLPatbfYJc7IG17dl7Yz2gVIX9MFpeeqbGt/5nMDtteEtbn7bgghy3
 ZJq2uY2OlHmwjmbGZVO9n7FNg59XF8tF1/kAFLXE2UeZXrgpGxERgwyXmv61/0L5I3v5f0M9vc3
 R1N9ZRzP+87JgLg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: 1IKq_Sq2ROn091DG1cBzC_SHPttRf99s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX83X0iGZ6w/ni
 xh49TXUUaO4NqJEzLCYouYSox7JTzrHFq5wNQ6uxCkAK/3O7vi/KcqUNXa014h4CFEfkhd52JeJ
 rbCSBVJA4FncUxZiPGdWxbHNBrIkJ9J1hdwsvQ9uOpzhWPR7It0Pj/owS6T99P/zFGlUQKKrupC
 lzlWJnpyzCzTaIPcWyDau+SRS+FxZl04ntUVcntw9sfacIlVmxZ6I+HvmEi8wjSNSyWmXqmJw7b
 OLi6jm4iG2neuDPnJ7EK5HYA+vW8b60Ag3RP/Ey423CasTrYnQw2+1HxHoQp6tHnkf/TWDAkK/c
 IB13KS/eCesQ08tx4m8uxwC/x17ehsm5pPTKma+8ptESKcKkfsR07J5iWen0lFymkCFo+zcvfIJ
 3x2kSJYN3fIU1hnK1mgPKIMTJKpO3EyyskbYQel229YFzKeX2t+aoXNBCyFGUsav0mRgE4PKaYc
 1cg/Cn5mJk1EKyB3ezg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX3ZASHSTsZdeH
 1MZF+rIMtXbFyvxCdPeoO0F3j7ha7c/2o4crwav5qqE1Smr+wS7uV72zqCgpvO78xMD4Mfo6np7
 irsrkUc1BuLzy9R4exUItQ5NGJlQTAk=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4ba370 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=Jb7EFCjKRuSTjX4XlnwA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: 1IKq_Sq2ROn091DG1cBzC_SHPttRf99s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060129

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the firmware node for dynamically allocated
platform devices with the provided helper.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpu/drm/xe/xe_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
index 706783863d07d66b4685005d6649b3cd143ecc3b..af4ebd93ad8e68c95a14cdf99de0959fbe080354 100644
--- a/drivers/gpu/drm/xe/xe_i2c.c
+++ b/drivers/gpu/drm/xe/xe_i2c.c
@@ -123,7 +123,7 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
 	}
 
 	pdev->dev.parent = i2c->drm_dev;
-	pdev->dev.fwnode = fwnode;
+	platform_device_set_fwnode(pdev, fwnode);
 	i2c->adapter_node = fwnode;
 	i2c->pdev = pdev;
 

-- 
2.47.3


