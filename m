Return-Path: <linuxppc-dev+bounces-28997-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920F8CA6002
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Oct 2026 17:19:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0Kbw1HV1z30Tf;
	Thu, 08 Oct 2026 04:19:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791393548;
	cv=none; b=HlFFnwbeM6cNcEdJcGgxhJqxzuWsLy+B5oUPfa7Aq6drqBCUbPFAX1UZbDzw7tNVYyOU3hCBR3YX/necZZdMLDStQ3qld+y4xV8Sj28cDJxf/VWo4eCTEEhPFHoCoA7eHY7RPLV1h5aw0IEShiytO8qUEqmSi+5df0j+g4UXcj2x/0XAI+XBpeIe0bDwAkJ42JPXfA25LGPOpAZRiRH7v2+AOVtQ0GHxY+Z2lkXrAhCKGN7RkpCtzwfUqykkdJF7cCC2lY1/R/r+GWd2mZBvS9/SDJjulpbfd2Ap17LfPTtSMR+g1tyihlXW4kjcGrecusT88bxnKnIfD/Ysj0TNlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791393548; c=relaxed/relaxed;
	bh=QFUZT4cZVyuL8haEG6rnP7VCFw7K75QKxT40XH5Z+t0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ok+HGytlIQH9xP74ir3nhyOC59Ca2loeWZbXgo11CAD1Ht5MEuewo0KvLnPeBfIW9FMuBtPdh4u//RabghFtEBkDQYQGcO9U4WagpoigFxf5mDipgH1RkNKT59ty7aS+sQFffkan9+EmawqIj4znhYy0Pr+CdXDMaWnK9iigP6EL4ZXTOcWRst94dqXqjrawsRU6YJP2GxmoJnyuTJlpiCvSOEJmk+5Yg41aUbrbHzDd1Ussfm3ycj/tuE8XGopVCTavE+nvq5ezBhkI+KU2PLQkSxazelFci3MVaSFFZpct/47iVDGb16T9PWAzhGGXMqdGrhkmpnXjw8Ibu7GgWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EJAanf+F; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EJAanf+F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0Kbt6Fx6z30Cj
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 04:19:06 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697F5MlL2822857;
	Wed, 7 Oct 2026 17:18:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=QFUZT4cZVyuL8haEG6rnP7VCFw7K75
	QKxT40XH5Z+t0=; b=EJAanf+FDxcZ1+lTVLY7D6iYjJV/2TbEG79oyurdefaXxw
	c/JH56mcI13FdcucbrVTO7OA/61xQcc30kKwOdhnet68+Bo8NLAfKETsc7gzIvUH
	FZBJbiteKTT+0U6ddDglWvasiE8F649qtHWsC5Nc6RDaOeel8AQRRcmHqHApJ34u
	1pq+P2x3NY42Hcl+9ivJ3nTLet40S3h9mjt33D5n1rUyuX1m3xssP9v702dklEsY
	4rH5rn9CuR1jnfHTNvPEaNlaGsEciyiJJCa2J6PPtoDGAhSmGfyaylFla45FpYuq
	dKxRYpVqnLK5gLqz3jxUZTR7/FZ1mPuZ1MUIrakQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2se5ps53-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 17:18:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 697F2Yuo802348;
	Wed, 7 Oct 2026 17:18:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5f3ttjbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 17:18:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697HIjJu37749200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 17:18:45 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10B7D20043;
	Wed,  7 Oct 2026 17:18:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1DC720040;
	Wed,  7 Oct 2026 17:18:41 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com (unknown [9.124.215.154])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  7 Oct 2026 17:18:41 +0000 (GMT)
Date: Wed, 7 Oct 2026 22:48:38 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <chleroy@kernel.org>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/8] KVM: selftests: add powerpc support
Message-ID: <asZoDVHc1hHlS6BO@li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com>
References: <cover.1791280439.git.ritesh.list@gmail.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1791280439.git.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA2NyBTYWx0ZWRfXzLAOHUMgXth0
 WVSIBAjIrKGetdYyPMdiILEoh47DQDAAeaVWUIIQP1Hp/AtIdXzgJDBX6YKVgYwTEbG4c4GEMgP
 KbMoNNd0p9BurjSv8XOPJLCn7KJ1SCc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA2NyBTYWx0ZWRfX6GTIAxdRK3GQ
 MtMkRAyHVlSsj7GUZNbWqWhmp9Wfe3kZQgtlg1JDWSylbv2+iVDXpg8YRV+17M+t08Nd6rKnnNP
 aZY4XXHscJ+AA6Hn43PR0rp8munn0t4b7dFmvzJiOZhA8dH/jr4dy+fRzAl7G25q7fa1gdX6j+x
 /Yz2g9VS4kPWtPZVMR2P9Z8jCTOiGwHm1NvrfZG3WTrQuswcF7qYLIDsfTevFAZexs4Qk2ZbCPr
 heqaXuxfDadwt9yQj9yxqJkbMgVVZoddwtXw6KaiRtrmSJdMeDlj7guwiMnKIGJl0BsJluCP0bJ
 FuYFVZVYsc+KISucHP30+Q4y3C9jpmyqbU709IL5hYKi0hSKZN8X0h90I3BRsVSxKmFjw08E6xx
 XomxcCqYpK7USfatdvOV6W6wqtwR/ReZQuLesxmmNpeFfze43xpkh1sQ3qkfZdrpoNiYdli2LFQ
 NDhojPDUOcnNmXzaWCw==
X-Proofpoint-GUID: piZ2NJeF4gcuBPiLh--2VNqd_b3rsgTU
X-Authority-Analysis: v=2.4 cv=UNRIjyfy c=1 sm=1 tr=0 ts=6ac67ef9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=IjqmoBHoaWwW2uD4uXkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: ANO0DObG1HFpe5l6Y4i2vM5qxQj7L76O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070067

Hi Ritesh,

The series LGTM. I also tested it on KVM on LPAR and KVM on PowerNV
systems (both L1 and L2).

Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>

Thanks,
Gautam

