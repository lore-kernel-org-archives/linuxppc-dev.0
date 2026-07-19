Return-Path: <linuxppc-dev+bounces-24413-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62ED3C4450A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 19 Jul 2026 07:09:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h2vsS2LlDz2yQJ;
	Sun, 19 Jul 2026 17:09:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784444972;
	cv=none; b=b397izPfvRuX0E4J785yw5wT0sJek+Kv2dcZvLuQXynVmKxCMC/tNsTiYJ7Au6kZ1cXOU/xn3THikWncVJSo+Ec/LfIRUTpHxFE1EiKna8IoHIBUmuoBv9Fy1BtsBUR6oO+7wAfCw4PdqSkyWJe7GIlZmh9zR6icmw1oIcKlvWBS4phfdgF9BFsX3oDOPZwd8jckVrBm+XJLo93f/zGP4GUktB91tSgAgQrttcD7BZVoh2z+41347Jki3HYbAy8QxRdFEqJuNd9W6UHbMphAng9N/kiJBQWNeyw4W0RqazpB+JaJhSepYNYi8z2HbB2Bcyo5nr6a9XaDAXhtxO85fw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784444972; c=relaxed/relaxed;
	bh=NOZUa9azFhnwHZt0tWFJabR96zBoYc4KTwGj0dV68W0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LRi4C1sqDLKvR7VSIV6GHcnRgo5/LM8v+vgPTgJ1G56Mkv/22y77jC7NFuVCjGXPtQrg7wVcozvVP3GulxGJgU9L4VIBReqiI4PUwJ+nvrALK93Atomb8spGYTeM3jbJdo/QKiZV1wl2W7cd4BuZTldpQjWbWSA9gv2peLBVdZUiYpG3NEKFR7rB5OoQpokKwTm6Lm4eh41q/y3X1PRrmt2Zl3Ad0XSQZzBjXUyCO2ungiv5YA+yWPwdeQdRHDudfUv4WWZjOXY3iHmyPHTw7nvf89sgp/PKSav/g2K5PXjHqdc3bub8bgUIOZWblOahr8wewRHOnFbGXarC8NxXgQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JtGNA0gC; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JtGNA0gC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h2vsQ5flTz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2026 17:09:30 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66J5CZnT2562410;
	Sun, 19 Jul 2026 07:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NOZUa9
	azFhnwHZt0tWFJabR96zBoYc4KTwGj0dV68W0=; b=JtGNA0gCyK5a60TPOglRLL
	weMkQtcwquLleUqywvvYNbnkhgIqvMUF2bR0mpJ//MStpyGoVoYEbyEz5AAYXk+O
	Z9LuHDpP8kJwn08AEW2TkmddZRWmr8G4/blkX44C8o5f5Bb8N5wke8uF4+fvkV7l
	j0LTdqkhOtH8hERgrR0KvUMIfhw5VgHhIRjt6VlD+OXTdjvBdy6+WBogn7kIaPOc
	vvd0gLoD1LEFADXO72o6rpQmJrlbXwTBIkG6hU+NvcEaEtJiGnK2B9dTCNGfa5EJ
	geD42PQp47APWT1SErTSCO7DGPwJlSiWzxwKqBBAsyKoByxY2BatBIioEdWI20Lw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78ftm5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jul 2026 07:09:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66J74hnx005955;
	Sun, 19 Jul 2026 07:09:10 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktpry8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jul 2026 07:09:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66J796px21627248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Jul 2026 07:09:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85A8B2004B;
	Sun, 19 Jul 2026 07:09:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58EA320040;
	Sun, 19 Jul 2026 07:09:03 +0000 (GMT)
Received: from [9.124.218.25] (unknown [9.124.218.25])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 19 Jul 2026 07:09:03 +0000 (GMT)
Message-ID: <446c84c2-8639-4ecb-8a46-1e203a166e46@linux.ibm.com>
Date: Sun, 19 Jul 2026 12:39:01 +0530
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
Subject: Re: [PATCH] ppc/fadump: collect dump if the collected size is lesser
 than reserved
To: Shivang Upadhyay <shivangu@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, adri.vero.dev@gmail.com, adityag@linux.ibm.com,
        anushree.mathur@linux.vnet.ibm.com
References: <20260714173010.615682-1-shivangu@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260714173010.615682-1-shivangu@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDA2OSBTYWx0ZWRfX2/whJCHOH5ta
 U6tYMkEmvgp+z/0R3VfaDjsdlc+FmHfpL2yeWdRahh1siUDTnVg2aZu7nyfgfrNGF+HHR1iDL3A
 xkYorPTB7yC1iFCDWfB/HeSB/S6sPk3SQ8sNjgCsN6/Vkx9WqiBZm3OMZOWqS0wVvlBx6AImeiC
 dNaK99CkfYA9phMXqjXrPeEPyaHYAnWiDAMjRyOpH8inbo8ijXONKrm2ONKuZpf2rjvko9fdGQB
 2ukXfsa6Nn9hxhAtXjHTnYKxp+W94xtQZwvAEq73yODDhlyTwefTyFBo28JezoRjt1ThehwNJDJ
 xePhzuRExNfXfH+IBfiV/SQV+7fvJHdEjvu31vzY6OaYYgllIiS6mSy7iUJMBNrY6KstfTc1fw8
 iaV9AhEiUdgFMRF5LkIRvepCxKq4CP7tT/+N6niEqfOpjqr87jaJbEtjL0/iAeWRfsN5SOW6C0s
 eisJy3RQ8urqA7vcPtw==
X-Proofpoint-GUID: JVdP_FG8F3TL1qyHM0_NLU0QR-X2v-gs
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a5c7817 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=CW4pDy2IeZdmWy9cdccA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDA2OSBTYWx0ZWRfX/pk3BGNG1671
 dfAg54zo1AAcoumRwEdxkQs+9sHia7uTxXJmp8GsV4MGLJ9mkq8ryZxeRWkiHZswJ7h+64oTayI
 li9qdY7LQSRnrHexlkxTMQ+E7P9TBu0=
X-Proofpoint-ORIG-GUID: uAs7vl-SaC5vVN1AuXHG8Y8NzUSQ2PDa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607190069

Could you please reword the commit title to make it a bit clearer?


On 14/07/26 23:00, Shivang Upadhyay wrote:
> When a machine is subjected to CPUs add/remove, using dlpar
> operations, the number of collected CPU_NOTES can change.
> As per PAPR, collected dump size should not be more than
> allocated size. Reflecting the same in source.

Can you add more details about the problem you are trying to solve
with this patch and how.

Adding the error message and scenario would be really helpful in
understanding the problem.

Can you add Closes tag if it is reported upstream and if possible fixes 
tag too.

> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> ---
>   arch/powerpc/platforms/pseries/rtas-fadump.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/pseries/rtas-fadump.c b/arch/powerpc/platforms/pseries/rtas-fadump.c
> index 3bb4ac2ab6cc..19a5adaf326b 100644
> --- a/arch/powerpc/platforms/pseries/rtas-fadump.c
> +++ b/arch/powerpc/platforms/pseries/rtas-fadump.c
> @@ -469,7 +469,8 @@ static int __init rtas_fadump_process(struct fw_dump *fadump_conf)
>   				pr_err("Dump taken by platform is not valid (%d)\n", i);
>   				rc = -EINVAL;
>   			}
> -			if (fdm_active->rgn[i].bytes_dumped != fdm_active->rgn[i].source_len) {
> +			if (be64_to_cpu(fdm_active->rgn[i].bytes_dumped)
> +			    > be64_to_cpu(fdm_active->rgn[i].source_len)) {

Can you please share your observations about `bytes_dump` for both QEMU 
and a
real system (LPAR) where the number of online CPUs is not equal to the 
maximum
number of CPUs?

I agree that you're making these changes to comply with PAPR, but since 
this has been
working for so long, it would be good to have all the data before making 
this change.

- Sourabh Jain

>   				pr_err("Dump taken by platform is incomplete (%d)\n", i);
>   				rc = -EINVAL;
>   			}


