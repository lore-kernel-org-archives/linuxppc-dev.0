Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB36A606A320
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Nov 2026 04:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=W941NW1a
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXGwQ6fXYz2xdY;
	Sun, 22 Nov 2026 15:55:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795323318;
	cv=none; b=fHvmLADDXw+uw8zuwdrBPmtbb1SMcgAfbUQ3T1ncUSlZ04vQLS6hvz9c5IGFxD8ohVpVLmRtRq3zXQZJhowoW4ihAI+XClEFi2QC8U0MxfWkRILqsUgeZ/hWyIAcqiv6eUY4NDjFZYmZJu9HHVYfQsnWV8gL6dl8W9QxcM0jAmIrlGnAInr7XNB0N0KmAkTLfxHUpOcyyS5AB/WEj1OssdUuGT8p+wNr0HJzvEuoiCjsDbN4XXnLxHTSxInFYqIW0ocXb0U/8t5+PokwdRZHYhwNm2Jb6+w8ueQsG0Y6oWaL3/k707GWQev6BWqrlpvjaZkrOAF6wqnwW3ZduxF4OA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795323318; c=relaxed/relaxed;
	bh=kdLauVpY9Yo6pj5sNKVnpV0+CPCa6XuOMaRpyST6pbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ANpSn2XfkczF+EB6lwX2gAJ6nEMrHfu0sh5gnuiQKh6t6RKcARnRayHH6wW9I9RUu51AuG9sAljrSyfdkUnL7SYzCx1WN0u9cTpj1w42Aa9zpvNknSHax8AeUoXEk+IFgBO35hkvVlaZNbzDrHxsGEE56IGPNqxjKUw6bIbmTa0J3O0N/LzMhjHnqwTh+8VJCZ7a6l527qbS5WyQ/KmZJqt++GjwGGDuPAg30dUvihS2XCVuZQ4TAiSj+aAvyJASQ9DbrRYfhQuSQxAxgYfOQ/eldSSzRtE23jHmyW1B0ApLXbqeXaKz7JO3onueZEqS+iGxNANdvdkPvGm5L9O/zQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=W941NW1a; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=W941NW1a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXGwQ0sn1z2x99
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Nov 2026 15:55:17 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM44cKC2469571;
	Sun, 22 Nov 2026 04:55:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kdLauV
	pY9Yo6pj5sNKVnpV0+CPCa6XuOMaRpyST6pbA=; b=W941NW1a5s76U6iuaWXtW6
	xpGpM1xk8JB5TXPvVfLhuI+qf37JMoVvP7kQb3ViZYiwmDqk7H1BZnBXGPGaR54q
	UsGdPst9t6gSrnjMeFw4cUAfI6ZWw0CsSKVmSvDJ7Ee96DUA386BroI53DbPPbJC
	UQcde6/Nww9FLes/wqCUytSu+zclyg2walG78b50UL694drsSV414Hrg80sgOC+E
	wCl00hYDYNxhXIkRwGzqKwh1A2zMf55O4D8U8PPVNcQlA3auu/7NNdGSvkJcDTmv
	RIozOpajHnxt/Dj1w/ZaUo3Up8Xrz6trLFZ+sz3RCLC+CcjFuI5NFQXOprotcyEw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p44rst-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 22 Nov 2026 04:54:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM3nYe0810579;
	Sun, 22 Nov 2026 04:54:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3q4h0hjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Nov 2026 04:54:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AM4srJ041746720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Nov 2026 04:54:53 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3888220043;
	Sun, 22 Nov 2026 04:54:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E806220040;
	Sun, 22 Nov 2026 04:54:49 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.90.96])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 22 Nov 2026 04:54:49 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org,
        ritesh.list@gmail.com, sshegde@linux.ibm.com, farosas@linux.ibm.com,
        Haoxiang Li <haoxiang_li2024@163.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: PPC: Book3S HV: Clean up on uvmem initialization failure
Date: Sun, 22 Nov 2026 10:24:48 +0530
Message-ID: <179532322364.92012.7986778361768910539.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118102012.2252221-1-haoxiang_li2024@163.com>
References: <20261118102012.2252221-1-haoxiang_li2024@163.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDAxOCBTYWx0ZWRfX5y5VOp5v1df4
 W6PJPQAHFa68FjOVGvn5sjfql9qo4ZvnuqvbAIpSNlzyhBvOJzec/6TNh1vHxM9GoE348j5Ms2f
 MnEWtimaI6qlNIl40JUY2WWK1Dt8FWE=
X-Proofpoint-GUID: X5PVK69_dnM84_fl8OYqgTKUcdIIPg3N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDAxOCBTYWx0ZWRfX5lMeTnyJDl7L
 TK0HMIYYBuq0AeJSJHY8SKXuXrxyjNIGOm+y+HdpHnI57bLS4YzJvaE6ru6YXOiWg7fT0R5M1di
 u9ZViP6wNso/gbVtvL4l+K2Jc9LjOB+mvpNIP+7KdbqodLNie2NuSRlyTAzIC9NNaotYiBgTYez
 knQhnLaCNQJFf1m4xbRnxk4wRzO6g+MZyiI2yeMcuWiRX1A50IdOhcL5Pq3aDgda+D9uEYHC8nn
 N1e5Iq4cXY2SNwP6U6KvVa8sMbxtKfVSXE4ytWpppoL+TWJSccDB+du4MkArkoq6IQjNXZOArPQ
 0h5xiEXGsnevCNOvUxik6/p/oDBGdRI0HvkUd2kU3pSjEdmZbioGG5FoXdIF4GWop34jfs56o+U
 L3ATkZp/qBtyRxB4DMjIZMouwxNYB/Guzfub29diRaAnzaneGX1LlrblzvSUq/FfUrlItMrkZPL
 2KzjM9hMEqAnDf6cKVw==
X-Proofpoint-ORIG-GUID: ekAhA9xlJfu9pb04B5umrzg9mpm7V3yj
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b0275a3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=pKdLQWa3WuirC5Xg7FAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-22_01,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611220018
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 18 Nov 2026 18:20:12 +0800, Haoxiang Li wrote:
> When kvmppc_uvmem_init() fails, kvmppc_book3s_init_hv() returns
> directly, bypassing the existing error path. Jump to the existing
> error path to clean up before returning the error.
> 
> 

Applied to powerpc/fixes.

[1/1] KVM: PPC: Book3S HV: Clean up on uvmem initialization failure
      https://git.kernel.org/powerpc/c/e721359e5ad0292d93bb9779c4b09fbeb681c266

cheers

