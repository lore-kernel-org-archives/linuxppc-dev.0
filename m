Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E56A606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 19:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kuJa6fLa
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPGkN4vkfz2xNC;
	Wed, 11 Nov 2026 06:22:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794338540;
	cv=none; b=lwsr09/U/ddB7ejegw+WAmjx/Rz1D85LQRbBGm/xw0hCvVImTnETOQM778bK5A9RC4+xPQKWCXnW3IYT0X5mPnYap7LaHOuxwpfy711puwCqK5cDBEWIb5gbbHQxAn4Ck1LMUI28svdJOLe9mhj6X1/Tza6MSbru6oVoiY59ecDr93cUssY63+qAcARc3SboP43YbU6xKv3FMhb3skeOYdDJ+wUDwO2Q8qZO8cZpVN6dkuOoGENdwhgA4t+LflMs7gJCT/QITKYhrF4jMwyn96CknxfG1s1y4T25M39iXIiRAGeFR7Y2AD59Q3JbSSKFZLUzl1EFyNW6PfZuD5ltnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794338540; c=relaxed/relaxed;
	bh=w82bV3O4CTnUIOtRe4QKHo0rl8s7//SUTJbVojJ2aQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPLa1t8kPYePxOSEVlEQMkZ7Hs6EdRMF6BqI1fiZaP413YXvuTsaFi3ot4+ZbDICtCvWPwpMMlTJ8qADgksL/gzQ/38grhtbmCF5nt0jvXqjgfC0llGOTnVEQ7+mRkgPMGK7+iYMB/cgY46xiW8O3++MxpMf7LeAZw5o03YOzPYq8C7SW6JslNkAkuQdrR1EHeofy71gMy9McLz9DVtH7cNfmDOaxvTMdq/xJtrqmhyDEsj0WK6MYE0ZIJq4NczaW1UVqjDYSXCSCKKh6nEaSnYgGrkTSxm4hNek3CJU5u/MyFf0tdtNYSdp3hez93xk7pS9u7WJPnWkwc7mGo69kg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kuJa6fLa; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tasmiya@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kuJa6fLa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tasmiya@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPGkM0Wsqz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 06:22:18 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAJEiA83166888;
	Tue, 10 Nov 2026 19:22:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=w82bV3
	O4CTnUIOtRe4QKHo0rl8s7//SUTJbVojJ2aQs=; b=kuJa6fLar1e7+5FXvFx71T
	l2aYvUWNOeqjOHugZA4fd163QOCM1TOXTXeHY9MKywgiQhE36dEmwnmo4rcGpVW9
	L8isjWhvlr0C1YwjvmxVXdaK+ZZrJHGj+yWKIYDHQZR7JZejMWJnl6D/UUuNSAKv
	5eJqSaBAg8YnJy6g7+PUDvvwONmQo0DXQEulfUCgKAuJOcHf9Hempx2eu6AtXGZX
	oR/b9bMfqv6V5KVtRZ/4ETONHoSRNJNDq59pHmEokUtrx1qaInopTwMb41McW36B
	YfUOmNxxpuYCARlPnumS65F2nAf5N6wvhTukK0XiCNnvDaEYNrgrHP7wO8JQZwJQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumuwyu3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 19:22:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAJ6sZ82228193;
	Tue, 10 Nov 2026 19:22:06 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htepw03kt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 19:22:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AAJLxwL31392392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 19:21:59 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99B892004B;
	Tue, 10 Nov 2026 19:21:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0567E20043;
	Tue, 10 Nov 2026 19:21:56 +0000 (GMT)
Received: from [9.124.212.251] (unknown [9.124.212.251])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Nov 2026 19:21:55 +0000 (GMT)
Message-ID: <b6a7ba26-e3f1-4dfe-a429-8dd3379e665a@linux.ibm.com>
Date: Wed, 11 Nov 2026 00:51:54 +0530
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] powerpc: Add RTAS based error injection support
 for pSeries
To: Narayana Murty N <nnmlinux@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Alex Williamson <alex@shazbot.org>
Cc: sourabhjain@linux.ibm.com, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, sbhat@linux.ibm.com,
        harshpb@linux.ibm.com
References: <20261023073642.59657-1-nnmlinux@linux.ibm.com>
Content-Language: en-US
From: tasmiya <tasmiya@linux.ibm.com>
In-Reply-To: <20261023073642.59657-1-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA3NiBTYWx0ZWRfX8sIjR/YGNfAH
 M/JUOPs4R6h2I+sNX7xbP8FUV9RErvctybBoEwtKvZ2V+oYwI4nf2Qyjw6jzJIqKlWN7Y6CDS19
 hKOpENFmabpTuuc5euBtG6YNWnLZnxg=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af36edf cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=wt1o8H50IsT6fsVrqxAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: bF2VkZfhLSNJRRigfk4ZzzsrTrbZ4s-V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA3NiBTYWx0ZWRfX3+76r3m+rW4K
 j0IqymTxuc9aQAgLVFtT6932MCMg93b9WiqIZwhmYwfrqlX02R/mWtsIzKuN2n47JLvYGVK92kE
 KaBpKwUxUYHXwXEMS3HJ5t5lT127GEG7bwMUgPATHmchIa4NkKWF/BN6FZNjF6TXbNqYjibjYLM
 Ndh9MsXhZuamwtqAf1kIXRzBkoX3VJxutSvoFZH65B/dzi5hSDpZsIwloRO3jcxdpHV+ryEe+0j
 PnPeA6pRR5oftFdAemdT6Mj3FjU9e0sPrcK5QwbRGAM3roqRQYIzPyRJy6l7wCaP1koCt1e63j0
 cA5SdwcKZVFc4znLcMJFFKFIxJEcdFbn+DnDLFsJvumAYgH+RuyQzaS495qaiyZsFhnoo3tI+T5
 38iMhlBPFQT928XVmHqe7AOsPVDve/ya84Y2tQHvHWrFPh6FchRtNswMVA/LZZ0XIJ9xlNv7tiu
 Dmsvv6nJlwNhvzWty1Q==
X-Proofpoint-ORIG-GUID: 4wOdbhRt4fq1tVao8zd49rlv59CDfrtr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1011 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100076
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Greetings,

I have tested this patch on my KVM guest environment. I am able to 
inject EEH errors from host console as well as on guest console using 
location code for a VFIO passthrough device.

Tested-by: Tasmiya Nalatwad <tasmiya@linux.ibm.com>
Reported-by: Tasmiya Nalatwad <tasmiya@linux.ibm.com>



Thank you
Tasmiya

