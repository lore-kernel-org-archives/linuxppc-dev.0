Return-Path: <linuxppc-dev+bounces-25495-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B499FC56208
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 16:50:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGCvQ1MYDz308X;
	Fri, 07 Aug 2026 02:50:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786035026;
	cv=none; b=GrAy0LquJLsGlK6roUR5Ciu4Ry1JMbV2zo5aJAeo7CmbhURrKmS/KiSoslSUb1JJ7G8EHfRUi3QONqYfsO60ermBO4RyYCG86O3YZU3xsg/OFfM5ImxgvtxZ+N182ID/u2tW1ZCf2ta65KcF40PMiLfPJa/Xbth1LKehuqyQvJQuI4sa2gNr/FyfdjoqMTKT+yd+OMZC7l+oe4uHNu2vMRHFWxaXYcz0f7O9hSh0UjvSKzJlIAketYivoClyFFg/TQRL+IZThCsNqD4ss6TnicE1FH603/igO2bST2SuzXvmkHvDHzXg7LsVOx1gLcEj+7sAdQbIRb6G3CZUlQnA1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786035026; c=relaxed/relaxed;
	bh=dI/JUWOXVfmk03QoibAP+70rE2yFJwykSpSDH95V5/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XJ1yf0jR18b+CmKyhC5+AVNvyPf2swD5D7hItSZsSKx+bNuF8cQ0SBvI2FI4wmc97v02c+ZFOP8iPXMULcHCbgSi77vTfWrlWvUJTzczX3xS3Wfx7leb/bNlHaVUowP/M9idQ4bKe14ZRwcrngBdG5RI9QW4xCQTxVQVTkj2zwRtyPW0HUnA1nyH1daiBp1SJRYCQdBdcrqgREvrq+uBiExVOBgDrAMqZ8L4c95NEDdE99zrSgabGWuCtIVbodTPQJ4p44S9AjENiF2M+lnNMoB5FpBRy8pnIz9NmzHnLdz93rQ92D2E2+Q2ZVPFLeHKqZzRtKifRDALXxYzNw45Aw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PWgW/xsI; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sbhat@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PWgW/xsI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sbhat@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGCvP1q3Cz3080
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 02:50:25 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676EnA1b2939527;
	Thu, 6 Aug 2026 16:50:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dI/JUW
	OXVfmk03QoibAP+70rE2yFJwykSpSDH95V5/w=; b=PWgW/xsI4pebgAH/BV1kz8
	PrYpd0TU18Kia8wtq8jNczblGnJT/lUvsuDMqLGrIaUzrXtht7DadTOtm4lj/qni
	m0P8s1ENRkiLbGPy/n9Z8COsJwxLX2UopugiFKvIKg6TPEWepo0IXQ669a7grjwB
	cp4t90+FIFaG9AWMHBmV4UpXr93ak5TjfjsH3BqSKb+78bV45ydLtW28McSyON2o
	dHCKK5TvclBcyZ+FCsCShJFdSahmvkmqB0RF0Aufvki2M31Jra3lJpp/e1EaqUrG
	znpkB6gk97y7VWWEZlJDHtNGlSHjvbhLOki+2cau6+h9f6OzjuzRGpOQ9MMwxd3w
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a49cn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 16:50:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676GfRJL018806;
	Thu, 6 Aug 2026 16:50:14 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyutnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 16:50:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676Go8OS30933476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 16:50:08 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1C3120043;
	Thu,  6 Aug 2026 16:50:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11FB120040;
	Thu,  6 Aug 2026 16:50:04 +0000 (GMT)
Received: from [9.67.65.218] (unknown [9.67.65.218])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 16:50:03 +0000 (GMT)
Message-ID: <72ce5fa7-d12b-40e5-a4a2-f2de414088d1@linux.ibm.com>
Date: Thu, 6 Aug 2026 22:20:02 +0530
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
Subject: Re: [PATCH] PCI: quirks: Add warm reset quirk for IBM Spyre
 accelerator
To: Bjorn Helgaas <helgaas@kernel.org>, Avinash Roy <avinash@linux.ibm.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, bhelgaas@google.com,
        npiggin@gmail.com, chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Avinash Roy <avinash.roy1@linux.ibm.com>
References: <20260805171840.GA2126423@bhelgaas>
Content-Language: en-US
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
In-Reply-To: <20260805171840.GA2126423@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a74bb47 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=lNBmhb5rY3KJr28suEEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: A9CrAhuigwKofBxmnfCcLJ4S9jqP9RFJ
X-Proofpoint-GUID: LvFnR9t07Rol95n-wE_uOh-qTWiH2Xy5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEzMSBTYWx0ZWRfX0srVlo17IyM8
 GCHvlg1eoQf97TwPNmj+IylyERYu1FuQTYWGmHs50pmU+6n2tg6c0oSLjGXSbrhEoHYhQWc8VOv
 UdNoe+xstgmTo7URo3sFwRlW3YQecTw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEzMSBTYWx0ZWRfX30k6tIyX9/0Y
 hVu7CVXerDNsdRZJrSmUneKKfa3juUzkXerZqx+WirCXg/F2vfcpx/mY1HSK3ova3muZyDR+S+F
 Hq53TLO/FazxXFQ1hKKGINeRxJjurSA0g4u6B4gKjT1k1+nlTOfqFz86ySi0yrrXU6YMieGduQo
 x25UeGLgZEHHkyAN2JELunV5ridXnuO7zLv2jC+w4PAC4xiQ1mZ8RWf500JGH0wpo9oepIb+itM
 q4jeQxrN5bKhwDMo1uibRRPtQv7MxJ79gUWPpT159LewXCX9mOBanP/NSt9wRq2ORzrZklPlBs/
 /j6m+PYBpXFS7sXl9Hdci90tFoZbshL0efZPKuygf+odI70Aj/9HPk0ymazRuXVcKTCPJpF9JLG
 ChLELbKXInS8PqDr2ydbS3F0C+i6oxT6A7/2NsoDXQw/4ANKvXqh2OZzUDwcnsPlWCo6Yjh+iAj
 CXRbGxkcql8Y62t3I6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060131

Hi Bjorn,

Thanks for taking a look.

On 8/5/26 10:48 PM, Bjorn Helgaas wrote:
> On Wed, Aug 05, 2026 at 06:21:32PM +0530, Avinash Roy wrote:
>> From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
>>
>> The IBM Spyre accelerator (PCI ID 1014:06a7) requires a dedicated warm
>> reset method for reliable EEH recovery on pSeries/ppc64 platforms.
>>
>> FLR alone is insufficient because it does not re-initialize the Spyre
>> firmware state machine. On ppc64 with EEH enabled,
>> pcibios_set_pcie_reset_state() is overridden in
>> arch/powerpc/kernel/eeh.c to drive the platform-level PERST# signal via
>> EEH PE operations, which is the correct mechanism for full device
>> recovery after an EEH event.
> 
> This makes it sound like this mechanism is needed for EEH recovery for
> *all* devices, not just Spyre.  If that's the case it sounds like we
> need more than just a Spyre-specific quirk.

Now I re-read it, The second statement needs to be re-worded. It does 
sound like its true for all devices. Quirk is only for the Spyre card.

Will post a v2 fixing the same.

Thanks and Regards,
Shivaprasad

> 
>> The reset function is placed in arch/powerpc/platforms/pseries/pci.c
>> where the EEH infrastructure is already present, declared in
>> pseries.h, and registered in the generic pci_dev_reset_methods[] table
>> in drivers/pci/quirks.c under a CONFIG_PPC_PSERIES guard.
>>
>> This reset method is only registered when CONFIG_PPC_PSERIES is enabled,
>> so it is not available on other platforms.
>>
>> Reset sequence:
>>    - Assert PERST# via pcie_warm_reset, hold 250 ms
>>    - Deassert PERST# via pcie_deassert_reset
>>    - Wait 250 ms for PCIe link retrain and device recovery
>>
>> Signed-off-by: Avinash Roy <avinash.roy1@linux.ibm.com>
>> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
>> ---
</snip>

