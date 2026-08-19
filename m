Return-Path: <linuxppc-dev+bounces-25983-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3298FC5DF81
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2026 16:05:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQBHr1fY2z2yT0;
	Thu, 20 Aug 2026 02:05:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787155544;
	cv=none; b=Zwk02F2MO+rBHtGD8KnI5TSjXr6T0wirejFpFWXqWWcz8lnKTkzLtb6vxbi0Gk5jKCjfmRfPyZ7pcFQ3PPaZG4UA363P86rV53Qv/uWQgMw/XHgOkJBChR9+mhSKy1uMld+AWKm+lkYZhpPLolQBuT/11/HtCa4cnWf1TlvKL3ZklnKV+OWIqgOC7LHToXkpsqwyAApBs6JRb6vggWbwHN8SIL1DWeWKgROcNPUiMzIwXFxgcm/Auf3MaRgRqjKR8uxHWXkilYXKqFfVJIKRZMUyhPGHqFMkCqmDzTTzFsm2HYpJDtdh2DmNEOCNTjDRMJ3/IE4oTrBIrMikmj6SEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787155544; c=relaxed/relaxed;
	bh=AV9+PaP7c3dWQBe1v5MWniVZxA/yih/PlQh9j83z5vo=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:Cc:
	 References:In-Reply-To; b=Fgk4ZcRqiWEod7geJoh60YbjiLUEBUWCD9AIjLdm1Veo0aAbyULNiPr9v7SuJ6qM/gBUXFHgCqy0FvChUpmSbwDp8Sj46bJKGn76XvQhyW0IEVjIJvtD7RAUAgIKSbA70iBdkubs6XOir6VqcuONcMDu0AeA1larUt4RpL/SfHE8N9tW16CfjfUZ/m3O8UfapdlEKrHUo848s6VM2na1aSIF2QNLVybxVrgi3bt9PmRcvs/caBiUGJ+Laep4eud7Pbn5E8IqrQ9utOCB6uo+YFhQOpZkAe/oYLhW4xZF1CiWvYj7QBZBE4ZzsLgMZjrWccJRboM7T4CO6FmKmnV25Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=V87dHvmg; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=avinash@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=V87dHvmg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=avinash@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQBHp6p1Rz2ySm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2026 02:05:42 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JF21m73696416;
	Wed, 19 Aug 2026 16:05:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=AV9+PaP7c3dWQBe1v5MWniVZxA/yih
	/PlQh9j83z5vo=; b=V87dHvmgUDjZVXCR1eiyXDku0rroCieJO1Zo6ByR9CIqgr
	rXUrAeujxfD+aRhidK1sj/mynqdCpqdEXuFdBgPrgx97WbtCEIwSq6xhIIaFXyfk
	UcZ6D598Qu7Cfqy2VBi/kyij2BYV6mhGnhcDJUSG2kJAtargYkIDHL4EAEYOrq37
	yg0RY71BqggyNRj+Cjhb9wC2I6+4+/aNDstFSYof+n+ij1mNL2mv/JxylSCf+AxP
	EvkldxliVwdHpSOypH0C4DEcZsutT2jNjVa1/mmecSPPvL7y3WZntVXDoPoNGa2Y
	gSRR82ARblOBET9hvIbldsAg9/swb81+85dd+uDA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu44qxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 16:05:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JFuGgs007966;
	Wed, 19 Aug 2026 16:05:28 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eq9wkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 16:05:28 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67JG5OqZ28443246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 16:05:24 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DA4958055;
	Wed, 19 Aug 2026 16:05:24 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1F7258054;
	Wed, 19 Aug 2026 16:05:20 +0000 (GMT)
Received: from [9.61.26.180] (unknown [9.61.26.180])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 16:05:20 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------ah2bf0sPeMXEweMWYCWcz5ou"
Message-ID: <1401d70e-0048-406b-ad78-6e0f8b32e107@linux.ibm.com>
Date: Wed, 19 Aug 2026 21:35:18 +0530
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
From: Avinash Roy <avinash@linux.ibm.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
        Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, bhelgaas@google.com,
        npiggin@gmail.com, chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Avinash Roy <avinash.roy1@linux.ibm.com>
References: <20260806172645.GA2192955@bhelgaas>
 <9d98e433-cc31-437e-9c72-12fee0711e6b@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <9d98e433-cc31-437e-9c72-12fee0711e6b@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEyNSBTYWx0ZWRfX2KvoN2+XGo4M
 gU8CalWwzhFci0zoLe9M1zrgICtylqTSBiIL2MoNZF1UZrnu8JuxKO37k/DHPM8jpZvlqq54Azx
 OH7qJwAKPgpoHCa3KOjf+TFd3MNhFbs=
X-Proofpoint-GUID: TCdDQqWd-3Ga-Qao3EmzrHLlGeCgdoHN
X-Proofpoint-ORIG-GUID: zbR0DTl4QpjRsgPj4bojB2PfI2xKZ0T6
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a85d449 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=r77TgQKjGQsHNAKrUKIA:9 a=VnNF1IyMAAAA:8
 a=-MZmP4MAjQaxQ1s9vKsA:9 a=QEXdDO2ut3YA:10 a=POafy96MoCDh9nv-CjMA:9
 a=X9rkhNw43GTF4Bv_:21 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEyNSBTYWx0ZWRfX6kCOBUd79B0u
 gl51PTrbFfCfo+Iks4pbv+u3GwwOyzI8oQmbHSy2Xgh1vxgt3FtHHruX+bZsms84pyInMbeBfSW
 WaDa0GBKIWBaV+ZcwwlqILktvYowM6JHGIJA2fGwNSy7MLjGqyt+8NpPvJtWMMumOlMnilZh7Gi
 Wh3cbyFx5ahG1UGBr1vku+N3a+mdgGZuRQWpAIoaGxmij4L6vR8SsPmxtR+zalGxIP4kCcE9B3m
 IducAxoTM2kbSIbzJPoP+F6178jEnfGp2abExNMZOysbRdITHR7Su7BRMcU8b6Quy4YLkCe+9Uj
 Ab2bZ28Acks0G4/DMOc3ZxCeRPBWbgKb7bzAl8f1rcJpSmJCGqY41U2ogt8is5PQKNC9SpWgnnZ
 T5smVlEtrxmVt3ls7e855ExS7fveoNSkBwA36vCjv/You5p7CI8x2rqe/Tmg+Nfr530RQ5qs3ph
 VpudU3nLVxfR6AWqZkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190125

This is a multi-part message in MIME format.
--------------ah2bf0sPeMXEweMWYCWcz5ou
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/19/26 9:04 PM, Avinash Roy wrote:
>
>
> On 8/6/26 10:56 PM, Bjorn Helgaas wrote:
>> On Thu, Aug 06, 2026 at 10:20:02PM +0530, Shivaprasad G Bhat wrote:
>>> On 8/5/26 10:48 PM, Bjorn Helgaas wrote:
>>>> On Wed, Aug 05, 2026 at 06:21:32PM +0530, Avinash Roy wrote:
>>>>> From: Shivaprasad G Bhat<sbhat@linux.ibm.com>
>>>>>
>>>>> The IBM Spyre accelerator (PCI ID 1014:06a7) requires a dedicated warm
>>>>> reset method for reliable EEH recovery on pSeries/ppc64 platforms.
>>>>>
>>>>> FLR alone is insufficient because it does not re-initialize the Spyre
>>>>> firmware state machine. On ppc64 with EEH enabled,
>>>>> pcibios_set_pcie_reset_state() is overridden in
>>>>> arch/powerpc/kernel/eeh.c to drive the platform-level PERST# signal via
>>>>> EEH PE operations, which is the correct mechanism for full device
>>>>> recovery after an EEH event.
>>>> This makes it sound like this mechanism is needed for EEH recovery for
>>>> *all* devices, not just Spyre.  If that's the case it sounds like we
>>>> need more than just a Spyre-specific quirk.
>>> Now I re-read it, The second statement needs to be re-worded. It does sound
>>> like its true for all devices. Quirk is only for the Spyre card.
>> So I guess this is related to some Spyre erratum?  Per spec, FLR is
>> supposed to "set all Function-specific state machines to their
>> initialization values" (PCIe r7.0, sec 6.6.2).
> Yes, This is for Spyre card specificchanges. The card requires an explicit warm reset to restore it to the 
> proper initialization state.

Sorry about the typo. This is for the current version of the Spyre card, which requires an explicit warm reset to restore it to the proper initialized state.

Thanks & Regards,
Avinash

--------------ah2bf0sPeMXEweMWYCWcz5ou
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
    <div class="moz-cite-prefix">On 8/19/26 9:04 PM, Avinash Roy wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:9d98e433-cc31-437e-9c72-12fee0711e6b@linux.ibm.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 8/6/26 10:56 PM, Bjorn Helgaas
        wrote:<br>
      </div>
      <blockquote type="cite"
        cite="mid:20260806172645.GA2192955@bhelgaas">
        <pre wrap="" class="moz-quote-pre">On Thu, Aug 06, 2026 at 10:20:02PM +0530, Shivaprasad G Bhat wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">On 8/5/26 10:48 PM, Bjorn Helgaas wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">On Wed, Aug 05, 2026 at 06:21:32PM +0530, Avinash Roy wrote:
</pre>
            <blockquote type="cite">
              <pre wrap="" class="moz-quote-pre">From: Shivaprasad G Bhat <a
              class="moz-txt-link-rfc2396E"
              href="mailto:sbhat@linux.ibm.com" moz-do-not-send="true">&lt;sbhat@linux.ibm.com&gt;</a>

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
            <pre wrap="" class="moz-quote-pre">This makes it sound like this mechanism is needed for EEH recovery for
*all* devices, not just Spyre.  If that's the case it sounds like we
need more than just a Spyre-specific quirk.
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">Now I re-read it, The second statement needs to be re-worded. It does sound
like its true for all devices. Quirk is only for the Spyre card.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">So I guess this is related to some Spyre erratum?  Per spec, FLR is
supposed to "set all Function-specific state machines to their
initialization values" (PCIe r7.0, sec 6.6.2).</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">Yes, This is for Spyre card specific <span
      style="white-space: normal">changes. The card requires an 
explicit warm reset to restore it to the proper initialization state.</span></pre>
    </blockquote>
    <pre wrap="" class="moz-quote-pre">Sorry about the typo. This is for the current version of the Spyre card, which requires an explicit warm reset to restore it to the proper initialized state.

Thanks &amp; Regards,
Avinash</pre>
  </body>
</html>

--------------ah2bf0sPeMXEweMWYCWcz5ou--


