Return-Path: <linuxppc-dev+bounces-18045-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C90FD065B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 08:37:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fW3z51cdVz3f1p;
	Wed, 11 Mar 2026 19:37:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773218257;
	cv=none; b=Kocc5QoJpVeB+gNRuO/livcQRbnhHV6L+rWzvl4U6wkodQ/sGvAIvXqz1Q3/JPBT6q6M5Dc/FkPkpvm6oGEtyUlohDXontUeZXN0HGcyaCSWmIyfqsEZ3aC0shV03KuXcH8cxxLNYQ9kJ9aLliS4KXWumnUl0e2Cl4Ac0iKbZ+ucncphDaNr6zcI2ApF2OF043/jrH00ac1GXA8Gu8waSz5X2dkzk8R6i12One+6QURlcZorv1y1IB1ey8bjU2V/eH/KWhW6rRfQpikRQ1IEuHJj9KHLIBCRmq+PFf9tpgrLsFx+V0fuHd8jsc1lA7F0x7UAKz56jxapnPMtPrTAgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773218257; c=relaxed/relaxed;
	bh=v6shnDKy0mTtNDl8IP4ADRHwgFmAxB+//orXLuR5fLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H4Y5bU7jbWPESTQMAHkirANlnPjVUGzHoZ1HsR+pxszi+pE9nZVlyOOZW87lk19c0OhVnIBVC2frAGV6gGleexnkbGetds64yHHHTUcl5VzDGs7AF3NBGYn+HPeHEmUk4kErzUwkJUMpmFUYPwkX+U40LowA88+V1Zgee+uN7i9QKtJYAlRdyHImgZI31A/3/tZJm/XdYrV8Q8S15CMs13K+RKdRhUGway20mkk+etuSyiwjwfeuwQsFpUAcKDNizpwer1DWGI8aKqTSwJYo4YPMB1EAtuR6Ot5xVhcqzPxJyQsDgVLx9TArUsoaori+ydi0K0hJtr0GZzMY1dTGfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hhs5fZMy; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AepgwhTu; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krishna.chundru@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hhs5fZMy;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AepgwhTu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krishna.chundru@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fW3z333P4z3dwr
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 19:37:33 +1100 (AEDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B4ScWi3894073
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 08:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v6shnDKy0mTtNDl8IP4ADRHwgFmAxB+//orXLuR5fLg=; b=hhs5fZMyvtxS8Nuu
	ytOLTRbVQ6fk7Nn3abZLkq4nk10BNPQgEP4xkSb75GAgLxtR8jfPQVALSNIK7cQt
	rEnKprQJPKQQe1prkq0IYawtPRkKqGL5DB9X1vgxK+SrSJXxiM+5raitEo0U0ZyF
	FJAjzHYw04iSe5osB9V/zMgrMm+hsPFXESQdDQi96rffkrjJNsmgL5axWCcr6Yxw
	Vk/i3gIeCLyIRyRiSzbBoTD1flcFtkou7t41nocrIfOv3n0aiXLrvweArTeVorNZ
	nxMd2wy/5pcqZREwyaV1LBEyNeUoLSvKiQtOPXTiBUtacHJtPkm1iEgB+nCoybAy
	AC9j6w==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctkmyuusu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 08:37:30 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-829b20cc6faso678449b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 01:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773218249; x=1773823049; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v6shnDKy0mTtNDl8IP4ADRHwgFmAxB+//orXLuR5fLg=;
        b=AepgwhTu/qirTxyxsYH91Ww67jUoYh9I7C+K5Bev76ArpmQPm4ewVXrPxmz79jNcB0
         KRk5pcah7VuxCgDLfYGd9lXglJ3pZznnYHNBXI5IHKyIPPYxpM0tV30MTlXwv7ZKMAIO
         ZlytJmXTX/mTWHybRhRph5vJpa+w+sNMFIYqFVVc600YaPkTlXISKvL2wfFP7X2s1Inx
         G/lJfpasOMmc7UVLbfWZ+7Dvf89tf9V1b2vR1GOGsdl7u4yQYAf1U9CYmSsREENilnKj
         zzyG5t3tNh4M6endJaHFSLck1BGWl/jiHGeeqIOvbxlh0vtZRRx6Vdm3539vgS5wVssb
         AHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773218249; x=1773823049;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v6shnDKy0mTtNDl8IP4ADRHwgFmAxB+//orXLuR5fLg=;
        b=dYNXbssEtUSAIYyl7jx9AJcpCaIWZeVTR3MMaCqxX06SRUVZnEG4AcV645n9U/5gSa
         /CUUgbM2jsH6czsZ/WyfvHsMLYKuLmSvknoZtEeHM034ieVNRrxcdvEqMwABx/5KdUiU
         Y/ueG9zAJ1y37D2Ae4zOrKJoAj3e3z/6nlJ4JtyQyeILQ7wQzcYuYO8zRz3smxwK/yL4
         OhMvPd46W6+nt0xetD5OkfD1lSaZHBUjMJtXyvkxgh1RkW7wvYp6a998RkI0aSiNjrIG
         YxI++OZNznYX9/qW4T1UVfOuqgU5S83c/K6yy9E0mQ0vkR0a/XJqWaREMOxvIxun33ci
         Jcig==
X-Forwarded-Encrypted: i=1; AJvYcCVw3TDWAizoSYPzb/KGOB3i/7hbogU7/iK/CG3UR5eplNzkbTjMlzqiELN47vLOD+EkjWiEJPCgRkn4dsQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzHy4z+3CZCZ+Dzz5IehSW3NmckjgijRvrB/lgOkz5ZvRL4kj3O
	4+CKu7st0F2oHeTX0PiG8mCDkOuUKvkC+ytctBFMy/6Qtg2zlYoLjf3vc2pIFHo5TEdGlnVLDj1
	UyWo4wb2jUlv6fFVV4fRJvPBNp8U4dDGtlvn0Gj3gLiepIwEuLj32G7E7a+VNkAdjjEBF
X-Gm-Gg: ATEYQzzjOVKjznOHnc2BQ8LQplgfdsacYtFZI4bcUhbI5m/ZgvdhTgBOZCLkAsSkJxQ
	W0ufDqQNMMWFQm9gPZHN8A5+3d37ZiUTSeivDdr+fhOCdA6ErT7fIm+J66ea6YNflYEH738T+XE
	jgF1GjNGf2NtdInrlHwx0UjI2lcUb5ii7h7XTvY8EitVWO8VH48WQM1tfdGLgiV6qbo5A7NKfrU
	cSv8gFFKlydWCjT+gAmA84y5g7YG9WqAK5c9Z0HYFWdBr8mcViUw5WYHQgqTDHsWxGlBdGJvQS9
	8DB6kVpgbu+xadMjyPbyJMghAErw7toqCCcAATCp8Ls9TykdECR9Gwj57M2bG9zXYurffkGU02B
	oATwsEQJAXxM8qcINJdP0KwpO6kP2WLnPmCRbmG0NU8pM92zOzLFPSA==
X-Received: by 2002:a05:6a00:349a:b0:81f:4e1c:1d3b with SMTP id d2e1a72fcca58-829f7ae6a79mr1535904b3a.23.1773218249443;
        Wed, 11 Mar 2026 01:37:29 -0700 (PDT)
X-Received: by 2002:a05:6a00:349a:b0:81f:4e1c:1d3b with SMTP id d2e1a72fcca58-829f7ae6a79mr1535869b3a.23.1773218248955;
        Wed, 11 Mar 2026 01:37:28 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6df3b14sm1736918b3a.20.2026.03.11.01.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 01:37:28 -0700 (PDT)
Message-ID: <cd192707-1f8e-4ad7-8be5-470415fb4e95@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 14:07:18 +0530
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/4] PCI: Add support for resetting the Root Ports in a
 platform specific way
To: manivannan.sadhasivam@oss.qualcomm.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>, Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Niklas Cassel <cassel@kernel.org>,
        Wilfred Mallawa
 <wilfred.mallawa@wdc.com>,
        Lukas Wunner <lukas@wunner.de>, Richard Zhu <hongxing.zhu@nxp.com>,
        Brian Norris <briannorris@chromium.org>,
        Wilson Ding <dingwei@marvell.com>, Frank Li <Frank.Li@nxp.com>
References: <20260310-pci-port-reset-v7-0-9dd00ccc25ab@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20260310-pci-port-reset-v7-0-9dd00ccc25ab@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RYudyltv c=1 sm=1 tr=0 ts=69b129ca cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=lJ8DZ0MjVbnDIa4D:21 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=ImqNvw3yTObJCdT6Mg8A:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 6I2oNQw3568BJhsvT6CBra-4mGml5izn
X-Proofpoint-ORIG-GUID: 6I2oNQw3568BJhsvT6CBra-4mGml5izn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA3MSBTYWx0ZWRfXwujfOyuKKDvI
 zhd45l5MtkLbXPDrXFAqQmZVQ6flEAlJ4Ucwdh9X/ESt6UAxhmSROang3Dvs0FvSuQ48qrbYki3
 rkzKj3PNPE3pk9qjj/cReB/+bssX2LMv7kWrLe0jPsiCsJfTAZ/vwv7O3834LA5FJj6Y5KQ81v8
 1/aym0XXQpykGYNIP2fTpZohmaWZ1uBLNB/R1gpg7oE3/0+qkGJoLuU+kPte4RAy4Uh4TGwy9pW
 LvGEYFwLq/vWo6tz33ZZdNb7hqDbVaYEsnnYL0QBt53AlB+1uTY3k8lTKTSbFVwihdZjBLTfivs
 BLXJM4Ea0jAZd+Gc/qM9oERkONYIKLPUIbDJzUH9VF7IyctM5XirxmYQGNPfdzsbKi/L7Cle1sE
 a+iqBPtFgGZUB59Po3G+VRXWgxsDRRHW1OHj9Ju0uakBGCtu2B2MXsWOEgUfChZwAMcAUC5/zoB
 UT6z3NnHftQCG5FqdGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110071



On 3/10/2026 7:31 PM, Manivannan Sadhasivam via B4 Relay wrote:
> Hi,
>
> Currently, in the event of AER/DPC, PCI core will try to reset the slot (Root
> Port) and its subordinate devices by invoking bridge control reset and FLR. But
> in some cases like AER Fatal error, it might be necessary to reset the Root
> Ports using the PCI host bridge drivers in a platform specific way (as indicated
> by the TODO in the pcie_do_recovery() function in drivers/pci/pcie/err.c).
> Otherwise, the PCI link won't be recovered successfully.
>
> So this series adds a new callback 'pci_host_bridge::reset_root_port' for the
> host bridge drivers to reset the Root Port when a fatal error happens.
>
> Also, this series allows the host bridge drivers to handle PCI link down event
> by resetting the Root Ports and recovering the bus. This is accomplished by the
> help of the new 'pci_host_handle_link_down()' API. Host bridge drivers are
> expected to call this API (preferrably from a threaded IRQ handler) with
> relevant Root Port 'pci_dev' when a link down event is detected for the port.
> The API will reuse the pcie_do_recovery() function to recover the link if AER
> support is enabled, otherwise it will directly call the reset_root_port()
> callback of the host bridge driver (if exists).
>
> For reference, I've modified the pcie-qcom driver to call
> pci_host_handle_link_down() API with Root Port 'pci_dev' after receiving the
> LDn global_irq event and populated 'pci_host_bridge::reset_root_port()'
> callback to reset the Root Ports.
>   
> Testing
> -------
>
> Tested on Qcom Lemans AU Ride platform with Host and EP SoCs connected over PCIe
> link. Simulated the LDn by disabling LTSSM_EN on the EP and I could verify that
> the link was getting recovered successfully.
>
> Changes in v7:
> - Dropped Rockchip Root port reset patch due to reported issues. But the series
>    works on other platforms as tested by others.
> - Added pci_{lock/unlock}_rescan_remove() to guard pci_bus_error_reset() as the
>    device could be removed in-between due to Native hotplug interrupt.
> - Rebased on top of v7.0-rc1
> - Link to v6: https://lore.kernel.org/r/20250715-pci-port-reset-v6-0-6f9cce94e7bb@oss.qualcomm.com
>
> Changes in v6:
> - Incorporated the patch: https://lore.kernel.org/all/20250524185304.26698-2-manivannan.sadhasivam@linaro.org/
> - Link to v5: https://lore.kernel.org/r/20250715-pci-port-reset-v5-0-26a5d278db40@oss.qualcomm.com
>
> Changes in v5:
> * Reworked the pci_host_handle_link_down() to accept Root Port instead of
>    resetting all Root Ports in the event of link down.
> * Renamed 'reset_slot' to 'reset_root_port' to avoid confusion as both terms
>    were used interchangibly and the series is intended to reset Root Port only.
> * Added the Rockchip driver change to this series.
> * Dropped the applied patches and review/tested tags due to rework.
> * Rebased on top of v6.16-rc1.
>
> Changes in v4:
> - Handled link down first in the irq handler
> - Updated ICC & OPP bandwidth after link up in reset_slot() callback
> - Link to v3: https://lore.kernel.org/r/20250417-pcie-reset-slot-v3-0-59a10811c962@linaro.org
>
> Changes in v3:
> - Made the pci-host-common driver as a common library for host controller
>    drivers
> - Moved the reset slot code to pci-host-common library
> - Link to v2: https://lore.kernel.org/r/20250416-pcie-reset-slot-v2-0-efe76b278c10@linaro.org
>
> Changes in v2:
> - Moved calling reset_slot() callback from pcie_do_recovery() to pcibios_reset_secondary_bus()
> - Link to v1: https://lore.kernel.org/r/20250404-pcie-reset-slot-v1-0-98952918bf90@linaro.org
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
For entire series,
Reviewed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

- Krishna Chaitanya.
> ---
> Manivannan Sadhasivam (4):
>        PCI/ERR: Add support for resetting the Root Ports in a platform specific way
>        PCI: host-common: Add link down handling for Root Ports
>        PCI: qcom: Add support for resetting the Root Port due to link down event
>        misc: pci_endpoint_test: Add AER error handlers
>
>   drivers/misc/pci_endpoint_test.c         |  20 +++++
>   drivers/pci/controller/dwc/pcie-qcom.c   | 143 ++++++++++++++++++++++++++++++-
>   drivers/pci/controller/pci-host-common.c |  35 ++++++++
>   drivers/pci/controller/pci-host-common.h |   1 +
>   drivers/pci/pci.c                        |  21 +++++
>   drivers/pci/pcie/err.c                   |   6 +-
>   include/linux/pci.h                      |   1 +
>   7 files changed, 221 insertions(+), 6 deletions(-)
> ---
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> change-id: 20250715-pci-port-reset-4d9519570123
>
> Best regards,


