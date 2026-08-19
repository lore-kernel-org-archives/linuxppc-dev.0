Return-Path: <linuxppc-dev+bounces-25982-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453C1C5B572
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2026 15:34:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQ9cJ0d5Wz2ySm;
	Thu, 20 Aug 2026 01:34:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787153696;
	cv=none; b=XcF/NWqajiDWuzRo6mnHsQLhy9FIi4O6MItiDokCIUbVDRMXpzugMPTxlYXm7kNiPHrag4dX5l3f5ayUxAzSDA7nHOHMxWzutfrfe/3Zmt2I1zblqQjRSkiWIpvcl8FGStPEWvWwg+RlEdqmRALRHD7LADR6TLKqmNP6+3IZ6cOOhzeqLy5JBSJwbOH06bMwKw7iLnbdAZEM2bvU1ijBtv/Udqgp7ck/DveJ8PJ4cGxHSwxZ3sBYZL7FxRQQXzwP0gXTRo56gWfzN9go1KPrjEh+z+LqapbmZIHnHmxmKgGEBThC9a/t5FMxgJZBP1hNj9aZvhD0jQXAeBjDghITmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787153696; c=relaxed/relaxed;
	bh=mQZy0l2jU0dhkYgdxjzOmEmEKsd88LPJoDcuxUt/PAQ=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=Wlc8UtT8QpXxD5Fz46ZRndLBpAjMMucfRD0fekWut0+08+sTk2KEmQ+BgGF1E/3o4JUYE9GqcBAl+XdgNLZaMXFQ0/CnzQYSKsMQeORCFQxT+82U0UgEbkXYVT8aFk3AYb4xLOJr9B2cUGgmd4ylK3iPK+SIswbk23+pXYbwHtLxATRlFuhNBbd8HgFlqmmYL5z6FsRhH9VJywAWAm6ghAM8ABXDSGkadl/dmHV2qy+CQET3vyD8GtRA/r7oOIRu7+Dx0tbzU6AQXDtCAVdtB14fFLD9TmVwOwoyGZy11YI3ABI2u85H0Ep2yzb4jreAxYX5chHVy9d1eyOlFpBfew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UXCCQPMX; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=avinash@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UXCCQPMX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=avinash@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQ9cG5Y4Bz2yRZ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2026 01:34:53 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JF1fV13758057;
	Wed, 19 Aug 2026 15:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=mQZy0l2jU0dhkYgdxjzOmEmEKsd88L
	PJoDcuxUt/PAQ=; b=UXCCQPMX7eyLn5ecXarrC3LUUGTOdCSsZbHAlum03F/wBk
	p59yCkN6by8nzxRt0WadaLb+nfDC0ET+OGI7FmM+ilRO4SAhSKYHDlwHKI7PFc66
	aiolobxoI+HkOxFcT1pJvWeuCWHJTTYqGiNKCuSLUIwhUwwjLvZl2McCUbYtUrSU
	c+op98NAcpdKw+p7h7xltt9sGcsAsdHmciScYWyEaRHDSMDdW4bFOO9B/tH40YJ3
	BYVyLfjs1Wqoizy9ZG0CKD0TxVQChrkhdMVlPb0FNkFg952nwXtLguOlIxLPhOiq
	DY5y7YFS9yvxzy9euSA1+6kzTireI/kPNoN1MMCQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu1cp89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 15:34:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JFQFLb021617;
	Wed, 19 Aug 2026 15:34:42 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354yhd03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 15:34:42 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67JFYecd41746840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 15:34:40 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56DA358054;
	Wed, 19 Aug 2026 15:34:40 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04F6E5804E;
	Wed, 19 Aug 2026 15:34:36 +0000 (GMT)
Received: from [9.61.26.180] (unknown [9.61.26.180])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 15:34:35 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------ooQjA17V5Ifxtkv5BRtdPu6e"
Message-ID: <9d98e433-cc31-437e-9c72-12fee0711e6b@linux.ibm.com>
Date: Wed, 19 Aug 2026 21:04:34 +0530
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
To: Bjorn Helgaas <helgaas@kernel.org>,
        Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, bhelgaas@google.com,
        npiggin@gmail.com, chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Avinash Roy <avinash.roy1@linux.ibm.com>
References: <20260806172645.GA2192955@bhelgaas>
Content-Language: en-US
From: Avinash Roy <avinash@linux.ibm.com>
In-Reply-To: <20260806172645.GA2192955@bhelgaas>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=LsCiDHdc c=1 sm=1 tr=0 ts=6a85cd13 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=r77TgQKjGQsHNAKrUKIA:9 a=VnNF1IyMAAAA:8
 a=DMY3FJNNxLzGxDKSYhcA:9 a=QEXdDO2ut3YA:10 a=POafy96MoCDh9nv-CjMA:9
 a=fOHooOhWFk7W7E98:21 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10
X-Proofpoint-GUID: rRXjCxzg2A0KYQYEB8BCpeAMb1fmuR1w
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEyMSBTYWx0ZWRfX4MoS0K12PrVt
 vIk9JSx6O9P8BoHd5HPbXcgJIL8nH38L34jK0u2epcHOkKYe3r5OZq9oyjEIPZtUJX+DiB/7HcW
 pIhnGDO4og5Vvz1gESUVcRefmYDv29g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEyMSBTYWx0ZWRfX1kqNdHA1sDqJ
 oCyeNXrLGS/6zA6RUo2HHxGpy7XpRaVGHOruEeYzNeN4TQs1WlNWabx1MfJ6BmM9WxhrkBG8YqO
 nfhZvPtcUceXTlz4ItV0PiSjP1kuwjPD49GS0732ewWjkQT8HjKiak9BmMYCzyDSZOW3+D2UJls
 2AkQUTrqKbGmE7iiCqTjBxEmm62dCQESDOS+hl7qYKqafd+0qTevdNMvagJ3WFRVt1GGxJjgZya
 dIaesug+IbDH8M6Oq4ib8jzXnhisRp2ba1JQ6CbtYmHFAR19hZ5t+k/f+MSdofeayJR1K0eTdQw
 lLebdXdNnEvOA0zC1+SJvANIr3PcD4isW5t72Z9yGszAetR03q1Qvj4pd4vaghBrbx22Ib6mYN4
 OhQbXYUpm4haGXeuvZtHiSxl/25u8asFL8Eu4ort0d+G6HJ7TH8isrJiJFROQ1ZAAVN1p9vQgmm
 SiWtz1b7Rh2rALB0KFw==
X-Proofpoint-ORIG-GUID: w3jpA6nLaht1sy63wUKTooYpMm0yFd9V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190121

This is a multi-part message in MIME format.
--------------ooQjA17V5Ifxtkv5BRtdPu6e
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/6/26 10:56 PM, Bjorn Helgaas wrote:
> On Thu, Aug 06, 2026 at 10:20:02PM +0530, Shivaprasad G Bhat wrote:
>> On 8/5/26 10:48 PM, Bjorn Helgaas wrote:
>>> On Wed, Aug 05, 2026 at 06:21:32PM +0530, Avinash Roy wrote:
>>>> From: Shivaprasad G Bhat<sbhat@linux.ibm.com>
>>>>
>>>> The IBM Spyre accelerator (PCI ID 1014:06a7) requires a dedicated warm
>>>> reset method for reliable EEH recovery on pSeries/ppc64 platforms.
>>>>
>>>> FLR alone is insufficient because it does not re-initialize the Spyre
>>>> firmware state machine. On ppc64 with EEH enabled,
>>>> pcibios_set_pcie_reset_state() is overridden in
>>>> arch/powerpc/kernel/eeh.c to drive the platform-level PERST# signal via
>>>> EEH PE operations, which is the correct mechanism for full device
>>>> recovery after an EEH event.
>>> This makes it sound like this mechanism is needed for EEH recovery for
>>> *all* devices, not just Spyre.  If that's the case it sounds like we
>>> need more than just a Spyre-specific quirk.
>> Now I re-read it, The second statement needs to be re-worded. It does sound
>> like its true for all devices. Quirk is only for the Spyre card.
> So I guess this is related to some Spyre erratum?  Per spec, FLR is
> supposed to "set all Function-specific state machines to their
> initialization values" (PCIe r7.0, sec 6.6.2).

Yes, This is for Spyre card specificchanges. The card requires an explicit warm reset to restore it to the 
proper initialization state.

--------------ooQjA17V5Ifxtkv5BRtdPu6e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 8/6/26 10:56 PM, Bjorn Helgaas
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260806172645.GA2192955@bhelgaas">
      <pre wrap="" class="moz-quote-pre">On Thu, Aug 06, 2026 at 10:20:02PM +0530, Shivaprasad G Bhat wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">On 8/5/26 10:48 PM, Bjorn Helgaas wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">On Wed, Aug 05, 2026 at 06:21:32PM +0530, Avinash Roy wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">From: Shivaprasad G Bhat <a class="moz-txt-link-rfc2396E" href="mailto:sbhat@linux.ibm.com">&lt;sbhat@linux.ibm.com&gt;</a>

The IBM Spyre accelerator (PCI ID 1014:06a7) requires a dedicated warm
reset method for reliable EEH recovery on pSeries/ppc64 platforms.

FLR alone is insufficient because it does not re-initialize the Spyre
firmware state machine. On ppc64 with EEH enabled,
pcibios_set_pcie_reset_state() is overridden in
arch/powerpc/kernel/eeh.c to drive the platform-level PERST# signal via
EEH PE operations, which is the correct mechanism for full device
recovery after an EEH event.
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">
This makes it sound like this mechanism is needed for EEH recovery for
*all* devices, not just Spyre.  If that's the case it sounds like we
need more than just a Spyre-specific quirk.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
Now I re-read it, The second statement needs to be re-worded. It does sound
like its true for all devices. Quirk is only for the Spyre card.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
So I guess this is related to some Spyre erratum?  Per spec, FLR is
supposed to "set all Function-specific state machines to their
initialization values" (PCIe r7.0, sec 6.6.2).</pre>
    </blockquote>
    <pre wrap="" class="moz-quote-pre">Yes, This is for Spyre card specific <span
    style="white-space: normal">changes. The card requires an 
explicit warm reset to restore it to the proper initialization state.</span></pre>
  </body>
</html>

--------------ooQjA17V5Ifxtkv5BRtdPu6e--


