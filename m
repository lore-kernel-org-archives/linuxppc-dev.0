Return-Path: <linuxppc-dev+bounces-27204-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C23E4C88E64
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Sep 2026 07:21:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hjxQg22YFz2yln;
	Mon, 14 Sep 2026 17:21:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789370475;
	cv=none; b=Oqnp5b5MOcc7EUWPxn0a1Y7KGnkbNAvZdUTair79T7CmB1HnYNbTUpNMvB+FhXoQvT6eUdCV7u2nC7qxYAaJ2ntDG1QkolLeYkRRuRo2mAiuUoPxYFfaDJVagPXQpATnjRHbuRFkRzsL3e5JU3sFQt+ytRN3mg6G8Y2RGJ3IgyPzZJs3hFt4G3zV1pQqS838QSopgBav7qknyURzKG/jzlfz8nOsbOYOswKsDo5/K4RON6SZewbVSmGql2eVpVUW/UWmXynToZwQGyLwOPY4uV1/DBgISyiOUFq/9wp4W/WYNEFxJVxFpteCWtYJL6de5AVmiSfcWjLI0Ap4Uxn0IA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789370475; c=relaxed/relaxed;
	bh=tvAglckuNGe1GKFzOm6MGddwaQMm8zfpaM97mS2Ybzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NovO0h3bCFv6HdfJATGZboXjG+Cc4CUx5tvSJgpeO8MdHDhrlE5QWiASlcxaozl8E3KFMCRzg4U0udvgynNYm5zN7jcrDZhRcIqL4PIUIAPFjs0gDt29VPZL+XPNy+cwe6SpTpiFPVVUeKIj6zytsmQOcBcLt9WzQFVVX911hLwJRyEKPwmEUtQJoj56KVLbh0x7tsI2YJym3fQl5dZDNSFOVv4/yxXlrivc4t0xp+DSsCvEtOGC4WcszPUpOkFEuysAFSIuNT9148meX6cLmenrFR0bQt7qgxT3LaIjpyZbLmDZ1KdUnKwTtxhkt+/x+PuKDD8ZmyGhIbUvJ6dFwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oMqx4K4n; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oMqx4K4n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hjxQf4qNLz2yDm
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2026 17:21:14 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E61kKQ3528143;
	Mon, 14 Sep 2026 07:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tvAglc
	kuNGe1GKFzOm6MGddwaQMm8zfpaM97mS2Ybzg=; b=oMqx4K4njyJTqPpBYw1RO6
	6Pugtk57ygImnGVf/i6I6zn1T+iyoSZkvNvem0dbwB2RajAkPuH1B8E/a9my6iFX
	e4qfBVbIZHVlTTslDUiLm51smQ54Dh3AM19n4ytPIOx8exBNmtf2Q0fDNZv7wO8X
	GteOe8B84gol7AG3H04Nwe3ffO7/AgawFuwVkiHypV6qgL7yA0IQU9cjolL8lr4n
	3IDguXij6+Aa5hbbYIMhHg8qtG0kIXVip1TXZ1BDeLjIYEGNk6NJ3VsrVSAMAEeU
	q9ngcI1CDaqT9tt660/zZMClCsOlsxEierpnvgNZzeIsIy+ks9FDdRvjwg1l0RmA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdpyrcr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 07:21:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68E5o5891805504;
	Mon, 14 Sep 2026 07:21:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gnkry4a00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 07:21:04 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68E7L3ZY48890136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Sep 2026 07:21:03 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 042C32004B;
	Mon, 14 Sep 2026 07:21:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20EB520040;
	Mon, 14 Sep 2026 07:21:00 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.93.83])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Sep 2026 07:20:59 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mpe@ellerman.id.au, chleroy@kernel.org, atrajeev@linux.ibm.com,
        npiggin@gmail.com, Michail Tatas <michail.tatas@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/pseries/htmdump: Fix leak in htmdump_init_debugfs
Date: Mon, 14 Sep 2026 12:50:58 +0530
Message-ID: <178919368038.441103.15578650989293635887.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <anJDq-JckR6j-6EJ@michalis-linux>
References: <anJDq-JckR6j-6EJ@michalis-linux>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDA5OCBTYWx0ZWRfX6LHL1shpG9wF
 5zfulkYy+ur5+Iy+Mi/kc3weJzPCSWdldj+uHN542dvIgWx1GuK63WCTQzkrhTgjw/QvLsOIVLQ
 He1/1UJ/uSvlkyT186I8BNuFldB7agBLCMkb7JMQjJ8KMaGF8St0dDroPwKTvqcGGIyc6fy/bem
 jD8el6MhKFHyjR9mkXfilQYmoxgyWGmhUBsapE/NclcCCylC9YHUOJtLit+7cs2DiiEPOa+Lo8L
 g2ffpDL09rgs+BdLX3tbs9Dq/xoeKZJmWd59hyduJgCCgdIdFq/8vFtFj3z7pjGEjoRP6H7WP9l
 Oc8m3FDavrh55ns5576W+rGEqqE+PDdXPA1w3tQmJOSBgu6Bp8qyS/27nF2SmwG2Ofb0WOKY2Zt
 SoARevyJKdKrvnGXokD+vzPleezn8SIH5LzjeTCO9flxx76gLf3eD9iAwvVcNk4LikOmMIUnM+k
 CV6E3AcFxmZcp/dfXJQ==
X-Proofpoint-GUID: tRyvwcDcFjkaBIQwjU3gNjef3J7BaurX
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aa7a061 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=C03VjNKf21U8VI5W56cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: L0Lusx8RqPPeKLnXgzXI6DQ8ls7xYyDK
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDA5OCBTYWx0ZWRfX5AuikOEoynbt
 knbg2PUTj+QCWMiO8VZcimos05gtIcnboKxqxNSSucjW1Y78sTwcUh3pui0WlaNR7QWMyjodHUp
 HFHEKelTxVDgFLMGSAz7rE2cNp0F8mo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_02,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140098

On Tue, 04 Aug 2026 22:55:23 +0300, Michail Tatas wrote:
> If any allocation fails during init all previous allocations are
> leaked and the debugfs directory is left.
> Fix by freeing the allocations that have already happened and also
> remove the directory that has been created.
> 
> 

Applied to powerpc/fixes.

[1/1] powerpc/pseries/htmdump: Fix leak in htmdump_init_debugfs
      https://git.kernel.org/powerpc/c/10557fe7fc9e09d273f8575274be2bbbe255dbf0

cheers

