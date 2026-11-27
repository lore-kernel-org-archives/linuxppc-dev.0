Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BCD606A321
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Nov 2026 09:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rXoBp1vU
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jbSYT1tNnz2yS4;
	Fri, 27 Nov 2026 20:19:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795771197;
	cv=none; b=TZ4PtqDXziNUUAr5H9TKn0T68cKX96XB+G4D4acad6K7cdRCqvdSLfW3RWk1gljXGPf6SvRyCYzsb7UeYljtcqB72wZ5JcfeIA4b1HetEC2ZMEpNCnChd8/x7EIM/PjYgaHinhS2P6kkdgwUWgKqFrEDQCvN9FMMRwKHpxt1mbl02epgofWgfSFbDHEr3on8I/30n57HW+jzYDLoqIe+Ou9wKTurdnURRT0o5Lz36X2WPc5EKPr1+c5c/NTcAznlhOrmFJTDapXAzqPldk+8/Mbe+CBviQnRuPyRgeVm7HhA+Vb0UHO5vTCanLKBLX0+cJPVlwa5fGSEtcBpOYBRwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795771197; c=relaxed/relaxed;
	bh=UV7bRKr4EmyRedHiTpywUdieR2Ox/33Ouk5Pyy9wuac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJjte6yYHHc8Tm5ez9x/eJoyQYHG+tskcF2fK4AM6exa39qn/N5FCNaD7EnoqpmFXBWUT9kGQoBfP7QiVIQbUabLZpeQ3iEvlo/Oz1YVs4nPsA8nS6ccBUNXQuXELtr5G7hE7alzWosgngp8J3rsFRhfv2gTj+Sb3lT3NqEfdIH58/tQpo3l0q2LEUhckMHIXWa51TIRuErqleRTCin4Nh2b1S4xsrBVq9kTNIjxWpObT8VI0IokywjKKB7bBmLf3SeBWCSbpdLZ2+uBoIl5d5JumGU5A6jG6UyK24U0neBL/NumvCLrh8cbhLh0a+ltrMELGWWKgFHHuXz8BvZBVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rXoBp1vU; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rXoBp1vU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jbSYS3kPqz2yS0
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 20:19:56 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AR7YoVa2642822;
	Fri, 27 Nov 2026 09:19:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=UV7bRKr4EmyRedHiTpywUdieR2Ox/3
	3Ouk5Pyy9wuac=; b=rXoBp1vUqeEA54A8cyzh/FSQJnVIi7KxDhltilDnUagixy
	xw/+S4xhZqJk8hcubiO/xrSDfYRWmMgaGc9sfnTkpGXsQB5g0n58K5FavrkjPSbR
	mloT/PGcsimiemajjk5nnAUBHqii3AphyQHrmQWstt+h1hqE8UXOXlb19Flx7V6h
	2Wvp1rtD+YDQO14Oj+gfNejafE8zXaxu7TKEPgyfNQQYJb8skxBkLKCLFRfXAXMl
	23+okPJI5sIz+pNkpuvXC1B2UAthpeW4QP4bd2m1LLX56FC0svrI8mvTFPnrOk2V
	2lE62uX8ywh7HXu3qKT3/9qAS7faNT8WeGyIGYvA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fan4e4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 09:19:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AR7JSbD2384610;
	Fri, 27 Nov 2026 09:19:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5kfa9n3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 09:19:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AR9JNWI31523362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 09:19:24 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D059120043;
	Fri, 27 Nov 2026 09:19:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA9312004F;
	Fri, 27 Nov 2026 09:19:21 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com (unknown [9.123.6.5])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 27 Nov 2026 09:19:21 +0000 (GMT)
Date: Fri, 27 Nov 2026 14:49:19 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Sridhar Markonda <sridharm@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        sshegde@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/hw_breakpoint: Fix NULL pointer dereference in
 thread_change_pc()
Message-ID: <awlKzM0YWWrCueMi@li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com>
References: <20261126230422.1533-1-sridharm@linux.ibm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126230422.1533-1-sridharm@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDAzNiBTYWx0ZWRfX/MZFAHphplan
 O88pzBlNyYQid03ocXE7HPSBfqpAzAbMHdcdXPTkbYAK4ViJLN2gM5dGbs31hzBbKxXlZRsQlzD
 +jsyML5UA0jFthrqsrFjTorHbpFbF3Po2IhvdVSwDl5h5+2duX2DHBC9AoXlFw5TrNRdb1ZKbZg
 2xxuS8s+8ZW4bV2ThFcapia8oV7a2O/rIn8vN24L0N+Pfy26pPWKvZdhCIKYbHRMpeexKYLvjk1
 9m6VxPhfDQ9Pblkz3Lrr/DtMtaFFpk/5vAyz1vEJTMIuhfRrxI4bnN68H61lVFNkd5EDnx5dFrR
 RHpCjwv7Ya1fwCry8W3RCc3QiwKmbIcpitXyk/z4dvDCqxKQ6eDpU5awd+xcylVWQ/AVgDXni1e
 op9xfhdRouQA22rhgLAbiRhi3xnf81CtfBP0SqJlVZiSFEei5wsyHXQny6xyH4DrEA4eEqfbCTI
 WGfSTps10d8lcvLbvSw==
X-Proofpoint-ORIG-GUID: 56469NUjvRIz9lnV9qvqw7KoaA9Wrd7W
X-Authority-Analysis: v=2.4 cv=U6QHnuru c=1 sm=1 tr=0 ts=6b094b23 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=-KWNbHr87wBw-rPjBFkA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: RECGKMkPj-g_ccDOShB1LNK9Mq0gAowr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDAzNiBTYWx0ZWRfX31bq+7PN2f1z
 SVmbQa+yxMl2hkKTeoU9U6mFWFJjed+P72KwDi4D8OCTS9ck+Xyt77k3GC7xQD1dzsa2LN6RYdf
 Kp8JHdADbEnoXF6omIBMk2/A5AzYsEA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_01,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270036
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Do you also have the reproducer for this issue? Also if this was
reported by upstream syzkaller, you have to put the Reported-by and
Closes tags.

Thanks,
Gautam

