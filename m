Return-Path: <linuxppc-dev+bounces-28003-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D01C982FA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 09:26:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqWmm2Lwhz2xmh;
	Wed, 23 Sep 2026 19:26:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790155576;
	cv=none; b=L4Zvspme96qf9PEa9LjjAkev+73oleyIC4N98rjnsyj6/HW/aQMm1gMveNDjOeI/cHiZ2dXUNzlXADGealVQjEwx5GgKrSnps80pvx8Kjv3/VoUU7SzbnmWQe2/2sZk6UksNRMFV7MVvE6T6kdDW3WsXLeWO+TFj5OWMLjEtfu2H8qloKN1869RYQxZcHt2kbni26znp6d/NlHwWxpSt82NpVU+YDtjt/ITw6yR9AveQSX4Ra2+ro0tpzO+sNqBFRElU59VHI8ZIwklczkAzWLh2xn7py25+I3UDfcOhjhBZoU/UnGtC95YP//cQ+U5h27jZeSR3WGA1gy1jNQQMWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790155576; c=relaxed/relaxed;
	bh=/Pb/HPk8qE15QQIw9lXoMFDPPQbYIBOkhW3LZaHPdyI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQHIBJVVYmHttZKi3G1dngkdgp0OC4ynvMY0zaXwd3e5dojqvRW5EMiXqd4LlZqO3f5SFaMzbyeR4BCSfhDbV/wbq+EniRzIb3ZADwpBKJzSWGZOzDEThfRE0bon/DvXLSfm4ozJhSaRg1Nj+BeJ33ku9yiRvh4WWb1hawglEojaxyxc6eY8tnP7+C+jj3XxtO6t1F6ZB6m7MZza2TxeppQC7PvuDMOd1o9R/UJOb1sdLozjjH4aJgINgNXSA3NDV72NwGGh2VUqfZLCZIcEm1pou48ieS+omtH1y0fgPP1PSWfHneiHU+VHvgfTBVkv5IUOCWwzZEOtPCb0qA5gYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SqPInnDC; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SqPInnDC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqWml1mnNz2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 19:26:14 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8ZTrm2907112;
	Wed, 23 Sep 2026 09:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=/Pb/HPk8qE15QQIw9lXoM
	FDPPQbYIBOkhW3LZaHPdyI=; b=SqPInnDCIXn0fGp9dgyE8yINNF0jZwcpHDCMJ
	2xpghe0+mYu5JUPmosKMuKIZ8UjA2ZYjw+CcpHgQ+q8K2HvqjyygZ3YOTJmXdQm1
	5/+Zh1P7mvVod+4eGQJZeAxLGrd+msoWyYEd5Sujgd/h4i1xsvYSNofoQ0qtpGQ+
	tr8N5X2Bdmg8vO+/cEs1e9uCaSf3ftHk5f/GrVa/Pkewyt4TXrdrIunhUYihDG9j
	DBd0hCE13xdw7rp4MuUAQ/5ACatkp9BTgJXt1nPi5vdbkDPlu3wN77r93p7S5VeT
	TNCAAvvlmvlz+JK6o8kExQu/TZaXbY46fnB9ZSRFwUf4qu84Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgsa9cg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 09:26:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8LwuS008049;
	Wed, 23 Sep 2026 09:26:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb6qg67q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 09:26:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68N9Q6dj47317366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 09:26:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CF4720043;
	Wed, 23 Sep 2026 09:26:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27CEB20040;
	Wed, 23 Sep 2026 09:26:05 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.126.150.29])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 23 Sep 2026 09:26:04 +0000 (GMT)
Date: Wed, 23 Sep 2026 14:56:04 +0530
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "scripts/faddr2line: Combine three readelf calls
 into one"
Message-ID: <arObLLalNd_fMi2u@linux.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.ibm.com>
References: <20260905012449.3872882-2-srikar@linux.ibm.com>
 <aqhDm60zSZIazrnC@jpoimboe>
 <aqiqScJg8Ey5QnKl@linux.ibm.com>
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
In-Reply-To: <aqiqScJg8Ey5QnKl@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab39b33 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=uZoqLgDn0AsYzM-udzAA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: TxBX3XJefu7F2_p06RZKwIsiUGgtT4ud
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzNSBTYWx0ZWRfX9CttZq7zgnxB
 t+Uq6P603T1ZglTzefMiPLhZFS5MCs49GaqAGNV83L705TjJqj6CwPxZXf7vGmtvYD1DGT+7Muq
 +Tzg6uKliqrfR7bhbGfJ886uiTAjWTokB7ijmKF0mTORJptjjI59gwRLURlGiVGsZ+k0QjuDKsg
 TJ0AcCJxoBVJeOLpN9Nn0/l+bOznV3LP1HgxKMfZd5rzVLfeGCLZxYoW04TehnO7dxOLQHiEUpI
 kHQZgWAidWhIU7sUXhWogxjGG1Bdj6tsQUMqju+EwBDT1/Qy7jnveDG3+FRvsmkO5gtYrKDVwjO
 BrxOQv4n+wUXjkrLbzbyXICpzfQpFAIgebwQI++woaqXITAH6wBw1UHta2Tt8ejBF6row5Z5aUO
 VCsKrFj+DGyXWFgmFCt3NmOaaYdgYRhJhuHiFc2c3NWIC89J7qdcVnlB4kh7AfozOmQ4F1Fc+jv
 LeBI0NeCqG14nlzVrBw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzNSBTYWx0ZWRfX9bOSIgz3krSJ
 tIbgmkVyq19UVUjRqh7I9vVpzcZiIuFxv4rjSXql84Zg4oarHHOzpqkMVsCVbcG1p/NuEGqyUW4
 5i8oucfoNxQE4ogaJ91c52rOXGq8nyY=
X-Proofpoint-GUID: ADsUo_F8NtOgviKY6q7Sh_ih7Q0BpUnX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230035

* Srikar Dronamraju <srikar@linux.ibm.com> [2026-09-15 07:45:37]:

> * Josh Poimboeuf <jpoimboe@kernel.org> [2026-09-14 12:00:26]:

Hi Josh,

> > > With the revert, we end up calling readelf three times but this should
> > > still be fine since calling faddr2line is a debug tool.
> > > 
> > > Fixes: b8d9d9496c1e ("scripts/faddr2line: Combine three readelf calls into one")
> > > Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
> > 
> > Can you run
> > 
> >   bash -x scripts/faddr2line ./vmlinux need_active_balance+0x1d4/0x21c
> > 
> 
> + set -o errexit
> + set -o nounset
> + UTIL_SUFFIX=
> + [[ '' == '' ]]

Did you get a chance to look into this.

-- 
Thanks and Regards
Srikar Dronamraju

