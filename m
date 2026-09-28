Return-Path: <linuxppc-dev+bounces-28405-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93034C9833F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 12:32:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htgfz19mXz2yMK;
	Mon, 28 Sep 2026 22:32:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790598731;
	cv=none; b=Mh2PfSvU1V7FI82ArOX/8i8aE9uxDFC3xdLYK10CUPOxL2qXA/c2X30SsKpJuaTJqEwD4QySs9peBr2Ho6R3fVd5+9FQC8TXbbpnxSKnUQCKaF79oeTWBFyZpdyZFMKrsoEiBybAzh09VT1bSm23w9D9CJfOQTfzpoLz+pk71WZvV3UOAIjFA+E+TazrWSGoZtWIhoJjzj16wZ6+QRNYDdQe94ogTM+C71D9pLortPO4/t3I+asolLMBuQKgpiGi8+KJUT0WWcimVCw4noPQEUdXFNumjv7jxfo2ETuOD6Lq+Wyg/UhPH4NGqkoMRikCLPrKbLjc0Vk7XN9top9RhA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790598731; c=relaxed/relaxed;
	bh=cWVmcFQgkWwK5TQ2EqXUonYtZWJMhC3DjJ3zw153gL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2gAJPLNxt/kHl912pTqyI2G5BD92UIYvRw/YuHo3tH/Wvza7v7x0qFhGTNzosVzeh8vX9cq0q/bCL1Cu7ovq/Euqg/VkVf4mLiMLZr5ARfLUV6oCMdZ2dpTLR/eKNhoeF6BabHO9faiv3I0V5QjOyBf4Tbtp+YmN5YJ51HXAPeuNTSSz+5qrPksXUev0L0ApRHdprgqnZoQcko300+7OgjP/tTTCR6BXkZA8jlHmTP+BB7nFNnSkpEBbRmCXUeoJjmDCR5Z4OhBQ2ahLsWwxwo8Z+JjTrOfjBtKoGZvVCTi3BTZa5mVGM8ZwiIFMqSUZWN5JP6QwjMUT4J1XNuAOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=B/Cug50B; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=B/Cug50B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htgfy3BQLz2yCL
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 22:32:10 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBZZKE1047082;
	Mon, 28 Sep 2026 12:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=cWVmcFQgkWwK5TQ2EqXUonYtZWJMhC
	3DjJ3zw153gL8=; b=B/Cug50B6TFCsq9Er9mT+zxJKqiTaXFCgPh1eIspxRz9IB
	Rl8RYuT1zKUz+SDcAZPtj7ueIG5VyVLjgkxehBoj14GqmvPKmGrwyjGlm1EeqIG1
	pB+0B727EV0aiE+LghxPh9Fw7t4N6BlsOnqnGO/7/tVhq30ZHlaB22nGaaSWq5d/
	5rTeY0JCDWaHfyvKlip3HFhROc9YfcXWVZJNfc+lz+rUnEELjZd2f320fvhhpfAN
	te7kO0KkEFGfyYPIO9YVnQ2z4mg2PLjxiDjtKs1n7uEl//TpI2BGYK3CNidyY6YH
	vH8AidAVf1OFz/Ynb1obMkh0K0uy/J/3qCaSO3hQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j51a8j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 12:32:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBHXE5017627;
	Mon, 28 Sep 2026 12:32:00 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsck55sc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 12:32:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68SCVuJX32506164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 12:31:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4C1A20040;
	Mon, 28 Sep 2026 12:31:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E4BE2004B;
	Mon, 28 Sep 2026 12:31:53 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 28 Sep 2026 12:31:52 +0000 (GMT)
Date: Mon, 28 Sep 2026 18:02:04 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, kvm-ppc@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gautam Menghani <gautam@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        R Nageswara Sastry <rnsastry@linux.ibm.com>,
        Alexander Graf <agraf@suse.de>, linux-hardening@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/3] KVM: PPC: Book3S HV: Add SRCU protection for
 virtual-mode HPT hcalls
Message-ID: <20260928180031.2e2f0bdc-13-amachhiw@linux.ibm.com>
Mail-Followup-To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, kvm-ppc@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Gautam Menghani <gautam@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	R Nageswara Sastry <rnsastry@linux.ibm.com>, Alexander Graf <agraf@suse.de>, linux-hardening@vger.kernel.org, 
	stable@vger.kernel.org
References: <20260928113704.48912-1-amachhiw@linux.ibm.com>
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
In-Reply-To: <20260928113704.48912-1-amachhiw@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0OCBTYWx0ZWRfXwZz865v3Qh6H
 z1WlFEUZc4nfAXnwMk/XklARZY1Z1H8jfobrvbT+9VipO9sny37qN6pG5thKvxJ+Ftx3Pb+4H1V
 yKQ+5wJCC1cO2C/ROXQm+Hot1sdUJB4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0OCBTYWx0ZWRfXzPlq/CVXvVcP
 cXh40P9rZsQdPwrdEskbXCA3a9DQJauuUSABJwzj2mU9cERNHbWPmrB0qKdfACYeC4PEB4byinP
 80jOl01v2g++oxucCisXhhxJkJ4nisSjgUQ7IaXrcoi002tWvsAKvLTmT43Y5WByO48d0wBa/tt
 Zk4ibQkdCFCTw9IXnvaYf1sNWzZUD4VYYvbGUjJhPwkd1rteRS2tq/6BOQe+SDj7ReJdR4SRoEQ
 qOYzjeB4utO6HAmG7uPZNIrt/jN6YjLdrhfX2Utg/MJ8dyuv0UDwCW6OBORENWGYYvX6JYFcDoM
 DqfdjkiQvIF8opF/0XhrBzJB9oWjJEtr2+U3pI+L89KRIPNzXTsDgb1BLnU9KMPJt/DmsXZy0YP
 oRm/jeRdZqUrmNSu1e5dlBYMQueI8vdIOAIqci+uOqWFBOJlAOxHqS+2FPBpmgOd0UIXAWIOnVc
 bgLL4ilHryRqdlAhobw==
X-Proofpoint-GUID: AZRzVH3h1Z9MhqPtwlS-GvIfWJ_q1lpa
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6aba5e42 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=idfDjKrkMIz4rnwQVkIA:9 a=CjuIK1q_8ugA:10 a=Qzt0FRFQUfIA:10
X-Proofpoint-ORIG-GUID: S5WsGqJVWKqwvg_OQSi0FUlEMEYG9jrK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280048

Hi all,

Apologies for the noise.  Due to a mishap while sending, the cover letter (0/3)
was omitted and patch 1/3 was posted as the thread parent.

I have resent the entire series cleanly with the cover letter (0/3) included:

https://lore.kernel.org/all/20260928122837.8782-1-amachhiw@linux.ibm.com/

Please discard this thread and follow up on the resent series instead.

Thanks,
Amit

