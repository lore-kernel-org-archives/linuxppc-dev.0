Return-Path: <linuxppc-dev+bounces-26498-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D473BC624A4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 16:56:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbQjr1H85z2y2X;
	Fri, 04 Sep 2026 02:56:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788454608;
	cv=none; b=RF3phmeCXS7TtEzKe5a73YWA2IZubnTrQdkc8+cbJowUjNN0ogWc4OVdkPgOwg4wJgZYeTi8/rNURfl9yQEVKvZz6wZN8zolAYQnjUBcRR2q6ImVTAnOCiLyYxAJrt4Vgi4cozTn9w15meWyu78ipyoixYIFUfYKxStE5OViLMWx5pycsZssDHzurPIiGyvtzgYKK/3MjTh8sYAWRcC5xOmCVyUQ2I+tJcpIifWXEwbD0uG72bOSI6adyne9DuhP/8Nw9oBkKsLlP93pD4OwUZ9UjXU1WQw8vkjJsRumVEeItRxmIssaTLl/TvqigREdU31K6e0pqJWPt3s6RcdiAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788454608; c=relaxed/relaxed;
	bh=PkYuOBnKxSMPtmBAHIe1yxX8ksre0sRUueo206+p7Sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kSUskelCcKDegkXBHKbA2McAi6TmVhhgyW55VYsCyFD2XvTWC8MlsvEd5Ka53Fb/0mfioJpabH8D9xRkWSNp/dVzZRMFNgvk67h8Bqtu9/irplk0ExUMqIojUNCKQdFCmVKcIaLMoQB86mQZGuIME/qcf2zzU1L5Oc/iH+AaHSaw0/efXxWtKyOHga2ZvnO7yr/o1YC4+aRHA8blnyR7S7mvDSzQqJHmT61rWYVBc7MAmTH+LxfkQC+XyF00JeAh6AXCw0uCvIVVx6mULxN/a8g5vCef02irriPt+RQzKPupY3Cm3VmWkvYM+fJqXLPBmx20aNCTEklRBhU7YM+awA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iwIwdKKY; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iwIwdKKY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbQjq2B0nz2xlv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 02:56:47 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683G2uol2292412;
	Thu, 3 Sep 2026 16:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PkYuOB
	nKxSMPtmBAHIe1yxX8ksre0sRUueo206+p7Sc=; b=iwIwdKKYz21A+uJFWpFhtk
	LmSVp/YA+o37pAQAAVwkYWX+ihnABjS/8yEAsR/88svEe1pRcpweaMDRiRxQgpcW
	9Eu1E/BJSHPQo04pGUwaWtZSEO1KChqpzNyM03Xwogw07PAOyp/9OtFCMwCrhi+l
	gzkBn20ebB0ABg8ld2sTOeIoQ1c8I5gCtPXzsiZDbO/ia9WscSnE97FFG/x8Q5Nl
	KpoERlNEgvhTu8w65pIlYIDH4ZMME2s10y+K5Qjw3YYa+SSWjlg31V6pgkfAVCZo
	WlN5zBLSdBEjI+gt6O5Ap9VSduw4invAqwPIQVtTcd/8wRXoutPfpunTx4olzdUw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnue5m5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 16:56:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683GuOZT029257;
	Thu, 3 Sep 2026 16:56:42 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gecjary37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 16:56:42 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 683Guf0J8520510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 16:56:41 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 003295805D;
	Thu,  3 Sep 2026 16:56:41 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B3B058055;
	Thu,  3 Sep 2026 16:56:40 +0000 (GMT)
Received: from [9.61.81.200] (unknown [9.61.81.200])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Sep 2026 16:56:40 +0000 (GMT)
Message-ID: <ae274c2b-cc1a-414b-8e79-41eb7c68a596@linux.ibm.com>
Date: Thu, 3 Sep 2026 09:57:21 -0700
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
Subject: Re: [PATCH] scsi: ibmvfc: Add Kconfig dependency to fix link failure
 when NVME_FC=m
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        James.Bottomley@HansenPartnership.com, mkp@kernel.org
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavrampu@linux.ibm.com, brking@linux.ibm.com, davemarq@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org
References: <20260903074329.6705-1-venkat88@linux.ibm.com>
Content-Language: en-US
From: Tyrel Datwyler <tyreld@linux.ibm.com>
In-Reply-To: <20260903074329.6705-1-venkat88@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IUZzmbX7od1_g-NjyLzHSC5YfgOx0gP_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE0NCBTYWx0ZWRfX7nLK9tacXoxL
 b5OGMid/wWbAY5iYdQHcNH0PlXO5hzD/NFjiDU9PfLTfvDthj8l5RPlyJq5K1ck0eLaC40fho5+
 thBerZjdKwjcX5LtvvAce/QWHa5l5u3//GNgjZ0El9T+XhGYIcJyg/NsPKra9PjfDotuQne5CXC
 ZsmVZyVxPCf2xKBMicbTpuj2XDddShwV2IYjnh/u11PR1pV9LyHx4sM+CdniD/MctUbQzYFx9Kx
 +CHRZ+bVn/YIFcC8xlpu5kF9EKvXgk044dYnbbRYE51mDQNge4MgTyjtudMSAnOZvnlySg5KfxV
 ZLMO5KGsqOZPq3gxEav8hddjOahNVDoTlRx/qCwC7PDc0khmm+kQ4YRV6qlXEM05suEvkV9D6CK
 m71Xnb8gBDwQsz3ZJ46ZMdcUPuekaoIlVV8BdeYJQOnLYOs8mdLrS6pxq57nJ2wwED2yOobjoKq
 CwFoBtSNLh303mHFnYw==
X-Proofpoint-ORIG-GUID: IUZzmbX7od1_g-NjyLzHSC5YfgOx0gP_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE0NCBTYWx0ZWRfXwYHyF54/8TWG
 wmmjzfhPkuQtVKJEQbuL4puwtw+jAUdZuIef0/fxJCRZ9Hsq2NnIzVqNcNHbzf8RzhysCqbZgMB
 h1aW66nbqvnP6D8IxnkYvFbL5q/UEt4=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a99a6cb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=l6V8SbYLYiLwnwxNSpgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1011 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030144

On 9/3/26 12:43 AM, Venkat Rao Bagalkote wrote:
> Building with CONFIG_SCSI_IBMVFC=y and CONFIG_NVME_FC=m results in a
> link failure:
> 
>   ibmvfc-nvme.o: undefined reference to `nvme_fc_register_localport'
>   ibmvfc-nvme.o: undefined reference to `nvme_fc_register_remoteport'
>   ibmvfc-nvme.o: undefined reference to `nvme_fc_unregister_localport'
>   ibmvfc-nvme.o: undefined reference to `nvme_fc_unregister_remoteport'
>   ibmvfc-core.o: undefined reference to `nvme_fc_rescan_remoteport'
> 
> IS_ENABLED() evaluates to 1 for both =y and =m, so the nvme_fc_*
> call sites are kept in the object file. When SCSI_IBMVFC=y (built-in)
> but NVME_FC=m (loadable module), the linker cannot resolve these
> symbols at vmlinux link time.
> 
> Add the same "depends on NVME_FC || NVME_FC=n" constraint already
> used by SCSI_LPFC to prevent this configuration.
> 
> Reported-by: Pavithra <pavrampu@linux.ibm.com>
> Closes: https://lore.kernel.org/all/327877a29337aa526cc50ac88fbddb86@linux.ibm.com/
> Signed-off-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> ---
Acked-by: Tyrel Datwyler <tyreld@linux.ibm.com>

