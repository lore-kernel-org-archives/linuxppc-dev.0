Return-Path: <linuxppc-dev+bounces-28179-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAA8C9830D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 06:57:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrhMd6T8lz2y2J;
	Fri, 25 Sep 2026 16:57:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790319421;
	cv=none; b=IGCvWyfNGZ2DTLxtQDj9JELXX1DE4mnf8i1cMxOuIKpmVi6NA/Lut2YiSK4ExCyH8m0fca1AZlYSFHMm6HrjYWGBGY8l2QMugkw0t6tGO94djJyCWN4GMHvUy/H0eSpdtlDC3qBhXAkdwV1uz4nEJU73LVx8P2CXn7cB4QrIuxPMR5h8VlCHye6Acg1yfRqwx2OAm3nHFpIJ8XlXlMT3nABPuYTKu/xmSLTtcg6wNAEp3jPBlFhFPxed3dpHMivFjSt5rbbvewpHk9RxWroBQ3mKbpmQtCigwtMWWtv/DnMqCmr7rmZW9GuimKStcxGTpzNqZzqLWXCeQHrE60C3Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790319421; c=relaxed/relaxed;
	bh=gg3zGTD2Nn4teC3ohC9gQ//QfX/4YNW3sAHzpThlsd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSpjF3ilIJ1/ATW8PNqUns12fXyNynSh/Ou7f2xRaPTE8O5V7AXdoTcUl+qcHSsz4fcD9skjBsMZ+psRsoUPEvLRuYATuwIs8CqjaTFPDwYz4qAIWBEYXs/mmzkKCkkxF3NqDee/E/w4tEdI1k7hwSflfRq7N4/5dmL9YjlfV7lx4oBnLTpcoa04rzR2x6u1MdhQ99BrWNqfsbJCLKEcRQOjTLVgSajRts0iXfbxJY1UiAgM8XQPaTi7tu19NdNOxNVDbh1G+ZSCxfGVJUVbL+UR1XlNqsQp5v2VLlz+Sq3dLC9jvTku3i+CfVU+xE/aQR34Y4HVL7IKaaSSJpJk+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SDihzcyf; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SDihzcyf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrhMd11Mqz2xyj;
	Fri, 25 Sep 2026 16:57:00 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4aKnJ061566;
	Fri, 25 Sep 2026 06:56:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=gg3zGTD2Nn4teC3ohC9gQ
	//QfX/4YNW3sAHzpThlsd4=; b=SDihzcyfbDEAETLARV0CuV4KpmuMl/f+45Uwg
	ce5rJsDEYG6HmL6tS2xAsSsElgxuLyfDdkRWjUoJZwwobUf7HkxuBlI6dDS+EYcm
	Mzivk96Mx97aq7QOawAieYYdHMu7bUWDcmRNmSnN60frQ7oTPCoBKZ944JQRv5bS
	+9zG5OTEseaVgh2GdFywaHL5g/46uQe9QV9ZKipvI6VwZaPzCjzROSEsFZ9CRm70
	RXRRdWbDaudIqpBIQbwRMeB/dMaOOmM7VslDDwjH3Dptz3QZTXzCH1yDeBnpEhJ5
	A3TDQ18uVr8ZuMUyD5P/B6e9epudbE8rxvdn8Y5f07nSZASPQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgsnk9n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 06:56:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4lWMX3248857;
	Fri, 25 Sep 2026 06:56:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt31asd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 06:56:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68P6uile46661892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 06:56:44 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D66220043;
	Fri, 25 Sep 2026 06:56:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B983B20040;
	Fri, 25 Sep 2026 06:56:41 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.126.150.29])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri, 25 Sep 2026 06:56:41 +0000 (GMT)
Date: Fri, 25 Sep 2026 12:26:40 +0530
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        skiboot@lists.ozlabs.org, arbab@linux.ibm.com, mahesh@linux.ibm.com,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] powerpc/numa: Support coregroup on PowerNV
Message-ID: <arYbKIJPnGQoyKES@linux.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.ibm.com>
References: <20260902123458.340456-5-srikar@linux.ibm.com>
 <20260902123458.340456-8-srikar@linux.ibm.com>
 <c11197ac-ce7b-4fba-8ea5-4f38be9f7106@linux.ibm.com>
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
In-Reply-To: <c11197ac-ce7b-4fba-8ea5-4f38be9f7106@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab61b31 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=xvsa6UuGsR3Vo65tH-wA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: ytdS7RR2m4FRQMKEA5kr_CDi9uDgQ6Hn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAyNiBTYWx0ZWRfX1dyQy+7cZjUx
 QgdFevMPGhhpBGzN/debrfNC9ANxHttngRU4O0q/twQZ9fnaAMKbr8W9VY656OqDfTuDlU4+/p7
 YQatc7mNjyZyfL1dxrOjxiLSbXyT71jgX3Sxsp/Z75kA+wIfSghxvTjAcSrYur5OEeEW1CYxrYc
 8hidKlQUfKsyDIOwdXe1jqUrY4cfxUsFGvCeK+tL4h6j28iZw1eYh0r1nYjdLuobnMhEqZi0sSu
 PJCbi3hHSsL8hdPnkhp9y3gnN64Bp+xDMYUbqdd9Q36m5RCRi9aPNBqKXfLC+rwwWp6HrJUPPfc
 998sPy7BbTb/rLUhMiENJqCISEdO5/lJxNCnpuRK9fkA09Bcv1yTCIHFxInveGrou8EYtnBrXyc
 ANPdA31fHd/zkk5JwFPDrc7NhViNeYT+M9Xjf6A8KeNJHLIR4OHZgBfFIndsmj6WuCgVdTz3j5U
 w+FA+3FS7lPNXQjEV7Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAyNiBTYWx0ZWRfX3of7sbNrSOuc
 2yMn1kTIZ4juxEoGi1sBZDzGvbqSJGDEbuz+5Ntfj9tDqPjzvSLF5e6pIbkr0/8CCpPFe4FfJmc
 AiOqqhWaZOZxDW+2+Sad0t9DAMVSCOk=
X-Proofpoint-GUID: T0iavXmKeUakmDjWdT5w0XnGRXSG3LM3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250026

* Shrikanth Hegde <sshegde@linux.ibm.com> [2026-09-04 15:34:50]:

> On 9/2/26 6:05 PM, Srikar Dronamraju wrote:
> > Coregroup support on powerpc has so far been limited to PowerVM LPARs.
> > However, PowerNV can also support coregroups when firmware exposes the
> > required coregroup information through the associativity hierarchy.
> > 
> 
> Existing firmware does expose this info already?
> 
> > Detect coregroup support by checking whether primary_domain_index is the
> > penultimate domain in the CPU node's ibm,associativity property. On
> > PowerNV, a non-penultimate primary_domain_index indicates that firmware
> > provides an additional level for coregroup information.
> > 
> > This keeps the logic compatible with PowerVM systems, where
> > primary_domain_index is likewise not the penultimate associativity
> > domain.
> > 
> 
> Could you please put the ibm,associativity on this powernv? as well
> PowerVM's so that one understands it better?
> 
> > Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
> > ---
> > Changelog from v2:
> > - Handle comments from Ritesh (one hunk needed to be moved from patch 2 to
> >    patch 3 to build correctly)
> > 
> > Changelog from v1: https://lkml.kernel.org/r/20260524010017.140408-1-srikar@linux.ibm.com
> > - Handle comments from Christophe Leroy; make code more flat
> > 
> >   arch/powerpc/mm/numa.c | 58 ++++++++++++++++++++++++++++++++++--------
> >   1 file changed, 48 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> > index 5f326b005a2a..e97b624203ea 100644
> > --- a/arch/powerpc/mm/numa.c
> > +++ b/arch/powerpc/mm/numa.c
> > @@ -889,12 +889,32 @@ static int __init numa_setup_drmem_lmb(struct drmem_lmb *lmb,
> >   	return 0;
> >   }
> > +/*
> > + * If hierarchy extends beyond primary_domain_index + 1, then next
> > + * level corresponds to coregroup.
> > + */
> > +static int detect_and_enable_coregroup(const __be32 *associativity, int index)
> > +{
> > +	if (!associativity || index == -1)
> > +		goto out;
> > +
> > +	index = of_read_number(associativity, 1);
> > +
> > +	if (index > primary_domain_index + 1) {
> > +		coregroup_enabled = 1;
> > +		return index;
> > +	}
> > +out:
> > +	coregroup_enabled = 0;
> > +	return -1;
> > +}
> > +
> >   static int __init parse_numa_properties(void)
> >   {
> >   	struct device_node *memory, *pci;
> > -	int default_nid = 0;
> > -	unsigned long i;
> > +	int default_nid = 0, index = 0;
> >   	const __be32 *associativity;
> > +	unsigned long i;
> >   	if (numa_enabled == 0) {
> >   		pr_warn("disabled by user\n");
> > @@ -927,7 +947,6 @@ static int __init parse_numa_properties(void)
> >   	 */
> >   	for_each_present_cpu(i) {
> >   		__be32 vphn_assoc[VPHN_ASSOC_BUFSIZE];
> > -		struct device_node *cpu;
> >   		int nid = NUMA_NO_NODE;
> >   		memset(vphn_assoc, 0, VPHN_ASSOC_BUFSIZE * sizeof(__be32));
> > @@ -935,7 +954,9 @@ static int __init parse_numa_properties(void)
> >   		if (__vphn_get_associativity(i, vphn_assoc) == 0) {
> >   			nid = associativity_to_nid(vphn_assoc);
> >   			initialize_form1_numa_distance(vphn_assoc);
> > +			index = detect_and_enable_coregroup(vphn_assoc, index);
> 
> nit: I don't see return value being used.

index is getting used within the loop. Do note, we are passing index as a
parameter to detect_and_enable_coregroup().
For example, index is set to -1, in the first iteration, then
in the next iterations,  detect_and_enable_coregroup will not retry.
So the return value gets used.

> 
> Other than that, rest looks good to me.
> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> 
> >   		} else {

-- 
Thanks and Regards
Srikar Dronamraju

