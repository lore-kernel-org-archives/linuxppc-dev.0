Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1376606A31E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SuUdRgmn
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYlXq2jW7z3c20;
	Wed, 25 Nov 2026 01:28:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795530507;
	cv=none; b=nc+pcglIpMSjRULDJV1NL+7Y8yQwqSXAdc+xqPihVOFwpqVgOhUe+D3ZgSBaRYfTV9aTsNj/QsfI4YfS9QqLibyDnFC3aA8e67HeyWTYf7R0yf7rRcQIz5/r5r6ay/TVyMXNBhw4biUk/NU9lukQKELmxxgMdyQmo49Wb3bkU4S18KEjTz82WCTnK2iizqLZ2r37PsB5/t0QD+sq+6yUW0ZXlt+5lSFyMnfoP3iaUqeeNoBsr5aEoNoM7omOi4q6JA6cC70/ee2D/MVQ5khJ9XaLTG3dANOQniBBs2Z1eUeQqUyA0W6G7nkHfvXeOla5WtdGNe2/BBx4NpDxUmSUSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795530507; c=relaxed/relaxed;
	bh=iryZQVDWMboCr+mzKmPFMcC4rJjIhj+mBGOAQYXnrgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EcJ399pkmw/dKJ4+6m68y6kg80oUdF94ir++raeob0okTab2jPJ04CObnJS2FBQx2yM+4pB8e/Q/1l47JIVDRF3ooRqYjwCpHWYODgxJuQaJosuLbcnP+4aKYZ1cFDgspwU0IfywU1v/ZnddaXimB0TZXdTGbTLu+dnvFhVsknU5CcV9ldjCph8CmjKcdXQjNULjgshhkRfEyDb8ArmonOMdmxjDuh9jRSIeV3EmoxCIp0dF0rK044CjyB7tAsNFQ/c/uccLYGOzwiIozYbXfnvJr/XZ2hmZ5VrtLnWiHehHvl85t6sJMjY301wuOqCqCPXAJp0wB/dH9Hx04wfKow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SuUdRgmn; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SuUdRgmn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYlXm5VLLz3bxM
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 01:28:24 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOB4VkE2236219;
	Tue, 24 Nov 2026 14:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iryZQV
	DWMboCr+mzKmPFMcC4rJjIhj+mBGOAQYXnrgQ=; b=SuUdRgmnxoRKE7RsLy2xSW
	0g/8sLa8/aFDv4r7IKiEumfvoyl9Zzb1nI5a1zmSHU+ZGbrM8OQ31oTEl3ClUyrj
	tfFHV/YNzy1nWe3vC10E+IYJmLQdPe2361ME/ibS8Wkt4zvl2rNHZnNckjRxzGc/
	doj0JVjWuoCDE1digOadraJnMiLa3vyckkfTnxGUjkQOpxytuWyZ+mZob+6BcCAb
	em+wI76RSyKIrhE4Tbt+uTZJueWcNi+YYfDNJXJ6I8CgSgSNnvVL47s32Jf63TD6
	R+Ra9z9BUss8ZIJ4/IZIExgB8XdsKUibWSuzeNaK5n14YskRnMveQM918N95ZtyA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fkg2yw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 14:28:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOCoR9U3374824;
	Tue, 24 Nov 2026 14:28:20 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5axkr9fu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 14:28:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AOESDdk39059860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Nov 2026 14:28:13 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A0C12004E;
	Tue, 24 Nov 2026 14:28:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD0552004B;
	Tue, 24 Nov 2026 14:28:10 +0000 (GMT)
Received: from [9.124.211.71] (unknown [9.124.211.71])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Nov 2026 14:28:10 +0000 (GMT)
Message-ID: <0b39ff0e-ee51-45f1-a361-5f0cb49d92b5@linux.ibm.com>
Date: Tue, 24 Nov 2026 19:58:09 +0530
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
Subject: Re: [PATCH 7/7] Subject: [PATCH] selftests/powerpc/rtas: consolidate
 TEST_GEN_PROGS definitions
To: Shirisha G <shirisha@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kselftest@vger.kernel.org, maddy@linux.ibm.com,
        venkat88@linux.ibm.com
References: <20260918052321.932660-1-shirisha@linux.ibm.com>
 <20260918052321.932660-7-shirisha@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260918052321.932660-7-shirisha@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA1NSBTYWx0ZWRfX0pZweAluiFvj
 bf05hTBKthK8xpt45M5cunFlYj0SyDYzz6rQLZ71K2ScTtW7xa6xklO4UIYjqrrn+l/YDyV9Sie
 XyWmPZflKDmQUcZiQ+R+IRfYLW+NeaKpomZ3s+vwC4XyP5rdqeSme1DtqFH+7RqXdo4QeTdz1bc
 OzPooxv66K3ye9eCOVGDJqEIrkovwkKXi9Un+y/5e+4SpGWkdRTAymehXQ5peu+OiGIvwPrtoaR
 B39XTp7Q5O0gj7wK2wnW0PsL8dKSP3DErRE8XevzrFyH5HsS3ClX4wAXD02439K/c/Ef830xjaK
 JFY1F8SnpI2baAag6Er9eDQCIk0k0D2HsiSz3E597uIS22K3dG9sDWatAtI15DkjxqtX9JuGWUj
 vU7BjH9ilElwJvHrOfkcSXvHWE5FtqBxcARn4IMQ/ZK4Z6p2sRrTi6LVf2YVD8UBCt0rywkadHy
 BZSUHpYBEf2rZOvjGaA==
X-Proofpoint-ORIG-GUID: H7BOJJMqW5UG_I3VeXGFmdSMWdLjl--Y
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA1NSBTYWx0ZWRfX8bOgBtIT48d2
 rvToiAwD0ZucaaUZxH1ZbToTXN85aeD+do7o2URi220YskacrY12hU2JG/OdW8sFpjrAO+LegBy
 KJeSys9bKSzlqcVNf4XEP66HRW7nNCI=
X-Authority-Analysis: v=2.4 cv=A9z5rKWG c=1 sm=1 tr=0 ts=6b059f05 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=d9toeekAIwPyeozeaWsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: H7BOJJMqW5UG_I3VeXGFmdSMWdLjl--Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240055
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 18/09/26 10:52, Shirisha G wrote:
> Use a single TEST_GEN_PROGS assignment followed by incremental additions
> for the RTAS selftests binaries.
>
> Signed-off-by: Shirisha G <shirisha@linux.ibm.com>
> ---
>   tools/testing/selftests/powerpc/rtas/Makefile | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>   create mode 100644 tools/testing/selftests/powerpc/rtas/Makefile
>
> diff --git a/tools/testing/selftests/powerpc/rtas/Makefile b/tools/testing/selftests/powerpc/rtas/Makefile
> new file mode 100644
> index 000000000000..eb30f62c5636
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/rtas/Makefile
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# RTAS tests
> +
> +TEST_GEN_PROGS := rtas_rtc_test
> +TEST_GEN_PROGS += nvram_test
> +TEST_GEN_PROGS += rtas_proc_test
> +TEST_GEN_PROGS += fadump_test
> +TEST_GEN_PROGS += rtas_flash_test

Each test patch should add its own TEST_GEN_PROGS entry. Please move
these lines into the patches that introduce the corresponding tests.

- Sourabh Jain
> +
> +top_srcdir = ../../../../..
> +include ../../lib.mk
> +
> +$(TEST_GEN_PROGS): utils.h
> +
> +CFLAGS += -I$(top_srcdir)/tools/testing/selftests/powerpc/include
> +CFLAGS += -Wall -Werror


