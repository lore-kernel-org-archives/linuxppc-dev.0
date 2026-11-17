Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0754606A32A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Dwa2kPeD
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTTGr1WC9z2xnZ;
	Wed, 18 Nov 2026 02:31:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794929492;
	cv=none; b=QoEdsBQ6u78+a08jQk5sjXQfmBGMm8V/XYBtmVnOnP3nK2AsrqKly+PNpVjoM+WRtcjyHTAOyH0kVAL8B9EXOe+ocwefxFrn/3tC/Oc1MkuMmV8V++7uuUM8i0xgpY4iwlJ0YdQZNK7p+mB4GgxLihDdBU/Lc/5gG7Tk9zWamZVJr7UO9+DHy1FafxgfgVOMTNU+kuQsJAzGWiEVsEvmggt4c392n8YLhpPQbz17c4w+tSPiXgx77GSHMscu0Zl02niRKSgZL3Zt0Lr6TTqgtlQ3rzCR/WkS97YQS6dUBro8lQW4boKUBd1N0xIYHYMR8Noed87wOknpJ+qj2U6OOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794929492; c=relaxed/relaxed;
	bh=GHUcsXv4NJ/0OfEH/BuftLRK3qu5u4G9nPmPrh98Nh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T3H96RDSq2F6gm5ulGHF0AE7VbXnzfIrJDs54SG3nl+Vouu2ivZSYzw6MmYCwXvaJmXXs1Wl+zdQUQcLxslENzFVLD9VjvkUtoM1InofP6cEt/M627Pkei9jGog4nAL/pY186N8yoCUHpeD0I7yIEE2oFksZq+UJ6l1nHV3IhWkuzy+M1wUsKo97KIwxCzUaCzY9q55jnHV3NI3maUzWELNQDCyUEIrDQlNjBWI2KAYGzPuHUlfE7/bSy9ma6FE5sWU/6pN1A0M0grHCHwtmR+/P9U/yhovD0WrbybtLxvSXsSFSq75jl5H6JsAH3XbzXxiCLzeSXgmvgmvU8u2YSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Dwa2kPeD; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Dwa2kPeD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTTGl2tJnz2xmk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 02:31:26 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHFQWlO1096810;
	Tue, 17 Nov 2026 15:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GHUcsX
	v4NJ/0OfEH/BuftLRK3qu5u4G9nPmPrh98Nh4=; b=Dwa2kPeDbjkpKq5du1gEf6
	2nLm22yeL6XT/+TJsUJZZ9bV4luL9p0a18XIL9j1U624fbfqTKlJQyDyD7X0Fuww
	Zh5o3p/vFDhPg487mzXIYhlvA0AgNpFLTH/ZKnBzn86elLhNKHBKFscqm96h9Rao
	EIEuF9b8b0MLcwjY7awgJm4/F68qddrKFq7rVjI/YGs9c5pfsjhYyMuseYKtI78+
	Ntpelg14HqYm4haMb1nzWwTs41LcmpaRhxLVvGKSWGtiQ7D7mNa9KLCTfFdZxTSZ
	xKq2HkjT5roFCmbn0tppue0Bl8tGf484RCl3DeZIuF3HjIKKvalxbuhVc6UvV7uA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxfat41g5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 15:31:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHC4sR5471690;
	Tue, 17 Nov 2026 15:31:14 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j02dfdhmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 15:31:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AHFV7kW51839444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Nov 2026 15:31:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89AB92004B;
	Tue, 17 Nov 2026 15:31:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C23720043;
	Tue, 17 Nov 2026 15:31:04 +0000 (GMT)
Received: from [9.124.217.181] (unknown [9.124.217.181])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Nov 2026 15:31:03 +0000 (GMT)
Message-ID: <55cd8963-eddf-4178-8498-cee671c9dbe3@linux.ibm.com>
Date: Tue, 17 Nov 2026 21:01:03 +0530
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] PPC32: Fix hard_irq_disable to follow tracing and
 lockdep state
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, maddy@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, chzigotzky@xenosoft.de
Cc: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, msuchanek@suse.de, harshpb@linux.ibm.com,
        gautam@linux.ibm.com, amachhiw@linux.ibm.com, venkat88@linux.ibm.com,
        nnmlinux@linux.ibm.com, mkchauras@gmail.com
References: <20261117131612.707038-1-sshegde@linux.ibm.com>
 <20261117131612.707038-2-sshegde@linux.ibm.com>
 <y0ar7fjq.ritesh.list@gmail.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <y0ar7fjq.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA2MSBTYWx0ZWRfX7yMp/lhxQ8Pb
 tLxZfA/4nGhmkkYtdLF+sg2rhBkXaD5nrO8mlR6HEqj3xeWga3taSiHkoJDN8lhh5YATCld+geR
 0X1Q2svsCVlwhJBbLzAgLv6zodr8btw=
X-Proofpoint-ORIG-GUID: DjUu5_H3lzpJSAmN6myhsEt5T4u_zfLQ
X-Proofpoint-GUID: aH_pkPDs35fD-Re-rBezI6xD1i6UMOoI
X-Authority-Analysis: v=2.4 cv=IaESymqa c=1 sm=1 tr=0 ts=6afc7343 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=DUkjywZXT_fQBTiHWmYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA2MSBTYWx0ZWRfX7Z/BcK9g6G2I
 hYCux9duOBIxNBHq5gl9KySBeQXQfERgDVwo6rN0McWFkNviGPKml/NknZjrwZYeuLUyxsNAyX+
 Zzeckwx+/Itoqj6xQ6guzvWfCaaIE/I4+QdXmHBA9v6irMRpGoqAimnjAxIMRcIvc8lnDYYy/1o
 xYui696OC0Se/wGHbumI+NONwJ3fQV8YeRuozHMlvNRNj0Oq+mSduKOMwVv1QX84C3AgEJS9d2Y
 65RbCBWFyV1o1PSljriQbsNf/hzWy67tVKluRv+QHWM3H1j4SQo0fJC4ZSzWVYVcCwYU3m66K6s
 fziY5ooMDS06HmZ5TyT/US2d0DHnKomGPA2KKaYQG98hh2FS7/VcKs2j9NmFCRxSCzJu05UYhpw
 NwrtSu94r10AiIta9gSqZ/MVfK11L/2+kIy358ERgSJmH6mxM8YdBCjA4u3WKMHY7niozND5S1+
 OIO2mCFwAJRbMKhev+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611170061
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ritesh, thanks for taking a look.

On 11/17/26 6:58 PM, Ritesh Harjani (IBM) wrote:
> Shrikanth Hegde <sshegde@linux.ibm.com> writes:
> 
>> On PPC32, the code for hard_irq_disable has diverged and it doesn't
>> do lockdep/tracing anymore, leading to use of both local_irq_disable
>> and hard_irq_disable on PPC32 to overcome those.
>>
>> That is un-necessary, instead simply calling local_irq_disable is
>> enough. It disables EE bit and does lockdep tracking.
>>
>> Subsequent patch uses this API in KVM code to avoid the warnings.
>> Wider use of it is possible, but it will be taken subsequently.
>>
>> Fixes: 5d38902c4838 ("powerpc: Add irqtrace support for 32-bit powerpc")
>> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>> ---
>> PS: Fixes tag is based on the historical analysis done by Ritesh.
>> I haven't got a chance to delve deep into it. Note that it is old
>> commit and lot of code interleave would have happened since
>> including local_irq_disable at some would have added proper
>> lockdep support.
>>
> 
> Yes, not sure whether we really want this this fix to go back to that
> old change?
> 
> Maybe we can add CC: stable and keep the minimum kernel version to it,
> so that it gets applied >= vX.Y+ sort of. Instead of stable backports
> picking this change and taking it all the way to a very a old kernel
> release - which in my opinion is not worth it. Thoughts?
> 
> Do we know from when we started hitting this problem? Should this be
> after we merge generic entry/exit? Or was there any previous kernel
> version too, where we were hitting this?
> 

I think we could keep below one. Bulk of the KVM specific problem
would have started from there.

Fixes: 12013e3d4695 ("KVM: powerpc: Use generic xfer to guest work function")

We do have the other callsites still, maybe they need earlier ones.
But yes, keeping very old is probably not going to be complicated backports.

@maddy, can you take care of the correct fixes tag in the changelog?
or you want to send v5?

>>   arch/powerpc/include/asm/hw_irq.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
> 
> BTW, thanks for taking it forward.
> 
> The change looks good to me. So, please Feel free to add:
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> 
> However, note that we should still get the stable tag / fixes thing
> sorted, for stable backports to do it's right thing.
> 


