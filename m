Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E36C001DF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Aug 2023 23:01:10 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UyGIrNJa;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RGSBs03rWz3cT7
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Aug 2023 09:01:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UyGIrNJa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RGS8M2wCgz3c1Q
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2023 08:58:59 +1000 (AEST)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372MrWD4026357;
	Wed, 2 Aug 2023 22:58:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=x1bhK8dC22U7nBkktIiSBiPfWiw/5rtVn0oMZZMLaj0=;
 b=UyGIrNJav1YNExxLEZAg5yqY4gPKsl3Cw0MlbfmBRTD8QcVxbHw67j0xcTimVXsDl0Yc
 zBRswQA9JJGANPMhNz8D42DhW6N7oATayKnxfJwXC6rhjdti70VWslK3hFRl0P0vfO0L
 AHWwTB0RsBXtCiGTxMZ0JmiNqzRyUAkaFa2EsQ6kHCtzSz4cdrjBKpSYJ2C7Hd/1+wRN
 dSH9PnA5zPGRdCDRxkr3C9sXnRqHDT2wANCnPJTAS3ijWF4/Cl8XfXbZJGV18U6rUR8I
 ATR22fKetJj4o49zPwhVakO3NOk2ttNHAeu/ugpwD2T730eZt7Yema6goEgYE4goQYSc Hw== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s80ba8274-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Aug 2023 22:58:54 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 372LtUKN017127;
	Wed, 2 Aug 2023 22:58:52 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s5fak0222-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Aug 2023 22:58:52 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 372Mwqnu6554344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Aug 2023 22:58:52 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F27B58056;
	Wed,  2 Aug 2023 22:58:52 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04CED5803F;
	Wed,  2 Aug 2023 22:58:52 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.115.23])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Aug 2023 22:58:51 +0000 (GMT)
Message-ID: <ae9174eff39d4bd57c603d0dca78dd04c7dccbb8.camel@linux.ibm.com>
Subject: Re: [PATCH 3/6] integrity: remove global variable from
 machine_keyring.c
From: Mimi Zohar <zohar@linux.ibm.com>
To: Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org
Date: Wed, 02 Aug 2023 18:58:51 -0400
In-Reply-To: <20230714153435.28155-4-nayna@linux.ibm.com>
References: <20230714153435.28155-1-nayna@linux.ibm.com>
	 <20230714153435.28155-4-nayna@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K7SAyDXmebBoxI_mE__j_PeNqQ_370Yh
X-Proofpoint-ORIG-GUID: K7SAyDXmebBoxI_mE__j_PeNqQ_370Yh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_18,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=908 impostorscore=0 phishscore=0 clxscore=1015
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020199
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2023-07-14 at 11:34 -0400, Nayna Jain wrote:
> trust_mok variable is accessed within a single function locally.
> 
> Change trust_mok from global to local static variable.
> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>

Reviewed-and-tested-by: Mimi Zohar <zohar@linux.ibm.com>

