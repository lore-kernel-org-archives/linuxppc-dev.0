Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B29606A320
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Nov 2026 04:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=llFjUWwy
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXGwl1Nlkz2yjg;
	Sun, 22 Nov 2026 15:55:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795323335;
	cv=none; b=SwJoOs62yToM4uWGj4UVaCVRcPV+wVaapObEJnGaesN7wj+kd5uixJ/J7W88eaVCtepjcOrQcy4cfCsGEE2Uy0SaBe5EZNLu0jJTm/AUFYi4cGYsX39LwBGoMQ4EiDmmJo/LLK5O0h3NglJszvDMlMRxPT3DkT48JsRyvdwvaqAvLj57MR8771GkIHDo2C5o7Qqtk3fgUDwpjfrx2w8yb6GmqaVbck5QZhoXDUFWA25vkzzThVdUU2bY2J5hTtvzDDKrHd45jkqb9CQO6FpI0iVgQqvG0ZTTaAaEs9UrSIp38QyYV8y1vvQS1MjjoOxmRDIKcB+4MGDv9QTVfJc4AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795323335; c=relaxed/relaxed;
	bh=UvD1XDHgV8kuPqdqxMhrx+KjEmgtr8uUpTTEddqRnLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=isUtUwWy9k7MUsvJoGhwEhk421GVGt+xqFcjZSOodQbRe7YTV9rzZWWyqv959nYrC5gIgY+zUaKMueTy2RPhXlfwvjKDN9SAqGSzdrav9hVXsLTrJjud7fAuEt1x2lnxMrdJ8P6pbY6pGvY0J6WamdW6Tq0Qg0W8oAUGxpIr1Ui4im7i2CWVzP5P3viUDg6cZkPVBYnXxK2GyIz+B1F9a+IUPUX8kbv+I7eirqux04aq5dUkGiu03utEN9s/COdfsxFRUz7riDl0djbhyFLS18zX/4zCU+w+fRWwV8Qn/nDDjkwERnWHrnxwId1aG/GATcT++QqCdlMZq5+Z3q/LKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=llFjUWwy; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=llFjUWwy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXGwk2tq0z2ygh
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Nov 2026 15:55:34 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM44s6H3865827;
	Sun, 22 Nov 2026 04:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UvD1XD
	HgV8kuPqdqxMhrx+KjEmgtr8uUpTTEddqRnLw=; b=llFjUWwyUso7jldJJZUIL0
	/OY4MdUBFGvwNPCujYeX3oiulb88Zci1l2IcBvNadzNdfU1Wythyn6JIq6+/SLdp
	hB7p3VAOHyizuA3GAEBWu+xm91vq2CovL9a2yBBISfJkXgf1IuUTmWRbMwzaHdZs
	QnH7mb3tjm85iiUDtrWK6lprPvM6nVABbA9rTmh0DeKEVJin3KRFGL8GdvD07Ghe
	efqVL6ZDWR3FwulYp82Ufs4cJYlLZNH7YTgDYr7dTV+lwzCMJGpISaoU/EYrIWuy
	Zgck8ipiNZNDHX0sPI8bASUXFd80V7aTNkIHPrzNivXPNCQspd3optPiqk0ZdcRQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34f9w0rh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 22 Nov 2026 04:55:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM3o6Hj3197290;
	Sun, 22 Nov 2026 04:55:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3p0v8q21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Nov 2026 04:55:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AM4t0Cg41746726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Nov 2026 04:55:00 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1630420043;
	Sun, 22 Nov 2026 04:55:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10E8020040;
	Sun, 22 Nov 2026 04:54:55 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.90.96])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 22 Nov 2026 04:54:54 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Hari Bathini <hbathini@linux.ibm.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Karl Mehltretter <kmehltretter@gmail.com>
Cc: Naveen N Rao <naveen@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Abhishek Dubey <adubey@linux.ibm.com>,
        Dan Carpenter <error27@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] powerpc32/bpf: return false from bpf_jit_supports_fsession() on ppc32
Date: Sun, 22 Nov 2026 10:24:53 +0530
Message-ID: <179532322374.92012.15207416512757152590.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261003184226.76740-1-kmehltretter@gmail.com>
References: <20261003184226.76740-1-kmehltretter@gmail.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDAxOCBTYWx0ZWRfX9KN2WSs3Va9x
 GViowpso6oJ4aXbvqp0b4l5uyaOltxXA5df4u5lC7OPeFudxHjAsvjx+BeQu/1vqyE4CLLFikbd
 pMf0oSNIn21dgKxXNnjOeeeYptUDrhzj0qSvXozQZ0gmUT9CDcKlnmEN9Z4pF0Kd8NK0aC6H+ti
 rmppxIHJd2HU40H/Sc1fBwc8MjCGzN2APf+wT9IBnZvW9RA4o2DCLK27AIINrmATpWQJcg3GPio
 j6LSnbGb8vM072A+bWaxdxFf6h2ZjIJ/E3roLmF0knUmmyNo0x3/bBib47W29tIJYilPOFWxerO
 6VYJPPs3pVI2Sjch4hBgwHJSk9QovGYpQFMSgAz7fMng5Feo0+LQteLfR5aurkYT0ac0boznvOB
 f/W4YJf2i6JXyhhVOCzN4t5JydFbQHZbRUDb59hFr3yM8awAqnY5qLqE2yftIsLpvLmarGB+BS1
 bXLtKwijGK9yf5PMC8w==
X-Proofpoint-ORIG-GUID: 1vYIMNPZlezeldqXvJxX8mwR6TJIFKvO
X-Authority-Analysis: v=2.4 cv=U6QHnuru c=1 sm=1 tr=0 ts=6b0275ab cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=-keKQWBAqDuMZrUa_q0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: jyYgcqtUMLmTuvrWiIxRUIKcvIr99gG9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDAxOCBTYWx0ZWRfXwBXDYCy5uSUc
 3WWHKs+HhQ2JorG5XZjg7RE8XdhZALhOVj8LYDB9viQ5fsR026oCK/OPodDGjeduB4+uIuILNrI
 wfQSiRGWjsoHntTOqhEJ5YknsJBk2bQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-22_01,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1011 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611220018
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 03 Oct 2026 20:42:26 +0200, Karl Mehltretter wrote:
> bpf_jit_supports_fsession() returns bool. Commit 92258b5bf1ec
> ("powerpc32/bpf: Add fsession support") made it return -EOPNOTSUPP on
> ppc32 until fsession is validated there. The negative value converts to
> true, so the verifier does not reject fsession programs on ppc32. Such a
> program loads, and only attaching it fails because
> __arch_prepare_bpf_trampoline() returns -EOPNOTSUPP on ppc32.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc32/bpf: return false from bpf_jit_supports_fsession() on ppc32
      https://git.kernel.org/powerpc/c/ba4564fc66ae796f5070925b803e8f3039423ffb

cheers

