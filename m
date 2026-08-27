Return-Path: <linuxppc-dev+bounces-26144-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B849C61DC2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Aug 2026 08:27:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVvlV6lFbz2xwN;
	Thu, 27 Aug 2026 18:27:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787819254;
	cv=none; b=NuWthCf7bByi+PI4hUnuL/eGouix6SfkUVrBo+sfKI/hiGSB+5vOy8QJsmmbeYWbkLClqYq3MMXavbUspHZd7KghQbfr5a15U63AcysMgGQygGwa/uOmsQHLxTNVVKTze7a+XZKEPLFDGtK4avsmoj8D4YnSNPT9XmEq4sOSjcx4u3J6ZSVccrZ7vLbbA8JTcITqQUYq+kpqULtQFaXXSNQevDwpewubV9Xdt8WYELifWDm95ThrcjffVL9wpQaGb0BZsH9SNeHg6YvLUBxfgC05OcNFLGzDSgyR+9naEu8i06gtNMzae4aMk6opI7Ncuwv8OGjYa3mc35fjQbadwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787819254; c=relaxed/relaxed;
	bh=LsCdWehN+6tqdtCq+Ukvfpfb6LLtXcF2WXAWEsQkk1g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k41cfVlkCKtQvuge2nMw6fH6eS5Mg5ChZ8uqEZUXyiuwDWPcc3lCVYNZ0NauYcgRCbSDNgWOGEFY4OvzywtdCmnfjMymn5e32+c39RmjmnkAQE0E87Xa5VCqIZiUzRwwFkkZ1Uq+75qLu/6XeSSAEBRKyHS6Wq0q9uqdG9awjiuFFbvsRJW4jWU5/75GzcJJ1sFoayArmEF26c4RwzU79Puk6PtPEjcfqnYahJJ5ar9ujrUchxADTks28/deKQ+UMO7rRDqoJIQjPBAN4LUqOeEqxMFrDD/4PayYz61X+sP8Ev4ldglXgmUdlfRA6YKMyC+5E+m5P0ndfnQPIYIrGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UUerknCQ; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UUerknCQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hVvlT0QTtz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2026 18:27:32 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R6Vdoq2210177;
	Thu, 27 Aug 2026 08:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LsCdWe
	hN+6tqdtCq+Ukvfpfb6LLtXcF2WXAWEsQkk1g=; b=UUerknCQraqa7b7Bse8fX6
	FbOUoHbREt2cRa7+k7pYQN9spzRZKB0Y2eEVCoUZ7rAzE5SlWH3fXWv3fBl/ZSLq
	TtmAzjRbGWpOsqmVWf9ebCyqybTmdah86Abq+wx4m++Szo/7/DT/O5mvSlDU/OBW
	lajQ4oNba2xmghQw28XoQeaImuoiN6okygA7niHm+xdGo7DQaaNDpyeFuhEZPjfG
	YjF00Ge8CEpF8YvN+NN6G22xO+tCEDVta/NutBC2OLJY3LLda9DmowHafBevquLw
	UFvZBSwJQys8OUO6aFw7z43D1T2oSGxDNzCcEEavOSHv+s/EZgmyBEujUpi065jw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g546rb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 08:27:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67R8QLnj006786;
	Thu, 27 Aug 2026 08:27:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfwf2kg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 08:27:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67R8RFLO43844054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 08:27:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4030F2004B;
	Thu, 27 Aug 2026 08:27:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A93020040;
	Thu, 27 Aug 2026 08:27:13 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.123.12.247])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 08:27:12 +0000 (GMT)
Message-ID: <8b61b631828a52b4fdf49122d3d2b41f86586219.camel@linux.ibm.com>
Subject: Re: [PATCH v3] ppc/fadump: collect dump if the collected size is
 lesser than reserved
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: sourabhjain@linux.ibm.com, adityag@linux.ibm.com, adri.vero.dev@gmail.com,
        anushree.mathur@linux.vnet.ibm.com, chleroy@kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com
Date: Thu, 27 Aug 2026 13:57:12 +0530
In-Reply-To: <20260827075803.2240934-1-shivangu@linux.ibm.com>
References: <20260827075803.2240934-1-shivangu@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
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
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: OLs1JXQN8IxKWtpTXIVaTjFP9lmTF8YQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA2NSBTYWx0ZWRfX0/duCQXP/53d
 3qLFWB0lIlWd5lrLWrTROV4KrS5qto3xGlM/fnDr9+QcPVnxa0aTJLBDvKXcklJeGzoozqtP1m0
 9P9xQhr6FtoCzZyzz6PfvYUBSl+reQM=
X-Proofpoint-GUID: IcZ5w1Q-cw4dsjTmPoOeVMdldq1dgegF
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8ff4ec cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=JSrYWKBkpYHP3JM9lOcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA2NSBTYWx0ZWRfXzG7LSAo2YJKW
 6KQ7jjPWQezhx2XA28tkD/ozx9lw1PgFICgG2L0n2LQsCQHKlLHtiSJA4r0alGhcdgUgneAmnxx
 Y9i1Y7ibXZlrTbeOG4fl3nob+fN3WjLBMYPztqzUIVadejrod653lKONhreYpABjE6/bRpkDuJ7
 7vYi6sZrYU3rz8tNsWuHZZ5HWPN7eYIttpmNXGg+0RqqkfCQJ8EEGzlqUKcSlfi44xUhOa52wmF
 ImYOPLIG43ijJ6kSbQlKrquY2uNrr7haND7nQgbWDkRvF4wqTwt3oFMj+UdqZfmjtaZFDq+aMI9
 pfgcAWEk/ovdbIvlVaV9yjYF/HnbRORbseDmZunlzBSWDVSUmoCuAkTEo4kpktwE2Ge0vbEm835
 PGzxmZwynNcUurlJ2Rv+oo4X5OUs2+qdBs1VzXaWXotsiKQxAJokltJU3Q/5U2NWBD3QnAOVuAE
 88zUJtOzXEq778KkxsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270065

On Thu, 2026-08-27 at 13:28 +0530, Shivang Upadhyay wrote:
> +
> =C2=A0				pr_err("Dump taken by platform is
> incomplete (%d)\n", i);
> +				pr_debug("type -> %d, bytes_dumped -
> > %llx, source_len -> %llx\n",
> +					 type, bytes_dumped,
> source_len);
> =C2=A0				rc =3D -EINVAL;
> =C2=A0			}
> +
> +
It seems checkpatch.pl --fix-inplace, broke more things then it fixed.
I will send another revision Tomorrow.

~Shivang.

