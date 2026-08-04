Return-Path: <linuxppc-dev+bounces-25353-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6306C55172
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 10:08:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDq4h0z3pz2yMl;
	Tue, 04 Aug 2026 20:08:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785838116;
	cv=none; b=jzLUOTHQ1m24TbEd1PG25Fr92nC81tfJ7lcMOCNfD/S+OkN1wasbgrWw103hQCsO4QRMQuxH65lQqq+h2IScn2gTsPD4i8b88gANEeivIhxepRpLLffPUWcLd56wjmjsn3oo8+6ben96Gdfs3IG2Vqlni49PXhXNgNwsVMcIhsUTr9z1lhq4gQKwdPL8+pEldK/FZsQg35Sajv3oELxG6zH1c5Fs5acj2Xa2kDS5DU9RuRYZQLoUFlZlx//4oKM2ixqLBY9qQbOiioB/oA1eB+5WsjU9a9XjjTEKYyhojL7ytx32rmwC57UDkXXU3yKyph1IewOwVXkqCAQJyqTeWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785838116; c=relaxed/relaxed;
	bh=Z8TdKGnZTYMqO75p+fQ6vrp2bZD+ts8wOgvcpdd/4Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PY1Oz4aE85DD1fJazuugHN9KY1epBRtu+jFWNfOGx0vhs/q5Sr+NqMtLBG2ZhY0/29J16UttBl7zCguariLZXBKLwSGFbKMfX5KkyKH+J8bfoGDhFO48vIW91TE450XXFv0lxgMXbX+Z4Wrs37CETR1XNZeAlR9VD0BUO7sKqRXsDwlyqVS1wp8s5s5aPjGSHV8qdOsda2Gy2oTnvuYpc66xsBIv9ubSIIfLKmzyB3w2jtjl83nP2eSUBFazCKr/kWq689HVv2eXpY4T4k+JAKsVGWfgXB8B2NbnND8fYO5qcOWlskiO16m6eKHGPvoSJb7I3dX+0dE+3VO9qAiTQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Buq/jCHb; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Buq/jCHb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDq4g0L66z2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 20:08:34 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6748HiQp236584;
	Tue, 4 Aug 2026 10:08:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Z8TdKGnZTYMqO75p+fQ6vrp2bZD+ts
	8wOgvcpdd/4Qo=; b=Buq/jCHb/QGsSADwcRh0KPH1n6NArC/APNstlRCcTboAoL
	VsnXT6QFrhWKFWjZAPMQ9lM1hIpAyF3gip4qzmSkbWBa+d50xBYBx6GTWfo7yvod
	zPghTPFEienbqqYr7pz1V2tRx7hLUAIRxQdeDyi3TRqjQ3afbWJvTAQH9jIBXeFn
	cKJphN8Asa6Nwc7pBXhlm97PV77d6F13r7wKcY/rEpG3cE4CD4GsoNexFT7n1IFZ
	p6ZfAptb5EreIxtZRZGlm4xWok3dkm0Mvba4SSmE+cSIg7khq1O/TtsqcTwus9pF
	05jYfFsAvmGB5LR8oSuKlNf9wtl6OD9PMnbNrJRg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77g51fs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 10:08:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6749uKAO010137;
	Tue, 4 Aug 2026 10:08:20 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg986s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 10:08:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674A8G2B31588786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 10:08:16 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6ECB22004F;
	Tue,  4 Aug 2026 10:08:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76ED620063;
	Tue,  4 Aug 2026 10:08:13 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  4 Aug 2026 10:08:13 +0000 (GMT)
Date: Tue, 4 Aug 2026 15:38:56 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
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
Subject: Re: [PATCH v5 1/4] KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and
 wire up ioctl
Message-ID: <20260804153728.0e6e98b0-7c-amachhiw@linux.ibm.com>
Mail-Followup-To: Gautam Menghani <gautam@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Vaibhav Jain <vaibhav@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Ritesh Harjani <ritesh.list@gmail.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
References: <20260701051409.51820-1-amachhiw@linux.ibm.com>
 <20260701051409.51820-2-amachhiw@linux.ibm.com>
 <anGT5rS60ns59jY-@Unknown_32:98:3c:96:ca:91>
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
In-Reply-To: <anGT5rS60ns59jY-@Unknown_32:98:3c:96:ca:91>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA3NyBTYWx0ZWRfXwRndxZ3ZRz/I
 K6eHC+s7Kl7YZ2ov0UNCrTPfVx35QdqdUaKaIiEyu4SnqhNi/V5P9rPaaL2YPna9wnmjSezE75f
 6k7wVoAIt4vCk5KwXuhIcC0uTv5P7m5+oJC4lDwzbwGL/4rUqseEODAlLFppLwdBlFu/U2OukZc
 HgUF3N/jMn1DtsL7bblS4lvKn2pt2uJVlIWmkdsw42OD43LgwTEBsFG32Owe8D2idGgjkks4zN/
 W6j5/Sp3TkO9ibHItKfiKHdANWc+kw2zW9eW5q+zPwvqABU9O7gHxR0ct62T+7/Pw29pa0jxGxG
 rcq+eiDkbtyC/yDb+ekM/pcufIDllu+dEvPA48eRx4hBRF6Jicx0eqEm/yOUzaY8JbDpCPajAMV
 DNU6z8yw6vynCGcACMVkZZWiP419iy2loGvl+y2ebO/FetTjPjht30dGx3Nchqf9e+uuRorgFZF
 VSP8W4MOyAP6ak62a5w==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a71ba15 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=59nB_xcw9bnwkcHRuAEA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: eRu8PNi_dZMRKR78rn3p2020rGeZqJhS
X-Proofpoint-ORIG-GUID: pG2Opiz0PKCe2Gbek78wqc5W_CAh3fEU
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA3NyBTYWx0ZWRfX0HNrs549QlTS
 o6/27dahEtBj8LRO5GUgP1iFlVFanuByEv05Eb5KMhL6V+Zv84g+GAQmHQbn7asd5CHfCIwSybM
 TzJlT97Mu88OM6rpc/2cMzaLuixWrh8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040077

On 2026/08/04 12:55 PM, Gautam Menghani wrote:
> On Wed, Jul 01, 2026 at 10:44:06AM +0530, Amit Machhiwal wrote:
> > Introduce a new capability and ioctl to expose CPU compatibility modes
> > supported by the host processor for nested guests.

<snip>

> > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > index 419011097fa8..1cf9a959669e 100644
> > --- a/include/uapi/linux/kvm.h
> > +++ b/include/uapi/linux/kvm.h
> > @@ -997,6 +997,7 @@ struct kvm_enable_cap {
> >  #define KVM_CAP_S390_KEYOP 247
> >  #define KVM_CAP_S390_VSIE_ESAMODE 248
> >  #define KVM_CAP_S390_HPAGE_2G 249
> > +#define KVM_CAP_PPC_COMPAT_CAPS 250
> >  
> >  struct kvm_irq_routing_irqchip {
> >  	__u32 irqchip;
> > @@ -1350,6 +1351,9 @@ struct kvm_s390_keyop {
> >  #define KVM_GET_DEVICE_ATTR	  _IOW(KVMIO,  0xe2, struct kvm_device_attr)
> >  #define KVM_HAS_DEVICE_ATTR	  _IOW(KVMIO,  0xe3, struct kvm_device_attr)
> >  
> > +/* Available with KVM_CAP_PPC_COMPAT_CAPS */
> > +#define KVM_PPC_GET_COMPAT_CAPS	_IO(KVMIO,  0xe4)
> 
> Can you use another ioctl number for this? This group of ioctls is for
> fds returned by "KVM_CREATE_DEVICE"

Sure, that makes sense. I'll send a v6 with this change soon. Thanks for
for the reviews and testing.

Thanks,
Amit


