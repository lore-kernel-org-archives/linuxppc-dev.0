Return-Path: <linuxppc-dev+bounces-20051-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D762FB44C4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 08:25:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g25dH5YLCz2xwH;
	Fri, 24 Apr 2026 18:25:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777019155;
	cv=none; b=SvsJqom0cGBldbRkzqrSRYQgY3CmUgSV5qCFV0GKIQhzErKZ3jDS6n90eoNOO0wy6CE6eF7C3BFl6LnmxMMGsfy+jD7XnuJMmHv5SPbi9ReyCSJNMQjlcScAhVKpg/TL9neQdyPVIejjltJMvUBDs1CXAfGKS4w/jwt8dmPbLLvEes1EU51jAN4Qxw0a+LjKWW6FIHmuuCCU6Y50cMXephH9nXQY7udZ1iEeKgRzHNOZr8kxWmk1w3Yh9vtIChJZgLGapKE/oxUIUE6/05mZQK9lUpPQDLd5QyKqwiewY3gDoZxgNoMe7Nml3iKM5b+Tphp2cqXaklC07Z5H2D9ARA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777019155; c=relaxed/relaxed;
	bh=qbpqHYHXo5cVVMvcWZZEGa2oGr0mmblnjVSPUfSnX7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6P7koCKbHxdH90UQyqfIeLMtGYzEP4Q/LD0UXY8BMw+BMsb/wvSDwpp1yFyZ1M1nW2WasQkPlAqQGy9fJws9ZluDBrxl8Rf+fyO7ZyRkJJIjCMhK/9FkHUxvXRyKfglf3HlF/PQzvB1XCEsckXFY6auy8B1hRKm/70zWi1TzXXoB4YSOeoaTfjj2jtPNRtIIVYv8Zg0zMyaWDGbQUR1z7bvXEFDITSLUrQ4TLcKJ6JbZu+ifDMfENbFoLdLq04DZP1EEVM+jhJzPpJhNlvnPz8QGCdZ5R1Fq7UlNc4lZmWAcGSHSCCdzPV/xHk0Z4vUeD2OQnbF8lXyQv2Ixb9JiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iyYMPc0Y; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iyYMPc0Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g25dH0Jzyz2xly
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 18:25:54 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NIUb943291955;
	Fri, 24 Apr 2026 08:25:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=qbpqHYHXo5cVVMvcWZZEGa2oGr0mmb
	lnjVSPUfSnX7k=; b=iyYMPc0YmOBLHbzcWETwJRncMGhcF+idc3kRUPpiphRXE7
	Hi+SBJkakrD6lwIwXn0qauX/EOVhr/YLtKg+UNd75jJDmhPZsTeky1CCWuvWbqMK
	CUn16OLtsnbhVAMrC26Tt8pMNmb8E0zGSrTkXXwTfX0owah55pacH5U/ohr7JnCj
	iDOKZVkyHVHNIhttE1yB0x2W+XDPx74xom0XGMihnLGo7WQvN4IjHERpMfSK/3Xz
	ZcnFKofZjbJqQu8wqKSzrEy5gThfD35qUt/y3TsOFpwqTaHpGBpX2tOKhqXDafYv
	UAYJjKGgSI4xWn9LIVerQskdhUqNZHC60dYnJztA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dphfrm81m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 08:25:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63O8KWKM019120;
	Fri, 24 Apr 2026 08:25:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkya0uh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 08:25:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63O8PVgG50528662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Apr 2026 08:25:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E04EB2004E;
	Fri, 24 Apr 2026 08:25:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3154B20040;
	Fri, 24 Apr 2026 08:25:27 +0000 (GMT)
Received: from Gautams-MacBook-Pro.local (unknown [9.43.77.7])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 24 Apr 2026 08:25:26 +0000 (GMT)
Date: Fri, 24 Apr 2026 13:55:18 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Peter Fang <peter.fang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>, Yosry Ahmed <yosry@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] KVM: Take gpa_t in kvm_vcpu_map[_readonly]()
Message-ID: <aeso7lRjzDhIKEXV@Gautams-MacBook-Pro.local>
References: <20260408001137.3290444-1-peter.fang@intel.com>
 <20260408001137.3290444-4-peter.fang@intel.com>
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
In-Reply-To: <20260408001137.3290444-4-peter.fang@intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: wBygo57Phfjx6n0uHlbxhJ9GYvH1qDtX
X-Proofpoint-ORIG-GUID: 2Vc1kq0JQ7XgGNb8DZGjRTzmC2-piCiM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDA3NiBTYWx0ZWRfXxm6Uzqq5Bp7u
 fkKJyf60yQlmdLJCU5AaAOzg0KlxPY07KEC++J+kEhZoYRh3+Uy+np02Mvg6gCcFjnaWL7J7p5K
 3uVlW2ik8Fdx+HsFgyuI1sQtRmrrnLlccb/yfdmsoLdO5d7YflPB7yX3LzoRU+JYH58JHd2HxsP
 uoTSQI1QuCNqOlvVJbI9Ma+sOjHxejmcVqdk4FCuPHchcj1+7Uhr1rJa3by0zBR2X4G38VZIsse
 WO5KoSOHxAsn1A9nhopSp5fIhybeVH6LNozsDZ3hvqrcibRPYb7IP9YpIwvY10dGFb8NZx6cmtD
 X7rKbFE18ccbir0wnGyjJduv1l3nbtLLY/HdudpLZjB18H1khfc2ST5kfY1Ne8V2aNTzA3g7k22
 j4fmaMbsn291hRCaG38fbVdW0gpHDBs9htd36LSIiGZH6B4nwACpmqwoynstE8nJRsi3zXuyJwf
 sArsyNxLOKPnR7AjQpQ==
X-Authority-Analysis: v=2.4 cv=SJxykuvH c=1 sm=1 tr=0 ts=69eb28ff cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=SXutj9_lnH9CGaSYosoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240076

On Tue, Apr 07, 2026 at 05:11:30PM -0700, Peter Fang wrote:
> Move the conversion from a gpa_t to a gfn_t into kvm_vcpu_map() and
> kvm_vcpu_map_readonly() so that they take a gpa_t directly, reducing
> boilerplate at call sites.

For this refactor, shouldn't the prototypes continue to take in gpa? I
think this was agreed in v1? [1]

Am I missing something?

[1] : https://lore.kernel.org/kvm/ac8BOGXIPMnJ7kIg@google.com/

Thanks,
Gautam

