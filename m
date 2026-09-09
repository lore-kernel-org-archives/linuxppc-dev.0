Return-Path: <linuxppc-dev+bounces-26885-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD88C79FAD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 06:20:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfrJ64zt2z2yrP;
	Wed, 09 Sep 2026 16:19:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788934790;
	cv=none; b=LNGh3lFeRvHi2cASsFiJ3m04xxmT42TjdkwLKwjnmWE2DhoarGtbmmQ/uZnQSnHlzR9KVKa9VRJMkK1xeMWJex+3wo8vNNeDayVTFIacXEmOwmW9POTAl6s7QXrnqXmp5jp58PBLiCDO1ig7B06cDmY/wvCu7CHJdFlLQ+ioyrRiBkz8himE/Qzv+SMRuixBCcTVN66naiRBOUO0w3fMM9y0SPy6iZxJOzs/jVGQxUEb3ca2gVl2z/MJdRMTBQNrc8hAqxFXBRdv1uvji8Q93wjDKYwm+emNNFLjB09jhq6y9G7OL0jN1CzElib52HgmyDgoZg8zPgzomJdVmIFrWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788934790; c=relaxed/relaxed;
	bh=umSG5zkQo9n8ak7oNcq8X7rJyP5FwV1uIQNFDgN3tVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PxTv7aJBV4MRFUbGpamf0fBfmoA8Y0uJtooUAVJrwpNiq0x7LLI7PEaWGGrG36YPrmDIePCONzAPLkTG9oRxsdfQG5vQlXmgMZ4tA/s6mxEi7tQ3+h1OXRm/LDWfvLZ4/lrHdMedklstOsMmL+kUJ98+UOqo3YVyxYM7c5sPh0fZidkAmIA9Tm0bg2yAzaLFhtjo9VG18RkX7Etixg+TP/YRx/7zaFmpkdERA3gHc/yg2tB4CJ/21oup2a6iBVAZVLhtejJ1NEQ8kH/v0ibsupkNtAqwqEdfkV+FKifz7K0mPe075TpIMM5DmaZKZVy8q3myJGi9mOj+jTUCtS5/cA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YRhcY7lR; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YRhcY7lR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfrJ55fHjz2yr9
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 16:19:49 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688N1aqp1116393;
	Wed, 9 Sep 2026 06:19:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=umSG5z
	kQo9n8ak7oNcq8X7rJyP5FwV1uIQNFDgN3tVg=; b=YRhcY7lRMo0bEScJk/vj78
	ACiXGN63l+xJBYlhsb3mmTsPl+kVQasSOX4qknJmze2sXqzDJ3FVS4vorDMV8mDG
	KgX/svP+4OT29lXeTS5d3FcTivZuKiBax+j+j7aX2WHb/BHp0G/Y/RUNXgMwKSgg
	4FosQEWQAyuuv3fmwRkT5Y6YUpmjhk8cCB7YwCzMdMw1rOvdnnZsqzQjKnUaIX6+
	pJzTU0Lqg6/u3g5gK1ndF4Tsckq+bQfFnEo2Xdk41CIsHzXznJsiiPP6kAHV3lCg
	T5/bJ2fZLj2MpJpLQFLiTglOvsaGJn+9ky5LcRTxJJ923U7Xp4kXX3sE0/0/WAOw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbjruqcc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 06:19:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6896BMxe008904;
	Wed, 9 Sep 2026 06:19:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggymggfwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 06:19:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6896JGxB12321220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 06:19:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 735CE2004B;
	Wed,  9 Sep 2026 06:19:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C762E20040;
	Wed,  9 Sep 2026 06:19:12 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.64.17])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Sep 2026 06:19:12 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Jiangshan Yi <yijiangshan@kylinos.cn>
Cc: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        nayna@linux.ibm.com, gcwilson@linux.ibm.com, kees@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        13667453960@163.com
Subject: Re: [PATCH v2] powerpc/pseries/pci: Fix misleading VF limit error message
Date: Wed,  9 Sep 2026 11:49:11 +0530
Message-ID: <178893459272.174069.11231777088972821976.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813063731.399598-1-yijiangshan@kylinos.cn>
References: <20260813063731.399598-1-yijiangshan@kylinos.cn>
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
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E7T9Y6dl c=1 sm=1 tr=0 ts=6aa0fa69 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=tdvlz4ZTpqE6WLztEXcA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA2NiBTYWx0ZWRfX8DznUlwjG4Li
 qG+4RK0fx8wPsuHJPgCxP7+F9APlSUfQCq6B3UPRlJDANOjYiBCFdBEXQyZtgVvr0wqUC+HiUMb
 dF+Qku/5Xs/QAAC05oq4mJYY95gIG+Y=
X-Proofpoint-ORIG-GUID: v126GnCJKoZU13sEZAauUgimU6MIyq_w
X-Proofpoint-GUID: KtG5DEIHQ2TQQkLjpDfcReegHPznyS8P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA2NiBTYWx0ZWRfX99J1kYga5iNf
 IK9AtsUspAxDZ0FDGfGokSUz65xXO5mz1gI6+fAE+EF5/hr7/83wbNqSuOXObtj2F0/DC+eTOQG
 +BFHqWiFWeXfVXMVZ2dsyRzfne5CSgUnxL2lMGYEf/95oDt4ACk6HpMI7cOl+JDcsc1qXCjbK6v
 Pl0LuaMU3R8vxOUmJX4BtJDjxM4/cHwvjDDpcqzLLMt/FNPpz5UhghA3gc1zPD/Fy+VkNqAgLHt
 ySyeztwLffo4upA0l6dpmIejCq/Oa+1fdUKB4yTc0R4/GW+wN7Lh3sP00/zKRTF8xL9NcQzjkTB
 7FRbzr+E9ryefwETHfz7K+ro1qWZXVPHUufK/L9NtIGvwt3FiVp+L3epO8gp9EXpC7uoy+kXgzz
 gLI+zyJSxooUNM3FS43eI1Hc2mxtycKEY8Qyqp3qJtja7PAtxayeaILoIb9LVY+5p/Ly5HIvhwF
 G2RoH0+THNu9xxcvVEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090066

On Thu, 13 Aug 2026 14:37:31 +0800, Jiangshan Yi wrote:
> When the number of requested VFs exceeds MAX_VFS_FOR_MAP_PE, the
> message prints that limit but labels it "Configurable VFs". Report
> the configurable VF limit and the PE mapping limit with separate
> error messages.
> 
> 

Applied to powerpc/fixes.

[1/1] powerpc/pseries/pci: Fix misleading VF limit error message
      https://git.kernel.org/powerpc/c/b1824233b19c1dffdb5e81283805a9e52e763caa

cheers

