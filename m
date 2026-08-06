Return-Path: <linuxppc-dev+bounces-25475-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E44C55ABF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 05:12:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFwPZ74Vzz306N;
	Thu, 06 Aug 2026 15:12:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785993122;
	cv=none; b=Chs0Ew2agewCShBJZOFUQdRmo7kpJUIF33HfZkdQBfYm2f8T/OJ1AmcPYAus8FdxohdqK9FYcLVsuv5WYfUuDpVnfhq3mDxUIcxreUTa5BBaFs9xDhE3i7D1+1iAZLz+dLbx1nvPzccw1MCvRbImlAw/XB+BjvJeIYNRaH4thU8MtNH98z+7rrxg09JQrj7vfA5YymW77W4gUptG6fjp4wkhw1VICpt9jRsxbQVmyjQNlKZU0qdB7eaSXwgLubb9Z2cHzpImwngEZBi6S7AIbMkJAZEv67e1STmPrHWEsfpUic5AaJaBk3eAKrq5q+599u8ratn4A7mejFpb3okbDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785993122; c=relaxed/relaxed;
	bh=e9W5HlI1tn/93FQ+C5XVKL4rfDCwLzLonyMzA+AVbrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jabY3twXC6gFel9FbwaphmlbmOknFefuH+acZSlbbncfewD3705fcfL54K5aZiDWllU5ejvZnz7mDqSymUTJLD3qgLvWzOosNnhG5PcJ6NcY2az9Fx/QhzgwpfBAunQAWnOGvtrboa+US7+vvQDShWuqwxHifVAaj9BzKZKbfJd6E/F8qJTWa3Zonee95eM6Ju+ddSo1PemeKiwloix0KTyomZYjPtEYDYZEQKhdbKop9vOULJ8TbimSjtGib5ixeCXI2qOBoscMP61pVlnIGRHq2N3RISdWhAuKUHTKRzI+NMYzi9rlJayl65p087kobTCUMai6VznY+PjFkiC41Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=a6e5oyh2; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=a6e5oyh2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFwPZ0yjxz3054
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 15:12:01 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675Nm3DE994338;
	Thu, 6 Aug 2026 04:16:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=e9W5Hl
	I1tn/93FQ+C5XVKL4rfDCwLzLonyMzA+AVbrM=; b=a6e5oyh28pmDH1YK5Xe9SD
	k+9OXcI1/7YGD4FINTB5u8DtPNnhvEO+E9j9FTiZpyV0+RFjK3FlKrcYS2NynBf/
	sMYTtyi31VXQwGiOUyCtGFOrOk6tlNBfZPLw3u5tC4/R7F0Ad6FRkLD4c++S0oLB
	uZR1c8uPH0NqyU9rgIdL0JQDOEgWUinRe6LETN6QQcV9q+GxS9QS1aFOZMi1zPvs
	bQCpcYGizWzdwaDWXcMjzeoieUVwtISmcJCPVzx6pQoRN0kj6/XO4YP3k2IJBszA
	q6Qy2MqL26tIYgLOhvXuv2UmW+5V8BAwrhXIenO9NUQdhvaE6mlwZBozaDabcIlw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hx13b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 04:16:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6764BIsW014624;
	Thu, 6 Aug 2026 04:16:34 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtysc52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 04:16:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6764GUHA31195490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 04:16:30 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FF5C20049;
	Thu,  6 Aug 2026 04:16:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53CE820040;
	Thu,  6 Aug 2026 04:16:28 +0000 (GMT)
Received: from Linuxdev.j9d-in.ibm.com (unknown [9.123.86.85])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 04:16:28 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mkchauras@gmail.com,
        Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, adityag@linux.ibm.com, mahesh@linux.ibm.com
Subject: Re: [PATCH v2] powerpc/64s: Clarify copy_and_flush() cache sync loop comment
Date: Thu,  6 Aug 2026 09:46:27 +0530
Message-ID: <178598971879.942627.13294708865954950446.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260706082708.43918-1-nikhilks@linux.ibm.com>
References: <20260701182756.273019-1-nikhilks@linux.ibm.com> <20260706082708.43918-1-nikhilks@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAyNSBTYWx0ZWRfX8bt86qXxeSt8
 pHtVZbciZpQip8o8ayzPxJo1iWcJpAhi+R7I4tSo+abxxLzCdkOObKYwBzkxkd2FWtqTh3Crplz
 ixpxtZwyUCC6axa0P/Pk98A9Sj3l1F8=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a740aa3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=hrc2wqqJEVIXeOxj9-YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAyNSBTYWx0ZWRfX8TjNasVF4/nS
 Bkt1qgOH77dv8zC1eaUso2FigQB0eFdUmawFlzwy2Zq9TtBcVhP3K/nN2pNyc5a2x7KcNfyHGjU
 rbdQlPMSup2+DDHZ8ZdVqmuHVy+0HkXNce80h8U6ehQR1w+GLaGUBrnI5F6aeYYpwtokPmB0DvL
 oqP15iNL5RZxdWlc46rBYY8ijrKsHLveL+RmajQZ8t5aGOkU6oUgB9coEpqxY6aOFAbJlyVSR+p
 w1S6H7v2ggmrAPdnA1JU/4KFWKP9ZWjByb2lpHK2rtQANWuSRPtTvjzshshRk74uqhmgXDPYluQ
 Er/MHoja9c6N5k24RERIpe13wJHihqXgGZpRU4S2KVVaANW0nhSUD1XAs35NEP4D6rpN7Ivb0EI
 hhoHmWZx5652CMZJcnXKH8b4Jnrf5mRVHef7wiGwEiAodIV5k+yfi71oYBj+33xnm+PC+GpriRA
 M+n/WyFqmBMU4m6WjaA==
X-Proofpoint-ORIG-GUID: mMXAFueohu88xwEW8uYqs_jNvmaP3XwI
X-Proofpoint-GUID: vavl4_K0Wx4EKoDJL1BZZTZf4buBGkl9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060025

On Mon, 06 Jul 2026 13:57:08 +0530, Nikhil Kumar Singh wrote:
> The value loaded into r0 in copy_and_flush() represents the number of
> 8-byte words processed between cache synchronization operations.
> 
> The existing comment refers to cache line size, which can make it appear
> that the value is a cache line size in bytes rather than a loop count.
> Clarify the comment to explain that the loop processes 8 words (64 bytes)
> per cache synchronization iteration, and that increasing the value would
> skip cache maintenance for intermediate cache lines.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/64s: Clarify copy_and_flush() cache sync loop comment
      https://git.kernel.org/powerpc/c/76ea1257924f64521f708db91c99014ce7249bbf

cheers

