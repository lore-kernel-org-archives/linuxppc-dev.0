Return-Path: <linuxppc-dev+bounces-29261-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436B2CA9ED0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 12:19:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3GkC407wz30VF;
	Mon, 12 Oct 2026 23:19:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791807587;
	cv=none; b=iA2DG6wxUvW+G/AwMIstpqgxWPXOmrp7yGChu2Mgbj9Co2nJ6b96GQxMg2Q2H9jxbeK1wqWi90m0o9GV4UrghYihQe1Km9pNS6Gds83OujwmtYg6AUTwmljzDnU4DsSx2UFZL3lJVPAQCgtGYv+NeYfaSkwmwW2Vn75TG6nZHof5/qMaAlWwlYcwiK5B5Cpa0sGYryfhNvWVxlS9s/HkpV26i9N2AbvjLvrpOcUVYGyZ6iMDuTtP5fJGRtR8tKSKwuxk+5LFemOxPfugXox5LK3QZfJcNZXxYYHMAaY0Ha4UT9zrWvv4URP1so+YegenrVhYF/fN3zD8r14eQkGh+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791807587; c=relaxed/relaxed;
	bh=7Muc5JG4mizx31AbrxHto9kiMf+HYwiLPxZOyTpDyh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KiGDNFOpb4v15x7eNUE5vDK1sNuxRhAfA7CHsYE38rhgJfdXTVwfRrYx56EfC2hLmghIwea7AbMUP+mGOWzW0X/2hcRnN9j0r0klXYi5cD0I1R8oyvVhSH2ObJ2u90XiXW04BMLRcf8ifJJFq+HnjwRSNSTh+5UHZQlgRXh1DSunKh1y2lntzFFzqWT5oEz3Xuo1KvbCsylAZX0/Ho36/u4QSvcsohUw7MubOQdpPpkWN0BRZETM5awj0xiPsoQCDcHHkp65ZWe09oohdIzXMmNZqjvTpEy4qV5gHh21vD36GmtYcPVXAP5s6+8RQx8tYDshdl/DHoM+jxVTVhag0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Wa8up/PP; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Wa8up/PP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3GkB5t54z30Tm
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 23:19:46 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCE6YQ316020;
	Mon, 12 Oct 2026 12:19:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=7Muc5JG4mizx31AbrxHto
	9kiMf+HYwiLPxZOyTpDyh0=; b=Wa8up/PP8448R2CDXx40JypRnRX6iulncV+ke
	/A+waAfBaRwvl5y4PsJFAX+M9P9T2STmscBr85pmU4pvH6nn3VbnZxbDuyP1onAy
	zmORbjDn1g9YD1SJQa4H9TuZX5qQZckqxS3aEKBs2l4lLulfa0vAEJB+JN64v+LC
	HDiraPu9Jtgpjhzzv5/iwFy0P2xjwsTIf3cmJv3SMkVWITAGZiSTanbi65TmZQfl
	m9IWtwX0dB7U28dJ3uWTUlPQtLIS1LTYHEEDiV6MIgy/z9XqCkeHEroSu4pRtasi
	LPTBOhPh7FBfHnS98CU3xCAQaBulU5ZMNWnpwML8kxPmGl7WQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dug8sx9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 12:19:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC53gL1287128;
	Mon, 12 Oct 2026 12:19:27 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h816gw0q1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 12:19:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CCJNhb42926392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 12:19:24 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7CAD2004B;
	Mon, 12 Oct 2026 12:19:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 672EC20049;
	Mon, 12 Oct 2026 12:19:20 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.126.150.29])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 12 Oct 2026 12:19:20 +0000 (GMT)
Date: Mon, 12 Oct 2026 17:49:19 +0530
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, peterz@infradead.org,
        tim.c.chen@linux.intel.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, ritesh.list@gmail.com,
        kprateek.nayak@amd.com, yu.c.chen@intel.com, vineethr@linux.ibm.com,
        vincent.guittot@linaro.org, npiggin@gmail.com, mpe@ellerman.id.au
Subject: Re: [PATCH 0/4] powerpc/topology: Introduce llc_override debugfs
Message-ID: <aszQR3jtdzE0OeB-@linux.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.ibm.com>
References: <20261012102037.2477378-1-sshegde@linux.ibm.com>
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
In-Reply-To: <20261012102037.2477378-1-sshegde@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6accd051 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=8nJEP1OIZ-IA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=kacj0h3wBOg16cJ-Ey0A:9 a=wPNLvfGTeEIA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: 3yrG65FVefjfY1jFO7W5ktT_2-FDSM9d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0OCBTYWx0ZWRfX/PF27WqSF4OQ
 iriI3V1nlLL6UKKlaykNJHDQ3L/0bEoMokkKKMltA9HHfY9EYeNIq1pYhy+NQ00Up3yH84cRy3C
 U8rI6jlJw2Gj6wHW3yGH5VedeOWKHr390QnYALD2wDzAO/J1okSrGp5qvAK7GlTTJvwFu43mx+k
 fdGUJaRn5s5iFM8LhH/f0O1fzR0tyQsuvBexGxGsAecaznfB8REqNrR0LjwYP563y4HBjAbyanX
 NI2/pIXINop4s7ggNO73WhHOSFSaKdPxfPUndG5cooCRU1kF0u4Mj0bhbsEtWwoyJylZOciwbga
 OzIKuKxixkm5GMoK+4MY3eTZC/+GMCNCeaW10UL9pql71BneTPptnCF3AjyKEvID9AIuBk1M+q+
 YK82QDrm+9y4r74514JCtassT1bpaiN0d/OYLrsNVa1o7/7Fx5xsNZgD0ijiR8xRepSyIyH2tt0
 4cQEF4tA+XKZTy/YOpA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0OCBTYWx0ZWRfX3rlVDLiVbf/f
 WXJPd4UDRgOgfxfZbXsLkVUbAP78eBIJvWK5mFjIYFDdn5kBjr8ACbb1Y6E69H+lSIhX9nzq0YX
 JPdJQ8YermrDqjBw2l09OEg9ybrSu0E=
X-Proofpoint-ORIG-GUID: 2s8Tm2c-9h1kNKXKstlHDCUZBGVzlce3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120048

* Shrikanth Hegde <sshegde@linux.ibm.com> [2026-10-12 15:50:33]:


Hi Shrikanth,

> There is a new feature in scheduler called as Cache Aware Scheduling [1].
> It tries to keep related tasks within the same LLC domain while
> keeping the system reasonably balanced.
> 
> Cache Aware Scheduling assumes that the scheduler LLC domain is large enough
> to be a useful placement target. This is true on many systems where an LLC spans
> several cores, but not on PowerPC systems where the scheduler-visible LLC is at
> the SMT level. In that case, sd_llc_size is effectively the SMT width.
> 

Can we add a reference to the earlier attempt to try MCLLC a few years back.

-- 
Thanks and Regards
Srikar Dronamraju

