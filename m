Return-Path: <linuxppc-dev+bounces-25978-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB43C5DF86
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2026 11:13:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQ3p71p9xz2yRP;
	Wed, 19 Aug 2026 21:13:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787137983;
	cv=none; b=dq+BNSQ98LJgzU44YiyXE6pYV98KMkDN4bjz4zX8Ao5ijc6WYOYFmF0d91LmNILUhhcvVYsRKC64zC/gYGIJG+ddb8J0UpWT5owGgOdsA56lvsjMfnW7WhvdF+vAk3Y0I4zGOO3sfAPu/3Z9++0ayNoi4Yy1Yv6rcRIXetWSbcQe5H38XNu0zHvUCL6AktSsES6wZdzzl+2eqsBpycCK8ZCwMVlnjYcx/SzEtdEYrhSJpng/n3mgqYoJr0VDx/KBrAhUR+lDC79mwngWlNUv7WEhldjfUYb/WDuEhnHLRBDcoprFo0KFjSZ8LuewSxVlRqltYHJowJg9py+x4AGZZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787137983; c=relaxed/relaxed;
	bh=RkjSQ0uJCIZ33GTkYK1E3hbKRZ6O2z9CKy2ozyZ/O48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbOTyspGUsX5TWJ5rXTEq4yslehB6PX25eIRjNTsRHUoj0JFj2pge512rKnixOq1Q5YaT58Fo6Zmn8oSEUYuOZ4tCsVRkzDnOY3z7lwO34wQg0/p8v+Zp04X137hL4+CzBmePuYbiZm4avXfyAQWxyKcp2M3DlvOwMuezRpqtRldGTNNANSprQmLxKruk1pG8L5IgRkwrTKBA8hHThBkPRitkkgurRrBitB+sUCws3ExQlI3erVADXmEPkW2KmMIWcevJDDUvhfcC8fmCaw7dSIWoIUl2HkuN7qE10Hs9ARsIna1L06NfWezw5JVZYuMOKyKGXd5t4Q6tFEijvGRHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=maGZjBRQ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=maGZjBRQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQ3p60cx2z2yFW
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2026 21:13:01 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JAVceg3085499;
	Wed, 19 Aug 2026 11:12:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RkjSQ0
	uJCIZ33GTkYK1E3hbKRZ6O2z9CKy2ozyZ/O48=; b=maGZjBRQFy2L//XwE99KbL
	3jilxm0MNY+J+odRRAk4YEsaXBVStQDzSEd2qBh8I3GIHqtaXNkQdwdy/SWlNxOW
	9dMXdGG8jEP+e6yOlUedLzs6xFzvO5HrN0Z2I6++wBxx9OlvnkBIrd+XFg+YY682
	jwS74cUpMXQl5W8WwW29ph90cdMxby2D9nE1zzhKsOrlzOxAFryLORd90UPHrsC7
	z3RxViDiAE5xlxc9+ewNbRM7P7nhSPHmoBITzg0fOTTgyCFcSEOYbfvwm1MKh/Ko
	ay0zdeCvSheAL4P69jIIGcm4tGAdgnNJH9l7Iwgau1X7hpA565545FkR2y1K/3jA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu436u9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 11:12:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JBBNDR021767;
	Wed, 19 Aug 2026 11:12:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32tw8pah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 11:12:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67JBClkI39518656
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 11:12:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC6532004D;
	Wed, 19 Aug 2026 11:12:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F0372004B;
	Wed, 19 Aug 2026 11:12:45 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 19 Aug 2026 11:12:45 +0000 (GMT)
Date: Wed, 19 Aug 2026 16:42:27 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Anushree Mathur <anushree.mathur@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
Subject: Re: [PATCH] KVM: PPC: Book3S HV nestedv2: Don't drop pending
 doorbell across L2 entry
Message-ID: <20260819163954.3b08c1c2-55-amachhiw@linux.ibm.com>
Mail-Followup-To: Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-ppc@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
References: <20260803034426.44249-1-vaibhav@linux.ibm.com>
 <aceec38a-7405-4020-b682-5a8c31af30f9@linux.ibm.com>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <aceec38a-7405-4020-b682-5a8c31af30f9@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA4NSBTYWx0ZWRfXwPToNPv7Ajd6
 shAZNay+yq2cwd/79rEPYt8z7d+spslzXNWvwEuX5Jdb2do0S/ke389DNy3vkmj2wA2UYOQFPJ5
 igLXeZpxmJj/cTrFyyQcF0Ut+Nn1Vo4=
X-Proofpoint-GUID: 4PBO9K_S8bsVHQNfryDiy8JjdlChxNrC
X-Proofpoint-ORIG-GUID: 4PBO9K_S8bsVHQNfryDiy8JjdlChxNrC
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a858fb4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=8nJEP1OIZ-IA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=bcat9CMdyZZG9BD0Pj8A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA4NSBTYWx0ZWRfX0TT6dY9iai6f
 eKj9qxhcrZzh3NQWeKLqWVHENv2fQlryoue+kXyDkXi5hXrwZ+ufktUjo7uVsOFkxKLJ08JPgFw
 ervydC1035F2UVbGHs6cKTxF//mYplGoclCcZVoCONNk3AYJ+hCxZLf+qSv17W15IcAabLHPAj2
 5XOn1dCiKdqvhpn0d8aAHoBsQ/vhTvqZURwJ4nxOcuyOrPRAgqQXWBC5GCAsBfOfbalHs+O1Yzv
 7lzu8j1d2A8OJ3SUuYBqgDkCC7LIWFwRuXectXewxX3+makhBoIlO+qU+GhOQc6DkSFHLdBUKRF
 KkBBTHW+hRw3EZYJ6hk02wFUgiaaNbEZbj3xH78PtZtApGCv/dxhDY4EYtfCfxCtDGJcjMPJ3DR
 ivIu92BHByzcIzpJ0Ur5ZRw57hrb4P9yfVMeI4EZV+uSohDaXlKSVjWk39JSeyoPM2gA1nEYRu3
 8yZ7NBnC07GKOsJ67qQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190085

On 2026/08/19 04:32 PM, Anushree Mathur wrote:
> 
> 

<...snip...>

> 
> b) Even after applying the patch also it is giving same softlockup issue as
> mentioned above:

Hi Anushree,

There was a v2 of this patch sent here:

  https://lore.kernel.org/all/20260812034628.1122115-1-vaibhav@linux.ibm.com/

Did you get a chance to test it? Could you verify if the issue persists
with the v2 as well?

Thanks,
Amit

> Though I have enough vcpus and memory on the guest (16 vcpus , 13Gi of
> memory)  and ample amount of memory and cpus
> present on host still these softlockups are happening after applying the
> patch too. I tried reducing stress also on the guest
> but still this issue is seen.
> 
> stress-ng --cpu 4 --vm 2 --vm-bytes 1G --hdd 2 --hdd-bytes 1G --sched other
> --timeout 3600000s
> 
> If you are planning to send next version of this patch,
> Please do add my reported-by:
> Reported-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> 

