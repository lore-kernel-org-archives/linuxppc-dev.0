Return-Path: <linuxppc-dev+bounces-24302-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4795C44501
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2026 18:41:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0lQ76psmz2yl0;
	Thu, 16 Jul 2026 04:41:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784140911;
	cv=none; b=VSIUVPvTgcs+Kcg57VnQ5bY1LvAD12Nqh3ScQxIkAhDav1C3wJW+WvXHvKmaJrVKRpakaLHC6Pk6M0yXlpne2R48oh44ED/x/Z1xEJVoi3SxIEqKcIxLbtf89ynkU2nx9UyRTQXWxy/ZBU9xMHfkY/xFoUKar0M2cQkADCKfI0xCu/4HKjkXEd9jn4OSKzck6r2tPOdQmPCughtYZbmtJCExhGIN7bUjqWqgP/z1O8lUnmQ8r3LaaRZX1JQW8gNVPU4+teMJnYBLcpvYdpR2uJpWFNWHQD+vccRmSknlXaPsFD1zOtFWcZKHnAjPvlPvmWUAXijMYvJzyRSQTWsmVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784140911; c=relaxed/relaxed;
	bh=AU2qqpVkJ4Y1G0kRmFGwIVNlvv6tjYFR4p5t3kE76Yc=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=AWoig/D0HPqOjG6fUUkgV+getydmHG1Ta7cX3bc5AFOe8HBt7QcB92S+J2/CxeHKhMC2W5pkpEMtoxDBqExT7t7bhB2arZA/cx1nX9UBWP8F7FWloB7aOCbYwt+GrK7ir6ys4gIhsPKxZQ4W223+wBPdFPeZnZ6UFrECLZNAe4jLS4JoZeWR3ao2MzjGOn9Uwk+beq8rLHNyetgisUX8d72DlI4IxYlUQetQuOTZeDceOrTwoT0I3Cn/UybyF7R1HuJx2W+7Ymn7pLeahvkAmCon2pWxotm/MC0tdXPEWD+OtB4ov5omadbLajhnG96gtyBROKBU+blYim+OGybCYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KEf2OBI9; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KEf2OBI9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h0lQ70M9yz2yY1
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2026 04:41:49 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FHCAC73094425;
	Wed, 15 Jul 2026 18:41:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=AU2qqpVkJ4Y1G0kRmFGwIVNlvv6tjY
	FR4p5t3kE76Yc=; b=KEf2OBI9Fdw8C4PY9OOpf246JaN0QuG+lbgzKN06dgdNQC
	efCgbZX1vggmA9bZFvF/MDOUNkJG3ojx/FaOOkPsgkIhkt/tbG9q3F0FIIWyW/sJ
	EAKuSrW2OuzO6UzpziqZj6/T7I9hFWC3gPJ35Q2jaibui/TKfxMUrCUKFeOX25nf
	eW1CCvwSfcSlg0HyETYiOYK5R++CnoMgMkq7YUTR0YcU0tap+noJOhEZzHaC5yGo
	ksYqGdJoajqSUtFAnsE6ohOH+wtPqs6utmnwTa7JcQoRYbcZJUxGjaDuja6L/7U0
	glNpI0HYxgqYzxYsctwCBBlW+Waol+SsM1JlmpeQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv33dp33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 18:41:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66FIYbg4016033;
	Wed, 15 Jul 2026 18:41:38 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhhc92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 18:41:38 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66FIfaps20054756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jul 2026 18:41:37 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4BA65805A;
	Wed, 15 Jul 2026 18:41:36 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E84BF5805C;
	Wed, 15 Jul 2026 18:41:35 +0000 (GMT)
Received: from [9.61.159.165] (unknown [9.61.159.165])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Jul 2026 18:41:35 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------SIQYUPrFNiS2ehQFzt7EOZ8m"
Message-ID: <3bb55402-aba0-40cf-b414-9d4982c238d0@linux.ibm.com>
Date: Wed, 15 Jul 2026 11:41:35 -0700
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
Subject: Re: [PATCH net-next v3 05/15] ibmveth: Refactor RX interrupt control
 for MQ RX queues
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, Dave Marquardt <davemarq@linux.ibm.com>
References: <20260706193603.8039-1-mmc@linux.ibm.com>
 <20260706193603.8039-6-mmc@linux.ibm.com>
 <20260714124327.GJ1364329@horms.kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260714124327.GJ1364329@horms.kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE4NiBTYWx0ZWRfX7eRJH5O5Qx1l
 LwFyV+3TAm846TvK4Q1QSG7ohrvwLoRF4vzA4AmoPhNZBDr8GVM4QkLHioGd3M/qdCoNji3CDNf
 bnIJoLAzR/jeB4z4DCL171nE8Ck+yEQ=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a57d463 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=r77TgQKjGQsHNAKrUKIA:9 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=F2C2ttmqdAMir2IvWxMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bXXEFKhlczlrUbFZEacA:9 a=_0g5kgeI9xMTp_xU:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10
X-Proofpoint-GUID: 3UVnk8OAsy0Ce9gSN0GBTXu2m0bikOF5
X-Proofpoint-ORIG-GUID: 8puQ4DCW4VHKArx2vCeR5uYeH-zyni49
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE4NiBTYWx0ZWRfX6rhZlzSnlze+
 kt2v0e2/CVcMgXw0VmFJ67O7E6CznTsaRwAyCvRkvfu1WzXQC87b+6p7hmnaEOh/revOs676Bb0
 sm5H0HEJC0iXeMGlreUsM+IKqaAa7+gtpbBlx7/8NOSctEUz4aeF2EliADMe5R6JTp2unJ27U/w
 /L16902Q2UiQldGw4RmjJ4N5unJLMBxIRRiNs4cI7LtEYJ8zq7eatn3o7ZMlLNOkgDrw8shmRp1
 ZhE8wEIpIO5jgqE4V32v89xC1wBPeNYwbgiP4AUwMRPQaRZCCJn47SCveFck4lj22e+JOpYgFJB
 3pDwrtp0Gj45kpmczTF9ywlQwRWpIJUz4GjGg2w2YmFNzgVa2AH7W5eZSTv+9C49CLoF2TvHMRz
 WVZ0QjslFMZ4kzMjKp6dy6/fxxdXkCEP5K9XPCKM6F70Qxt7zawtLrB8vMOrMgSL882K+3NGvCM
 pMDfgLM61h/4CEhMZOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150186

This is a multi-part message in MIME format.
--------------SIQYUPrFNiS2ehQFzt7EOZ8m
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/14/26 5:43 AM, Simon Horman wrote:
> On Mon, Jul 06, 2026 at 12:35:53PM -0700, Mingming Cao wrote:
>> Queue 0 and subordinate RX queues use different interrupt control
>> interfaces in PHYP:
>>
>>    - queue 0: h_vio_signal() after h_register_logical_lan()
>>    - queue N: H_VIOCTL against the queue handle/hwirq mapping
>>
>> The current code is single-queue oriented and cannot safely scale to
>> multiple RX queues in poll completion and open/close IRQ setup.
>>
>> Introduce queue-indexed interrupt helpers:
>>
>>    ibmveth_enable_irq(adapter, queue_index)
>>    ibmveth_disable_irq(adapter, queue_index)
>>    ibmveth_setup_rx_interrupts()
>>    ibmveth_cleanup_rx_interrupts()
>>
>> These helpers centralize queue0-vs-subordinate dispatch and make IRQ
>> lifecycle symmetric across open/close and future resize paths.
>>
>> request_irq() is wired with &adapter->napi[i] as dev_id per queue, so
>> interrupt ownership follows the NAPI instance that services that RX
>> queue.
>>
>> Signed-off-by: Mingming Cao<mmc@linux.ibm.com>
>> Reviewed-by: Dave Marquardt<davemarq@linux.ibm.com>
*

Hi Simon,


Thanks for the thorough review to the entire series!

*
> Although it is added later in this patch set, I believe linux/irqdomain.h
> needs to be included in this patch so that irq_dispose_mapping is defined.
*

Thanks, will fix in v4 — move linux/irqdomain.h into this patch

where irq_dispose_mapping() is first used.

*
> Also, I think it would be best to add these helpers in the same patch(es)
> that they are first used.  As this will avoid temporal compiler warnings
> about declared but otherwise unused functions. Similarly for patch 13/15.
*

Agreed. In v4 I will introduce each helper in the same patch that

first calls it from open()/close() (and the same rule for resize /

set_channels), move linux/irqdomain.h with the first

irq_dispose_mapping() use, and open()/close() will be converted 
incrementally; there

will not be a separate MQ-only open path before multi_queue is enabled

*
> Overall, please make sure that when each patch of the series is applied
> no new warnings or errors are introduced for allmodconfig W=1 builds.
>
> FWIIW, I exercised this using gcc 16.1 from
> https://www.kernel.org/pub/tools/crosstool/
>
> ...

**

*Will do — v4 will be checked so each patch applies cleanly under*

*

allmodconfig W=1 (no new warnings/errors), including with a

current crosstool gcc.

*
*

Thanks,

Mingming

*

--------------SIQYUPrFNiS2ehQFzt7EOZ8m
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 7/14/26 5:43 AM, Simon Horman wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20260714124327.GJ1364329@horms.kernel.org">
      <pre wrap="" class="moz-quote-pre">On Mon, Jul 06, 2026 at 12:35:53PM -0700, Mingming Cao wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Queue 0 and subordinate RX queues use different interrupt control
interfaces in PHYP:

  - queue 0: h_vio_signal() after h_register_logical_lan()
  - queue N: H_VIOCTL against the queue handle/hwirq mapping

The current code is single-queue oriented and cannot safely scale to
multiple RX queues in poll completion and open/close IRQ setup.

Introduce queue-indexed interrupt helpers:

  ibmveth_enable_irq(adapter, queue_index)
  ibmveth_disable_irq(adapter, queue_index)
  ibmveth_setup_rx_interrupts()
  ibmveth_cleanup_rx_interrupts()

These helpers centralize queue0-vs-subordinate dispatch and make IRQ
lifecycle symmetric across open/close and future resize paths.

request_irq() is wired with &amp;adapter-&gt;napi[i] as dev_id per queue, so
interrupt ownership follows the NAPI instance that services that RX
queue.

Signed-off-by: Mingming Cao <a class="moz-txt-link-rfc2396E" href="mailto:mmc@linux.ibm.com">&lt;mmc@linux.ibm.com&gt;</a>
Reviewed-by: Dave Marquardt <a class="moz-txt-link-rfc2396E" href="mailto:davemarq@linux.ibm.com">&lt;davemarq@linux.ibm.com&gt;</a>
</pre>
      </blockquote>
    </blockquote>
    <b style="font-weight:normal;"
      id="docs-internal-guid-3507f67c-7fff-3d5d-9d81-31c9627b2d82">
      <p dir="ltr"
        style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span
style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">Hi Simon,</span></p>
      <br>
      <p dir="ltr"
        style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span
style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">Thanks for the thorough review to the entire series!</span></p>
      <p dir="ltr"
        style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span
style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">
</span></p>
    </b>
    <blockquote type="cite"
      cite="mid:20260714124327.GJ1364329@horms.kernel.org">
      <pre wrap="" class="moz-quote-pre">
Although it is added later in this patch set, I believe linux/irqdomain.h
needs to be included in this patch so that irq_dispose_mapping is defined.
</pre>
    </blockquote>
    <b style="font-weight:normal;"
      id="docs-internal-guid-16d6fd33-7fff-b844-efa9-dc554c7d6051">
      <p dir="ltr"
        style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span
style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">Thanks, will fix in v4 — move linux/irqdomain.h into this patch</span></p>
      <p dir="ltr"
        style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span
style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">where irq_dispose_mapping() is first used.</span></p>
    </b><br>
    <blockquote type="cite"
      cite="mid:20260714124327.GJ1364329@horms.kernel.org">
      <pre wrap="" class="moz-quote-pre">
Also, I think it would be best to add these helpers in the same patch(es)
that they are first used.  As this will avoid temporal compiler warnings
about declared but otherwise unused functions. Similarly for patch 13/15.
</pre>
    </blockquote>
    <b style="font-weight:normal;"
      id="docs-internal-guid-0a4aa8fa-7fff-8247-249c-fbc3e0470937">
      <p dir="ltr"
        style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span
style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">Agreed. In v4 I will introduce each helper in the same patch that</span></p>
      <p dir="ltr"
        style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span
style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">first calls it from open()/close() (and the same rule for resize /</span></p>
      <p dir="ltr"
        style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span
style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">set_channels), move linux/irqdomain.h with the first</span></p>
      <p dir="ltr"
        style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span
style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">irq_dispose_mapping() use, and open()/close() will be converted incrementally; there</span></p>
      <p dir="ltr"
        style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span
style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">will not be a separate MQ-only open path before multi_queue is enabled</span></p>
    </b><br>
    <blockquote type="cite"
      cite="mid:20260714124327.GJ1364329@horms.kernel.org">
      <pre wrap="" class="moz-quote-pre">
Overall, please make sure that when each patch of the series is applied
no new warnings or errors are introduced for allmodconfig W=1 builds.

FWIIW, I exercised this using gcc 16.1 from
<a class="moz-txt-link-freetext" href="https://www.kernel.org/pub/tools/crosstool/">https://www.kernel.org/pub/tools/crosstool/</a>

...</pre>
    </blockquote>
    <p><b style="font-weight:normal;"
        id="docs-internal-guid-35d5c06a-7fff-3f5a-5741-81c68f8d9787">
        <p dir="ltr"
          style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span
style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">Will do — v4 will be checked so each patch applies cleanly under</span></p>
        <p dir="ltr"
          style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span
style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">allmodconfig W=1 (no new warnings/errors), including with a</span></p>
        <p dir="ltr"
          style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span
style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">current crosstool gcc.</span></p>
      </b><br class="Apple-interchange-newline">
      <b style="font-weight:normal;"
        id="docs-internal-guid-aed5b841-7fff-77c3-8e93-665483bd81a6">
        <p dir="ltr"
          style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span
style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">Thanks,</span></p>
        <p dir="ltr"
          style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span
style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">Mingming</span></p>
      </b><br class="Apple-interchange-newline">
      <br>
    </p>
  </body>
</html>

--------------SIQYUPrFNiS2ehQFzt7EOZ8m--


