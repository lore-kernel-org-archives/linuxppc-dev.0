Return-Path: <linuxppc-dev+bounces-19048-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44D8FF60C6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 06:11:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flHnV0Y21z2ybQ;
	Tue, 31 Mar 2026 17:11:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774937502;
	cv=none; b=GIZD98GUI48uQxey4PcKsaQQnSGVqelcFjc6uJr7P3e3HcN3cX9pSqRLm2M2xxmACNlx+5QLlyTxwT4qAd2JbqhpwqOMyBhTrqX+AduEgy5DovWudZZ6mmar97TkQN9J+fqubIACTUgoEQq+4TE09Jl5OcIoWVsJHmHl5nI9MJCQCxPGrNefcbSWUhnnxsZpsz9H5u/YYiInU/l9wvbWR+feo2Rqv//HqEPir4BxByWszx0S6O+ySlWMgn8ptLGQ3svYMuWRE0sPGUwx7bdVZoxRfkjd65LlZMKqinp0QDEiWbDT20laPgzXXfFeqN6k76MdaFgE5FRotcvjEcYwBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774937502; c=relaxed/relaxed;
	bh=VAF44wP2gHY4d1zEtaBQlWufh0RkH9cH7OJGJ3wpnA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LC8NoQF45/tZ+EuJ8MrgbcRzEeDVrkAiiilhKRJYGG1Uva4C/qwf5a6GT18gg+WH7ZE3O/qVJNyriBld8Bpt9VnMKlho/G4SzkTDaivQj6WeAhcQ4/S8gSXy48VnMzcfTKihiwqT2fCILrD/89wDjnPeKJlWwXExroG0EpLgBRWRwBzhdcs3zkcnnxVVd24YelezyqjV4Ot++qjrRFvt/tYG9UFmvHlipUNOosgeb+xRbx5vbk3ooIfEkxZT7lv2tFG2Uga/gNfL9Gkb9qf88RYIAE/Uj5lw3mQ3BUQemk39Cr9bCIlerLGrJMLoSJ6cbZ0I/zTrqeO/aMhH2+5zsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EVlcHK4Y; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EVlcHK4Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flHnS4yc1z2xnZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 17:11:40 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UFHUHW197973;
	Tue, 31 Mar 2026 06:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=VAF44wP2gHY4d1zEtaBQl
	Wufh0RkH9cH7OJGJ3wpnA0=; b=EVlcHK4YaA1TQzBCSTe0w3tGkhQM9PqABc/bL
	x8z86pw/a7bKEjfw5MtBblEXli1WupFQJKvwEveWz/WQkLChjPHlwcIQ0JyBvill
	esjG+x93472LR0faPPUuNZArkSlSmyMQz5fdbLS7gMp+vk3HeW5jfym9E/lkwQez
	Ss5XYg4sToLiVRDFGsJ/MCvM8uKWzbWfcUe8oWCLET7XsOSSvlIJ8QVgPi8ndCj7
	Xqc5LBo21edsQeTTv/RD5Nrwp6yCFO25+m8upaJ1QxIglOuW3Uw++03XuBPAmRkV
	TlICHf27mq82mxi3kJ706AKtw0SFd7Efoo57rxOXrbcr/42EA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dghn3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 06:11:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62V2L0g4031552;
	Tue, 31 Mar 2026 06:11:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhjqn89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 06:11:26 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62V6BMU447382988
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 06:11:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60D4D20040;
	Tue, 31 Mar 2026 06:11:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4F342004D;
	Tue, 31 Mar 2026 06:11:20 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.126.150.29])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 31 Mar 2026 06:11:20 +0000 (GMT)
Date: Tue, 31 Mar 2026 11:41:20 +0530
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/2] pseries/dtl: Use counter in !native case too
Message-ID: <actliHcBNZMjbW2J@linux.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.ibm.com>
References: <20251112111051.826922-1-srikar@linux.ibm.com>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20251112111051.826922-1-srikar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA1MiBTYWx0ZWRfX3npgWpmzdb3u
 P7G9j639jmUfoFn9fuBHy4fuF9XGqRip2gNUp7WH+V4iJMPxgCZ5I6hg9L7OdLI7IYhnojUg/3o
 3lTkfo4wpGeWSWrgTWbWslQoHhxncnwvIUwQCxfIKYtKZL163jzTbHEpvUv8tencnewDYWxoyK5
 EaMH+uyEgjhTq19SGg7JcikmQK+YBCZUUbKVRhAglKPVgE01sgJE01TnaMCdzIizzz3XwT6w7Is
 NUyjV4rjSw99cbzlfZ2DH+NKqLDVc3/J8zBR+Jm7QJVvm1k0QZsERELEtr6ksj40WxN0pADyVbm
 ty64PdAZQ+5UFxhpO0VYzjb82HHTj6ZZK0Yfx2tbVDawJmXsKpLd37A9f4bmeQrP4p9J0E2NxPO
 y5Ql7kaQGw7/wXM2tpVWP68nvNbDYrxJCnnXhfUwPIgYTTUppbWMUpcnJL1UYyj3cL1se6/ojc1
 vWZ+3LBB/t2/WfbaUFQ==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69cb658f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=iAsku9RrTobtFAOM7DsA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: BCazrVHO5eFoElMgpvId1Q3aeHQVbFnX
X-Proofpoint-ORIG-GUID: vwjn5RzLMyY_NF96QnGBWlpEseuza9Ek
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310052

* Srikar Dronamraju <srikar@linux.ibm.com> [2025-11-12 16:40:50]:

Hey Madhavan,

> Currently dtl_count is only under CONFIG_VIRT_CPU_ACCOUNTING_NATIVE.
> Its used to track and clear dtl_consumer callback.
> 

Any inputs on this?
Do you want me to repost or something?

-- 
Thanks and Regards
Srikar Dronamraju

