Return-Path: <linuxppc-dev+bounces-25338-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E5BC55172
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 07:28:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDlXH230Tz2yYs;
	Tue, 04 Aug 2026 17:28:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785828527;
	cv=none; b=kp07MOw/67+8VhzPlVtgr3VPOhCKZxvuBYYdLGbhAw5N+qdkJ131eUjH91VGWBpvinCim/rdJqX0u7FTB00GvPu3iz0Nax7e5k56YDA0FUY+Qbn5bHz7JnAIgSKy8kex4RyaTtRwas7qndw6DTkLo1/u6dVdTfSzTAuK0PNBxsUfuEjggAecBRkGVvp67AzILIq4dbRuDplHybIjkobyYWCYtBvnTJIFxMKX7dXixI37mBlzkyiso1XPAb8VdVE/QHjiQ0bTjt3adzOPdNZOopwj/fEJbk82buzsrA5fsQL+FHAlrRwYdWQqNSaXQTyduVmD2Mbu9hBc/ongHpOlhA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785828527; c=relaxed/relaxed;
	bh=59QBGdszpD+ptvH3BvC3eYi/REMGyve3Ua1AnGhc/Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIe/5nTH49Lt6TY9+qjBEAXQd4t+bqEG+VeqhjYK9Q9vjJypYZIZM+TlepwyAhXLD9LhqUzqaTVDnBXY8CgfqRGhCnHrVQR6UN+MEVXh/CzSlfYJu4QA82mILH18jh057CAKdTDRpGP7Fcmssu3vjDN9s0qH+kr3QkELObowfRVDgucj0j9Wxzd5cQBnVv8X5uEmVxGsga/fWzKIlREp4mUwCrCiWl00vIlhe9EU3unfIsYpj9ICNBmLFinkFRfHF5nUYiqFKYQWADpp+FPMQbMD+RL82yENScziGyzfAQk9CEs/ETMM1partpv6dsdWfL6yA2aeXQWsUYOZYYDknw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=e7/6dXCz; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=e7/6dXCz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDlXG0LPYz2yMl
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 17:28:45 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6741HjfD3656328;
	Tue, 4 Aug 2026 07:28:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=59QBGdszpD+ptvH3BvC3eYi/REMGyv
	e3Ua1AnGhc/Nk=; b=e7/6dXCz8rShuh1euBRoO+SpC4UN6OQb+hnVH18hB2f6qp
	E6qI/u/BEpUKaNVrQUNspfe32tqdNAaYjG8aj0vVWRbUiarLJAVRgU5b24MQPNIZ
	ZQNkKgujfZGooJzWX39/gvVi/QqEawOhi18Cd5Q3j6l/kVWxQ4ZIp6LYT8UuGOkK
	R7P0FCFNDjFVTaLK3PnEJmNSkhJyjuKhV3ly0Ho3UdIDMrWhKN7uSvNFgx2LrSo6
	Vi2PW9S96gE9j5pFvVyDEBbSZervufviwm9s7OOcVKtpmveWvGfyA/3Oz4I4MxEz
	TbffkUPG89iOzZi17c1YgudPiKTePXFzB0g8/y3Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4vpa6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 07:28:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6747QVoA000854;
	Tue, 4 Aug 2026 07:28:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtygpt3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 07:28:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6747SVZq17629676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 07:28:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1ACAC2004B;
	Tue,  4 Aug 2026 07:28:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C19DE20040;
	Tue,  4 Aug 2026 07:28:27 +0000 (GMT)
Received: from Unknown_32:98:3c:96:ca:91 (unknown [9.39.29.19])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  4 Aug 2026 07:28:27 +0000 (GMT)
Date: Tue, 4 Aug 2026 12:58:24 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 0/4] KVM: PPC: Expose CPU compatibility modes for
 nested guests
Message-ID: <anGUmKdw_-hWt9ez@Unknown_32:98:3c:96:ca:91>
References: <20260701051409.51820-1-amachhiw@linux.ibm.com>
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
In-Reply-To: <20260701051409.51820-1-amachhiw@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA1NyBTYWx0ZWRfX0lByIJB1cDyy
 03cjG7jfeXX9Nhhwu1MNOoVwIEUs/nEjozv5tu4YgUxK65k9jOByTydgzgswAIirFvuNrx1Rdpb
 bTRWbPpbxZoZF0VyUuFMPCN4MOJ9Y1Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA1NyBTYWx0ZWRfX0tP4bY/3dR/5
 T20sWbWh+Nti+qojJbpTycygkRBJmzXqtP3v/kTTZJKTpj7Otn3j5Uzzvm0VafwUxqiBO0xmrop
 tL3Nna3LOhicIaxR3i4n7qjEXOCz8EMrM/UY+7a2vZbQr2lyNCyUMfX4LM/ifRW6eFGdDVEhskb
 yDwC4XIqEMJYhRypQ7ya7MOSRiDVUM7Mm780vQnBAidcOoh2HP59cRSztPvE6U4PR/SJU7l5eZZ
 Cst4p4Lja3EmXyjhoBJ9pQz81kikPxCblcbtEPvuzmoyq8mqmyaVVR7hTcqb4PZZV9dRVnDATkj
 4f85yluVR0kRsktRB5zYYOKZMOhgSL7Wjol8PDqfx54DCemwOeWxNVsq1Z65eZpprxDYfqBDzE3
 ZxzRU+qhPTAHBU542xwM20iu44G2B4sA7XY+sDWZO0kAeTHIIbcpC/xZh4yMpgZb/HqxL9wcx0R
 PJ5nQUdg+qv0eEzKBww==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a7194a4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=_8gdUu-fOGR6YzzzubEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: blkI9nAo2OGj3UAR_USXM6KmN8uoBlcs
X-Proofpoint-GUID: uXipwvrm6_K3wMwPh2T2rP2uz6tT5l2l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040057


I tested this series with different compat mode settings for KVM on LPAR
and KVM on PowerNV.

I've left a comment regarding the ioctl number selection. With that
fixed, feel free to add:

Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>

Thanks,
Gautam

